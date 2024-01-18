<%@page import="com.entities.Patient"%>
<%@page import="com.services.PatientService"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Patient's Vital</title>
<style>
body {
	font-family: 'Arial', sans-serif;
	background-color: #f2f2f2;
	margin: 0;
	padding: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	flex-direction: column;
}
h1 {
	display: flex;
	color: blue;
	
}
form {
	background-color: #fff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	width: 400px;
}

label {
	display: block;
	margin-bottom: 8px;
	font-weight: bold;
}

input {
	width: 100%;
	padding: 10px;
	margin-bottom: 16px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
}

button {
	background-color: #4caf50;
	color: #fff;
	padding: 10px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

button:hover {
	background-color: #45a049;
}

h2 {
	text-align: center;
	margin-bottom: 20px;
}
</style>
</head>
<body>
	<%
	Long patientId = Long.parseLong(request.getParameter("patientId"));
	%>
	<%
	PatientService patientService = new PatientService();
	%>
	<%
	Patient patient = patientService.getPatientDetails(patientId);
	%>
	<%
	String patientName = "John Doe";
	%>
	<%
	int patientAge = 30;
	%>
	<%
	String patientPhoneNo = "+91 9876543210";
	%>
	<h1>Health Logger</h1>
	<form action="AddPatientVitals" method="post">
		<h2>
			Add Vitals for
			<%=patient.getPatientName()%></h2>
		<p>
			Patient ID:
			<%=patient.getPatientId()%></p>
		<p>
			Name:
			<%=patient.getPatientName()%></p>
		<p>
			Age:
			<%=patient.getPatientAge()%></p>
		<p>
			Mobile No:
			<%=patient.getPatientPhoneNo()%></p>

		<input type="hidden" name="patientId" value="<%=patientId%>">

		<label>BP High Value</label> <input type="number" name="bp_high"
			required> <label>BP Low Value</label> <input type="number"
			name="bp_low" required> <label>SPO2 Value</label> <input
			type="number" name="spo2" required>

		<button type="submit">Submit</button>
	</form>
</body>
</html>
