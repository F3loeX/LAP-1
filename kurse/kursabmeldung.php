<?php
require 'header.php';
?>

<div class="kurs" id="kurs">
    <div class="container">
        <div class="row">
            <div class ="navigation">
                <div class="four columns navigation">
                    <nav>
                        <?php require 'menu.php'; ?>
                    </nav>
                </div>
            </div>
            <div class="Anmeldung">
                <div class="eight columns">
                <h2>Kursabmeldung</h2>

                <?php
                include 'config.php';
                if(isset($_POST['abmelden']))
                {
                    echo "FORMULARDATEN VERARBEITEN<br>";
                    //$per_id  = $_POST['per'];
                    $per_id = explode(",", $_POST["per"]);
                    print_r($per_id);
                    
                    echo 'Folgende Daten werden gelöscht: ' . $per_id[0] . ' ' . $per_id[1] . '<br>';

                    $query = 'delete from kurse_personen where per_id = :per_id and kur_id = :kur_id ';

                    try
                    {

                        $stmt = $con->prepare($query);

                        $stmt->execute([
                            'per_id' => $per_id[0],
                            'kur_id' => $per_id[1]
                        ]);

                        echo 'Datensatz wurde entfernt<br>';


                    } catch(Exception $e)
                    {
                        echo 'Datensatz wurde nicht bearbeitet';
                        echo $e->getMessage() . '<br>';
                    }


                } else
                {
                    // Formular anzeigen
                    echo '<form method="post">';
                    echo '<label>Kunde: </label>';


                    $query1 = 'select per_id, per_vorname, per_nachname, kur_id, kur_bezeichnung  
                                from kurse_personen
                                join personen using(per_id)
                                join kurse using(kur_id)
                                where kupe_isLeader = 0
                                order by per_nachname, per_vorname';

                    try
                    {
                        $stmt1 = $con->prepare($query1);
                        $stmt1->execute();
                        echo '<select name="per">';
                        while($row1 = $stmt1->fetch(PDO::FETCH_NUM))
                        {
                            echo '<option value="' . $row1[0] . ',' . $row1[3] .'">' . $row1[1] . ' ' . $row1[2] . ' - ' . $row1[4] .'</option>';
                        }
                        echo '</select><br>';

                    } catch(Exception $e)
                    {
                        echo $e->getMessage() . '<br>';
                    }


                    echo '<input type="submit" name="abmelden" value="abmelden">
                        </form>';
                    
                }

                ?>
                </div>
            </div>
        </div>
    </div>         
</div>

</html>
