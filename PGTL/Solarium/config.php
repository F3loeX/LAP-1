<?php
/**
 * Created by PhpStorm.
 * User: Philipp Lang
 * Date: 28.09.2018
 * Time: 11:22
 * Verbindung zum Webserver und zur DB solarium
 */

try {
    // Verbindungsaufbau
    $server = 'localhost';
    $db = 'solarium';
    $user = 'root';
    $pwd = '';
    $con = new PDO('mysql:host=' . $server . ';dbname=' . $db . ';charset=utf8', $user, $pwd);
    // Exception Handling explizit einschalten
    $con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(Exception $e) {
    // Fehlerbehandlung
    echo $e->getMessage().'<br>';
}