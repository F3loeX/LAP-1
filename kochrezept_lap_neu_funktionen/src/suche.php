<?php
/**
 * Created by PhpStorm.
 * User: regin
 * Date: 02.01.2018
 * Time: 15:16
 */

if(isset($_POST['search']))
{
    echo '<h2>Nach Rezepten suchen</h2>';
    try {
        $rezname = $_POST['rezname'];
        echo '<h3>Gesucht wurde nach: '.$rezname.'</h3>';
        $query = 'select * from rezeptname where rez_name like ?';
        $rezname = '%'.$rezname.'%';
        $rezarray = array($rezname);
        $stmt = GetStatement($con, $query, $rezarray);
        $count = $stmt->rowCount();

        if($count == null) throw new Exception('<h3>Die Suchanfrage brachte keine Ergebnisse</h3>');
        ?>

        <form method="post">
            <div class="table">
                <div class="tr">
                    <div class="th">
                        <label for="suche">Ergebnisliste der Suche:</label>
                    </div>
                    <div class="td">

                        <select name="rezid">
                        <?php

                        while($row = $stmt->fetch(PDO::FETCH_NUM))
                        {
                            echo '<option value="'.$row[0].'">'.$row[1];

                        }
                        ?>
                        </select>

                    </div>
                </div>
                <div class="tr">
                    <div class="td">
                        <input type="submit" name="show" value="anzeigen">
                    </div>
                </div>
            </div>
        </form>
        <?php


    } catch (Exception $e)
    {
        echo $e->getMessage();
    }
} else if(isset($_POST['show'])) {

    try {
        $rezid = $_POST['rezid'];
        $rezid_suche = array($rezid);
        $query2 = 'select rez_name from rezeptname where rez_id=?';
        $stmt = GetStatement($con, $query2, $rezid_suche);
        $rezname = $stmt->fetch();
        $query = 'select * from zubereitung where rez_id=? order by rez_id';

        $stmt = GetStatement($con, $query, $rezid_suche);
        echo '<h3>Alle Ergebnisse für '.$rezname[0].':</h3>';
        while($row = $stmt->fetch(PDO::FETCH_NUM))
        {

            echo '<hr>Rezeptnummer '.$row[0].': '.$row[1];
            $query1 = 'select zubein_menge as Menge, ein_name as Einheit, zut_name as Zutat from zutat_einheit natural join (zutat, einheit) natural join zubereitung_einheit where zub_id=?';

            $zubArray = array($row[0]);
            $stmt1 = GetStatement($con, $query1, $zubArray);
            ShowTable($stmt1);
            //$rezept->CreateTableOutput($query1, $zubArray);
        }
    } catch (Exception $e)
    {
        echo $e->getMessage();
    }

}else
{
    echo '<h2>Nach Rezepten suchen</h2>';
    ?>

    <form method="post">
        <div class="table">
            <div class="tr">
                <div class="th">
                    <label for="suche">Rezeptnamen suchen (auch Wortteil möglich):</label>
                </div>
                <div class="td">
                    <input class="textonly" id="suche" type="text" name="rezname" placeholder="z.B. kuchen">
                </div>
            </div>
            <div class="tr">
                <div class="td">
                    <input type="submit" name="search" value="suchen">
                </div>
            </div>
        </div>
    </form>
    <?php
}
