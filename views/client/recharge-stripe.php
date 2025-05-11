<?php

if(!defined("IN_SITE")) {
    exit("The Request Not Found");
}

$body = ["title" => __("Recharge Stripe"), "desc" => "CMSNT Panel", "keyword" => "cmsnt, CMSNT, cmsnt.co,"];
$body["header"] = "\n<script src=\"https://js.stripe.com/v3/\"></script>\n";
require_once __DIR__ . "/header.php";
require_once __DIR__ . "/nav.php";

if($CMSNT->site("stripe_status") != 1) {
    exit("<script type=\"text/javascript\">if(!alert(\"" . __("This payment method is not available") . "\")){window.history.back();}</script>");
}

if(!$row = $CMSNT->get_row(" SELECT * FROM `payment_stripe` WHERE `user_id` = '" . $getUser["id"] . "' AND `status` = 'pending' ")) {
    $tx_ref = "STRIPE_" . time() . "_" . random("123456789", 5);
    $CMSNT->insert("payment_stripe", [
        "user_id" => $getUser["id"],
        "tx_ref" => $tx_ref,
        "amount" => 0,
        "currency" => $CMSNT->site("stripe_currency_code"),
        "create_gettime" => gettime(),
        "update_gettime" => gettime(),
        "status" => "pending"
    ]);
}

if(isset($_GET["limit"])) {
    $limit = (int) check_string($_GET["limit"]);
} else {
    $limit = 10;
}
if(isset($_GET["page"])) {
    $page = check_string((int) $_GET["page"]);
} else {
    $page = 1;
}
$from = ($page - 1) * $limit;
$where = " `user_id` = '" . $getUser["id"] . "' ";
$listDatatable = $CMSNT->get_list(" SELECT * FROM `payment_stripe` WHERE " . $where . " ORDER BY `id` DESC LIMIT " . $from . "," . $limit . " ");
$totalDatatable = $CMSNT->num_rows(" SELECT * FROM `payment_stripe` WHERE " . $where . " ORDER BY id DESC ");
$urlDatatable = pagination(base_url("recharge-stripe&limit=" . $limit . "&"), $from, $totalDatatable, $limit);

?>

<div class="main-content app-content">
    <div class="container-fluid">
        <div class="d-md-flex d-block align-items-center justify-content-between my-4 page-header-breadcrumb">
            <h1 class="page-title fw-semibold fs-18 mb-0"><?php echo __("Recharge Stripe"); ?></h1>
        </div>
        <div class="row">
            <div class="col-xl-12">
                <div class="card custom-card">
                    <div class="card-header justify-content-between">
                        <div class="card-title">
                            <?php echo __("Recharge Stripe"); ?>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-xl-6">
                                <form id="payment-form">
                                    <div class="row mb-4">
                                        <label class="col-sm-3 col-form-label" for="example-hf-email"><?php echo __("Amount"); ?></label>
                                        <div class="col-sm-9">
                                            <div class="input-group">
                                                <input type="number" class="form-control" id="amount" name="amount" placeholder="<?php echo __("Enter amount"); ?>" required>
                                                <span class="input-group-text"><?php echo $CMSNT->site("stripe_currency_code"); ?></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mb-4">
                                        <label class="col-sm-3 col-form-label" for="example-hf-email"><?php echo __("Card Information"); ?></label>
                                        <div class="col-sm-9">
                                            <div id="card-element" class="form-control"></div>
                                            <div id="card-errors" class="text-danger mt-2" role="alert"></div>
                                        </div>
                                    </div>
                                    <div class="row mb-4">
                                        <div class="col-sm-9 offset-sm-3">
                                            <button type="submit" class="btn btn-primary" id="submit-button">
                                                <span id="button-text"><?php echo __("Pay now"); ?></span>
                                                <span id="spinner" class="spinner hidden"></span>
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="col-xl-6">
                                <div class="card custom-card">
                                    <div class="card-header">
                                        <div class="card-title"><?php echo __("Transaction History"); ?></div>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table text-nowrap table-striped table-hover table-bordered">
                                                <thead>
                                                    <tr class="text-center">
                                                        <th class="text-center"><?php echo __("TransID"); ?></th>
                                                        <th class="text-center"><?php echo __("Amount"); ?></th>
                                                        <th class="text-center"><?php echo __("Price"); ?></th>
                                                        <th class="text-center"><?php echo __("Create date"); ?></th>
                                                        <th class="text-center"><?php echo __("Status"); ?></th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <?php foreach ($listDatatable as $row) { ?>
                                                    <tr>
                                                        <td><b><?php echo $row["tx_ref"]; ?></b></td>
                                                        <td><b><?php echo format_cash($row["amount"]); ?></b></td>
                                                        <td><b><?php echo format_currency($row["price"]); ?></b></td>
                                                        <td><?php echo $row["create_gettime"]; ?></td>
                                                        <td>
                                                            <?php if($row["status"] == "success") { ?>
                                                            <span class="badge bg-success"><?php echo __("Success"); ?></span>
                                                            <?php } elseif($row["status"] == "pending") { ?>
                                                            <span class="badge bg-warning"><?php echo __("Pending"); ?></span>
                                                            <?php } else { ?>
                                                            <span class="badge bg-danger"><?php echo __("Failed"); ?></span>
                                                            <?php } ?>
                                                        </td>
                                                    </tr>
                                                    <?php } ?>
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-12 col-md-5">
                                                <p class="dataTables_info">Showing <?php echo $limit; ?> of <?php echo format_cash($totalDatatable); ?> Results</p>
                                            </div>
                                            <div class="col-sm-12 col-md-7 mb-3">
                                                <?php echo $limit < $totalDatatable ? $urlDatatable : ""; ?>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<?php require_once __DIR__ . "/footer.php"; ?>

<script>
var stripe = Stripe('<?php echo $CMSNT->site("stripe_public_key"); ?>');
var elements = stripe.elements();
var card = elements.create('card');
card.mount('#card-element');

card.addEventListener('change', function(event) {
    var displayError = document.getElementById('card-errors');
    if (event.error) {
        displayError.textContent = event.error.message;
    } else {
        displayError.textContent = '';
    }
});

var form = document.getElementById('payment-form');
form.addEventListener('submit', function(event) {
    event.preventDefault();
    var submitButton = document.getElementById('submit-button');
    var buttonText = document.getElementById('button-text');
    var spinner = document.getElementById('spinner');
    
    submitButton.disabled = true;
    buttonText.textContent = '<?php echo __("Processing..."); ?>';
    spinner.classList.remove('hidden');

    var amount = document.getElementById('amount').value;
    
    fetch('<?php echo base_url("api/process_stripe.php"); ?>', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'amount=' + amount
    })
    .then(function(response) {
        return response.json();
    })
    .then(function(data) {
        if (data.status === 'success') {
            stripe.confirmCardPayment(data.client_secret, {
                payment_method: {
                    card: card,
                }
            }).then(function(result) {
                if (result.error) {
                    var errorElement = document.getElementById('card-errors');
                    errorElement.textContent = result.error.message;
                    submitButton.disabled = false;
                    buttonText.textContent = '<?php echo __("Pay now"); ?>';
                    spinner.classList.add('hidden');
                } else {
                    if (result.paymentIntent.status === 'succeeded') {
                        window.location.href = '<?php echo base_url("recharge-stripe"); ?>';
                    }
                }
            });
        } else {
            var errorElement = document.getElementById('card-errors');
            errorElement.textContent = data.message;
            submitButton.disabled = false;
            buttonText.textContent = '<?php echo __("Pay now"); ?>';
            spinner.classList.add('hidden');
        }
    })
    .catch(function(error) {
        var errorElement = document.getElementById('card-errors');
        errorElement.textContent = error.message;
        submitButton.disabled = false;
        buttonText.textContent = '<?php echo __("Pay now"); ?>';
        spinner.classList.add('hidden');
    });
});
</script>

<style>
#card-element {
    padding: 12px;
    border: 1px solid #e0e0e0;
    border-radius: 4px;
    background: white;
}

.spinner {
    display: inline-block;
    width: 20px;
    height: 20px;
    border: 3px solid rgba(255, 255, 255, .3);
    border-radius: 50%;
    border-top-color: #fff;
    animation: spin 1s ease-in-out infinite;
}

@keyframes spin {
    to { transform: rotate(360deg); }
}

.hidden {
    display: none;
}
</style> 