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
            <div class="kursliste">
                <div class="eight columns">
                <h2>Kursliste</h2>
                <?php
                include 'config.php';

                $query = 'SELECT kur_id as Kurs_ID, kur_bezeichnung as Bezeichnung, kur_start as Startdatum, concat_ws(" ", per_vorname, per_nachname ) as Vortragender 
                          FROM kurse_personen 
                          left join kurse using(kur_id) 
                          left join personen using(per_id)
                          where kupe_isLeader = 1';
                //$query = 'select * from kurse';
                try
                {
                    $stmt = $con->prepare($query);
                    $stmt->execute();

                    $meta = [];

                    echo '<table border="1"><tr>';
                    for($i = 0; $i < $stmt->columnCount(); $i++)
                    {
                        $meta[$i] = $stmt->getColumnMeta($i);
                        echo '<th>' . $meta[$i]['name'] . '</th>';
                    }
                    echo '<br>';
                    echo '</tr>';
                    while($row = $stmt->fetch(PDO::FETCH_NUM))
                    {
                        echo '<tr>';
                        foreach ($row as $r)
                        {
                            echo '<td>'. $r . '</td>';
                        }
                        echo '</tr>';
                    }
                    echo '</table>';
                } catch(Exception $e)
                {
                    echo $e->getMessage() . '<br>';
                }

                ?>
                </div>
            </div>
        </div>
    </div>         
</div>

</html>

   