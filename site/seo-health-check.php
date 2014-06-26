<?php
ini_set("sendmail_from", " hello@realworksinternet.com "); 
$mailto[] = "hello@realworksinternet.com";
//$mailto[] = "marc@realworksmedia.com";

$name = $_POST['fname'];
$email = $_POST['femail'];
$phone = $_POST['fphone'];
$website = $_POST['fwebsite'];
$comments = $_POST['fmessage'];

$errorurl = "/opps";
$thankyouurl = "/thankyou";

if ($phone != 'Phone Number' && $email != 'Email Address') {
	$details = "$phone or $email";
} elseif ($phone != 'Phone Number') {
	$details = $phone;
} elseif ($email != 'Email Address') {
	$details = $email;
}
if (get_magic_quotes_gpc()) $message = stripslashes($message);

$subject = "RWI SEO Health Check";
$msg =
	"$name, requested an SEO Health Check &amp; Report.\n\n".
	
	"Website: $website \n".
	"Comments: ".(($comments == "Comments (optional)") ? "-" : $comments)." \n".
	"Contact $name on: $details \n";

foreach ($mailto as $mail){
	mail($mail, $subject, $msg, "From: \"$name\" <$email>\nReply-To: \"$name\" <$email>\nX-Mailer: chfeedback.php 2.02");
}
header("Location: $thankyouurl");
exit;
?>