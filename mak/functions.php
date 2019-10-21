<?php
/**
 * Created by PhpStorm.
 * User: Philipp Lang
 * Date: 30.10.2018
 * Time: 13:21
 */

function getStatment($con, $query, $bindParam = null)
{
    try {

        $statment = $con->prepare($query);

        if (!empty($bindParam)) {
            if ((count($bindParam) == 1)) {
                if (($bindParam != 0)) {
                    $bindParam = [
                        '1' => $bindParam
                    ];
                }
            }
            for ($i = 1; $i <= count($bindParam); $i++) {
                $statment->bindParam($i, $bindParam[$i]);
            }
        }
        $statment->execute();
        return $statment;

    } catch (Exception $e) {
        echo 'Help';
        switch ($e->getCode()) {
            case 2300:
                echo "Datensatz ist schon vorhanden.";
                break;
            default:
                echo $e->getMessage() . '<br>';
                break;
        }
    }
}

function printTableNew($con) {

    $query = 'select pat_id as "PatientenID", concat_ws("/", pat_svn_4, pat_gebDatum) as "SV-Nr", concat_ws(" ", pat_vName, pat_nName) as "Patient" from patient order by pat_nName';

    try {
        $statment = $con->prepare($query);
        $statment->execute();

        $meta = [];
        echo '<table border="1">
                    <tr>';
        for ($i = 0; $i < $statment->columnCount(); $i++){
            $meta[$i] = $statment->getColumnMeta($i);
            echo '<th>' . $meta[$i]['name'] . '</th>';
        }
        echo '<tr>';
        while($row = $statment->fetch(PDO::FETCH_NUM)){
            echo '<tr>';
            foreach ($row as $item) {
                echo '<td>' . $item . '</td>';
            }
            echo '</tr>';
        }

    } catch (Exception $e) {
        echo $e->getMessage() . '<br>';
    }
}