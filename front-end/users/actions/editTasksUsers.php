
<!----- PHP Section ----->

<?php

	// Include DB connection
 	include "../../../includes/dbconnect.ini.php";

 	// Button pressed boolean
 	$buttonPressedBool = false;

 	// If edit button is pressed -> take them to a separate page with taskId in the bar

 	if (isset($_GET['edit']))
 	{
 		$id = (int)$_GET['edit'];
 		$query = "SELECT taskId, description, status, statusNotes FROM Tasks WHERE taskId = $id";
 		$stmt = $conn->query($query);
 		$row = $stmt->fetch(PDO::FETCH_ASSOC);

    $statusSelectArray = array(1 => "", 2 => "", 3 => "", 4 => "", 5 => "");
    $statusSelectArray[$row['status']] = "selected";
 	}

 	// Update the table in SQL with inputted information - cast int to make sure no errors

 	if (isset($_POST['submitChanges']))
 	{

 		$descriptionChange = $_POST['descriptionChange'];
 		$statusNotesChange = $_POST['statusNotesChange'];
 		$statusChange = (int) $_POST['statusChange'];
 		$costUpdate = (float) $_POST['costChange'];

 		// Add something to check if a user just started a task or not

 		$queryUpdate = "UPDATE Tasks SET description = '$descriptionChange', status = $statusChange, statusNotes = '$statusNotesChange' WHERE taskId = $row[taskId]";
 		$stmt = $conn->query($queryUpdate);

 		$queryTaskProject = "SELECT projectId FROM Tasks WHERE taskId = $row[taskId]";
 		$stmt2 = $conn->query($queryTaskProject);

 		$row2 = $stmt2->fetch(PDO::FETCH_ASSOC);

 		echo $row2[projectId];

 		$queryCost = "UPDATE ProjectCosts SET tasksCosts = tasksCosts + $costUpdate WHERE projectId = $row2[projectId]";
 		$conn->query($queryCost);

 		$buttonPressedBool = true;

 	}

 	// Flag the entity in the table

 	else if (isset($_POST['flagChanges']))
 	{
 		$queryFlag = "UPDATE Tasks SET deleteFlagStatus = 1 WHERE taskId = $row[taskId]";
 		$stmt2 = $conn->query($queryFlag);

 		$buttonPressedBool = true;
 	}
 	else if (isset($_POST['goBack']))
 	{$buttonPressedBool = true;}

 	// Redirects user back to old page once pressed

 	if ($buttonPressedBool == true)
 	{ header ("Location: ../usersTaskView.php");}


?>


<!----- HTML Section ----->

<!DOCTYPE HTML>
<link rel = "stylesheet" href = "../bootstrap.css">
<link rel="stylesheet"type="text/css"href="../../style.css">



<div id="login-container" class="ui-container">
	<center>
		<form method = "post">
		 <div class="form-group">
		   <label for="description">Description</label>
		   <input type="text" class="form-control" name ="descriptionChange" value="<?php echo $row['description'];?>">
		   <small id="descriptionHint" class="form-text text-muted">Change the description of the related task</small>
		   <input type="hidden" name = "id" value = <?php echo $row['taskId'];?>>
		   <label for="description"> Status Notes </label>
		   <input type="tyex" class="form-control" name ="statusNotesChange" value= "<?php echo $row['statusNotes'];?>">
		  <label> Cost update </label>
		<input type="number" step = "any" class="form-control" name ="costChange" placeholder="Cost Update">
		<label class="mr-sm-2" for="inlineFormCustomSelect">Update Status</label>
		<select class="custom-select mr-sm-2" name = "statusChange" id="inlineFormCustomSelect" class = "form-control">
			<option selected>Choose...</option>
        	<option value=1 <?php echo $statusSelectArray[1];?>> No Progress</option>
        	<option value=2 <?php echo $statusSelectArray[2];?>> Early Stages</option>
        	<option value=3 <?php echo $statusSelectArray[3];?>> In Progress</option>
        	<option value=4 <?php echo $statusSelectArray[4];?>> Almost Finished </option>
        	<option value=5 <?php echo $statusSelectArray[5];?>> Finished</option>
      	</select>
      	 <button type ="submit" name ="goBack" class = "btn btn-secondary btn-space2"> Back </button>
		 <button type="submit" name = "submitChanges" class="btn btn-primary btn-space2">Submit</button>
		 <button type="submit" name = "flagChanges" class="btn btn-danger btn-space2">Flag for Deletion</button>
	</form>

	</center>
</div>




</HTML>
