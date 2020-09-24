<?php 
function database_open(){
    $server= "localhost";
    $username = "unistamgroups_yoyo_pizza";
    $password = "yoyopizza@06";
    $conn=null;
    $database = "unistamgroups_yoyo_pizza";
    try 
    {
       $conn = new PDO("mysql:host=$server;dbname=$database", $username, $password);
       $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
       return $conn;
     }
     catch(PDOException $e)
     {
       return "Failed" . $e->getMessage();
     }
}

function database_close(){
    $conn=null;
    return $conn;
}
?>