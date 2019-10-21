<?php
/*
 * Steiner Alexander 3ATIX 19/10/2018
 * Aufgabe - Kursverwaltung
 * registrierung_erweitert.php
 */
?>
<!DOCTYPE html>
<head>
    <title>Registrierung</title>
</head>
<body>
<main>
    <?php
    if(isset($_POST['confirm'])) {
        $yesno = $_POST['yesno'];
        if($yesno == "Yes"){
            $vname = $_POST['vname'];
            $nname = $_POST['nname'];
            $query = 'insert into person values(null, ?, ?, null)';
            try {
                $stmt = $con->prepare($query);
                $stmt->bindParam(1, $nname);
                $stmt->bindParam(2, $vname);
                $stmt->execute();

                $lastID = $con->lastInsertId();
                if($lastID > 1) {
                    echo 'Daten wurden erfolgreich gespeichert. <br>';
                    echo 'KundenID =' . $lastID;
                }
            } catch(Exception $e) {
                echo $e->getMessage().'<br>';
            }
        }
        else {
            echo 'Die Daten wurden nicht gespeichert.';
        }
    }
    else {
        if(isset($_POST['save'])) {
            echo "<h3>Persönliche Daten</h3>";
            $vname = $_POST['vname'];
            $nname = $_POST['nname'];
            $strasse = $_POST['strasse'];
            $plz = $_POST['plz'];
            $ort = $_POST['ort'];

            echo $vname.'<br>'.$nname.'<br>'.$strasse.'<br>'.$plz.'<br>'.$ort.'<br><br>';
            ?>
            <form method="post">
                <h4>Sind Sie sicher, dass Sie die Daten speichern wollen?</h4>
                <input type="radio" name="yesno" value="Yes">Ja<br>
                <input type="radio" name="yesno" value="No">Nein<br>
                <input type="submit" name="confirm" value="Datensatz speichern">

                <input type="hidden" name="vname" value="<?php echo $vname ?>">
                <input type="hidden" name="nname" value="<?php echo $nname ?>">
            </form>
            <?php
        }
        else {
            ?>
            <form method="post">
                <h1>Registrierung</h1>
                <label for="vn">Vorname:</label>
                <input id="vn" type="text" name="vname" required>
                <br>
                <label for="nn">Nachname:</label>
                <input id="nn" type="text" name="nname" required>
                <br>
                <label for="nn">Strasse:</label>
                <input id="str" type="text" name="strasse" required>
                <br>
                <label for="nn">PLZ:</label>
                <input id="plz" type="text" name="plz" required>
                <br>
                <label for="nn">Ort:</label>
                <input id="ort" type="text" name="ort" required>
                <br>
                <input type="submit" name="save" value="Speichern">
            </form>
            <?php
        }
    }
    ?>

</main>
</body>
</html>