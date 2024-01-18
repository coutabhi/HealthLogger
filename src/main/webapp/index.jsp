<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Health Logger</title>
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

h1, h3 {
	color: #3498db;
}

h5, p {
	margin-top: 20px;
}

a {
	text-decoration: none;
}

button {
	padding: 10px 20px;
	font-size: 16px;
	margin: 10px;
	cursor: pointer;
	background-color: #3498db;
	color: #fff;
	border: none;
	border-radius: 10px;
}

button:hover {
	background-color: blue;
}
</style>
</head>
<body>
	<div class="container">
		<h1>Health Logger</h1>
		<h5>Developed by Abhishek Yadav</h5>
		<a href="doctorLogin.jsp"><button>Doctor Login</button></a> <a
			href="adminLogin.jsp"><button>Admin Login</button></a>
	</div>
</body>
</html>
