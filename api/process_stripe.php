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
    $amount = check_string($_POST["amount"]);
    $currency = $CMSNT->site("stripe_currency_code");
    $tx_ref = "STRIPE_" . time() . "_" . random("123456789", 5);

    try {
        \Stripe\Stripe::setApiKey($CMSNT->site("stripe_secret_key"));

        $payment_intent = \Stripe\PaymentIntent::create([
            "amount" => $amount * 100, // Convert to cents
            "currency" => strtolower($currency),
            "automatic_payment_methods" => [
                "enabled" => true,
            ],
            "metadata" => [
                "tx_ref" => $tx_ref
            ]
        ]);

        $CMSNT->insert("payment_stripe", [
            "user_id" => $getUser["id"],
            "tx_ref" => $tx_ref,
            "amount" => $amount,
            "currency" => $currency,
            "create_gettime" => gettime(),
            "update_gettime" => gettime(),
            "status" => "pending"
        ]);

        echo json_encode([
            "status" => "success",
            "client_secret" => $payment_intent->client_secret
        ]);
    } catch (Exception $e) {
        echo json_encode([
            "status" => "error",
            "message" => $e->getMessage()
        ]);
    }
}

?> 