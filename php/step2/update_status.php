<?php
require "db.php";

$stmt = $pdo->prepare("UPDATE TASK SET idStatus = ? WHERE idTask = ?");
$stmt->execute([
    $_POST['idStatus'],
    $_POST['idTask']
]);

header("Location: tasks.php");
exit;
?>