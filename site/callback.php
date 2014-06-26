<?php
ini_set("sendmail_from", "hello@hudhosting.com");
$mailto[] = "hello@hudhosting.com";

$subject = "HudHosting Callback";

$name = $_POST['fname'];
$phone = $_POST['fphone'];
$referrer = getenv("HTTP_REFERER");

$errorurl = "/opps.htm";
$thankyouurl = "/thankyou.htm";

if ($name == "Full Name" || $phone == "Phone Number"){
	header("Location: $errorurl");
	exit;
}

if (get_magic_quotes_gpc()) $message = stripslashes($message);

$msg =
	"$name, sent the following message from '$referrer':\n\n".

	"Call $name on: $phone \n";

foreach ($mailto as $mail){
	mail($mail, $subject, $msg, "From: \"$name\" <$email>\nReply-To: \"$name\" <$email>\nX-Mailer: chfeedback.php 2.02");
}
header("Location: $thankyouurl");
exit;
?>