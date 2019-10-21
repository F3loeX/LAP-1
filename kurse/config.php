<?php
/**
 * Created by PhpStorm.
 * User: root
 * Date: 19.10.2018
 * Time: 08:00
 * Verbindung zum Webserver und zur DB kirse
 */

try
{
    $server = 'localhost';
    $db = 'kurse';
    $user = 'root';
    $pwd = '';
    $con = new PDO('mysql:host=' . $server. ';dbname=' . $db.';charset=utf8', $user, $pwd);
    $con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(Exception $e)
{
    // Fehlerbehandlung
    echo $e->GetMessage() . '<br>';
    echo "keine Verbindung zu Datenbank";
}