<?php
/**
 * Created by PhpStorm.
 * User: Martl
 * Date: 05.12.2018
 * Time: 15:15
 */
$server = "localhost";
$user = "root";
$pwd = "";
$db = "schule";

try
{
    $con = new PDO('mysql:host='.$server.
        ';dbname='.$db.';charset=utf8', $user, $pwd);
    $con->setAttribute(PDO::ATTR_ERRMODE,
        PDO::ERRMODE_EXCEPTION);

} catch (Exception $e)
{
    echo $e->getMessage();
}