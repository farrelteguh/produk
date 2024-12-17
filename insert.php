<?php
header('Content-Type: application/json');
include "konek.php";

$product_name = $_POST['product_name'];
$category = $_POST['category'];
$price = $_POST['price'];
$stock = $_POST['stock'];


$stmt = $db->prepare("INSERT INTO produk (product_name, category, price, stock) 
                        VALUES (?, ?, ?, ?)");
$result = $stmt->execute([$product_name, $category, $price, $stock]);

echo json_encode([
    'success' => $result
]);
?>