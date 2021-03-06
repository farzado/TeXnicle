<?php

require("profileConfig.php");
require("profileDB.php");

$debug = 0;

if (array_key_exists('appName', $_GET)) {
  // connect to the database
  if (!TryOpenDB()) {
  	abortAndExit();
  }

  if ($debug) {
  	print "<html><head><title>debug</title></head><body>\n";
  }
  // Record the report
  $report_date = strftime("%Y-%m-%d %H:%M:%S");
  $queryString = "INSERT INTO profileReport (IP_ADDR, REPORT_DATE) VALUES (\"". $_SERVER["REMOTE_ADDR"] . "\",\"" . $report_date .  "\")";
  if ($debug) {
  	print "$queryString<br />";
  }

  $sqlResult = mysql_query($queryString);
  if (!$sqlResult) {
  	abortAndExit();
  }
  $record_id = mysql_insert_id();

  global $appcastKeys;

  // parse the data report
  while (list($key, $value) = each($_GET)) {

  // Date, 
  	if (array_key_exists($key, $appcastKeys) && $appcastKeys[$key] == 1) {
	
  		$value = mysql_real_escape_string($value);
	
  		$queryString = "INSERT INTO reportRecord (REPORT_KEY, REPORT_VALUE, REPORT_ID) VALUES (\"" . $key . "\",\"" . $value . "\",\"" . $record_id . "\")";
  		if ($debug) {
  			print "$key: $value<br />\n";
  			print "$queryString<br />";
  		}
	
  		$sqlResult = mysql_query($queryString);
  		if (!$sqlResult) {
  			abortAndExit();
  		}
  	}

  }

  CloseDB();
  if ($debug) {
  	print "</body>\n";
  	exit();
  }
}

header("content-type: application/xhtml+xml");

	$xml = simplexml_load_file($appcastURL);
	echo $xml->asXML();
?>
