<!DOCTYPE html>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Registrierung</title>
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
    if(isset($_POST['send'])) {

      echo 'Formulardaten verarbeiten'.'<br>';
      $vname = $_POST['vname'];
      $nname = $_POST['nname'];
      $street = $_POST['strasse'];
      $place = $_POST['ort'];
      $plz = $_POST['plz'];
      echo 'Folgende Daten werden gespeichert: <br>'.'Vorname: '.$vname.'<br>'.'Nachname: '.$nname.'<br>';
      echo 'Ihre Adresse lautet : '.$street.'<br>in '.$plz.' '.$place;
      echo '<br><br>';
      //sleep(5);
      try {
        $arrayPerson = array(":firstName"=>$vname,':lastName'=>$nname);
        $arrayAdress = array(":ort"=>$place,':strasse'=>$street,':plz'=> $plz);

        $statment = $con->prepare('insert into Kurse.Adressen values(null,:ort,:strasse,:plz);');
        $statment->execute($arrayAdress);

        $addrID = $con->lastInsertID();

        $statment = $con->prepare('insert into Kurse.Personen values(null,:firstName,:lastName,'.$addrID.');');
        $statment->execute($arrayPerson);
          echo "Success";

        }catch(Exception $e) {
          echo "$e";
        }
    } else {

      ?>
      <br>
        <form method="post">
          <div class="form-row">
            <div class="form-group col-md-6">
              <label for="vn">Vorname</label>
              <input type="text" class="form-control" name="vname" placeholder="Vorname">
            </div>
            <div class="form-group col-md-6">
              <label for="nn">Nachname</label>
              <input type="text" class="form-control" name="nname" placeholder="Nachname">
            </div>
          </div>
          <div class="form-row">
          <div class="form-group col-md-6">
            <label for="ort">Stadt</label>
            <input type="text" class="form-control" name="ort" placeholder="Wien">
          </div>
          <div class="form-group col-md-6">
            <label for="strasse">Strasse</label>
            <input type="text" class="form-control" name="strasse" placeholder="Mustergasse 1">
          </div>
        </div>
          <div class="form-row">
            <div class="form-group col-md-6">
              <label for="plz">PLZ</label>
              <input type="text" class="form-control" name="plz" placeholder="4020">
            </div>
            <div class="form-group col-md-6">
          <button type="submit" class="btn btn-primary" name="send" >Senden</button>
          </div>
        </div>
        </form>
      <?php

    }
    ?>

</main>
</body>
</html>
