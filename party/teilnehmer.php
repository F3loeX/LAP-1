<html>
<head>
  <title>Party</title>
  <meta charset="utf-8">
</head>
<body>
<?php
include 'config.php';
include 'funktion.php';
try {
  $query = 'select distinct tei_id, tei_vname, tei_nname from teilnehmer natural join menu';
  $stmt = $con->prepare($query);
  $stmt->execute();

  while($row = $stmt->fetch(PDO::FETCH_NUM))
  {
    echo '<h2>'.$row[1].' '.$row[2].'</h2>';
    $q = 'select k.kat_name, s.spe_bezeichnung from kategorie k NATURAL join 
speisekarte  s natural join menu where tei_id = ?';
    $bindA = array($row[0]);
    $s = prepareStatement($con, $q, $bindA);
    printTable($s);
  }
  $q2 = 'select teilnehmer.* from teilnehmer left outer join menu using(tei_id) 
where spe_id is null';
  $s2 = prepareStatement($con, $q2);
  while($r2 = $s2->fetch(PDO::FETCH_NUM))
  {
      echo '<h2>'.$r2[1].' '.$r2[2].'</h2>';
  }
} catch(Exception $e)
{
  echo $e->getMessage();
}

?>

</body>
</html>