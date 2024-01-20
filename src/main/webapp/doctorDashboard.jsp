<%@page import="com.services.PatientService"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.entities.Doctor"%>
<%@ page import="com.entities.Patient"%>
<%@ page import="java.util.List"%>
<%@ page import="javax.servlet.http.HttpSession"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Doctor's Dashboard</title>
<style>
.header-container {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.tabs {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.buttons {
	border-radius: 10px;
	height: 5vh;
	width: auto;
	text-align: center;
	margin: 10px;
	border-color: white;
}

h1 {
	text-align: center;
	color: blue;
}

h2 {
	margin: 10px;
}

input {
	height: 4vh;
	border-radius: 10px;
	padding: 2px;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin: 20px 0;
}

th, td {
	border: 1px solid #bdc3c7;
	padding: 10px;
	text-align: left;
}

th {
	background-color: black;
	color: #fff;
}

.patient-card a {
	text-decoration: none;
	color: #3498db;
	margin-top: 10px;
	display: block;
}
</style>
</head>
<body>
	<h1>Health Logger</h1>
	<div class="header-container">
		<h2>
			<%
			HttpSession httpSession = request.getSession();
			Doctor loggedDoctor = (Doctor) httpSession.getAttribute("loggedDoctor");
			if (loggedDoctor != null) {
				out.print("Hi, " + loggedDoctor.getDoctorName() + "!");
			} else {
				response.sendRedirect("doctorLogin.jsp");
			}
			%>
		</h2>
		<div>
			<button class="buttons">Manage your Profile</button>
			<button class="buttons" onclick="logout()">Logout</button>
		</div>
	</div>

	<div class="tabs">
		<div>
			<button class="buttons"
				onclick="window.location.href='searchPatient.jsp'">Search
				Patient</button>
		</div>
		<div>
			<button class="buttons"
				onclick="window.location.href='addPatient.jsp'">Add Patient</button>
			<button class="buttons"
				onclick="window.location.href='managePatients.jsp'">Manage
				Patients</button>
			<button onclick="window.location.href='vitalAlerts.jsp'"
				class="buttons">Vital Alerts</button>
			<button class="buttons"
				onclick="window.location.href='manageVitals.jsp'">Manage
				Vitals</button>
		</div>
	</div>

	<div class="patients-list">
		<h2>All Patients</h2>
		<%
		List<Patient> patients = PatientService.getAllPatientsByDoctorId(loggedDoctor.getDoctorId());
		%>
		<table>
			<thead>
				<tr>
					<th>Patient Name</th>
					<th>Email</th>
					<th>Phone Number</th>
					<th>Remarks</th>
					<th>Diagnosis</th>
					<th>Gender</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (Patient patient : patients) {
				%>
				<tr>
					<td><%=patient.getPatientName()%></td>
					<td><%=patient.getPatientEmail()%></td>
					<td><%=patient.getPatientPhoneNo()%></td>
					<td><%=patient.getPatientRemarks()%></td>
					<td><%=patient.getPatientDiagnosis()%></td>
					<td><%=patient.getPatientGender()%></td>
					<td><a
						href="viewVitals.jsp?patientId=<%=patient.getPatientId()%>">View
							Vitals</a></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>
	<script>
		function logout() {
	<%new com.services.AdminService().adminLogout(session);%>
		window.location.href = "index.jsp";
			alert("Logout successful");
		}
	</script>
</body>
</html>
