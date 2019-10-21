<?php
/**
 * Created by PhpStorm.
 * User: admin
 * Date: 28.09.2018
 * Time: 12:15
 */


?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Modell</title>
</head>
<body>
<nav>
    <?php
    include'menu.html';
    ?>
</nav>
<main>
    <h2>Modell</h2>
    <?php
    include 'config.php';
    try {
        $statment =  $con->prepare('select * from modell');
        $statment->execute();

        // Attributeigenschaften in Array speichern, z.b. Attributname
        $meta = [];
        echo '<table border="1">
                <tr>';
        for ($i = 0; $i < $statment->columnCount(); $i++){
            $meta[$i] = $statment->getColumnMeta($i);
            echo '<th>' . $meta[$i]['name'] . '</th>';
        }
        echo '</tr>';
        while($row = $statment->fetch(PDO::FETCH_NUM)){
            //echo $row[0] . ' ' . $row[1] . ' ' . $row[2] . '<br>';
            echo '<tr>';
            foreach ($row as $item) {
                echo '<td>' . $item . '</td>';
            }
            echo '</tr>';
        }
        echo '</table>';
    } catch(Exception $e) {

    }
    ?>
</main>
</body>
</html>