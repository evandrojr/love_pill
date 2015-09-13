<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
  // Set default timezone
  date_default_timezone_set('UTC');

  try {
    // Create (connect to) SQLite database in file
    $file_db = new PDO('sqlite:love_pill.sqlite3');
    // Set errormode to exceptions
    $file_db->setAttribute(PDO::ATTR_ERRMODE, 
                            PDO::ERRMODE_EXCEPTION);
    $file_db->exec("CREATE TABLE IF NOT EXISTS user (
                    id INTEGER PRIMARY KEY, 
                    email TEXT, 
                    day_of_week INTEGER)");
//      $file_db->exec("CREATE UNIQUE INDEX index_email on user (email)"); 
 
if(array_key_exists('email', $_REQUEST) ){

    // Prepare INSERT statement to SQLite3 file db
    $insert = "INSERT INTO user (email, day_of_week) 
                VALUES (:email, 5)";
    $stmt = $file_db->prepare($insert);
 
    // Bind parameters to statement variables
    $stmt->bindParam(':email', $_REQUEST['email']);
 
      // Execute statement
    if($_REQUEST['email']!="test@gmail.com")
        $stmt->execute();
    echo "<center><h2>Muito bem " . $_REQUEST['email'] . "!!! </br></br>Agora aguarde nosso email semanalmente.</br> <a href='index.html'>Clique aqui para de cadastrar seu/sua companheiro(a)!</a></h2></ce$
 }

    /**************************************
    * Close db connections                *
    **************************************/
    // Close file db connection
    $file_db = null;
  }
  catch(PDOException $e) {
    // Print PDOException message
    if($e->getMessage() != "SQLSTATE[23000]: Integrity constraint violation: 19 column email is not unique")
        echo $e->getMessage();
    else
        echo "Email cadastrado anteriomente.";
  }
?>

