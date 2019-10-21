<!DOCTYPE HTML>
<html>
<head>
    <!-- R. Martl, 5.12.2018
    DB schule
    Übung zu PDO mit MySQL -->
    <title>Schule</title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="schule.css">
</head>
<body>
<nav>
    <?php
    include('menu.html');
    ?>
</nav>
<main>
    <?php
    include('config.php');
    include('funktion.php');

    if(!isset($_GET['menu']))
    {
        include ('start.php');
    }
    else {
        switch ($_GET['menu']) {
            case 'person':
                include('person.php');
                break;
            case 'ort':
                include('orte.php');
                break;
            default:
                include('start.php');
        }
    }
    ?>
</main>
</body>
</html>
