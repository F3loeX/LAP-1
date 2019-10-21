<?php
/**
 * Created by PhpStorm.
 * User: Philipp Lang
 * Date: 30.10.2018
 * Time: 13:01
 */
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Patientenerfassung</title>
</head>
<body>

<nav>
    <?php
    include'menu.php';
    ?>
</nav>
<main>
    <?php
    include 'config.php';
    require_once('functions.php');

    if(isset($_POST['sureSave'])){

            $svNr = $_POST['svnr'];
            $gebDat = $_POST['gebDat'];
            $vn = $_POST['vname'];
            $nn = $_POST['nname'];

            $query = 'INSERT INTO patient (pat_id, pat_svn_4, pat_gebDatum, pat_vName, pat_nName) 
                        VALUES (NULL, :svnr, :gebDat, :vn, :nn);';

        try {

            $bindArray = [
                ':svnr' => $svNr,
                ':gebDat' => $gebDat,
                ':vn' => $vn,
                ':nn' => $nn
            ];

            $statment = $con->prepare($query)->execute($bindArray);

            echo '<h4>Datensatz wurde erfolgreich gespeichert!</h4>';

            printTableNew($con);

        } catch (Exception $e) {
            switch ($e->getCode()) {
                case 23000:
                    echo "<br>Der Patient ist bereits gespeichert: " . $svNr . '/' . $gebDat . '<button><a href="index.php">zur&uuml;ck</a></button><br>';
                    printTableNew($con);
                    break;
                default:
                    echo 'Beim speichern des Patienten: ' . $nn . ' ' . $vn . ', ist ein Fehler aufgetreten.';
                    break;
            }
        }
    }
    elseif (isset($_POST['editBeforeSave'])){
        ?>

        <form class="regFormSure" method="post">

            <p class="bigText" style="font-weight: 700;">Daten&auml;nderung vor Speicherung</p>

            <table>
                <tr>
                    <?php
                    echo '<td><label for="svnrID">SV Nummer:</label></td>';
                    echo '<td><input value="' . $_POST['svnr'] . '" id="svnrID" name="svnr" type="text" required></td>';
                    ?>
                </tr>
                <tr>
                    <?php
                        echo '<td><label for="gebID">Geburtsdatum:</label></td>';
                        echo '<td><input value="' . $_POST['gebDat'] .'" id="gebID" name="gebDat" type="date" min="1900-01-01" required></td>';
                    ?>
                </tr>
                <tr>
                    <?php
                        echo '<td><label for="vornID">Vorname:</label></td>';
                        echo '<td><input value="' . $_POST['vname'] .'" id="vornID" name="vname" type="text" required></td>';
                    ?>
                </tr>
                <tr>
                    <?php
                        echo '<td><label for="nachnID">Nachname:</label></td>';
                        echo '<td><input value="' . $_POST['nname'] .'" id="nachnID" name="nname" type="text" required></td>';
                    ?>
                </tr>
                <tr>
                    <td><input class="inputBtn" type="submit" name="sureSave" value="speichern"></td>
                </tr>
            </table>

        </form>

        <?php
    }

    elseif (isset($_POST['save'])){
        ?>
            <form class="regFormSure" method="post">
                <p>M&ouml;chten Sie folgende Daten speichern oder nochmals &auml;ndern:</p>
                <?php
                echo '<p style="font-weight: 700;">';
                echo $_POST['svnr'] . ' ' . $_POST['gebDat'] . ', ' . $_POST['nname'] . ' ' . $_POST['vname'];
                echo '<input name="svnr" type="hidden" value="' . $_POST['svnr'] .'">';
                echo '<input name="gebDat" type="hidden" value="' . $_POST['gebDat'] .'">';
                echo '<input name="vname" type="hidden" value="' . $_POST['vname'] .'">';
                echo '<input name="nname" type="hidden" value="' . $_POST['nname'] .'">';
                echo '</p>';
                ?>
                <br>
                <div class="">
                    <input class="inputBtn" type="submit" name="sureSave" value="speichern">
                    <input class="inputBtn" type="submit" name="editBeforeSave" value="&auml;ndern">
                </div>
            </form>
        <?php
    }
    else {
        ?>
            <h2>Patientenerfassung</h2><br>

            <form class="regForm" method="post">
                <table>
                    <tr>
                        <td><label for="svnrID">SV Nummer:</label></td>
                        <td><input id="svnrID" name="svnr" type="text" required></td>
                    </tr>
                    <tr>
                        <td><label for="gebID">Geburtsdatum:</label></td>
                        <td><input id="gebID" name="gebDat" type="date" min="1900-01-01" required></td>
                    </tr>
                    <tr>
                        <td><label for="vornID">Vorname:</label></td>
                        <td><input id="vornID" name="vname" type="text" required></td>
                    </tr>
                    <tr>
                        <td><label for="nachnID">Nachname:</label></td>
                        <td><input id="nachnID" name="nname" type="text" required></td>
                    </tr>
                    <tr>
                        <td><input class="inputBtn" type="submit" name="save" value="speichern"></td>
                    </tr>
                </table>

            </form>
        <?php
    }
    ?>
</main>
</body>
</html>
