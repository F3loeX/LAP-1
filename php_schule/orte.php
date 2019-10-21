<?php
/**
 * Created by PhpStorm.
 * User: Martl
 * Date: 05.12.2018
 * Time: 16:02
 * nach Ortsnamen suchen
 */
echo '<h2>Nach Ortsnamen suchen</h2>';

if(isset($_POST['search']))
{
  $ort = $_POST['ort'];
  $such = $_POST['such'];
  // Suche nach Teilstring: z.b lin %lin%

  $text = 'am Wortanfang';
  switch($such)
  {
    case 1:
      $suchOrt = $ort.'%';
      break;
    case 2:
      $suchOrt = '%'.$ort;
      $text = 'am Wortende';
      break;
    default:
      $suchOrt = '%'.$ort.'%';
      $text = 'im Wortverlauf';
  }
  //$suchOrt = '%'.$ort.'%';

  $query = 'select * from ort where ort_name like ?';
  try
  {
    $stmt = $con->prepare($query);
    $stmt->execute([$suchOrt]);
    if($stmt->rowCount() == 0) // Anzahl der selektierten DS
    {
      echo '<span>Für den Suchstring <b>'.$ort.'</b> mit Option '.$text.' gibt es kein Ergebnis!</span>';
    }
    while($row = $stmt->fetch(PDO::FETCH_NUM))
    {
      echo $row[0].' | '.$row[1].'<br>';
    }
  } catch(Exception $e)
  {
    echo $e->getMessage();
  }


} else
{
  // FORMULAR
  ?>
  <form method="post">
    <label for="or">Suche nach Ort:</label>
    <input id="or" type="text" name="ort">
    <br>
    <input type="radio" name="such" value="1" checked>Am Anfang des Wortes suchen<br>
    <input type="radio" name="such" value="2">Am ENDE des Wortes suchen<br>
    <input type="radio" name="such" value="3">Im Wortverlauf suchen<br>
    <input type="submit" name="search" value="suchen">
  </form>
<?php
}