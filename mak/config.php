<?php
/**
 * Created by PhpStorm.
 * User: Philipp Lang
 * Date: 30.10.2018
 * Time: 12:53
 */

try {
    // Verbindungsaufbau
    $server = 'localhost';
    $db = 'praxis';
    $user = 'root';
    $pwd = '';
    $con = new PDO('mysql:host=' . $server . ';dbname=' . $db . ';charset=utf8', $user, $pwd);
    // Exception Handling explizit einschalten
    $con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(Exception $e) {
    // Fehlerbehandlung
    echo $e->getMessage().'<br>';
}