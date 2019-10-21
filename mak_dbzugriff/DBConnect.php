<?php
/**
 * Created by PhpStorm.
 * User: regin
 * Date: 10.01.2018
 * Time: 16:04
 */

class DBConnect
{

    public $connect;

    /**
     * DBConnect constructor.
     * @param $server
     * @param $user
     * @param $pwd
     * @param $db
     */
    function __construct($server, $user, $pwd, $db = null)
    {
        //echo 'mysql:host='.$server.';dbname='.$db.';charset=utf8'. $user.' '. $pwd;
        /**/
        try {
            $this->connect = new PDO('mysql:host='.$server.';dbname='.$db.';charset=utf8', $user, $pwd);
            $this->connect->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        } catch (Exception $e)
        {
            echo $e->getMessage();
        }

    }
}