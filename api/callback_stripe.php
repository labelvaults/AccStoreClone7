<?php

define("IN_SITE", true);
require_once __DIR__ . "/../libs/db.php";
require_once __DIR__ . "/../config.php";
require_once __DIR__ . "/../libs/lang.php";
require_once __DIR__ . "/../libs/helper.php";
require_once __DIR__ . "/../libs/database/users.php";

$CMSNT = new DB();
$Mobile_Detect = new Mobile_Detect();

// Get the webhook secret from your Stripe dashboard
$endpoint_secret = $CMSNT->site("stripe_webhook_secret");

$payload = @file_get_contents('php://input');
$sig_header = $_SERVER['HTTP_STRIPE_SIGNATURE'];
$event = null;

try {
    $event = \Stripe\Webhook::constructEvent(
        $payload, $sig_header, $endpoint_secret
    );
} catch(\UnexpectedValueException $e) {
    // Invalid payload
    http_response_code(400);
    exit();
} catch(\Stripe\Exception\SignatureVerificationException $e) {
    // Invalid signature
    http_response_code(400);
    exit();
}

// Handle the event
switch ($event->type) {
    case 'payment_intent.succeeded':
        $paymentIntent = $event->data->object;
        
        // Get payment details
        $id = check_string($paymentIntent->id);
        $amount = check_string($paymentIntent->amount / 100); // Convert from cents
        $currency = check_string($paymentIntent->currency);
        $txRef = check_string($paymentIntent->metadata->tx_ref);
        
        // Calculate price based on rate
        $price = $amount * $CMSNT->site("stripe_rate");
        
        // Check if payment exists and is pending
        if($row = $CMSNT->get_row(" SELECT * FROM `payment_stripe` WHERE `tx_ref` = '" . $txRef . "' AND `currency` = '" . $currency . "' AND `status` = 'pending' ")) {
            $user = new users();
            $isCong = $user->AddCredits($row["user_id"], $price, __("Recharge Stripe") . " #" . $id, "TOPUP_Stripe_" . $txRef);
            
            if($isCong) {
                // Update payment status
                $CMSNT->update("payment_stripe", [
                    "status" => "success",
                    "price" => $price,
                    "update_gettime" => gettime(),
                    "amount" => $amount
                ], " `id` = '" . $row["id"] . "' AND `status` = 'pending' ");
                
                // Add to deposit log
                $CMSNT->insert("deposit_log", [
                    "user_id" => $row["user_id"],
                    "method" => "Stripe",
                    "amount" => $price,
                    "received" => $price,
                    "create_time" => time(),
                    "is_virtual" => 0
                ]);
                
                // Send notification
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
        break;
    default:
        // Unexpected event type
        http_response_code(400);
        exit();
}

http_response_code(200);
?> 