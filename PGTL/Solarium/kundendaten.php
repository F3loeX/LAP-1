<?php
/**
 * Created by PhpStorm.
 * User: admin
 * Date: 02.10.2018
 * Time: 13:17
 */


?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Kundendaten</title>
</head>
<body>
<nav>
    <?php
    include'menu.html';
    ?>
</nav>
<main>
    <h2>Kundendaten</h2>
    <?php
    include 'config.php';
    if(isset($_POST['show'])){
        // Daten ausgeben
        echo '<h3>Kundendatenanzeige</h3>';

        $kid = $_POST['kun'];

        // echo $kid . '<br>';

        $query = 'select * from kunde where kun_id = ?';
        try {
            $statment = $con->prepare($query);
            $statment->bindParam(1, $kid);
            $statment->execute();
            // es wird nur 1 DS selektiert!
            $row = $statment->fetch(PDO::FETCH_NUM);

            foreach ($row as $item) {
               echo $item . '<br>';
            }
        } catch (Exception $e){
            echo $e->getMessage(). '<br>';
        }



    } else {
        // Formular anzeigen
        echo '<form method="post">';
        echo '<label>Kundenliste</label>';

        $query = 'select * from kunde order by kun_nname, kun_vname';
        try {
            $statment =  $con->prepare($query);
            $statment->execute();
            echo '<select name="kun">';
            while($row = $statment->fetch(PDO::FETCH_NUM)){
                echo '<option value="' . $row[0]. '">' . $row[1] . ' ' . $row[2];
            }
            echo '</select>';
        } catch(Exception $e){
            echo $e->getMessage(). '<br>';
        }


        echo '<input type="submit" name="show" vlaue="anzeigen">
               </form>';
    }
    try {

    } catch(Exception $e){

    }
    ?>
</main>
</body>
</html>