<?php
/**
 * Created by PhpStorm.
 * User: Philipp Lang
 * Date: 17.01.2019
 * Time: 07:54
 *
 * Klasse fuer die Datenbank Connection mittels PDO
 *
 */



try {
    // Verbindungsaufbau
    $server = 'localhost';
    $db = 'theater';
    $user = 'root';
    $pwd = '';
    $con = new PDO('mysql:host=' . $server . ';dbname=' . $db . ';charset=utf8', $user, $pwd);
    // Exception Handling explizit einschalten
    $con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(Exception $e) {
    // Fehlerbehandlung
    echo $e->getMessage().'<br>';
}
