<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Doctor</title>
<style>
body {
	font-family: 'Roboto', sans-serif;
	background-color: #f5f5f5;
	display: flex;
	align-items: center;
	justify-content: center;
	height: 100vh;
	margin: 0;
}

.container {
	text-align: center;
}

h1, h6 {
	color: #3498db;
}

p {
	margin-top: 20px;
}

a {
	text-decoration: none;
}

form {
	display: flex;
	flex-direction: column;
	align-items: center;
}

label {
	margin-top: 15px;
}

input, select {
	margin-top: 5px;
	height: 40px;
	width: 300px;
	border: 1px solid #3498db;
	border-radius: 5px;
	padding: 8px;
	box-sizing: border-box;
}

button {
	margin-top: 15px;
	padding: 10px 20px;
	font-size: 16px;
	cursor: pointer;
	background-color: #3498db;
	color: #fff;
	border: none;
	border-radius: 10px;
	transition: background-color 0.3s;
}

button:hover {
	background-color: #2077b4;
}
</style>
</head>
<body>
	<div class="container">
		<h1>Health Logger</h1>
		<h6>Add Doctor</h6>
		<form action="AddDoctorServlet" method="post">
			<label>Doctor Name</label> <input type="text" name="doctorName"
				required> <label>Doctor Email</label> <input type="email"
				name="doctorEmail" required> <label>Doctor Phone</label> <input
				type="text" name="doctorPhoneNo" required> <label>Doctor
				Password</label> <input type="password" name="doctorPassword" required><label>Doctor
				Speciality</label> <select name="doctorSpeciality" required>
				<option value="General Medicine">General Medicine</option>
				<option value="Cardiology">Cardiology</option>
				<option value="Dermatology">Dermatology</option>
				<option value="Orthopedics">Orthopedics</option>
				<option value="Pediatrics">Pediatrics</option>
				<option value="Ophthalmology">Ophthalmology</option>
				<option value="Gynecology">Gynecology</option>
				<option value="Neurology">Neurology</option>
				<option value="Urology">Urology</option>
				<option value="ENT (Ear, Nose, Throat)">ENT (Ear, Nose,
					Throat)</option>
			</select>
			<button type="submit">Add Doctor</button>
		</form>
	</div>
</body>
</html>
