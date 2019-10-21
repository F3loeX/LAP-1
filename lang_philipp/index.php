<?php
/**
 * Created by PhpStorm.
 * User: Philipp Lang
 * Date: 17.01.2019
 * Time: 07:54
 *
 * Startseite, Liste aller zur Zeit in der Datenbank vorhandenen Theaterstuecke inkl. Autor und Erstauffuehrungstermin.
 *
 */

?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Startseite</title>
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
        <h1>Willkommen im Theater der Zukunft</h1>
        <h3>Wir zeigen und zeigten</h3>
        <?php
        try {
            $query = 'select dra.dra_id as "Nr.", ge.gen_name as "Genre", dra.dra_name as "Name des Stücks", concat_ws(\' \', per.per_vName, per.per_nName) as "Autor", drev.eve_termin as "Erstaufführung"  from drama dra 
left outer join genre ge
on dra.gen_id = ge.gen_id
left outer join dramaevent drev
on dra.dra_id = drev.dra_id
left outer join person per
on dra.autor_id = per.per_id
group by dra.dra_name
order by dra.dra_id;';

            $statement = $con->prepare($query);
            $statement->execute();

            printTable($statement);

        } catch (Exception $e) {
            echo 'Tabelle wurde nicht gefunden. Bitte Pr&uuml;en Sie ihre Datenbank.';
            echo $e->getMessage() . '<br>';
        }
        ?>
    </div>

</body>
</html>
