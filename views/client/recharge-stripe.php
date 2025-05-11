<?php

if(!defined("IN_SITE")) {
    exit("The Request Not Found");
}
$body = ["title" => __("Recharge Stripe") . " | " . $CMSNT->site("title"), "desc" => $CMSNT->site("description"), "keyword" => $CMSNT->site("keywords")];
$body["header"] = "\n<link rel=\"stylesheet\" href=\"" . BASE_URL("public/client/") . "css/wallet.css\">\n";
$body["footer"] = "\n<script src=\"https://js.stripe.com/v3/\"></script>\n";
require_once __DIR__ . "/../../models/is_user.php";
if($CMSNT->site("stripe_status") != 1) {
    redirect(base_url());
}
require_once __DIR__ . "/header.php";
require_once __DIR__ . "/nav.php";

if(0 < $CMSNT->num_rows("SELECT * FROM `payment_stripe` WHERE `user_id` = '" . $getUser["id"] . "' AND `status` = 'pending' ")) {
    $tx_ref = $CMSNT->get_row("SELECT * FROM `payment_stripe` WHERE `user_id` = '" . $getUser["id"] . "' AND `status` = 'pending' ")["tx_ref"];
} else {
    $tx_ref = md5(random("QWERTYUIOPASDFGHJKLZXCVBNM", 4) . "_" . time());
    $CMSNT->insert("payment_stripe", ["user_id" => $getUser["id"], "tx_ref" => $tx_ref, "amount" => 0, "currency" => $CMSNT->site("stripe_currency_code"), "create_gettime" => gettime(), "update_gettime" => gettime(), "status" => "pending"]);
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
$where = " `user_id` = '" . $getUser["id"] . "' AND `status` = 'success' ";
$shortByDate = "";
$trans_id = "";
$time = "";
$amount = "";

if(!empty($_GET["trans_id"])) {
    $trans_id = check_string($_GET["trans_id"]);
    $where .= " AND `tx_ref` = \"" . $trans_id . "\" ";
}
if(!empty($_GET["amount"])) {
    $amount = check_string($_GET["amount"]);
    $where .= " AND `amount` = " . $amount . " ";
}
if(!empty($_GET["time"])) {
    $time = check_string($_GET["time"]);
    $create_gettime_1 = str_replace("-", "/", $time);
    $create_gettime_1 = explode(" to ", $create_gettime_1);
    if($create_gettime_1[0] != $create_gettime_1[1]) {
        $create_gettime_1 = [$create_gettime_1[0] . " 00:00:00", $create_gettime_1[1] . " 23:59:59"];
        $where .= " AND `create_gettime` >= '" . $create_gettime_1[0] . "' AND `create_gettime` <= '" . $create_gettime_1[1] . "' ";
    }
}
if(isset($_GET["shortByDate"])) {
    $shortByDate = check_string($_GET["shortByDate"]);
    $yesterday = date("Y-m-d", strtotime("-1 day"));
    $currentWeek = date("W");
    $currentMonth = date("m");
    $currentYear = date("Y");
    $currentDate = date("Y-m-d");
    if($shortByDate == 1) {
        $where .= " AND `create_gettime` LIKE '%" . $currentDate . "%' ";
    }
    if($shortByDate == 2) {
        $where .= " AND YEAR(create_gettime) = " . $currentYear . " AND WEEK(create_gettime, 1) = " . $currentWeek . " ";
    }
    if($shortByDate == 3) {
        $where .= " AND MONTH(create_gettime) = '" . $currentMonth . "' AND YEAR(create_gettime) = '" . $currentYear . "' ";
    }
}

$listDatatable = $CMSNT->get_list(" SELECT * FROM `payment_stripe` WHERE " . $where . " ORDER BY `id` DESC LIMIT " . $from . "," . $limit . " ");
$totalDatatable = $CMSNT->num_rows(" SELECT * FROM `payment_stripe` WHERE " . $where . " ORDER BY id DESC ");
$urlDatatable = pagination(base_url("?action=recharge-stripe&limit=" . $limit . "&shortByDate=" . $shortByDate . "&time=" . $time . "&trans_id=" . $trans_id . "&amount=" . $amount . "&"), $from, $totalDatatable, $limit);
?>

<section class="py-5 inner-section profile-part">
    <div class="container">
        <div class="row">
            <div class="col-md-7">
                <div class="account-card">
                    <h4 class="account-title"><?php echo __("Recharge Stripe"); ?></h4>
                    <div class="text-center mb-4">
                        <img width="300px" src="<?php echo base_url("mod/img/logo-stripe.png"); ?>" />
                    </div>
                    <form id="payment-form">
                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label" for="amount">
                                <?php echo __("Enter the deposit amount: (" . $CMSNT->site("stripe_currency_code") . ")"); ?>
                            </label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="amount" name="amount" 
                                    placeholder="<?php echo __("Please enter the amount to deposit"); ?>" required>
                                <input type="hidden" id="tx_ref" value="<?php echo $tx_ref; ?>">
                            </div>
                        </div>
                        <div class="row mb-3">
                            <label class="col-sm-4 col-form-label" for="card-element">
                                <?php echo __("Credit or debit card"); ?>
                            </label>
                            <div class="col-sm-8">
                                <div id="card-element" class="form-control"></div>
                                <div id="card-errors" class="text-danger" role="alert"></div>
                            </div>
                        </div>
                        <center>
                            <div class="wallet-form">
                                <button type="submit" id="submit-button"><?php echo __("Submit"); ?></button>
                            </div>
                        </center>
                    </form>
                </div>
            </div>
            <div class="col-md-5">
                <div class="account-card">
                    <h4 class="account-title"><?php echo __("Lưu ý"); ?></h4>
                    <?php echo $CMSNT->site("stripe_notice"); ?>
                </div>
            </div>
            <div class="col-md-12">
                <div class="account-card">
                    <h4 class="account-title"><?php echo __("Lịch sử nạp Stripe"); ?></h4>
                    <form action="<?php echo base_url(); ?>" method="GET">
                        <input type="hidden" name="action" value="recharge-stripe">
                        <div class="row">
                            <div class="col-lg col-md-4 col-6">
                                <input class="form-control col-sm-2 mb-1" value="<?php echo $trans_id; ?>"
                                    name="trans_id" placeholder="<?php echo __("Search transaction ref"); ?>">
                            </div>
                            <div class="col-lg col-md-4 col-6">
                                <input class="form-control col-sm-2 mb-1" value="<?php echo $amount; ?>" name="amount"
                                    placeholder="<?php echo __("Search amount"); ?>">
                            </div>
                            <div class="col-lg col-md-6 col-6">
                                <input type="text" class="js-flatpickr form-control mb-1" id="example-flatpickr-range"
                                    name="time" placeholder="<?php echo __("Chọn thời gian cần tìm"); ?>" value="<?php echo $time; ?>"
                                    data-mode="range">
                            </div>
                            <div class="col-lg col-md-4 col-6">
                                <button class="shop-widget-btn mb-2"><i class="fas fa-search"></i><span><?php echo __("Tìm kiếm"); ?></span></button>
                            </div>
                            <div class="col-lg col-md-4 col-6">
                                <a href="<?php echo base_url("?action=recharge-stripe"); ?>" class="shop-widget-btn mb-2"><i
                                        class="far fa-trash-alt"></i><span><?php echo __("Bỏ lọc"); ?></span></a>
                            </div>
                        </div>
                        <div class="top-filter">
                            <div class="filter-show"><label class="filter-label">Show :</label>
                                <select name="limit" onchange="this.form.submit()" class="form-select filter-select">
                                    <option <?php echo $limit == 5 ? "selected" : ""; ?> value="5">5</option>
                                    <option <?php echo $limit == 10 ? "selected" : ""; ?> value="10">10</option>
                                    <option <?php echo $limit == 20 ? "selected" : ""; ?> value="20">20</option>
                                    <option <?php echo $limit == 50 ? "selected" : ""; ?> value="50">50</option>
                                    <option <?php echo $limit == 100 ? "selected" : ""; ?> value="100">100</option>
                                    <option <?php echo $limit == 500 ? "selected" : ""; ?> value="500">500</option>
                                    <option <?php echo $limit == 1000 ? "selected" : ""; ?> value="1000">1000</option>
                                </select>
                            </div>
                            <div class="filter-short">
                                <label class="filter-label"><?php echo __("Short by Date:"); ?></label>
                                <select name="shortByDate" onchange="this.form.submit()" class="form-select filter-select">
                                    <option value=""><?php echo __("Tất cả"); ?></option>
                                    <option <?php echo $shortByDate == 1 ? "selected" : ""; ?> value="1"><?php echo __("Hôm nay"); ?></option>
                                    <option <?php echo $shortByDate == 2 ? "selected" : ""; ?> value="2"><?php echo __("Tuần này"); ?></option>
                                    <option <?php echo $shortByDate == 3 ? "selected" : ""; ?> value="3"><?php echo __("Tháng này"); ?></option>
                                </select>
                            </div>
                        </div>
                    </form>
                    <div class="table-scroll">
                        <table class="table fs-sm mb-0">
                            <thead>
                                <tr>
                                    <th class="text-center"><?php echo __("TransID"); ?></th>
                                    <th class="text-center"><?php echo __("Amount"); ?></th>
                                    <th class="text-center"><?php echo __("Price"); ?></th>
                                    <th class="text-center"><?php echo __("Create date"); ?></th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($listDatatable as $row) { ?>
                                <tr>
                                    <td class="text-center"><b><?php echo $row["tx_ref"]; ?></b></td>
                                    <td class="text-center"><b><?php echo $row["amount"]; ?></b></td>
                                    <td class="text-center"><b><?php echo format_currency($row["price"]); ?></b></td>
                                    <td class="text-center"><?php echo $row["create_gettime"]; ?></td>
                                </tr>
                                <?php } ?>
                            </tbody>
                        </table>
                    </div>
                    <?php if($totalDatatable == 0) { ?>
                    <div class="empty-state">
                        <svg width="184" height="152" viewBox="0 0 184 152" xmlns="http://www.w3.org/2000/svg">
                            <g fill="none" fill-rule="evenodd">
                                <g transform="translate(24 31.67)">
                                    <ellipse fill-opacity=".8" fill="#F5F5F7" cx="67.797" cy="106.89" rx="67.797" ry="12.668"></ellipse>
                                    <path d="M122.034 69.674L98.109 40.229c-1.148-1.386-2.826-2.225-4.593-2.225h-51.44c-1.766 0-3.444.839-4.592 2.225L13.56 69.674v15.383h108.475V69.674z" fill="#AEB8C2"></path>
                                    <path d="M101.537 86.214L80.63 61.102c-1.001-1.207-2.507-1.867-4.048-1.867H31.724c-1.54 0-3.047.66-4.048 1.867L6.769 86.214v13.792h94.768V86.214z" fill="url(#linearGradient-1)" transform="translate(13.56)"></path>
                                    <path d="M33.83 0h67.933a4 4 0 0 1 4 4v93.344a4 4 0 0 1-4 4H33.83a4 4 0 0 1-4-4V4a4 4 0 0 1 4-4z" fill="#F5F5F7"></path>
                                    <path d="M42.678 9.953h50.237a2 2 0 0 1 2 2V36.91a2 2 0 0 1-2 2H42.678a2 2 0 0 1-2-2V11.953a2 2 0 0 1 2-2zM42.94 49.767h49.713a2.262 2.262 0 1 1 0 4.524H42.94a2.262 2.262 0 0 1 0-4.524zM42.94 61.53h49.713a2.262 2.262 0 1 1 0 4.525H42.94a2.262 2.262 0 0 1 0-4.525zM121.813 105.032c-.775 3.071-3.497 5.36-6.735 5.36H20.515c-3.238 0-5.96-2.29-6.734-5.36a7.309 7.309 0 0 1-.222-1.79V69.675h26.318c2.907 0 5.25 2.448 5.25 5.42v.04c0 2.971 2.37 5.37 5.277 5.37h34.785c2.907 0 5.277-2.421 5.277-5.393V75.1c0-2.972 2.343-5.426 5.25-5.426h26.318v33.569c0 .617-.077 1.216-.221 1.789z" fill="#DCE0E6"></path>
                                </g>
                                <path d="M149.121 33.292l-6.83 2.65a1 1 0 0 1-1.317-1.23l1.937-6.207c-2.589-2.944-4.109-6.534-4.109-10.408C138.802 8.102 148.92 0 161.402 0 173.881 0 184 8.102 184 18.097c0 9.995-10.118 18.097-22.599 18.097-4.528 0-8.744-1.066-12.28-2.902z" fill="#DCE0E6"></path>
                                <g transform="translate(149.65 15.383)" fill="#FFF">
                                    <ellipse cx="20.654" cy="3.167" rx="2.849" ry="2.815"></ellipse>
                                    <path d="M5.698 5.63H0L2.898.704zM9.259.704h4.985V5.63H9.259z"></path>
                                </g>
                            </g>
                        </svg>
                        <p><?php echo __("Không có dữ liệu"); ?></p>
                    </div>
                    <?php } ?>
                    <div class="bottom-paginate">
                        <p class="page-info">Showing <?php echo $limit; ?> of <?php echo $totalDatatable; ?> Results</p>
                        <div class="pagination">
                            <?php echo $limit < $totalDatatable ? $urlDatatable : ""; ?>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<?php require_once __DIR__ . "/footer.php"; ?>

<script>
// Initialize Stripe
var stripe = Stripe('<?php echo $CMSNT->site("stripe_public_key"); ?>');
var elements = stripe.elements();

// Create card Element
var card = elements.create('card');
card.mount('#card-element');

// Handle form submission
var form = document.getElementById('payment-form');
var submitButton = document.getElementById('submit-button');

form.addEventListener('submit', function(event) {
    event.preventDefault();
    submitButton.disabled = true;

    stripe.createPaymentMethod({
        type: 'card',
        card: card,
        billing_details: {
            name: '<?php echo $getUser["username"]; ?>',
            email: '<?php echo $getUser["email"]; ?>'
        }
    }).then(function(result) {
        if (result.error) {
            var errorElement = document.getElementById('card-errors');
            errorElement.textContent = result.error.message;
            submitButton.disabled = false;
        } else {
            // Send payment info to server
            var amount = document.getElementById('amount').value;
            var tx_ref = document.getElementById('tx_ref').value;

            fetch('<?php echo base_url("api/create_payment_intent.php"); ?>', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    payment_method_id: result.paymentMethod.id,
                    amount: amount,
                    tx_ref: tx_ref
                })
            })
            .then(function(response) {
                return response.json();
            })
            .then(function(data) {
                if (data.error) {
                    var errorElement = document.getElementById('card-errors');
                    errorElement.textContent = data.error;
                    submitButton.disabled = false;
                } else {
                    // Handle successful payment
                    window.location.href = '<?php echo base_url("?action=recharge-stripe"); ?>';
                }
            })
            .catch(function(error) {
                var errorElement = document.getElementById('card-errors');
                errorElement.textContent = 'An error occurred. Please try again.';
                submitButton.disabled = false;
            });
        }
    });
});
</script>

<script>
Dashmix.helpersOnLoad(['js-flatpickr', 'jq-datepicker', 'jq-maxlength', 'jq-select2', 'jq-rangeslider',
    'jq-masked-inputs', 'jq-pw-strength'
]);
</script> 