<?php
header('Content-Type: application/json');
include "konek.php";

$stmt = $db->prepare("SELECT id, product_name, category, price, stock, description FROM produk              ");
$stmt->execute();
$result = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($result);
?>