<?php
/**
 * Created by PhpStorm.
 * User: regin
 * Date: 08.01.2019
 * Time: 09:20
 */


if(isset($_POST['dbsel'])) {
    try {
        $dbname = $_POST['dbselect'];
        $datenbank = $dbname;
        echo '<h2>' . $dbname . '</h2>';

        $connect = new DBFunctions('localhost', 'root', '', $dbname);

        $stmt2 = $connect->GetStatement('show tables');

        echo '<form method="post">';
        while ($row = $stmt2->fetch(PDO::FETCH_NUM)) {
            foreach ($row as $r) {
                echo '<input type="radio" name="tabsel" value="' . $r . '" checked>' . $r . '<br>';
            }
        }
        echo '<input type="hidden" name="dbselname" value="'.$dbname.'">';
        echo '<input type="submit" name="tablesel" value="Tabelle auswählen">';
        echo '</form>';
    } catch (Exception $e) {
        echo $e->getMessage();
    }
} else if(isset($_POST['tablesel']))
{
    try
    {
        $dbselname= $_POST['dbselname'];
        $tabsel = $_POST['tabsel'];
        $connect = new DBFunctions('localhost', 'root', '', $dbselname);
        echo '<h2>'.$dbselname.'.'.$tabsel.'</h2>';
        $datenbank = $dbselname;
        $query2 = 'select * from '.$tabsel;
        $stmt2 = $connect->GetStatement($query2);
        /* Attribute der Tabelle zur Auswahl ausgeben ... checkbox */
        echo '<p>Sie können nun jene Attribute auswählen, die Sie anzeigen wollen. </p>';

        echo '<form method="post">
<table>';

        $countAttribute = $stmt2->columnCount();
        $meta = array();
        echo '<tr><td>&nbsp;</td>';
        for($i = 0; $i < $countAttribute; $i++)
        {
            $meta[] = $stmt2->getColumnMeta($i);
            echo '<th><input type="checkbox" name="attribut[]" value="'.$meta[$i]['name'].'">'.$meta[$i]['name'].'</th>';
        }
        echo '</tr>';
        $num = 0;


        echo '</table>';
        echo '<input type="hidden" name="dbselname" value="'.$dbselname.'">';
        echo '<input type="hidden" name="tabsel" value="'.$tabsel.'">';
        echo '<input type="submit" name="show" value="anzeigen">
                </form>';


echo '</form>';
    } catch(Exception $e)
    {
        echo $e->getMessage();
    }

} else if(isset($_POST['show'])) {
    try {
        $dbselname= $_POST['dbselname'];
        $connect = new DBFunctions('localhost', 'root', '', $dbselname);

        $tabsel = $_POST['tabsel'];
        $attribut = $_POST['attribut'];
        $sizeAttr = sizeof($attribut);
        $count = 0;
        $query = 'select ';
        foreach($attribut as $a)
        {
            if($count < $sizeAttr -1)
            {
                $query .= $a.', ';
            } else
            {
                $query .= $a;
            }
            $count++;
        }
        $query .= ' from '.$tabsel;

        $stmt = $connect->GetStatement($query);
        $connect->ShowTable($stmt);
    } catch(Exception $e)
    {
        echo $e->getMessage();
    }
}else
    {
    echo '<h3>Sie können eine DB auswählen und anschließend eine Tabelle</h3>';

    try
    {

        $connect = new DBFunctions('localhost', 'root', '');

        $query = 'show databases';

        $stmt = $connect->GetStatement($query);

        /* create Table with radio-Button */
        echo '<form method="post">';
        echo '<table border="1">';
        echo '<tr><th>&nbsp;</th><th>Datenbank</th></tr>';
        while($row = $stmt->fetch(PDO::FETCH_NUM))
        {
            //echo '<tr><td>'.$row[0].'</td><td>'.$row[1].'</td><td>'.$row[2].'</td></tr>';
            echo '<tr>';
            foreach($row as $r)
            {
                echo '<td><input type="radio" name="dbselect" value="'.$r.'" checked></td>
</td><td>'.$r.'</td>';
            }
            echo '</tr>';
        }
        echo '</table>';
        echo '<input type="submit" name="dbsel" value="DB auswählen">';
        echo '</form>';
    } catch(Exception $e){
        echo $e->getMessage();
    }

}
