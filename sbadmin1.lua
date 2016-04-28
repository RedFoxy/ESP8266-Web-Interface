<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="">
  <meta name="author" content="">
  <title>ESP8266 Web Interface</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
  <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/metisMenu/2.5.0/metisMenu.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/startbootstrap-sb-admin-2/1.0.8/css/timeline.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/startbootstrap-sb-admin-2/1.0.8/css/sb-admin-2.min.css">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">
  <style>
  .circle {
    width: 30px;
    height: 30px;
    border-radius: 50%;
    margin: 0 auto;
    background-color: silver;
  }
  </style>
<body>
<div id="wrapper">
  <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="/">ESP8266 Web Interface</a></div>
      <div class="navbar-default sidebar" role="navigation">
        <div class="sidebar-nav navbar-collapse">
          <ul class="nav" id="side-menu">
            <li><a href="/"><i class="fa fa-dashboard fa-fw"></i> Dashboard</a></li>
            <li>
              <a href="#"><i class="fa fa-wrench fa-fw"></i> Configurazione<span class="fa arrow"></span></a>
              <ul class="nav nav-second-level">
                <li><a href="/wifi"><i class="fa fa-sitemap fa-fw"></i> WiFi</a></li>
                <li><a href="/pref"><i class="glyphicon glyphicon-time"></i> Tempi di azione</a></li>
              </ul>
            </li>
          </ul>
        </div>
      </div>
    </nav>
    <div id="page-wrapper">
