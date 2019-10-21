<?php
/*
 * Steiner Alexander 3ATIX 19/10/2018
 * Aufgabe - Kursverwaltung
 * config.php
 */

try {
    // Verbindungsaufbau
    $server = 'localhost';
    $db = 'kursverwaltung';
    $user = 'root';
    $pwd = '';
    $con = new PDO('mysql:host=' . $server . ';dbname=' . $db . ';charset=utf8', $user, $pwd);
    // Exception Handling explizit einschalten
    $con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(Exception $e) {
    // Fehlerbehandlung
    echo $e->getMessage().'<br>';
}