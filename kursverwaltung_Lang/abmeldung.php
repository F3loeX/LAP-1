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
    <title>Abmeldung</title>
    <link rel="stylesheet" href="layout.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
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
                <div class="col-8 offset-1 itemBox ">
                    <main>
                        <h2>Kursabmeldung</h2><br>
                        <?php
                        include 'config.php';


                        if(isset($_POST['derolle'])) {

                            if(isset($_POST['per'])){
                                $perID = $_POST['per'];
                            }

                            $query = 'delete from kurse_personen where per_id = :per_id AND kur_id = :kur_id ;';

                            try {

                                $statment = $con->prepare($query)->execute([
                                    ':kur_id' => $_POST['kur'],
                                    ':per_id' => $perID
                                ]);

                                $query = 'select kur.kur_id as "Kurs_ID", be.bez_bezeichnung as "Bezeichnung", date_format(kur.kur_start, \'%Y-%m-%d\') as "Startdatum", concat_ws(\' \', per.per_vorname, per.per_nachname) as "Vortragender" from kurse_personen kupe
                left outer join kurse kur
                using (kur_id)
                left outer join personen per
                using (per_id)
                left outer join bezeichnung be
                using (bez_id)
                where kupe.per_id = ?;';

                                try {
                                    $statment = $con->prepare($query);
                                    $statment->bindParam(1, $perID);
                                    $statment->execute();

                                    while($row = $statment->fetch(PDO::FETCH_NUM)){
                                        if($row) {
                                            echo '<p>';
                                            echo '<label>Kunde wurde <b>abgemeldet</b></label><br><br>';
                                            echo '<label>' . $row[1] .'</label><br>';
                                            echo '<label>' . $row[2] .'</label><br>';
                                            echo '<label>' . $row[3] .'</label><br>';
                                            echo '</p>';
                                        }
                                    }
                                }
                                catch (Exception $e){
                                    echo $e->getMessage(). '<br>';
                                }

                            } catch (Exception $e){
                                echo 'Datensatz wurde nicht eingefügt: ';
                                echo $e->getMessage(). '<br>';
                            }

                        }
                        elseif (isset($_POST['choosePerson']) && isset($_POST['per'])) {

                            if (isset($_POST['per'])){
                                $perID = $_POST['per'];
                            }

                            echo 'Alle Kurse f&uuml;r: ' . $perID . '<br><br>';

                            echo '<form method="post">';

                            $query = 'select kur.kur_id, be.bez_bezeichnung, date_format(kur.kur_start, "%Y-%m-%d") from kurse kur
                            left join bezeichnung be
                            using (bez_id)
                            left join kurse_personen kupe
                            using (kur_id)
                            left join personen per 
                            using (per_id)
                            where per.per_id = ? and kur.kur_ende > sysdate();';

                            try {
                                $statment = $con->prepare($query);
                                $statment->bindParam(1, $perID);
                                $statment->execute();
                                echo '<select name="kur">';
                                while ($row = $statment->fetch(PDO::FETCH_NUM)) {

                                    echo '<option value="' . $row[0] . '">' . $row[1] . ' ' . $row[2];
                                }
                                echo '</select><br><br>';
                            } catch (Exception $e) {
                                echo $e->getMessage() . '<br>';
                            }

                            echo '<input type="submit" name="derolle" value="Abmelden">
                       </form>';


                        }
                        else {

                            echo '<form method="post">';
                            echo '<div class="row"><div class="col-2"><label>Kunde:</label></div>';

                            $query = 'select DISTINCT per.per_id, per.per_vorname, per.per_nachname from personen per;';

                            try {
                                $statment = $con->prepare($query);
                                $statment->execute();
                                echo '<div class="col-10"><select id="personSelect" name="per">';
                                while ($row = $statment->fetch(PDO::FETCH_NUM)) {
                                    echo '<option value="' . $row[0] . '">' . $row[2] . ' ' . $row[1];
                                }
                                echo '</select></div></div><br><br>';
                            } catch (Exception $e) {
                                echo $e->getMessage() . '<br>';
                            }


                            echo '<input type="submit" name="choosePerson" value="Kurse anzeigen">
                       </form>';
                        }
                        ?>

                    </main>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
