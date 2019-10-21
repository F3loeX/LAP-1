<?php
/**
 * Created by PhpStorm.
 * User: regin
 * Date: 02.01.2018
 * Time: 15:17
 */

if(isset($_POST['insert1']))
{
    $anzahl = $_POST['anzahl'];
    if($anzahl < 1)
        $anzahl = 1;

    ?>
    <form method="post">
    <div class="table">
        <div class="tr">
            <div class="th">
                <label for="rez">Rezeptname:</label>
            </div>
            <div class="td">
                <input type="text" id="rez" name="rezname" placeholder="z.B. Warmer Apfelstrudel" required>
            </div>
        </div>
        <div class="tr">
            <div class="th">
                <label for="rez">Zubereitung:</label>
            </div>
            <div class="td">
                <textarea name="zubereitung"></textarea>
            </div>
        </div>
        <?php
        $query = 'select zutat_einheit.zuei_id, zutat.zut_name, einheit.ein_name from zutat_einheit natural join (zutat, einheit)';
        $stmt = $rezept->GetStatement($query);
        $rowAgain = array();
        while($row = $stmt->fetch(PDO::FETCH_NUM))
        {
            $rowAgain[] = $row;

        }

        $cC = $stmt->columnCount();
        $rC = sizeof($rowAgain);

        for($i = 0; $i < $anzahl; $i++) {
            ?>
            <div class="tr">
                <div class="th">
                    <label>Menge</label>
                </div>
                <div class="td">
                    <input class="menge" type="text" name="menge[]" value="0">
                </div>
                <div class="td">
                    <select name="zutateinheit[]">
                        <?php
                        for($j = 0; $j < sizeof($rowAgain); $j++)
                        {
                            echo '<option value="'.$rowAgain[$j][0].'">'.$rowAgain[$j][1].' '.$rowAgain[$j][2];
                        }
                        ?>
                    </select>
                </div>
            </div>
        <?php
        }
        ?>
        <div class="tr">
            <div class="td">
                <?php echo '<input type="hidden" name="anzahl" value="'.$anzahl.'">'; ?>
                <input type="submit" name="insert2" value="Rezept speichern">
            </div>
        </div>
    </div>
    </form>
    <?php
} else if(isset($_POST['insert2']))
{

    $rezname = $_POST['rezname'];
    $menge = $_POST['menge'];
    $anzahl = $_POST['anzahl'];
    $zutateinheit = $_POST['zutateinheit'];
    $zubereitung = $_POST['zubereitung'];
    $pos = 0;
    while($pos < $anzahl)
    {
        if($menge[$pos] == '' || $menge[$pos] < 1)
        {
            $pos = $anzahl;
            echo '<h3>Sie haben nicht für jede Zutat eine Menge angegeben!</h3><a href="javascript:history.back()">zurück</a> ';
            exit();
        }
        $pos++;
    }
    try {
        // zuerst ermitteln, ob rezeptname bereits erfasst wurde ... ID auslesen!
        $query = 'select rez_id from rezeptname where rez_name = ?';
        $rezArray = array($rezname);
        $stmt = $rezept->GetStatement($query, $rezArray);
        $rezid = $stmt->fetch(PDO::FETCH_NUM);
        $lastID = $rezid[0];
        if($rezid <= 0) {
            $query = 'insert into rezeptname (rez_name) values(?)';

            $stmt = $rezept->GetStatement($query, $rezArray);
            $lastID = $rezept->GetLastInsertID();
        }
        $query = 'insert into zubereitung (zub_beschreibung, rez_id) values(?, ?)';
        $rezArray = array($zubereitung, $lastID);
        $stmt = $rezept->GetStatement($query, $rezArray);
        $lastIDZubereitung = $rezept->GetLastInsertID();

        for($i = 0; $i < $anzahl; $i++) {
            $query = 'insert into zubereitung_einheit values(?, ?, ?)';
            $zubereitungeinheit = array($lastIDZubereitung, $zutateinheit[$i], $menge[$i]);

            $stmt = $rezept->GetStatement($query, $zubereitungeinheit);
        }
        echo '<h3>Rezept '.$rezname.' wurde erfolgreich erfasst!<br>';
    } catch(Exception $e)
    {
        if($e->getCode() == '23000')
        {
            echo '<h3>Insert Exception: Sie haben versucht bei den Zutaten die gleiche Zutat mit anderer Menge zu erfassen!</h3><br>'.$e->getMessage();
        } else {
            echo $e->getMessage();
        }
    }

} else {
    echo '<h2>Neue Rezepte erfassen</h2>';
    ?>

<h3>Geben Sie zuerst an wie viele Zutaten das Rezept braucht:</h3>
<form method="post">
<div class="table">
    <div class="tr">
        <div class="th">
            <label for="anz">Anzahl:</label>
        </div>
    <div class="td">
        <input type="number" id="anz" name="anzahl" placeholder="mind. 1">
    </div>
    </div>
    <div class="tr">
        <div class="td">
            <input type="submit" name="insert1" value="zum Erfassen">
        </div>
    </div>
</div>
</form>
<?php
}
