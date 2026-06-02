<?php
require "db.php";

if (isset($_GET['id'])) {

    $id = (int) $_GET['id'];

    $pdo->prepare("DELETE FROM TASK_TAG WHERE idTask = ?")->execute([$id]);
    $pdo->prepare("DELETE FROM TASK WHERE idTask = ?")->execute([$id]);
}

header("Location: tasks.php");
exit;
?>