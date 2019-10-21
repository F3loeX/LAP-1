<?php
/**
 * Philipp Lang, Übung Kursverwaltung
 * Created by PhpStorm.
 * User: Philipp Lang
 * Date: 19.10.2018
 * Time: 07:53
 * Verbindung zum Webserver und zur DB kurse
 */

try {
    // Verbindungsaufbau
    $server = 'localhost';
    $db = 'kurse';
    $user = 'root';
    $pwd = '';
    $con = new PDO('mysql:host=' . $server . ';dbname=' . $db . ';charset=utf8', $user, $pwd);
    // Exception Handling explizit einschalten
    $con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(Exception $e) {
    // Fehlerbehandlung
    echo $e->getMessage().'<br>';
}