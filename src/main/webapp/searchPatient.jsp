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
</style>
</head>
<body>
	<div class="header-container">
		<h1>
			<%
			HttpSession httpSession = request.getSession();
			Doctor loggedInDoctor = (Doctor) httpSession.getAttribute("loggedInDoctor");
			if (loggedInDoctor != null) {
				out.print("Hi, " + loggedInDoctor.getDoctorName() + "!");
			} else {
				response.sendRedirect("doctorLogin.jsp");
			}
			%>
		</h1>
	</div>
	<div>
		<button class="buttons"
			onclick="window.location.href='doctorDashboard.jsp'">Home</button>
		<div class="search-form">
			<input type="text" id="searchQuery" placeholder="Search Patients" />
			<ul id="searchResults"></ul>
		</div>
	</div>
	<div class="patients-list">
		<h2>All Patients</h2>
		<%
		String searchQuery = request.getParameter("searchQuery");
		List<Patient> patients;

		if (searchQuery != null && !searchQuery.isEmpty()) {
			// Fetch the list of patients based on search criteria
			patients = PatientService.searchPatientsByName(loggedInDoctor.getDoctorId(), searchQuery);
		} else {
			// Fetch all patients
			patients = PatientService.getAllPatientsByDoctorId(loggedInDoctor.getDoctorId());
		}
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
    document.getElementById('searchQuery').addEventListener('input', function () {
        var searchQuery = this.value.trim();
        var searchResultsContainer = document.getElementById('searchResults');

        searchResultsContainer.innerHTML = '';

        if (searchQuery !== '') {
            // Fetch filtered patients
            var doctorId = <%=loggedInDoctor.getDoctorId()%>;
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
            // Fetch all patients
            var doctorId = <%=loggedInDoctor.getDoctorId()%>;
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