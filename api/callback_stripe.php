<?php

define("IN_SITE", true);
require_once __DIR__ . "/../libs/db.php";
require_once __DIR__ . "/../config.php";
require_once __DIR__ . "/../libs/lang.php";
require_once __DIR__ . "/../libs/helper.php";
require_once __DIR__ . "/../libs/database/users.php";

$CMSNT = new DB();
$Mobile_Detect = new Mobile_Detect();

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $payload = @file_get_contents("php://input");
    $sig_header = $_SERVER["HTTP_STRIPE_SIGNATURE"];
    $webhook_secret = $CMSNT->site("stripe_webhook_secret");

    try {
        $event = \Stripe\Webhook::constructEvent(
            $payload, $sig_header, $webhook_secret
        );
    } catch(\UnexpectedValueException $e) {
        http_response_code(400);
        exit();
    } catch(\Stripe\Exception\SignatureVerificationException $e) {
        http_response_code(400);
        exit();
    }

    if ($event->type == "payment_intent.succeeded") {
        $payment_intent = $event->data->object;
        $tx_ref = $payment_intent->metadata->tx_ref;
        $amount = $payment_intent->amount / 100; // Convert from cents to dollars
        $currency = strtoupper($payment_intent->currency);
        $price = $amount * $CMSNT->site("stripe_rate");

        if ($row = $CMSNT->get_row(" SELECT * FROM `payment_stripe` WHERE `tx_ref` = '" . $tx_ref . "' AND `currency` = '" . $currency . "' AND `status` = 'pending' ")) {
            $user = new users();
            $isCong = $user->AddCredits($row["user_id"], $price, __("Recharge Stripe") . " #" . $payment_intent->id, "TOPUP_Stripe_" . $tx_ref);
            
            if ($isCong) {
                $CMSNT->update("payment_stripe", [
                    "status" => "success",
                    "price" => $price,
                    "update_gettime" => gettime(),
                    "amount" => $amount
                ], " `id` = '" . $row["id"] . "' AND `status` = 'pending' ");

                $CMSNT->insert("deposit_log", [
                    "user_id" => $row["user_id"],
                    "method" => "Stripe",
                    "amount" => $price,
                    "received" => $price,
                    "create_time" => time(),
                    "is_virtual" => 0
                ]);

                $my_text = $CMSNT->site("noti_recharge");
                $my_text = str_replace("{domain}", $_SERVER["SERVER_NAME"], $my_text);
                $my_text = str_replace("{username}", getRowRealtime("users", $row["user_id"], "username"), $my_text);
                $my_text = str_replace("{method}", "Stripe", $my_text);
                $my_text = str_replace("{amount}", $price, $my_text);
                $my_text = str_replace("{price}", $price, $my_text);
                $my_text = str_replace("{time}", gettime(), $my_text);
                sendMessAdmin($my_text);
            }
        }
    }

    http_response_code(200);
    exit();
}

?> 