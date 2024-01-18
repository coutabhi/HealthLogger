<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Doctor's Login</title>
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
	gap:100px;
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

input {
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
		<h3>Doctor Login</h3>
		<%
		if (request.getParameter("error") != null) {
		%>
		<p style="color: red;">Login failed. Please check your email and
			password.</p>
		<%
		}
		%>
		<form action="DoctorAuthencticate" method="post">
			<label>Email</label>
			<input type="email" name="doctorEmail" placeholder="abc@example.com" required>
			<label>Password</label>
			<input type="password" name="doctorPassword" placeholder="*************" required>
			<button type="submit">Login</button>
		</form>
	</div>
</body>
</html>
