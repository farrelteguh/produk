<?php
header('Content-Type: application/json');
include "konek.php";

$id = (int) $_POST['id'];
$stmt = $db->prepare("DELETE FROM produk WHERE id = ?");
$result = $stmt->execute([$id]);

echo json_encode([
    'id' => $id,
    'success' => $result
]);
?>