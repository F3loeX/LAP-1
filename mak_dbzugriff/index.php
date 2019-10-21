<!DOCTYPE HTML>
<html>
<head>
    <title>MAK DB Zugriff</title>
    <meta charset="utf-8">
    <link href="makdbzugriff.css" type="text/css" rel="stylesheet">
</head>
<body>
<nav>
    <?php
    include 'nav.html';
    ?>
</nav>
<main>
    <h1>Tabellen einer bestimmten DB anzeigen, mit Einschränkung der Attribute</h1>
    <?php
    //include 'DBConnect.php';
    include 'DBFunctions.php';
    if(isset($_GET['seite']))
    {
        $seite = $_GET['seite'];
        switch($seite)
        {
            case 'index':include 'start.php'; break;
            //case 'suche': include 'seiten/suche.php'; break;
        }
    } else {
        include 'start.php';
    }
    ?>
</main>
</body>
</html>