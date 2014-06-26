<?php

$domain = $_POST['fdomain'];
$referrer = getenv("HTTP_REFERER");

$errorurl = $referrer;
$successurl = "/secure/domainchecker.php?domain=$domain";

if ($domain == ""){
	//header("Location: $errorurl");
	exit;
} else {
  header("Location: $successurl");
}
exit;
?>