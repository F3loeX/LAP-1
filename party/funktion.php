<?php
/**
 * Created by PhpStorm.
 * User: Martl
 * Date: 06.12.2018
 * Time: 15:50
 *
 * Funktionen für:
 * prepare: prepareStatement(....)
 * bind_param und oder execute bindParameter(...),
 * executeStatement (...)
 *
 * function funktionsName(parameter1, parameter2 = 1 ...)
 * {
 *    return xyz; // optional
 * }
 */

/*
 * Prepare Statement mittels Query und übergebener Verbindung
 */
function prepareStatement($con, $query, $bindArray = null)
{
  $stmt = $con->prepare($query);
  if($bindArray != null)
    $stmt = bindParameter($stmt, $bindArray);
  $stmt->execute();
  return $stmt;
}

function bindParameter($stmt, $bindArray)
{
  for($i = 0; $i < sizeof($bindArray); $i++)
  {
      $stmt->bindParam($i+1, $bindArray[$i]);
  }
  return $stmt;
}

function printTable($stmt)
{
  echo '<table>
          <tr>';
  $meta = array();
  $count = $stmt->columnCount();
  for($i = 0; $i < $count; $i++)
  {
    $meta[] = $stmt->getColumnMeta($i);
  }
  foreach($meta as $m)
  {
    echo '<th>'.$m['name'].'</th>';
  }
  echo '</tr>';
  while($row = $stmt->fetch(PDO::FETCH_NUM))
  {
    echo '<tr>';
    foreach($row as $r)
    {
      echo '<td>'.$r.'</td>';
    }
    echo '</tr>';
  }
  echo '</table>';
}