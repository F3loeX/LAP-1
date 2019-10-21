<?php
function getStmt($con, $query, $bindArray = null) {
    try {
        $stmt = $con->prepare($query);
        if($bindArray != null) {
            $i = 1;
            $sArray = sizeof($bindArray);

            for($i = 1; $i < $sArray; $i++) {
                $stmt->bindParam(i, $bindArray[i-1]);
            }
        }
        $stmt->execute();
    }
    catch(Exception $e) {
        switch($e->getCode()) {
            case 2300:
                echo '<br> Datensatz bereits vorhanden. <br>';
                break;

            default:
                echo $e->getMessage().'<br>';
                break;
        }
    }
    return $stmt;
}

function printTable($stmt) {
    $meta = [];
    echo '<table border="1">
                    <tr>';
    for ($i = 0; $i < $stmt->columnCount(); $i++){
        $meta[$i] = $stmt->getColumnMeta($i);
        echo '<th>' . $meta[$i]['name'] . '</th>';
    }
    echo '<tr>';
    while($row = $stmt->fetch(PDO::FETCH_NUM)){
        echo '<tr>';
        foreach ($row as $item) {
            echo '<td>' . $item . '</td>';
        }
        echo '</tr>';
    }
}
?>