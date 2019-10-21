<?php
/**
 * Created by PhpStorm.
 * User: Stefan Rohrauer
 * Date: 19.12.2018
 * Time: 15:11
 * ue_php/person.php
 */
?>
<html>
<head>
    <title>Personen erfassen</title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="style.css">
</head>
<body>
<nav>
    <?php
    include 'nav.html';
    ?>
</nav>
<main>
    <h2>Personen erfassen</h2>
    <?php
    include 'config.php';

    if(isset($_POST['save2']))
    {
        $vname = $_POST['vname'];
        $nname = $_POST['nname'];
        $svnr = $_POST['svnr'];
        $geburt = $_POST['geburt'];

        $query = 'insert into person (per_vname, per_nname, per_svnr4, per_geburt) values(?,?,?,?)';
        try {
            $insert = $con->prepare($query);


            $insert->execute([$vname, $nname, $svnr, $geburt]);
            echo 'Neue ID: '.$con->lastInsertId().'<br>';
        } catch(Exception $e)
        {
            echo $e->getMessage();
        }
        //Speichern
    }elseif (isset($_POST['save1']))
    {
        ?>
        <h2>Wollen Sie die Daten Speichern oder Ihre Engabe ändern?</h2>
        <button onclick="history.back()">Ändern</button>
        <form method="post">
            <div class="table">
                <div class="tr">
                    <div class="td">
                        <?php
                        $vname = $_POST['vname'];
                        $nname = $_POST['nname'];
                        $svnr = $_POST['svnr'];
                        $geburt = $_POST['geburt'];
                        echo '<input type="hidden" name="vname" value="'.$vname.'">';
                        echo '<input type="hidden" name="nname" value="'.$nname.'">';
                        echo '<input type="hidden" name="svnr" value="'.$svnr.'">';
                        echo '<input type="hidden" name="geburt" value="'.$geburt.'">';
                        ?>
                    </div>
                <div class="tr">
                    <div class="th">
                        <input type="submit" name="save2" value="Speichern">
                    </div>
                </div>
            </div>
        </form>
        <?php
    }else
    {
        $vname = $_POST['vname'];
        $nname = $_POST['nname'];
        $svnr = $_POST['svnr'];
        $geburt = $_POST['geburt'];
        ?>
        <form method="post">
            <div class="table">
                <div class="tr">
                    <div class="th">
                        <label for="vn">Vorname:</label>
                    </div>
                    <div class="td">
                        <input id="vn" type="text" name="vname" required>
                    </div>
                </div>
                <div class="tr">
                    <div class="th">
                        <label for="nn">Nachname:</label>
                    </div>
                    <div class="td">
                        <input id="vn" type="text" name="nname" required>
                    </div>
                </div>
                <div class="tr">
                    <div class="th">
                        <label for="sn">Sozialversicherungsnummer:</label>
                    </div>
                    <div class="td">
                        <input id="sn" type="text" name="svnr" placeholder="0000" required>
                        <input type="date" name="geburt" min="1900-01-01" required>
                    </div>
                </div>
                <div class="tr">
                    <div class="th">
                        <input type="submit" name="save1" value="Speichern">
                    </div>
                </div>
            </div>
        </form>
    <?php
    }
    ?>
</main>
</body>
</html>
