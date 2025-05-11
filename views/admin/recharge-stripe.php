<?php

if(!defined("IN_SITE")) {
    exit("The Request Not Found");
}
$body = ["title" => __("Recharge Stripe"), "desc" => "CMSNT Panel", "keyword" => "cmsnt, CMSNT, cmsnt.co,"];
$body["header"] = "\n<script src=\"https://cdnjs.cloudflare.com/ajax/libs/clipboard.js/2.0.6/clipboard.min.js\"></script>\n\n";
$body["footer"] = "\n<!-- ckeditor -->\n<script src=\"" . BASE_URL("public/ckeditor/ckeditor.js") . "\"></script>\n";
require_once __DIR__ . "/../../models/is_admin.php";
require_once __DIR__ . "/header.php";
require_once __DIR__ . "/sidebar.php";
require_once __DIR__ . "/nav.php";

if(!checkPermission($getUser["admin"], "view_recharge")) {
    exit("<script type=\"text/javascript\">if(!alert(\"Bạn không có quyền sử dụng tính năng này\")){window.history.back();}</script>");
}

if(isset($_POST["SaveSettings"])) {
    if($CMSNT->site("status_demo") != 0) {
        exit("<script type=\"text/javascript\">if(!alert(\"" . __("This function cannot be used because this is a demo site") . "\")){window.history.back().location.reload();}</script>");
    }
    if(!checkPermission($getUser["admin"], "edit_recharge")) {
        exit("<script type=\"text/javascript\">if(!alert(\"Bạn không có quyền sử dụng tính năng này\")){window.history.back();}</script>");
    }
    $Mobile_Detect = new Mobile_Detect();
    $CMSNT->insert("logs", ["user_id" => $getUser["id"], "ip" => myip(), "device" => $Mobile_Detect->getUserAgent(), "createdate" => gettime(), "action" => __("Cấu hình nạp tiền Stripe")]);
    foreach ($_POST as $key => $value) {
        $CMSNT->update("settings", ["value" => $value], " `name` = '" . $key . "' ");
    }
    $my_text = $CMSNT->site("noti_action");
    $my_text = str_replace("{domain}", $_SERVER["SERVER_NAME"], $my_text);
    $my_text = str_replace("{username}", $getUser["username"], $my_text);
    $my_text = str_replace("{action}", __("Cấu hình nạp tiền Stripe"), $my_text);
    $my_text = str_replace("{ip}", myip(), $my_text);
    $my_text = str_replace("{time}", gettime(), $my_text);
    sendMessAdmin($my_text);
    exit("<script type=\"text/javascript\">if(!alert(\"" . __("Save successfully!") . "\")){window.history.back().location.reload();}</script>");
} else {
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
    $where = " `status` = 'success' ";
    $shortByDate = "";
    $tx_ref = "";
    $createdate = "";
    $amount = "";
    $user_id = "";
    $username = "";

    if(!empty($_GET["username"])) {
        $username = check_string($_GET["username"]);
        if($idUser = $CMSNT->get_row(" SELECT * FROM `users` WHERE `username` = '" . $username . "' ")) {
            $where .= " AND `user_id` =  \"" . $idUser["id"] . "\" ";
        } else {
            $where .= " AND `user_id` =  \"\" ";
        }
    }
    if(!empty($_GET["user_id"])) {
        $user_id = check_string($_GET["user_id"]);
        $where .= " AND `user_id` = " . $user_id . " ";
    }
    if(!empty($_GET["tx_ref"])) {
        $tx_ref = check_string($_GET["tx_ref"]);
        $where .= " AND `tx_ref` LIKE \"%" . $tx_ref . "%\" ";
    }
    if(!empty($_GET["amount"])) {
        $amount = check_string($_GET["amount"]);
        $where .= " AND `amount` = " . $amount . " ";
    }
    if(!empty($_GET["create_gettime"])) {
        $create_gettime = check_string($_GET["create_gettime"]);
        $createdate = $create_gettime;
        $create_gettime_1 = str_replace("-", "/", $create_gettime);
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
    $urlDatatable = pagination(base_url_admin("recharge-stripe&limit=" . $limit . "&shortByDate=" . $shortByDate . "&create_gettime=" . $createdate . "&tx_ref=" . $tx_ref . "&amount=" . $amount . "&user_id=" . $user_id . "&username=" . $username . "&"), $from, $totalDatatable, $limit);

    $yesterday = date("Y-m-d", strtotime("-1 day"));
    $currentWeek = date("W");
    $currentMonth = date("m");
    $currentYear = date("Y");
    $currentDate = date("Y-m-d");
    $total_yesterday = (int) $CMSNT->get_row("SELECT SUM(price) FROM payment_stripe WHERE `status` = 'success' AND  `create_gettime` LIKE '%" . $yesterday . "%' ")["SUM(price)"];
    $total_today = $CMSNT->get_row("SELECT SUM(price) FROM payment_stripe WHERE `status` = 'success' AND `create_gettime` LIKE '%" . $currentDate . "%' ")["SUM(price)"];
    $total_all_time = $CMSNT->get_row("SELECT SUM(price) FROM payment_stripe WHERE `status` = 'success' ")["SUM(price)"];
?>

<div class="main-content app-content">
    <div class="container-fluid">
        <div class="d-md-flex d-block align-items-center justify-content-between my-4 page-header-breadcrumb">
            <h1 class="page-title fw-semibold fs-18 mb-0">Phương thức thanh toán Stripe</h1>
        </div>
        <div class="row">
            <div class="col-xl-12">
                <div class="text-right">
                    <button type="button" id="open-card-config" class="btn btn-primary label-btn mb-3">
                        <i class="ri-settings-4-line label-btn-icon me-2"></i> CẤU HÌNH
                    </button>
                </div>
            </div>
            <div class="col-xl-12" id="card-config" style="display: none;">
                <div class="card custom-card">
                    <div class="card-body">
                        <form action="" method="POST" enctype="multipart/form-data">
                            <div class="row">
                                <div class="col-lg-12 col-xl-6">
                                    <div class="row mb-4">
                                        <label class="col-sm-7 col-form-label" for="example-hf-email"><?php echo __("Trạng thái"); ?></label>
                                        <div class="col-sm-5">
                                            <select class="form-control" name="stripe_status">
                                                <option <?php echo $CMSNT->site("stripe_status") == 1 ? "selected" : ""; ?> value="1">ON</option>
                                                <option <?php echo $CMSNT->site("stripe_status") == 0 ? "selected" : ""; ?> value="0">OFF</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row mb-4">
                                        <label class="col-sm-7 col-form-label" for="example-hf-email">Currency</label>
                                        <div class="col-sm-5">
                                            <input type="text" class="form-control" value="<?php echo $CMSNT->site("stripe_currency_code"); ?>" name="stripe_currency_code">
                                        </div>
                                    </div>
                                    <div class="row mb-4">
                                        <label class="col-sm-7 col-form-label" for="example-hf-email"><?php echo __("1 " . $CMSNT->site("stripe_currency_code") . " ="); ?></label>
                                        <div class="col-sm-5">
                                            <div class="input-group">
                                                <input type="text" class="form-control" value="<?php echo $CMSNT->site("stripe_rate"); ?>" name="stripe_rate" placeholder="">
                                                <span class="input-group-text">
                                                    <?php echo $CMSNT->get_row(" SELECT `code` FROM `currencies` WHERE `display` = 1 AND `default_currency` = 1")["code"]; ?>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12 col-xl-6">
                                    <div class="row mb-4">
                                        <label class="col-sm-4 col-form-label" for="example-hf-email">Secret Key</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" value="<?php echo $CMSNT->site("stripe_secret_key"); ?>" name="stripe_secret_key">
                                        </div>
                                    </div>
                                    <div class="row mb-4">
                                        <label class="col-sm-4 col-form-label" for="example-hf-email">Public key</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" value="<?php echo $CMSNT->site("stripe_public_key"); ?>" name="stripe_public_key">
                                        </div>
                                    </div>
                                    <div class="row mb-4">
                                        <label class="col-sm-4 col-form-label" for="example-hf-email">Webhook Secret</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" value="<?php echo $CMSNT->site("stripe_webhook_secret"); ?>" name="stripe_webhook_secret">
                                        </div>
                                    </div>
                                    <div class="row mb-4">
                                        <label class="col-sm-4 col-form-label" for="example-hf-email">Link Webhook</label>
                                        <div class="col-sm-8">
                                            <div class="input-group">
                                                <input type="text" class="form-control" value="<?php echo base_url("api/callback_stripe.php"); ?>" id="webhook_url" readonly>
                                                <button class="btn btn-primary btn-sm copy" type="button" data-clipboard-target="#webhook_url" onclick="copy()"><i class="fa-solid fa-copy"></i> Copy</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12 col-xl-12">
                                    <div class="row mb-4">
                                        <label class="col-sm-6 col-form-label" for="example-hf-email"><?php echo __("Note"); ?></label>
                                        <div class="col-sm-12">
                                            <textarea id="stripe_notice" name="stripe_notice"><?php echo $CMSNT->site("stripe_notice"); ?></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="d-grid gap-2 mb-4">
                                <button type="submit" name="SaveSettings" class="btn btn-primary btn-block"><i class="fa fa-fw fa-save me-1"></i> <?php echo __("Save"); ?></button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="col-xl-5">
                <div class="row">
                    <div class="col-xl-6">
                        <div class="card custom-card">
                            <div class="card-body">
                                <div class="d-flex align-items-center">
                                    <div class="flex-fill">
                                        <p class="mb-1 fs-5 fw-semibold text-default"><?php echo format_currency($total_all_time); ?></p>
                                        <p class="mb-0 text-muted">Toàn thời gian</p>
                                    </div>
                                    <div class="ms-2">
                                        <span class="avatar text-bg-danger rounded-circle fs-20"><i class='bx bxs-wallet-alt'></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-6">
                        <div class="card custom-card">
                            <div class="card-body">
                                <div class="d-flex align-items-center">
                                    <div class="flex-fill">
                                        <p class="mb-1 fs-5 fw-semibold text-default">
                                            <?php echo format_currency($CMSNT->get_row("SELECT SUM(price) FROM payment_stripe WHERE `status` = 'success' AND MONTH(create_gettime) = '" . $currentMonth . "' AND YEAR(create_gettime) = '" . $currentYear . "' ")["SUM(price)"]); ?>
                                        </p>
                                        <p class="mb-0 text-muted">Tháng <?php echo date("m"); ?></p>
                                    </div>
                                    <div class="ms-2">
                                        <span class="avatar text-bg-info rounded-circle fs-20"><i class='bx bxs-wallet-alt'></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-6">
                        <div class="card custom-card">
                            <div class="card-body">
                                <div class="d-flex align-items-center">
                                    <div class="flex-fill">
                                        <p class="mb-1 fs-5 fw-semibold text-default">
                                            <?php echo format_currency($CMSNT->get_row("SELECT SUM(price) FROM payment_stripe WHERE `status` = 'success' AND YEAR(create_gettime) = " . $currentYear . " AND WEEK(create_gettime, 1) = " . $currentWeek . " ")["SUM(price)"]); ?>
                                        </p>
                                        <p class="mb-0 text-muted">Trong tuần</p>
                                    </div>
                                    <div class="ms-2">
                                        <span class="avatar text-bg-warning rounded-circle fs-20"><i class='bx bxs-wallet-alt'></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-6">
                        <div class="card custom-card">
                            <div class="card-body">
                                <div class="d-flex align-items-center">
                                    <div class="flex-fill">
                                        <p class="mb-1 fs-5 fw-semibold text-default"><?php echo format_currency($total_today); ?></p>
                                        <p class="mb-0 text-muted">Hôm nay
                                            <?php
                                            if($total_yesterday != 0) {
                                                $revenueGrowth = ($total_today - $total_yesterday) / $total_yesterday * 100;
                                                if(0 < $revenueGrowth) {
                                                    echo "<span class=\"fs-12 text-success ms-2\"><i class=\"ti ti-trending-up me-1 d-inline-block\"></i>" . round($revenueGrowth, 2) . "% </span>";
                                                } elseif($revenueGrowth < 0) {
                                                    echo "<span class=\"fs-12 text-danger ms-2\"><i class=\"ti ti-trending-down me-1 d-inline-block\"></i>" . round(abs($revenueGrowth), 2) . "% </span>";
                                                }
                                            }
                                            ?>
                                        </p>
                                    </div>
                                    <div class="ms-2">
                                        <span class="avatar text-bg-primary rounded-circle fs-20"><i class='bx bxs-wallet-alt'></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-7">
                <div class="card custom-card">
                    <div class="card-header">
                        <div class="card-title">THỐNG KÊ NẠP TIỀN THÁNG <?php echo date("m"); ?></div>
                    </div>
                    <div class="card-body">
                        <canvas id="chartjs-line" class="chartjs-chart"></canvas>
                        <script>
                        (function() {
                            /* line chart  */
                            Chart.defaults.borderColor = "rgba(142, 156, 173,0.1)", Chart.defaults.color = "#8c9097";
                            const labels = [
                                <?php
                                $month = date("m");
                                $year = date("Y");
                                $numOfDays = cal_days_in_month(CAL_GREGORIAN, $month, $year);
                                for ($day = 1; $day <= $numOfDays; $day++) {
                                    echo "\"" . $day . "/" . $month . "/" . $year . "\",";
                                }
                                ?>
                            ];
                            const data = {
                                labels: labels,
                                datasets: [{
                                    label: 'Paid',
                                    backgroundColor: 'rgb(132, 90, 223)',
                                    borderColor: 'rgb(132, 90, 223)',
                                    data: [
                                        <?php
                                        $data = [];
                                        for ($day = 1; $day <= $numOfDays; $day++) {
                                            $date = $year . "-" . $month . "-" . $day;
                                            $row = $CMSNT->get_row("SELECT SUM(price) FROM payment_stripe WHERE `status` = 'success' AND DATE(create_gettime) = '" . $date . "' ");
                                            $data[$day - 1] = $row["SUM(price)"];
                                        }
                                        for ($i = 0; $i < $numOfDays; $i++) {
                                            echo $data[$i] . ",";
                                        }
                                        ?>
                                    ],
                                }]
                            };
                            const config = {
                                type: 'bar',
                                data: data,
                                options: {}
                            };
                            const myChart = new Chart(
                                document.getElementById('chartjs-line'),
                                config
                            );
                        })();
                        </script>
                    </div>
                </div>
            </div>
            <div class="col-xl-12">
                <div class="card custom-card">
                    <div class="card-header justify-content-between">
                        <div class="card-title">
                            LỊCH SỬ NẠP TIỀN STRIPE TỰ ĐỘNG
                        </div>
                    </div>
                    <div class="card-body">
                        <form action="" class="align-items-center mb-3" name="formSearch" method="GET">
                            <div class="row row-cols-lg-auto g-3 mb-3">
                                <input type="hidden" name="module" value="admin">
                                <input type="hidden" name="action" value="recharge-stripe">
                                <div class="col-md-3 col-6">
                                    <input class="form-control form-control-sm" value="<?php echo $user_id; ?>" name="user_id"
                                        placeholder="<?php echo __("Search ID User"); ?>">
                                </div>
                                <div class="col-md-3 col-6">
                                    <input class="form-control form-control-sm" value="<?php echo $username; ?>" name="username"
                                        placeholder="<?php echo __("Search Username"); ?>">
                                </div>
                                <div class="col-md-3 col-6">
                                    <input class="form-control form-control-sm" value="<?php echo $tx_ref; ?>"
                                        name="tx_ref" placeholder="<?php echo __("Transaction"); ?>">
                                </div>
                                <div class="col-md-3 col-6">
                                    <input class="form-control form-control-sm" value="<?php echo $amount; ?>" name="amount"
                                        placeholder="<?php echo __("Amount"); ?>">
                                </div>
                                <div class="col-lg col-md-4 col-6">
                                    <input type="text" name="create_gettime" class="form-control form-control-sm"
                                        id="daterange" value="<?php echo $createdate; ?>" placeholder="Chọn thời gian">
                                </div>
                                <div class="col-12">
                                    <button class="btn btn-sm btn-primary"><i class="fa fa-search"></i> <?php echo __("Search"); ?></button>
                                    <a class="btn btn-sm btn-danger" href="<?php echo base_url_admin("recharge-stripe"); ?>"><i class="fa fa-trash"></i> <?php echo __("Clear filter"); ?></a>
                                </div>
                            </div>
                            <div class="top-filter">
                                <div class="filter-show">
                                    <label class="filter-label">Show :</label>
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
                        <div class="table-responsive mb-3">
                            <table class="table text-nowrap table-striped table-hover table-bordered">
                                <thead>
                                    <tr class="text-center">
                                        <th class="text-center"><?php echo __("Username"); ?></th>
                                        <th class="text-center"><?php echo __("TransID"); ?></th>
                                        <th class="text-center"><?php echo __("Amount"); ?></th>
                                        <th class="text-center"><?php echo __("Price"); ?></th>
                                        <th class="text-center"><?php echo __("Create date"); ?></th>
                                        <th class="text-center"><?php echo __("Update date"); ?></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php foreach ($listDatatable as $row) { ?>
                                    <tr>
                                        <td class="text-center"><a class="text-primary" href="<?php echo base_url_admin("user-edit&id=" . $row["user_id"]); ?>">
                                                <?php echo getRowRealtime("users", $row["user_id"], "username"); ?> [ID <?php echo $row["user_id"]; ?>]</a>
                                        </td>
                                        <td><b><?php echo $row["tx_ref"]; ?></b></td>
                                        <td><b><?php echo format_cash($row["amount"]); ?></b></td>
                                        <td><b><?php echo format_currency($row["price"]); ?></b></td>
                                        <td><?php echo $row["create_gettime"]; ?></td>
                                        <td><?php echo $row["update_gettime"]; ?></td>
                                    </tr>
                                    <?php } ?>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="7">
                                            <div class="float-right">
                                                <?php echo __("Paid:"); ?> <strong style="color:red;"><?php echo format_currency($CMSNT->get_row(" SELECT SUM(`price`) FROM `payment_stripe` WHERE " . $where . " ")["SUM(`price`)"]); ?></strong>
                                            </div>
                                        </td>
                                    </tr>
                                </tfoot>
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

<?php require_once __DIR__ . "/footer.php"; ?>

<script>
document.addEventListener('DOMContentLoaded', function() {
    var button = document.getElementById('open-card-config');
    var card = document.getElementById('card-config');

    button.addEventListener('click', function() {
        if (card.style.display === 'none' || card.style.display === '') {
            card.style.display = 'block';
        } else {
            card.style.display = 'none';
        }
    });
});
</script>

<script>
CKEDITOR.replace("stripe_notice");
</script>

<script type="text/javascript">
new ClipboardJS(".copy");

function copy() {
    showMessage("<?php echo __("Đã sao chép vào bộ nhớ tạm"); ?>", 'success');
}
</script>

<?php } ?> 