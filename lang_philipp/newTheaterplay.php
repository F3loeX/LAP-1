<?php
/**
 * Created by PhpStorm.
 * User: Philipp Lang
 * Date: 17.01.2019
 * Time: 08:42
 *
 * Hier kann ein neues Theraterstueck erstellt werden.
 *
 */


?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Neues Theaterst&uuml;ck erfassen</title>
    <?php
    include 'config.php';
    require('functions.php');
    ?>
</head>
<body>
<nav>
    <?php
    include'menu.php';
    ?>
</nav>
<div class="container topContainer">
    <h1>Theaterst&uuml;ck erfassen</h1>

    <?php

        if(isset($_POST['createTheater'])) {


            $query = 'INSERT INTO `drama` (`dra_id`, `dra_name`, `gen_id`, `autor_id`) VALUES (NULL, :tname, :tgenre, :tautor)';

            $lastDrama = 0;

            try {

                $statementDrama = $con->prepare($query)->execute([
                    ':tname' => $_POST['tname'],
                    ':tgenre' => $_POST['tgenre'],
                    ':tautor' => $_POST['tautor']
                ]);

                $lastDrama = $con->lastInsertId();

                echo 'Drama wurde erfolgreich eingef&uumlgt!<br><br>';


            } catch (Exception $e) {
                if ($e->getCode() == 23000) {
                    echo '<h3>Folgender DS wurde nicht eingef&uuml;gt!</h3>';
                    echo 'In der Tabelle drama existiert bereits ein Eintrag ' . $_POST['tname'] .' . <br>';
                } else {
                    echo $e->getMessage() . '<br>';
                }
            }

            try {

                $queryEvent = 'INSERT INTO `dramaevent` (`eve_id`, `eve_termin`, `dra_id`) VALUES (NULL, :eveTime, :lastDramaID)';

                $dramaTime = $_POST['tdate'] . ' ' . $_POST['ttime'];

                if ($lastDrama == 0) {

                    $querySearch = 'select dra_id from drama where dra_name like :drama_name AND gen_id = :gen_id AND autor_id = :autor_id';
                    $statementSearch = $con->prepare($querySearch);
                    $statementSearch->execute([
                        ':drama_name' => $_POST['tname'],
                        ':gen_id' => $_POST['tgenre'],
                        ':autor_id' => $_POST['tautor']
                    ]);


                    while($row = $statementSearch->fetch(PDO::FETCH_NUM)){
                        $lastDrama = $row[0];
                    }

                    try {
                        $statement = $con->prepare($queryEvent)->execute([
                            ':eveTime' => $dramaTime,
                            ':lastDramaID' => $lastDrama
                        ]);
                        echo '<br>Dramaevent wurde erfolgreich eingef&uumlgt!<br>';

                    } catch (Exception $e) {
                        if ($e->getCode() == 23000) {
                            echo 'In der Tabelle dramaevent existiert bereits ein Eintrag zu diesem Termin: ' . $dramaTime;
                        } else {
                            echo $e->getMessage() . '<br>';
                        }
                    }
                } else {
                    $statement = $con->prepare($queryEvent)->execute([
                        ':eveTime' => $dramaTime,
                        ':lastDramaID' => $lastDrama
                    ]);

                    echo '<br>Dramaevent wurde erfolgreich eingef&uumlgt!<br>';
                }

            }  catch (Exception $e) {
                echo $e->getMessage() . '<br>';
            }


        } else {

            ?>

            <form method="post">
                <label for="tid">Titel des St&uuml;cks:</label>
                <input type="text" name="tname" id="tid" required>
                <br><br>
                <label for="ta">Autor:</label>
                <select name="tautor" id="ta">
                    <?php

                    $query = 'select per.per_id, per.per_vName, per.per_nName from person per left outer join rolle ro on per.rol_id = ro.rol_id where ro.rol_name like \'Autor\';';

                    try {

                        $statement = $con->prepare($query);
                        $statement->execute();

                        while($row = $statement->fetch(PDO::FETCH_NUM)){
                            $combinedName = $row[1] . ' ' . $row[2];
                            echo '<option value="' . $row[0] .'">' . $combinedName . '</option>';
                        }

                    } catch (Exception $e) {
                        echo 'Autor wurde nicht gefunden.';
                        echo $e->getMessage() . '<br>';
                    }

                    ?>
                </select>
                <br><br>
                <label for="tg">Genre:</label>
                <select name="tgenre" id="tg">
                    <?php

                    $query = 'select gen_id, gen_name from genre;';

                    try {

                        $statement = $con->prepare($query);
                        $statement->execute();

                        while($row = $statement->fetch(PDO::FETCH_NUM)){
                            echo '<option value="' . $row[0] .'">' . $row[1] . '</option>';
                        }

                    } catch (Exception $e) {
                        echo 'Genre wurde nicht gefunden.';
                        echo $e->getMessage() . '<br>';
                    }

                    ?>
                </select>
                <br><br>
                <label for="td">Erstauff&uuml;hrung am:</label>
                <input type="date" name="tdate" id="td" required>
                <input type="time" name="ttime" required>
                <br><br>
                <input type="submit" name="createTheater" value="speichern">
            </form>

    <?php


        }

    ?>

</div>

</body>
</html>
