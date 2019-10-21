<?php
/**
 * Created by PhpStorm.
 * User: Martl
 * Date: 05.12.2018
 * Time: 16:07
 */
echo '<h2>Startseite Schule</h2>';
try
{
    $query =
    'select concat_ws(\' \', per_vname, per_nname) 
            as "Person", 
            concat_ws(\' \', str_name, pps_hnr) as 
            "Strasse Hausnr", 
	        concat_ws(\' \', plz_nr, ort_name) as 
	        "PLZ und Ort"
     from 	person p left outer join person_plz_strasse pps 
		    on p.per_id = pps.per_id left outer join 
		    plz_strasse using(plst_id) left outer join 
		    (plz, strasse) using(plz_nr, str_id) left outer join 
		    ort using(ort_id) 
     order by ort_name;
    ';
    $stmt = $con->prepare($query);
    $stmt->execute();
    while($row = $stmt->fetch(PDO::FETCH_NUM))
    {
        foreach ($row as $r)
        {
            echo $r.' ';
        }
        echo '<br>';

    }
    $stmt->closeCursor(); // Statement ist ab hier nicht mehr
    // ausführbar

    /*
     * Geben Sie eine Tabelle aller PLZ + Ortsnamen aus
     * FORMATIERT als HTML-Tabelle
     */
    $query1 = 'select plz_nr as "PLZ", ort_name as "Ortsname" 
    from plz natural join ort order by plz_nr';
    $stmt1 = $con->prepare($query1);
    $stmt1->execute();

    echo '<br><h3>Alle Orte</h3>';

    echo '<table>
          <tr>';
    $meta = array();
    $count = $stmt1->columnCount(); //Anzahl der Attribut aus Select
    for($i = 0; $i < $count; $i++)
    {
        $meta[] = $stmt1->getColumnMeta($i);
        // getColumnMeta: Eigenschaften eines Attributs wie z.B. Name
    }
    foreach($meta as $m)
    {
        echo '<th>'.$m['name'].'</th>';
        /* name: Bezeichnung des Attributs
                 Aliase falls verwendet
        */
    }
    echo '</tr>';




    while($row = $stmt1->fetch(PDO::FETCH_NUM))
    {
        echo '<tr>';
        foreach($row as $r)
        {
            echo '<td>'.$r.'</td>';
        }
        echo '</tr>';
    }
    echo '</table>';
} catch (Exception $e)
{
    echo $e->getMessage();
}