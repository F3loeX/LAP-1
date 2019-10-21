<?php
/**
 * Created by PhpStorm.
 * User: Martl
 * Date: 05.12.2018
 * Time: 16:01
 * Personen erfassen
 */
echo '<h2>Personen erfassen</h2>';

if(isset($_POST['send']))
{
  try {

    $vname = $_POST['vname'];
    $nname = $_POST['nname'];
    $svnr = $_POST['svnr'];
    $geburt = $_POST['geburt'];
    echo '<span class="input">Wollen Sie folgende Daten
speichern: ' . $vname . ' ' . $nname . ' SVNr ' . $svnr . '/'
      . $geburt . '</span><br>';
    echo '
    <form method="post">
      <input type="hidden" name="vname" value="'.$vname.'">
      <input type="hidden" name="nname" value="'.$nname.'">
      <input type="hidden" name="svnr" value="'.$svnr.'">
      <input type="hidden" name="geburt" value="'.$geburt.'">
      <input type="submit" name="save" value="JA">
      <input type="button" onclick="history.back()" 
      name="back" value="zurück">
    </form>
    ';
  } catch (Exception $e)
  {
      echo $e->getMessage();
  }
}
else if(isset($_POST['save']))
{
    try{

      $vname = $_POST['vname'];
      /*
       * OLD
       * Methode quote: überprüft, ob es sich um einen gültigen
       * String handelt ... verhindert SQL-Injection
       */
      $nname = $_POST['nname'];
      $svnr = $_POST['svnr'];
      $geburt = $_POST['geburt'];

      $query = 'insert into person (per_nname, per_vname, 
                  per_svnr4, per_geburt) values(?, ?, ?, ?)';
      $bindArray = array($nname, $vname, $svnr, $geburt);
      $stmt = prepareStatement($con, $query, $bindArray);

      $query1 = 'select * from person';
      $stmt1 = prepareStatement($con, $query1, null);
      printTable($stmt1);
      /*
      $stmt = $con->prepare($query);
      //$stmt->bindParam(1, $nname); für jedes ?
      $stmt->execute([$nname, $vname, $svnr, $geburt]);
        */



    } catch (Exception $e)
    {
        echo $e->getMessage().' '.$e->getFile().' '.$e->getLine();
    }


} else {
    // Formular
   ?>
    <form method="post">
      <div class="table">
        <div class="tr">
          <div class="th">
              <label for="vn">Vorname:</label>
          </div>
          <div class="td">
            <input id="vn" type="text" name="vname">
          </div>
        </div>
          <div class="tr">
              <div class="th">
                  <label for="nn">Nachname:</label>
              </div>
              <div class="td">
                  <input id="nn" type="text" name="nname" required>
              </div>
          </div>
          <div class="tr">
              <div class="th">
                  <label for="sv">SV-Nr (4stellig):</label>
              </div>
              <div class="td">
                  <input id="sv" type="number" name="svnr" min="0" required>
              </div>
          </div>
          <div class="tr">
              <div class="th">
                  <label for="dt">Geburtsdatum:</label>
              </div>
              <div class="td">
                  <input id="dt" type="date" min="1900-01-01" name="geburt" required>
              </div>
          </div>
        <div class="tr">
          <div class="td">
            <input type="submit" name="send" value="speichern">
          </div>
        </div>

      </div>
    </form>
<?php
}