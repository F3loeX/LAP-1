<?php
/**
 * Created by PhpStorm.
 * User: Philipp Lang
 * Date: 17.01.2019
 * Time: 08:43
 *
 * Such nach einem bestimmten Theaterstueck
 *
 */

?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Suche nach Theaterst&uuml;ck</title>
    <?php
    include 'config.php';
    require('functions.php');
    ?>
</head>
<body>
<nav>
    <?php
    include'menu.php';
    ?>
</nav>
<div class="container topContainer">

    <?php

    if(isset($_POST['startSearch'])) {

        try {
            if(isset($_POST['searchString'])) {
                $sarchSting = $_POST['searchString'];
            } else {
                $sarchSting = "";
            }

            $sarchSting = '%' . $sarchSting . '%';


            $query = 'select dra.dra_name as "Drama", ge.gen_name as "Genre", concat_ws(\' \', per.per_vName, per.per_nName) as "Autor", concat_ws(\' \', date_format(drev.eve_termin, "%a, %M. %Y - %h:%m"), \'Uhr \') as "Erstaufführung" from drama dra 
left outer join genre ge
on dra.gen_id = ge.gen_id
left outer join dramaevent drev
on dra.dra_id = drev.dra_id
left outer join person per
on dra.autor_id = per.per_id
where dra.dra_name like ?
group by dra.dra_name
order by drev.eve_termin;';

            $statement = $con->prepare($query);
            $statement->bindParam(1, $sarchSting);
            $statement->execute();

            printTable($statement);

        } catch (Exception $e) {
            echo 'Tabelle wurde nicht gefunden/oder der Eingebatewert ist fehlerhaft.';
            echo $e->getMessage() . '<br>';
        }

    } else {

        ?>
    <div>
        <h1>Theaterst&uuml;ck suchen</h1>
        <form method="post">
            <label for="searchField">Titel des gesuchten St&uuml;cks:</label>
            <input type="text" placeholder="z.B. romeo" id="searchField" name="searchString">
            <br>
            <br>
            <input type="submit" value="Suche starten" name="startSearch">
        </form>
    </div>


    <?php


    }

    ?>

</div>

</body>
</html>