<?php
require 'header.php';
?>

<div class="kurs" id="kurs">
    <div class="container">
        <div class="row">
            <div class ="navigation">
                <div class="four columns">
                    <nav>
                        <?php require 'menu.php'; ?>
                    </nav>
                </div>
            </div>
            <div class="Anmeldung">
                <div class="eight columns">
                <h2>Kursanmeldung</h2>

                <?php
                include 'config.php';
                if(isset($_POST['anmelden']))
                {
                    echo "FORMULARDATEN VERARBEITEN<br>";

                    $per_id  = $_POST['per'];
                    $kurs = $_POST['kurs'];

                    echo 'Folgende Daten werden gespeichert: ' . $per_id . ' ' . $kurs . '<br>';

                    $query = 'insert into kurse_personen (kupe_id, kur_id, per_id, kupe_isLeader) values (NULL, :kur_id, :per_id, 0)';

                    try
                    {

                        $stmt = $con->prepare($query);

                        $stmt->execute([
                            'per_id' => $per_id,
                            'kur_id' => $kurs
                        ]);
                        if($con->lastInsertId() > 1)
                        {
                            echo 'Datensatz wurde eingefügt<br>';
                        }


                    } catch(Exception $e)
                    {
                        echo 'Datensatz wurde nicht eingefügt';
                        echo $e->getMessage() . '<br>';
                    }


                } else
                {
                    // Formular anzeigen
                    echo '<form method="post">';
                    echo '<label>Kunde: </label>';


                    $query1 = 'select per_id, per_vorname, per_nachname  from personen order by per_nachname, per_vorname';

                    try
                    {
                        $stmt1 = $con->prepare($query1);
                        $stmt1->execute();
                        echo '<select name="per">';
                        while($row1 = $stmt1->fetch(PDO::FETCH_NUM))
                        {
                            echo '<option value="' . $row1[0] . '">' . $row1[1] . ' ' . $row1[2] . '</option>';
                        }
                        echo '</select><br>';

                    } catch(Exception $e)
                    {
                        echo $e->getMessage() . '<br>';
                    }

                    echo '<form method="post">';
                    echo '<label>Kurs: </label>';

                    $query1 = 'select * from kurse';

                    try
                    {
                        $stmt1 = $con->prepare($query1);
                        $stmt1->execute();
                        echo '<select name="kurs">';
                        while($row1 = $stmt1->fetch(PDO::FETCH_NUM))
                        {
                            echo '<option value="' . $row1[0] . '">' . $row1[1] . '</option>';
                        }
                        echo '</select><br>';

                    } catch(Exception $e)
                    {
                        echo $e->getMessage() . '<br>';
                    }
                    echo '<input type="submit" name="anmelden" value="anmelden">
                        </form>';

                }

                ?>
                </div>
            </div>
        </div>
    </div>         
</div>

</html>
