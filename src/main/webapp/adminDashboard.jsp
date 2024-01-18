<%@page import="com.services.DoctorService"%>
<%@page import="com.entities.Doctor"%>
<%@page import="java.util.List"%>
<%@page import="com.entities.Admin"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>Admin's Dashboard</title>
<style>
h1 {
	color: #3498db;
}

.header {
	margin-left: 10px;
}

body {
	font-family: 'Roboto', sans-serif;
	background-color: #f5f5f5;
	margin: 0;
}

#tabs {
	display: flex;
	background-color: grey;
	padding: 10px;
	color: #fff;
	justify-content: right;
}

#tabs button {
	background-color: transparent;
	border: none;
	color: #fff;
	cursor: pointer;
	font-size: 16px;
	margin-right: 20px;
}

#logout {
	margin-right: 20px;
	cursor: pointer;
	color: #fff;
}

#content {
	padding: 20px;
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

a {
	text-decoration: none;
	color: #3498db;
	margin-top: 10px;
	display: block;
}
</style>
</head>
<body>
	<h1 align="center">Health Logger</h1>
	<h2 class="header">
		<%
		HttpSession httpSession = request.getSession();
		Admin loggedInAdmin = (Admin) httpSession.getAttribute("loggedInAdmin");
		if (loggedInAdmin != null) {
			out.print("Hi, " + loggedInAdmin.getAdminName() + "!");
		} else {
			response.sendRedirect("adminLogin.jsp");
		}
		%>
	</h2>

	<div id="tabs">
		<button onclick="window.location.href='addDoctor.jsp'">Add
			Doctor</button>
		<button onclick="window.location.href='addAdmin.jsp'">Add
			Admin</button>
		<div id="logout" onclick="logout()">Logout</div>
	</div>

	<div id="content">
		<h2>List of Doctors</h2>
		<%
		List<Doctor> doctors = DoctorService.getAllDoctorsByAdminId(loggedInAdmin.getAdminId());
		%>
		<table>
			<thead>
				<tr>
					<th>Doctor Name</th>
					<th>Email</th>
					<th>Phone Number</th>
					<th>Speciality</th>
					<th>No of patients</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (Doctor doctor : doctors) {
				%>
				<tr>
					<td><%=doctor.getDoctorName()%></td>
					<td><%=doctor.getDoctorEmail()%></td>
					<td><%=doctor.getDoctorPhoneNo()%></td>
					<td><%=doctor.getDoctorSpeciality()%></td>
					<td><%=doctor.calculateNoOfPatients()%></td>
					<td>
						<!-- Add a link to view vitals --> <a
						href="manageDoctor.jsp?doctorId=<%=doctor.getDoctorId()%>">
							Action</a>
					</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>

	<script>
		function showDoctors() {
			document.getElementById("content").innerHTML = "<h2>List of Doctors</h2> <!-- Add content specific to the 'List of Doctors' tab here -->";
		}

		function showManageDoctor() {
			document.getElementById("content").innerHTML = "<h2>Manage Doctor</h2> <!-- Add content specific to the 'Manage Doctor' tab here -->";
		}

		function showAddDoctor() {
			document.getElementById("content").innerHTML = "<h2>Add Doctor</h2> <!-- Add content specific to the 'Add Doctor' tab here -->";
		}

		function logout() {
		<%new com.services.AdminService().adminLogout(session);%>
			window.location.href = "index.jsp";
			alert("Logout successful");
		}
	</script>

</body>
</html>
