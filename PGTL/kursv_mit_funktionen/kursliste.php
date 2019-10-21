<?php
/*
* Steiner Alexander 3ATIX 19/10/2018
* Aufgabe - Kursverwaltung
* kursliste.php
*/
$stmt = getStmt($con, 'select kur_id as "Kurs_ID", kur_bez as "Bezeichnung", kur_start as "Startdatum", concat_ws(\' \', person.per_vn, person.per_nn) as "Vortragender"
                      from kurs, person 
                      where kurs.per_id = person.per_id
                      order by kur_id', null);
printTable($stmt);
