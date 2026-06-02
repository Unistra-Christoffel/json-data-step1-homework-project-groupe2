<?php
require "db.php";

$statuses = $pdo->query("SELECT * FROM TASK_STATUS")->fetchAll();
$priorities = $pdo->query("SELECT * FROM PRIORITY")->fetchAll();
$categories = $pdo->query("SELECT * FROM CATEGORY")->fetchAll();

if ($_SERVER["REQUEST_METHOD"] === "POST") {

    $pdo->beginTransaction();

    $stmt = $pdo->prepare("
INSERT INTO TASK (title, dateFinished, note, idStatus, idPriority, idCategory)
VALUES (?, ?, ?, ?, ?, ?)
");

    $stmt->execute([
        $_POST['title'],
        $_POST['dateFinished'],
        $_POST['note'],
        $_POST['idStatus'],
        $_POST['idPriority'],
        $_POST['idCategory']
    ]);

    $taskId = $pdo->lastInsertId();

    if (!empty($_POST['tags'])) {
        $tags = explode(",", $_POST['tags']);

        foreach ($tags as $tag) {
            $tag = trim($tag);
            if ($tag == "")
                continue;

            $stmt = $pdo->prepare("SELECT idTag FROM TAG WHERE tag = ?");
            $stmt->execute([$tag]);
            $exist = $stmt->fetch();

            if ($exist) {
                $tagId = $exist['idTag'];
            } else {
                $stmt = $pdo->prepare("INSERT INTO TAG (tag) VALUES (?)");
                $stmt->execute([$tag]);
                $tagId = $pdo->lastInsertId();
            }

            $stmt = $pdo->prepare("INSERT INTO TASK_TAG (idTask, idTag) VALUES (?, ?)");
            $stmt->execute([$taskId, $tagId]);
        }
    }

    $pdo->commit();

    header("Location: tasks.php");
    exit;
}
?>

<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <title>Créer une tâche</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>

    <a class="btn btn0" href="tasks.php">Voir les tâches ☰</a>

    <h1>Créer une tâche</h1>

    <form method="POST">

        <div class="form-field">
            <label for="title">Titre</label>
            <input type="text" id="title" name="title" required>
        </div>

        <div class="form-field">
            <label for="note">Note</label>
            <textarea id="note" name="note" rows="4"></textarea>
        </div>

        <div class="form-field">
            <label for="dateFinished">Date de fin</label>
            <input type="date" id="dateFinished" name="dateFinished" required>
        </div>

        <div class="form-field">
            <label for="idStatus">Statut</label>
            <select id="idStatus" name="idStatus" required>
                <?php foreach ($statuses as $s): ?>
                    <option value="<?= $s['idStatus'] ?>"><?= $s['status'] ?></option>
                <?php endforeach; ?>
            </select>
        </div>

        <div class="form-field">
            <label for="priority">Priorité</label>
            <select name="idPriority" required>
                <?php foreach ($priorities as $p): ?>
                    <option value="<?= $p['idPriority'] ?>"><?= $p['priority'] ?></option>
                <?php endforeach; ?>
            </select>
        </div>

        <div class="form-field">
            <label for="idCategory">Catégorie</label>
            <select id="idCategory" name="idCategory" required>
                <?php foreach ($categories as $c): ?>
                    <option value="<?= $c['idCategory'] ?>"><?= $c['category'] ?></option>
                <?php endforeach; ?>
            </select>
        </div>

        <div class="form-field">
            <label for="tags">Étiquettes</label>
            <input type="text" id="tags" name="tags">
        </div>

        <button class="btn btn2" type="submit">Enregistrer</button>

    </form>

</body>

</html>