<?php
/**
 * Created by PhpStorm.
 * User: regin
 * Date: 10.01.2018
 * Time: 16:24
 */
include 'DBConnect.php';

class DBFunctions
{
    public $connect;
    private $server;
    private $user;
    private $pwd;
    private $db;
    public $stmt;

    /**
     * DBFunctions constructor.
     */
    function __construct($server, $user, $pwd, $db=null)
    {
        $this->server = $server;
        $this->user = $user;
        $this->pwd = $pwd;
        $this->db = $db;
        $this->connect = new DBConnect($this->server, $this->user, $this->pwd, $db);
    }

    /**
     * @param $query
     * @param null $paramArray
     */
    function GetStatement($query, $paramArray = null)
    {
        if($paramArray == null)
        {

            $this->stmt = $this->connect->connect->prepare($query);
            $this->stmt->execute();
        } else {

        }
        return $this->stmt;
    }

    function ShowTable($stmt)
    {
        echo '<table border="1">';
        $cA = $stmt->columnCount();
        $meta = array();
        for($i = 0; $i < $cA; $i++)
        {
            $meta[] = $stmt->getColumnMeta($i);
        }
        echo '<tr>';
        foreach($meta as $m)
        {
            echo '<th>'.$m['name'].'</th>';
        }
        echo '</tr>';
        while($row = $stmt->fetch(PDO::FETCH_NUM))
        {
            //echo '<tr><td>'.$row[0].'</td><td>'.$row[1].'</td><td>'.$row[2].'</td></tr>';
            echo '<tr>';
            foreach($row as $r)
            {
                echo '<td>'.$r.'</td>';
            }
            echo '</tr>';
        }
        echo '</table>';
    }

    /**
     * @param DBConnect $connect
     * @return DBFunctions
     */
    public function setConnect($connect)
    {
        $this->connect = $connect;
        return $this;
    }
}
/* Test
$query = 'select * from kunde';
$test = new DBFunctions('localhost', 'root', '', 'braunun');
$stmt = $test->GetStatement($query);
$test->ShowTable($stmt);
*/