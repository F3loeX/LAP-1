<!DOCTYPE html>
<!-- P. Lang, Menu for 01_uebung -->
<!--<a href="kunde.php" target="_self" style="padding-bottom: 15px;">Kundentabelle</a> |
<a href="kundendaten.php" target="_self" style="padding-bottom: 15px;">Kundendaten</a> |
<a href="insert.php" target="_self" style="padding-bottom: 15px;">Kundenanlage</a> |
-->
<!--<a href="formular.php" target="_self" style="padding-bottom: 15px;">Formular</a> |
<a href="verarbeitenFormular.php" target="_self" style="padding-bottom: 15px;">Aufgabe 1</a> -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<br>
<br>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Kursliste</title>
</head>
<body>
  <?php
  include'menu.php';
  ?>
<main>
  <?php
  include 'config.php';
  $query = 'select kurs_id as "Kurs-ID",zeit_von as Startzeit,kur_name as Kursname,concat_ws(" ",per_nname,per_vname) as Vortragender from Kurs
            left join Kurszeiten using(zeit_id)
            left join Kursarten using(kur_artid)
            left join Vortragende using(vor_id)
            left join Personen using(per_id);';
  try {
    $statment =  $con->prepare($query);
    $statment->execute();
    // Attributeigenschaften in Array speichern, z.b. Attributname
    $meta = [];
    echo '<table class="table">
            <thead class="thead-dark">
            <tr>';
    for ($i = 0; $i < $statment->columnCount(); $i++){
        $meta[$i] = $statment->getColumnMeta($i);
        echo '<th>' . $meta[$i]['name'] . '</th>';
    }
    echo '</tr>';
    echo '</thead>';
    while($row = $statment->fetch(PDO::FETCH_NUM)){
        //echo $row[0] . ' ' . $row[1] . ' ' . $row[2] . '<br>';
        echo '<tr>';
        foreach ($row as $item) {
            echo '<td>' . $item . '</td>';
        }
        echo '</tr>';
    }
    echo '</table>';
  } catch (Exception $e){
      echo $e->getMessage(). '<br>';
  }
   ?>
</main>
</body>
</html>
