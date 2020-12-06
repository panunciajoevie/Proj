<?php
    require_once 'Connection.php';

    $fullname=$_POST['fullname'];
    $username=$_POST['username'];
    $completeaddress=$_POST['completeaddress'];
    $contact=$_POST['contact'];
    $password=$_POST['password'];

    $query="INSERT INTO tbl_user(fullname, username, completeaddress, contact, password)
        VALUES ('$fullname', '$username', '$completeaddress', '$contact', '$password')";
    $exeQuery = mysqli_query($con, $query);

    if($exeQuery){
        echo (json_encode(array('code' => 1, 'message' => 'Success')));

    }else{
        echo (json_encode(array('code' => 2, 'message' => 'Failed')));
    }
?>