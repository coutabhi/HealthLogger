<%@page import="java.util.List"%>
<%@page import="com.services.PatientService"%>
<%@page import="com.entities.Patient"%>
<%@page import="com.entities.Doctor"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Search Patient</title>
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
	margin: 10px;
}

input {
	height: 4vh;
	border-radius: 10px;
	padding: 2px;
}

.search-form {
	display: inline;
}

#searchResults {
	list-style: none;
	padding: 0;
	margin: 0;
	max-height: 150px;
	overflow-y: auto;
	border: 1px solid #ddd;
	position: absolute;
}

#searchResults li {
	padding: 10px;
	background-color: #f9f9f9;
	border-bottom: 1px solid #ddd;
	cursor: pointer;
}

#searchResults li:hover {
	background-color: #ddd;
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
</style>
</head>
<body>
	<div class="header-container">
		<h1>
			<%
			HttpSession httpSession = request.getSession();
			Doctor loggedDoctor = (Doctor) httpSession.getAttribute("loggedDoctor");
			if (loggedDoctor != null) {
				out.print("Hi, " + loggedDoctor.getDoctorName() + "!");
			} else {
				response.sendRedirect("doctorLogin.jsp");
			}
			%>
		</h1>
	</div>
	<div>
		<button class="buttons"
			onclick="window.location.href='doctorDashboard.jsp'">Home</button>
		<form action="searchPatient.jsp" class="search-form" method="post">
			<input type="text" name="search" placeholder="Search Patients" />
			<ul id="searchResults"></ul>
		</form>
	</div>
	<%
		String searchText = request.getParameter("search");
	%>
	<div class="patients-list">
		<h2>All Patients</h2>
		<%
			String searchQuery = searchText;
			List<Patient> patients;
	
			if (searchQuery != null && !searchQuery.isEmpty()) {
				patients = PatientService.searchPatientsByName(loggedDoctor.getDoctorId(), searchQuery);
			} else {
				patients = PatientService.getAllPatientsByDoctorId(loggedDoctor.getDoctorId());
			}
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
							Vitals</a> <h1> </h1>
							<a
						href="addVitals.jsp?patientId=<%=patient.getPatientId()%>">Add
							Vitals</a></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>

	<script>
	document.getElementById('searchQuery').addEventListener('input', function () {
	    var searchQuery = this.value.trim();
	    var searchResultsContainer = document.getElementById('searchResults');

	    searchResultsContainer.innerHTML = '';

	    if (searchQuery !== '') {
	        var doctorId = <%=loggedDoctor.getDoctorId()%>;
	        console.log('Search query:', searchQuery);

	        fetch(`SearchPatientsServlet?doctorId=${doctorId}&searchQuery=${searchQuery}`)
	            .then(response => {
	                if (!response.ok) {
	                    throw new Error('Network response was not ok');
	                }
	                return response.json();
	            })
	            .then(data => {
	                data.forEach(patient => {
	                    var listItem = document.createElement('li');
	                    listItem.textContent = patient.patientName;
	                    listItem.addEventListener('click', function () {
	                        window.location.href = 'viewVitals.jsp?patientId=' + patient.patientId;
	                    });
	                    searchResultsContainer.appendChild(listItem);
	                });
	            })
	            .catch(error => console.error('Error:', error));
	    } else {
	        var doctorId = <%=loggedDoctor.getDoctorId()%>;

	        fetch(`SearchPatientsServlet?doctorId=${doctorId}`)
	            .then(response => {
	                if (!response.ok) {
	                    throw new Error('Network response was not ok');
	                }
	                return response.json();
	            })
	            .then(data => {
	                data.forEach(patient => {
	                    var listItem = document.createElement('li');
	                    listItem.textContent = patient.patientName;
	                    listItem.addEventListener('click', function () {
	                        window.location.href = 'viewVitals.jsp?patientId=' + patient.patientId;
	                    });
	                    searchResultsContainer.appendChild(listItem);
	                });
	            })
	            .catch(error => console.error('Error:', error));
	    }
	});

</script>

</body>
</html>