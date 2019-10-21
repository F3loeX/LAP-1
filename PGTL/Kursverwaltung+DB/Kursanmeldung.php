<!DOCTYPE html>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Kursanmeldung</title>
</head>
<body>
<nav>
    <?php
    include'menu.php';
    ?>
</nav>
<main>
    <h2>Kursanmeldung</h2>
    <?php
    include 'config.php';
    if(isset($_POST['anmelden'])) {

      echo 'Formulardaten verarbeiten'.'<br>';
      $person = $_POST['kun'];
      $kurs = $_POST['kur'];
      echo 'personen'.$person;
      echo 'Kurs'.$kurs;
      try {
        $arraySign = array(":person"=>$person,':kurs'=>$kurs);

        $statment = $con->prepare('insert into Kurse.Kurs_has_Personen values(:person,:kurs,null);');
        $statment->execute($arraySign);

          echo "Success";

        }catch(Exception $e) {
          echo "$e";
        }
    }elseif(isset($_POST['abmelden'])) {

          echo 'Formulardaten verarbeiten'.'<br>';
          $person = $_POST['kun'];
          $kurs = $_POST['kur'];
          echo 'personen'.$person;
          echo 'Kurs'.$kurs;

          try {
            $arraySign = array(":person"=>$person,':kurs'=>$kurs);

            $statment = $con->prepare('delete from Kurse.Kurs_has_Personen where Kurs_kurs_id = '.$kurs.' and Personen_per_id = '.$person.';');
            $statment->execute($arraySign);

              echo "Success";

            }catch(Exception $e) {
              echo "$e";
            }
          }else {
        // Formular anzeigen
        echo '<form method="post">';
        echo '<div class="form-row">';
        echo '<label>Personen </label>';

        $queryPer = 'select * from Personen order by per_id';
        try {
            $statment =  $con->prepare($queryPer);
            $statment->execute();
            echo '<div class="form-group">
                  <select name="kun">';
            while($row = $statment->fetch(PDO::FETCH_NUM)){
                echo '<option value="' . $row[0]. '">' . $row[1] . ' ' . $row[2];
            }
          } catch(Exception $e){
              echo $e->getMessage(). '<br>';
            }
            echo '</select>';
            echo '</div>';
            echo '</div>';
            echo '<div class="form-row">';
            echo '<label>Kurse </label>';

            $queryKur = 'select kurs_id,kur_name from Kurs
                          left join Kursarten using(Kur_artid);';
            try {
                $statment =  $con->prepare($queryKur);
                $statment->execute();

                echo '<div class="form-group">
                      <select name="kur">';
                while($row = $statment->fetch(PDO::FETCH_NUM)){
                    echo '<option value="' . $row[0].'">'. $row[1] .'</option>';
                }
              } catch(Exception $e){
                  echo $e->getMessage(). '<br>';
                }

                echo '</select>';
                echo '</div>';
                echo '</div>';

            echo '<button type="submit" class="btn btn-primary" name="anmelden" >Anmelden</button>';
            echo '<button type="submit" class="btn btn-primary" name="abmelden" >Abmelden</button>
                   </form>';

    try {

    } catch(Exception $e){

    }
  }
    ?>
</main>
</body>
</html>
