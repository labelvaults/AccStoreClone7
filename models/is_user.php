<?php

if(!defined("IN_SITE")) {
    exit("The Request Not Found");
}
$CMSNT = new DB();
if(isset($_COOKIE["token"])) {
    $getUser = $CMSNT->get_row(" SELECT * FROM `users` WHERE `token` = '" . check_string($_COOKIE["token"]) . "' ");
    if(!$getUser) {
        header("location: " . BASE_URL("client/logout"));
        exit;
    }
    $_SESSION["login"] = $getUser["token"];
}
if(!isset($_SESSION["login"])) {
    redirect(base_url("client/login"));
} else {
    $getUser = $CMSNT->get_row(" SELECT * FROM `users` WHERE `token` = '" . check_string($_SESSION["login"]) . "'  ");
    if(!$getUser) {
        redirect(base_url("client/login"));
    }
    if($getUser["banned"] != 0) {
        redirect(base_url("common/banned"));
    }
    if($getUser["money"] < -500) {
        $User = new users();
        $User->Banned($getUser["id"], "Tài khoản âm tiền, ghi vấn bug");
        redirect(base_url("common/banned"));
    }
    if(!empty($getUser["token_forgot_password"])) {
        $CMSNT->update("users", ["token_forgot_password" => NULL], " `id` = '" . $getUser["id"] . "' ");
    }
    $CMSNT->update("users", ["time_session" => time()], " `id` = '" . $getUser["id"] . "' ");
}

?>