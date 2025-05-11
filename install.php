<?php

define("IN_SITE", true);
require_once __DIR__ . "/libs/db.php";
require_once __DIR__ . "/libs/lang.php";
require_once __DIR__ . "/config.php";
require_once __DIR__ . "/libs/helper.php";
$CMSNT = new DB();
$CMSNT->query(" CREATE TABLE `deposit_log` (\n        `id` INT(11) NOT NULL AUTO_INCREMENT,\n        `user_id` INT(11) NOT NULL,\n        `method` VARCHAR(255) NULL DEFAULT NULL,\n        `amount` FLOAT NOT NULL DEFAULT 0,\n        `received` FLOAT NOT NULL DEFAULT 0,\n        `create_time` INT(11) NOT NULL,\n        `is_virtual` TINYINT(1) NOT NULL DEFAULT 0,\n        PRIMARY KEY (`id`)\n    )  ");
$CMSNT->query(" CREATE TABLE `order_log` (\n        `id` INT NOT NULL AUTO_INCREMENT,\n        `buyer` INT NOT NULL,\n        `product_name` VARCHAR(255) NULL DEFAULT NULL,\n        `pay` FLOAT NOT NULL DEFAULT 0,\n        `amount` INT NOT NULL DEFAULT 0,\n        `create_time` INT(11) NOT NULL,\n        PRIMARY KEY (`id`)\n    ); ");
insert_options("status_giao_dich_gan_day", 1);
insert_options("content_gd_mua_gan_day", "<b style=\"color: green;\">...{username}</b> mua <b style=\"color: red;\">{amount}</b> <b>{product_name}</b> với giá <b style=\"color:blue;\">{price}</b>");
insert_options("content_gd_nap_tien_gan_day", "<b style=\"color: green;\">...{username}</b> thực hiện nạp <b style=\"color:blue;\">{amount}</b> bằng <b style=\"color:red;\">{method}</b> thực nhận <b style=\"color:blue;\">{received}</b>");
insert_options("status_tao_gd_ao", 0);
insert_options("sl_mua_toi_thieu_gd_ao", 1);
insert_options("sl_mua_toi_da_gd_ao", 10);
insert_options("toc_do_gd_mua_ao", 5);
insert_options("menh_gia_nap_ao_ngau_nhien", "10000\n20000\n40000\n50000\n60000\n70000\n100000\n200000\n300000\n500000\n400000\n40000\n15000\n25000\n35000\n45000\n55000\n65000\n45000\n100000\n1500000\n200000");
insert_options("toc_do_gd_nap_ao", 5);
insert_options("method_nap_ao", "ACB\nMB\nUSDT\nPayPal");
insert_options("tao_gd_ao_sp_het_hang", 1);
$CMSNT->query(" ALTER TABLE `order_log` ADD `is_virtual` INT(11) NOT NULL DEFAULT '0' AFTER `create_time` ");
insert_options("check_time_cron_cron", 0);
insert_options("blog_status", 1);
$CMSNT->query(" ALTER TABLE `product_sold` ADD `time_check_live` INT(11) NOT NULL DEFAULT '0' AFTER `create_gettime` ");
$CMSNT->query(" ALTER TABLE `product_order` ADD `refund` INT(11) NOT NULL DEFAULT '0' AFTER `trash` ");
insert_options("cong_tien_nguoi_ban", 0);
insert_options("noti_buy_product", "[{time}] <b>{username}</b> vừa mua {amount} tài khoản {product} với giá {pay} - #{trans_id}");
$CMSNT->query(" ALTER TABLE `products` ADD `flag` TEXT NULL DEFAULT NULL AFTER `max` ");
$CMSNT->query(" CREATE TABLE `automations` ( `id` INT NOT NULL AUTO_INCREMENT , `name` TEXT NULL DEFAULT NULL , `type` VARCHAR(55) NULL DEFAULT NULL , `product_id` LONGTEXT NULL DEFAULT NULL , `schedule` INT(11) NOT NULL DEFAULT '0' , `other` TEXT NULL DEFAULT NULL , `create_gettime` DATETIME NOT NULL , `update_gettime` DATETIME NOT NULL , PRIMARY KEY (`id`)) ");
$CMSNT->query(" ALTER TABLE `payment_momo` CHANGE `id` `id` INT(11) NOT NULL AUTO_INCREMENT ");
insert_options("check_time_cron_task", 0);
insert_options("thoi_gian_mua_cach_nhau", 3);
insert_options("max_register_ip", 5);
$CMSNT->query(" ALTER TABLE `suppliers` ADD `check_string_api` VARCHAR(55) NOT NULL DEFAULT 'ON' AFTER `update_gettime` ");
insert_options("time_cron_suppliers_api20", 0);
insert_options("status_menu_tools", 0);
insert_options("debug_auto_bank", 0);
$CMSNT->query(" ALTER TABLE `product_order` ADD `note` TEXT NULL DEFAULT NULL AFTER `api_transid` ");
insert_options("time_cron_suppliers_api9", 0);
insert_options("debug_api_suppliers", 1);
insert_options("order_by_product_home", 1);
insert_options("token_webhook_web2m", "");
insert_options("time_cron_suppliers_api21", 0);
$CMSNT->query(" ALTER TABLE `products` ADD `text_txt` TEXT NULL DEFAULT NULL AFTER `api_time_update` ");
$CMSNT->query(" ALTER TABLE product_die DROP INDEX uid ");
$CMSNT->query(" ALTER TABLE product_die ADD UNIQUE (uid) ");
insert_options("time_cron_suppliers_api17", 0);
$CMSNT->query(" ALTER TABLE `products` ADD `order_by` INT(11) NOT NULL DEFAULT '1' AFTER `text_txt` ");
insert_options("api_check_live_gmail", "");
insert_options("api_key_check_live_gmail", "");
insert_options("time_cron_checklive_gmail", 0);
insert_options("time_limit_check_live_gmail", 1800);
$CMSNT->query(" ALTER TABLE `product_sold` ADD `type` VARCHAR(55) NULL DEFAULT 'WEB' AFTER `time_check_live` ");
insert_options("widget_zalo1_status", 0);
insert_options("widget_zalo1_sdt", "");
insert_options("widget_phone1_status", 0);
insert_options("widget_phone1_sdt", "");
$CMSNT->query(" CREATE TABLE `payment_flutterwave` ( `id` INT NOT NULL AUTO_INCREMENT , `user_id` INT(11) NOT NULL DEFAULT '0' , `tx_ref` VARCHAR(55) NULL DEFAULT NULL , `amount` FLOAT NOT NULL DEFAULT '0' , `currency` TEXT NULL DEFAULT NULL , `create_gettime` DATETIME NOT NULL , `update_gettime` DATETIME NOT NULL , `status` VARCHAR(55) NOT NULL DEFAULT 'pending' , PRIMARY KEY (`id`)) ");
insert_options("flutterwave_status", 0);
insert_options("flutterwave_rate", 16);
insert_options("flutterwave_currency_code", "NGN");
insert_options("flutterwave_publicKey", "");
insert_options("flutterwave_secretKey", "");
insert_options("flutterwave_notice", "");
insert_options("limit_block_ip_login", 5);
insert_options("limit_block_client_login", 10);
$CMSNT->query(" CREATE TABLE `failed_attempts` ( `id` INT NOT NULL AUTO_INCREMENT , `ip_address` VARCHAR(45) NULL DEFAULT NULL , `attempts` INT(11) NOT NULL DEFAULT '0' , `create_gettime` DATETIME NOT NULL , `type` VARCHAR(55) NULL DEFAULT NULL , PRIMARY KEY (`id`)) ");
insert_options("limit_block_ip_api", 20);
insert_options("limit_block_ip_admin_access", 5);
insert_options("time_cron_suppliers_api22", 0);
insert_options("isPurchaseIpVerified", 0);
insert_options("isPurchaseDeviceVerified", 0);
$CMSNT->query(" CREATE TABLE `payment_manual` ( `id` INT NOT NULL AUTO_INCREMENT , `icon` TEXT NULL DEFAULT NULL , `title` TEXT NULL DEFAULT NULL , `description` TEXT NULL DEFAULT NULL , `content` LONGTEXT NULL DEFAULT NULL , `display` INT(11) NOT NULL DEFAULT '0' , `create_gettime` DATETIME NOT NULL , `update_gettime` DATETIME NOT NULL , PRIMARY KEY (`id`)) ");
$CMSNT->query(" ALTER TABLE `payment_manual` ADD `slug` TEXT NULL DEFAULT NULL AFTER `title` ");
$CMSNT->query(" ALTER TABLE `log_ref` CHANGE `id` `id` INT(11) NOT NULL AUTO_INCREMENT, add PRIMARY KEY (`id`) ");
insert_options("footer_card", "<a href=\"#\"><img src=\"/public/client/images/payment/jpg/01.jpg\" alt=\"payment\"></a>\n<a href=\"#\"><img src=\"/public/client/images/payment/jpg/02.jpg\" alt=\"payment\"></a>\n<a href=\"#\"><img src=\"/public/client/images/payment/jpg/03.jpg\" alt=\"payment\"></a>\n<a href=\"#\"><img src=\"/public/client/images/payment/jpg/04.jpg\" alt=\"payment\"></a>");
insert_options("notice_orders", "");
$CMSNT->query(" ALTER TABLE `menu` ADD `parent_id` INT(11) NOT NULL DEFAULT '0' AFTER `id` ");
insert_options("widget_fbzalo2_status", 0);
insert_options("widget_fbzalo2_zalo", "");
insert_options("widget_fbzalo2_fb", "");
$CMSNT->query(" ALTER TABLE `payment_flutterwave` ADD `price` FLOAT NOT NULL DEFAULT '0' AFTER `amount` ");
insert_options("time_cron_suppliers_api23", 0);
insert_options("show_btn_category_home", 0);
$CMSNT->query(" ALTER TABLE `suppliers` ADD `sync_category` VARCHAR(55) NOT NULL DEFAULT 'OFF' AFTER `update_name` ");
$CMSNT->query(" ALTER TABLE `categories` ADD `supplier_id` INT(11) NOT NULL DEFAULT '0' AFTER `id_api` ");
insert_options("time_cron_suppliers_api24", 0);
function insert_options($name, $value)
{
    global $CMSNT;
    if(!$CMSNT->get_row("SELECT * FROM `settings` WHERE `name` = '" . $name . "' ")) {
        $CMSNT->insert("settings", ["name" => $name, "value" => $value]);
    }
}

?>