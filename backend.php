<?php
DEFINE('host', 'localhost');
DEFINE('user','root');
DEFINE('password','');
$conn=mysqli_connect(host,user,password);
mysqli_set_charset($conn,'utf8');
$baza=mysqli_select_db($conn,'muzyka2021');
$jsonContent = file_get_contents('php://input');
$decoded=json_decode($jsonContent,true);
$kwerenda=mysqli_prepare($conn,"SELECT tytul,data_wyd_org,nosnik,cena from plyta where tytul=? or cena<? or nosnik=?");
mysqli_stmt_bind_param($kwerenda ,'sds', $decoded['tytul'],$decoded['cena'],$decoded['nosnik']);
mysqli_stmt_execute($kwerenda);
mysqli_stmt_bind_result($kwerenda,$v1,$v2,$v3,$v4);
echo"<table>";
echo"<th>TYTUŁ</th>";
echo"<th>DATA WYDANIA</th>";
echo"<th>NOŚNIK</th>";
echo"<th>cena</th>";

while (mysqli_stmt_fetch($kwerenda)) {
    echo"<tr>";
    echo"<td>$v1</td><td>$v2</td><td>$v3</td><td>$v4</td>";
    echo"</tr>";
}
echo "</table>";
mysqli_close($conn)
?>