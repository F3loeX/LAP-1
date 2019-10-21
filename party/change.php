<html>
<head>
  <title>Party</title>
  <meta charset="utf-8">
</head>
<body>
<?php
include 'config.php';
include 'funktion.php';
if(isset($_POST['change']))
{
  $speiseid = $_POST['speiseid'];
  $query = 'select * from speisekarte where spe_id = ?';
  $ba = array($speiseid);
  $stmt = prepareStatement($con, $query, $ba);
  $speise = $stmt->fetch(PDO::FETCH_NUM);
  echo '<form method="post">';
  echo 'Speisenbezeichnung ändern:<input style="width:200pt" type="text" name="speise" value="'.$speise[1].'"><br>';
  echo '<input type="hidden" name="speiseid" value="'.$speiseid.'">';
  echo '<input type="submit" name="save" value="speichern">';
  echo '</form>';
} else if(isset($_POST['save']))
{
  $speise = $_POST['speise'];
  $speiseid = $_POST['speiseid'];

  $q1 = 'select * from speisekarte where spe_id = ?';
  $u1 = 'update speisekarte set spe_bezeichnung = ? where spe_id = ?';

  $ba1 = array($speiseid);
  $ba2 = array($speise, $speiseid);
  $s1 = prepareStatement($con, $q1, $ba1);
  $speiseold = $s1->fetch(PDO::FETCH_NUM);
  $s2 = prepareStatement($con, $u1, $ba2);


  echo $speiseold[1].' wurde auf '.$speise.' geändert!<br>';
}
else
{
  try {
    $query = 'select kat_id, kat_name
  from kategorie';
    $stmt = prepareStatement($con, $query);

    echo '<form method="post">';
    while($row = $stmt->fetch(PDO::FETCH_NUM))
    {
      echo '<b>'.$row[1].'</b><br>'; // style="width: 10pc;"
      $q2 = 'select * from speisekarte where kat_id = ?';
      $ba = array($row[0]);
      $s2 = prepareStatement($con, $q2, $ba);
      while($r2 = $s2->fetch(PDO::FETCH_NUM))
      {
        echo '<input type="radio" name="speiseid" value="'.$r2[0].'" checked>'.$r2[1].'<br>';
      }
    }

    echo '<input type="submit" name="change" value="ändern">
    </form>';
  } catch(Exception $e)
  {
    echo $e->getMessage();
  }
}


?>

</body>
</html>