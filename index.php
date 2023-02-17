<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="includy/dashboard_main.css" type="text/css">
    <title>Document</title>
</head>
<body>
<?php
    include_once('includy/header.incl')
?>
<div class="main" >
    <div class="center" >
        <form action="" method="">
            <h1>Kryteria wyszukiwania</h1>
            <label >tytuł</label><input type="text"  id="tytul" name="tytul">
            <label >cena</label><input type="text"  id="cena" name="cena">
            <label >nosnik</label><input type="text"  id="nosnik" name="nosnik"><br>
            <input type="button" id="guzik" value="szukaj">
        </form>
    </div>
    <main>
        <div id="results">
    
        </div>
    </main>
</div>
<script src="engine.js"></script>
<?php
    include_once('includy/footer.incl')
?>
</body>
</html>