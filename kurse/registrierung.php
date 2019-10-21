<?php
require 'header.php';
?>

<div class="kurs" id="kurs">
    <div class="container">
        <div class="row">
            <div class="four columns navigation">
                <nav>
                    <?php require 'menu.php'; ?>
                </nav>
            </div>
            <div class="Registrierung">
                <div class="eight columns">
                <h2>Registrierung</h2>
                <?php
                include 'config.php';
   
                if(isset($_POST['speichern']))
                {

                    echo "FORMULARDATEN VERARBEITEN<br>";

                    $vname = $_POST['vname'];
                    $nname = $_POST['nname'];
                    $strasse = $_POST['strasse'];
                    $str_nr = $_POST['str_nr'];
                    $plz = $_POST['plz'];
                    $ort = $_POST['ort'];

                    echo 'Folgende Person wird gespeichert: ' . $vname . ' ' . $nname . '<br>';

                    $query = 'insert into personen (per_id, per_vorname, per_nachname, fir_id, pea_id, per_strasse, per_str_nr, per_plz, per_ort) values (NULL, :per_vorname, :per_nachname, 1, 1, :per_strasse, :per_str_nr, :per_plz, :per_ort)';

                    try
                    {
                        $stmt = $con->prepare($query);

                        $stmt->execute([
                            'per_nachname' => $nname,
                            'per_vorname' => $vname,
                            'per_strasse' => $strasse,
                            'per_str_nr' => $str_nr,
                            'per_plz' => $plz,
                            'per_ort' => $ort,

                        ]);

                        $id = $con->lastInsertId();

                        $query = 'Select * from personen where per_id = ' .$id;

                        $stmt = $con->prepare($query);
                        $stmt->execute();

                        $row = $stmt->fetch(PDO::FETCH_NUM);
                        //print_r ($row);

                        ?>

                        <ul class="reg_liste">
                            <li><?php echo $row[1]; ?></li>
                            <li> <?php echo $row[2]; ?></li>
                            <li><?php   echo $row[3]; ?></li>
                            <li> <?php   echo $row[4]; ?></li>
                            <li><?php   echo $row[5]; ?></li>
                            <li><?php   echo 'Persönliche Daten erfasst'; ?></li>
                            <li><?php   echo 'KundenID = '. $row[0]; ?></li>
                        </ul>

                        <?php

                    } catch(Exception $e)
                    {
                        echo 'Datensatz wurde nicht eingefügt';
                        echo $e->getMessage() . '<br>';
                    }

                } else {
                    // Formular anzeigen
                    ?>

                    <form method="post">
                        <div class="form-group">
                          <label class="control-label col-md-3" for="vn_id">Vorname:</label><input type="text" name="vname" id="vn_id"><br>
                          <label class="control-label col-md-3" for="vn_id">Nachname:</label><input type="text" name="nname" id="nn_id"><br>
                          <label class="control-label col-md-3" for="str_id">Strasse:</label><input type="text" name="strasse" id="str_id"><br>
                          <label class="control-label col-md-3" for="str_nr_id">Hausnummer:</label><input type="text" name="str_nr" id="str_nr_id"><br>
                          <label class="control-label col-md-3" for="plz_id">PLZ:</label><input type="text" name="plz" id="plz_id"><br>
                          <label class="control-label col-md-3" for="ort_id">Ort:</label><input type="text" name="ort" id="ort_id"><br>
                          <input class="control-label col-md-3" type="submit" name="speichern" value="speichern">
                        </div>
                    </form>
                <?php
                }
                ?>
                </div>
            </div>
        </div>
    </div>         
</div>

</html>
