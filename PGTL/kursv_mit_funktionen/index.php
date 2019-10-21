<?php
/*
 * Steiner Alexander 3ATIX 19/10/2018
 * Aufgabe - Kursverwaltung
 * index.php
 */
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="style.css">
    <title>Kursverwaltung</title>
</head>
<body>
<main>
    <div class="column left">
        <form method="get">
            <a href="?page=index">Startseite</a> <br>
            <a href="?page=kursliste">Kursliste</a> <br>
            <a href="?page=reg">Registrierung</a> <br>
        </form>
    </div>

    <div class="column right">
        <?php
        include_once 'config.php';
        include_once 'funktion.php';

        if(isset($_GET['page'])){
            switch($_GET['page']) {
                case "kursliste":
                    include 'kursliste.php';
                    break;
                case "reg":
                    include 'registrierung_erweitert.php';
                    break;
                case "index":
                    include 'index_content.php';
                    break;
                default:
                    include 'index_content.php';
            }
        } else {
            include_once 'index_content.php';
        }
        ?>
    </div>
</main>
</body>
</html>