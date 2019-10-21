<!DOCTYPE HTML>
<html>
<head>
    <title>Theater</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="css/rezept.css" rel="stylesheet" type="text/css">
</head>
<body>
<nav>
    <?php
    include 'nav.html';
    ?>
</nav>
<main>
    <br>
<?php
include 'funktionen/funktionen.php';
$con = DBConnection('localhost', 'root', '', 'rezept');
if(!isset($_GET['seite']))
{
    include 'src/welcome.php';
} else
{


    switch($_GET['seite'])
    {
        case 'einheit':
            include 'src/einheit.php'; break;
        case 'zutat':
            include'src/zutat.php'; break;
        case 'rezept':
            include 'src/rezept.php'; break;
        case 'suche':
            include'src/suche.php'; break;
        default:
            include 'src/welcome.php';
    }
}
?>
</main>
</body>
</html>
