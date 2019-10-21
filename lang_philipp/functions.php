<?php
/**
 * Created by PhpStorm.
 * User: Philipp Lang
 * Date: 17.01.2019
 * Time: 08:47
 *
 * Funktionen fuer zb Daten alls Tabelle anzeigen.
 *
 */

function printTable($stmt) {
    $meta = [];
    echo '<table border="1">
                    <tr>';
    for ($i = 0; $i < $stmt->columnCount(); $i++){
        $meta[$i] = $stmt->getColumnMeta($i);
        echo '<th>' . $meta[$i]['name'] . '</th>';
    }
    echo '</tr>';
    while($row = $stmt->fetch(PDO::FETCH_NUM)){
        echo '<tr>';
        foreach ($row as $item) {
            echo '<td>' . $item . '</td>';
        }
        echo '</tr>';
    }
    echo '</table><br>';
}
?>