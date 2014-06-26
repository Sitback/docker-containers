<?php
ini_set("sendmail_from", "hello@hudhosting.com");
$mailto[] = "hello@hudhosting.com";
//$mailto[] = "baxxtskateshop@gmail.com";

$name = $_POST['fname'];
$email = $_POST['femail'];
$phone = $_POST['fphone'];
$message = $_POST['fmessage'];

$errorurl = "/opps";
$thankyouurl = "/thankyou";

if ($phone != 'Phone Number' && $email != 'Email Address') {
	$details = $phone.' or '.$email;
} elseif ($phone != 'Phone Number') {
	$details = $phone;
} elseif ($email != 'Email Address') {
	$details = $email;
}
if (get_magic_quotes_gpc()) $message = stripslashes($message);

$subject = "HudHosting Enquiry";
$msg =  "$name, sent the following message:\n\n".
	"$message \n\n".
	"Contact $name on: $details \n";

foreach ($mailto as $mail){
	mail($mail, $subject, $msg, "From: \"$name\" <$email>\nReply-To: \"$name\" <$email>\nX-Mailer: chfeedback.php 2.02");
}
header("Location: $thankyouurl");
exit;
?>