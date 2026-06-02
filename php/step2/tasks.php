<?php
require "db.php";

$statuses = $pdo->query("SELECT * FROM TASK_STATUS")->fetchAll(PDO::FETCH_ASSOC);

$filter = $_GET['status'] ?? [];

if ($filter === 'none') {
    $filter = ['none'];
}

$sql = "
SELECT t.*,
       s.status AS status_name,
       p.priority AS priority_name,
       c.category AS category_name,
       GROUP_CONCAT(tag.tag SEPARATOR ', ') AS tags
FROM TASK t
JOIN TASK_STATUS s ON t.idStatus = s.idStatus
JOIN PRIORITY p ON t.idPriority = p.idPriority
JOIN CATEGORY c ON t.idCategory = c.idCategory
LEFT JOIN TASK_TAG tt ON t.idTask = tt.idTask
LEFT JOIN TAG tag ON tt.idTag = tag.idTag
";

$selectedStatuses = $filter;

if (!empty($filter) && !in_array('none', $filter, true)) {
    $ids = array_map('intval', (array) $filter);
    $sql .= " WHERE t.idStatus IN (" . implode(",", $ids) . ")";
} elseif (in_array('none', $filter, true)) {
    $sql .= " WHERE 1=0";
}

$sql .= " GROUP BY t.idTask ORDER BY t.dateFinished ASC";

$tasks = $pdo->query($sql)->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <title>Les tâches</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>

<div class="header">
    <a class="btn btn0" href="savetask.php">Créer une tâche +</a>

    <div style="display:flex;align-items:center;justify-content:space-between;width:100%;">
        <h1>Les tâches</h1>
        <button class="btn btn0" onclick="openFilterModal()">Filtrer ∇</button>
    </div>
</div>

<div id="modal-filter" class="modal">
    <div class="modal-content">
        <h3>Statuts à afficher</h3>
        <div id="statusCheckboxes"></div>
        <button class="btn btn5" onclick="closeFilterModal()">Annuler</button>
        <button class="btn btn4" onclick="applyFilter()">Valider</button>
    </div>
</div>

<div id="modal-task-status" class="modal">
    <div class="modal-content">
        <div class="form-field">
            <label>Statut</label>
            <select id="idStatus"></select>
        </div>
        <form id="statusForm" method="POST" action="update_status.php">
            <input type="hidden" name="idTask" id="statusTaskId">
            <input type="hidden" name="idStatus" id="statusValue">
        </form>
        <button class="btn btn5" onclick="closeStatusModal()">Annuler</button>
        <button class="btn btn4" onclick="submitStatus()">Valider</button>
    </div>
</div>

<table>
    <tbody>

    <?php if (empty($tasks)): ?>
        <tr class="no-task">
            <td colspan="4">⚠️ Pas de tâche ⚠️</td>
        </tr>
    <?php endif; ?>

    <?php foreach ($tasks as $t): ?>
        <tr>
            <td>
                <div><b><?= htmlspecialchars($t['title']) ?></b></div>

                <div class="flags">
                    <span class="flag"><?= $t['priority_name'] ?></span>
                    <span class="flag"><?= $t['category_name'] ?></span>
                </div>

                <?php if (!empty($t['note'])): ?>
                    <div><?= htmlspecialchars($t['note']) ?></div>
                <?php endif; ?>

                <?php if (!empty($t['tags'])): ?>
                    <div class="tags">🏷️ <?= htmlspecialchars($t['tags']) ?></div>
                <?php endif; ?>
            </td>

            <td class="center">
                <?= date("d/m/Y", strtotime($t['dateFinished'])) ?>
            </td>

            <td class="center">
                <button class="btn btn<?= $t['idStatus'] ?>"
                        onclick="openStatusModal(<?= $t['idTask'] ?>, <?= $t['idStatus'] ?>)">
                    <?= $t['status_name'] ?>
                </button>
            </td>

            <td class="actions">
                <a href="delete_task.php?id=<?= $t['idTask'] ?>" class="delete-btn">✕</a>
            </td>
        </tr>
    <?php endforeach; ?>

    </tbody>
</table>

<script>
let statuses = <?= json_encode($statuses) ?>;
let selectedStatuses = <?= json_encode($selectedStatuses) ?>;

function openStatusModal(taskId, currentStatus) {
    const modal = document.getElementById("modal-task-status");
    const select = document.getElementById("idStatus");

    document.getElementById("statusTaskId").value = taskId;

    select.innerHTML = "";

    statuses.forEach(s => {
        const option = document.createElement("option");
        option.value = s.idStatus;
        option.text = s.status;
        if (s.idStatus == currentStatus) option.selected = true;
        select.appendChild(option);
    });

    modal.style.display = "block";
}

function closeStatusModal() {
    document.getElementById("modal-task-status").style.display = "none";
}

function submitStatus() {
    document.getElementById("statusValue").value =
        document.getElementById("idStatus").value;

    document.getElementById("statusForm").submit();
}

function openFilterModal() {
    const modal = document.getElementById("modal-filter");
    const container = document.getElementById("statusCheckboxes");

    container.innerHTML = "";

    const selectedSet = new Set(selectedStatuses.map(v => v.toString()));

    statuses.forEach(s => {
        const div = document.createElement("div");
        div.className = "status";

        const id = `status_${s.idStatus}`;

        div.innerHTML = `
            <input type="checkbox" id="${id}" value="${s.idStatus}"
            ${selectedSet.size === 0 || selectedSet.has(String(s.idStatus)) ? "checked" : ""}>

            <label for="${id}">${s.status}</label>
        `;

        container.appendChild(div);
    });

    modal.style.display = "block";
}

function closeFilterModal() {
    document.getElementById("modal-filter").style.display = "none";
}

function applyFilter() {
    const checked = [...document.querySelectorAll("#statusCheckboxes input:checked")]
        .map(cb => cb.value);

    const url = new URL(window.location.href);
    url.searchParams.delete("status[]");

    if (checked.length === 0) {
        url.searchParams.set("status", "none");
    } else {
        checked.forEach(id => {
            url.searchParams.append("status[]", id);
        });
    }

    window.location.href = url;
}
</script>

</body>
</html>