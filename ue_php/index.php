<?php
/**
 * Created by PhpStorm.
 * User: Stefan Rohrauer
 * Date: 19.12.2018
 * Time: 14:31
 * ue_php/index.php
 */
?>
<html>
<head>
    <title>Schule</title>
    <meta charset="utf-8">
</head>
<body>
<nav>
    <?php
    include 'nav.html';
    ?>
</nav>
<main>
    <h2>Personen</h2>
    <?php
    include 'config.php';

    /* Eine Tabelle aller Personen */
    $query = 'select * from person';

    $stmt = $con->prepare($query);
    $stmt->execute();

    /* Tabelle ausgeben:
       Spaltenbezeichnung "dynamisch"...
    */
    $countAttr = $stmt->columnCount();
    $meta = array(); // Array zum speichern der Attribute
    for($i = 0; $i < $countAttr; $i++)
    {
        $meta[] = $stmt->getColumnMeta($i);
    }

    echo '<Table><tr>';
    foreach($meta as $m)
    {
        echo '<th>'.$m['name'].'</th>';
    }
    echo '</tr>';

    while($row = $stmt->fetch(PDO::FETCH_NUM))
    {
        echo '<tr>';
        foreach($row as $r)
        {
            echo '<td>'.$r.'</td>';
        }
        echo '</tr>';
    }

    echo '</table>';

    ?>
</main>
</body>
</html>
