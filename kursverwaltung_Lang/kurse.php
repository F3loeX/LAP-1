<?php
/**
 * Philipp Lang, Übung Kursverwaltung
 * Created by PhpStorm.
 * User: admin
 * Date: 19.10.2018
 * Time: 07:57
 */


?>

<!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Kunden erfassen</title>
        <link rel="stylesheet" href="layout.css">

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

    </head>
<body>
<div class="container-fluid mainBG">
    <div class="container siteBG">
        <div class="row">
            <div class="col-3">
                <nav>
                    <?php
                    include'menu.html';
                    ?>
                </nav>
            </div>
            <div class="col-8 offset-1 itemBox">
                <main>
                    <h2>Kursliste</h2><br>
                    <?php

                    include 'config.php';

                    $query = 'select kur.kur_id as "Kurs_ID", be.bez_bezeichnung as "Bezeichnung", date_format(kur.kur_start, \'%Y-%m-%d\') as "Startdatum", concat_ws(\' \', per.per_vorname, per.per_nachname) as "Vortragender" from personen per
                    left outer join kurse_personen kupe
                    using (per_id)
                    left outer join kurse kur
                    using (kur_id)
                    left outer join bezeichnung be
                    using (bez_id)
                    where kupe.kupe_isLeader = 1
                    order by kur.kur_id;';

                    try {
                        $statment = $con->prepare($query);
                        $statment->execute();
                        echo '<div class="container">';

                        while($row = $statment->fetch(PDO::FETCH_NUM)){
                            echo '<div class="row">';
                            foreach ($row as $item) {
                                echo '<div class="col-3">' . $item . '</div>';
                            }
                            echo '</div>';
                        }
                        echo '</div>';
                    }
                    catch (Exception $e){
                        echo $e->getMessage(). '<br>';
                    }

                    ?>
                </main>
            </div>
        </div>
    </div>
</div>
</body>
</html>