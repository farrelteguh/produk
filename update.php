<?php
header('Content-Type: application/json');
include "konekdb.php";

$product_name = $_POST['product_name'];
$category = $_POST['category'];
$price = $_POST['price'];
$stock = $_POST['stock'];

$stmt = $db->prepare("UPDATE produk SET product_name = ?, category = ?, price = ?, stock = ? WHERE id = ?");
$result = $stmt->execute([$product_name, $category, $price, $stock]);

echo json_encode([
    'success' => $result
]);
?>