<?php
/**
 * Philipp Lang, Übung Kursverwaltung
 * Created by PhpStorm.
 * User: admin
 * Date: 19.10.2018
 * Time: 08:02
 */

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Registrierung</title>
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
                    <?php
                    include 'config.php';

                    if(isset($_POST['sureSave']) && isset($_POST['saveVal'])){

                        if($_POST['saveVal'] == 'yes') {

                            $vn = $_POST['vorname'];
                            $nn = $_POST['nachname'];
                            $street = $_POST['strasse'];
                            $plz = $_POST['plz'];
                            $location = $_POST['ort'];

                            $query = 'INSERT INTO personen (`per_id`, `per_vorname`, `per_nachname`, `pea_id`, `per_street`, `per_plz`, `per_ort`) 
                            VALUES (NULL, :vname, :nname, 1, :strasse, :plz, :ort);';

                            try {

                                $statment = $con->prepare($query)->execute([
                                    ':nname' => $_POST['nachname'],
                                    ':vname' => $_POST['vorname'],
                                    ':strasse' => $_POST['strasse'],
                                    ':plz' => $_POST['plz'],
                                    ':ort' => $_POST['ort']
                                ]);

                                $lastInsertID = $con->lastInsertId();

                                $query = 'select * from personen where per_id = ?';

                                try {
                                    $statment = $con->prepare($query);
                                    $statment->bindParam(1, $lastInsertID);
                                    $statment->execute();
                                    echo '<h2>Pers&ouml;nliche Daten</h2>';
                                    while($row = $statment->fetch(PDO::FETCH_NUM)){
                                        if($row) {
                                            echo '<p>';
                                            echo '<label>Nachname: ' . $row[2] . '</label><br>';
                                            echo '<label>Vorname: ' . $row[1] . '</label><br>';
                                            echo '<label>Strasse: ' . $row[4] . '</label><br>';
                                            echo '<label>PLZ: ' . $row[5] . '</label><br>';
                                            echo '<label>Ort: ' . $row[6] . '</label><br>';
                                            echo '<label>Pers&ouml;nliche Daten erfasst!</label><br>';
                                            echo '<label>KundenID = ' . $row[0] . '</label>';
                                            echo '</p>';
                                        }
                                    }
                                }
                                catch (Exception $e){
                                    echo $e->getMessage(). '<br>';
                                }

                            } catch (Exception $e){
                                echo 'Datensatz wurde nicht eingef&uuml;gt: ';
                                echo $e->getMessage(). '<br>';
                            }
                        } else {
                            echo 'Datensatz wurde nicht eingef&uuml;gt!';
                        }

                    }
                    elseif (isset($_POST['save'])){
                        ?>

                        <form class="regFormSure" method="post">
                            <div class="row">
                                <div class="col-12">
                                    <p class="bigText">Sind Sie sicher, dass Sie die Daten speichern wollen?</p>
                                    <?php
                                    echo 'Vorname: ' . $_POST['vorname'] . '<br>';
                                    echo '<input name="vorname" type="hidden" value="' . $_POST['vorname'] .'">';
                                    echo 'Nachname: ' . $_POST['nachname']. '<br>';
                                    echo '<input name="nachname" type="hidden" value="' . $_POST['nachname'] .'">';
                                    echo 'Strasse: ' . $_POST['strasse']. '<br>';
                                    echo '<input name="strasse" type="hidden" value="' . $_POST['strasse'] .'">';
                                    echo 'PLZ: ' . $_POST['plz']. '<br>';
                                    echo '<input name="plz" type="hidden" value="' . $_POST['plz'] .'">';
                                    echo 'Ort: ' . $_POST['ort']. '<br>';
                                    echo '<input name="ort" type="hidden" value="' . $_POST['ort'] .'">';
                                    ?>
                                    <br>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12 text-left paddBot">
                                    <input id="saveYes" type="radio" name="saveVal" value="yes"><label for="saveYes">Ja</label><br>
                                    <input id="saveNo" type="radio" name="saveVal" value="no"><label for="saveNo">Nein</label><br>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12 text-left">
                                    <input class="inputBtn" type="submit" name="sureSave" value="Datensatz speichern">
                                </div>
                            </div>
                        </form>

                        <?php
                    }
                    else {

                        ?>

                        <h2>Registrierung</h2><br>

                        <form class="regForm" method="post">
                            <div class="row">
                                <div class="col-4">
                                    <label for="vorn">Vorname:</label>
                                </div>
                                <div class="col-8">
                                    <input id="vorn" name="vorname" type="text" required>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-4">
                                    <label for="nname">Nachname:</label>
                                </div>
                                <div class="col-8">
                                    <input id="nname" name="nachname" type="text" required>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-4">
                                    <label for="street">Strasse:</label>
                                </div>
                                <div class="col-8">
                                    <input id="street" name="strasse" type="text" required>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-4">
                                    <label for="plzID">PLZ:</label>
                                </div>
                                <div class="col-8">
                                    <input id="plzID" name="plz" type="text" required>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-4">
                                    <label for="loc">Ort:</label>
                                </div>
                                <div class="col-8">
                                    <input id="loc" name="ort" type="text" required>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12 text-left">
                                    <input class="inputBtn" type="submit" name="save" value="speichern">
                                </div>
                            </div>
                        </form>
                        <?php
                        }
                    ?>
                </main>
            </div>
        </div>
    </div>
</div>
</body>
</html>
