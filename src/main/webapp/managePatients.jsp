<%@page import="com.entities.Patient"%>
<%@page import="com.entities.Doctor"%>
<%@page import="com.services.PatientService"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Health Logger</title>
<style>
table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	text-align: left;
	padding: 12px;
	border-bottom: 1px solid #a0a0a0;
}

td a, .add-btn {
	text-decoration: none;
	padding: 4px 16px;
	color: #000;
	background-color: #d9d9d9;
	border-radius: 8px;
	margin: 12px 0;
}

h3 {
	margin: 0;
}
</style>
</head>
<body>
	<%
	HttpSession httpSession = request.getSession();
	Doctor loggedDoctor = (Doctor) httpSession.getAttribute("loggedDoctor");
	if (loggedDoctor != null) {
		out.print("<h1 align='center'>Health Logger</h1>");
	} else {
		response.sendRedirect("doctorLogin.jsp");
	}
	%>
	<div
		style="display: flex; justify-content: space-between; align-items: center; width: 100%;">
		<h1>Doctor Home Page</h1>
		<a class="add-btn" href="AdminLoginController?mode=logout">Logout</a>
	</div>

	<div
		style="display: flex; align-items: center; width: 100%; margin: 8px 0; gap: 12px;">
		<a class="add-btn" href="searchPatient.jsp">Search Patient</a> <a
			class="add-btn" href="addPatient.jsp?">Add Patient</a> <a
			class="add-btn" href="manageVitals.jsp">Manage Vitals</a>
	</div>

	<div class="patients-list">
		<h2>All Patients</h2>
		<%
		// Fetch the list of patients from your backend service
		List<Patient> patients = PatientService.getAllPatientsByDoctorId(loggedDoctor.getDoctorId());
		%>
		<!-- Displaying the list of patients -->
		<table>
			<thead>
				<tr>
					<th>Patient Name</th>
					<th>Email</th>
					<th>Phone Number</th>
					<th>Remarks</th>
					<th>Diagnosis</th>
					<th>Gender</th>
					<th>Actions</th>
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
						href="addVitals.jsp?patientId=<%=patient.getPatientId()%>">Add
							Vitals</a> <a href="javascript:void(0);"
						onclick="deletePatient(<%=patient.getPatientId()%>)">Delete
							Patient</a>
							<a href="javascript:void(0);"
						onclick="updatePatient(<%=patient.getPatientId()%>)">Update
							Patient</a></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>
	<script>
        function deletePatient(patientId) {
            if (confirm("Are you sure you want to delete this patient?")) {
                // Use AJAX to asynchronously delete the patient
                fetch('DeletePatientServlet?patientId=' + patientId, {
                    method: 'DELETE'
                })
                .then(response => {
                    if (response.ok) {
                        // If the deletion is successful, reload the page
                        window.location.reload();
                    } else {
                        alert("Error deleting patient");
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert("An unexpected error occurred");
                });
            }
        }
    </script>
</body>
</html>
