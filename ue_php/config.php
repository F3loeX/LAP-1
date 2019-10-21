<?php
/**
 * Created by PhpStorm.
 * User: Rohrauer Stefan
 * Date: 19.12.2018
 * Time: 14:07
 * ue_php/config.php
 * Verbindung zu Server und DB
 */
$server = 'localhost';
$user = 'root';
$pwd = '';
$db = 'schule';

try
{
    $con = new PDO('mysql:host='.$server.';dbname='.$db.';charset=utf8', $user, $pwd);
    $con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
}catch(Exception $e)
{
    echo $e->getMessage();
}