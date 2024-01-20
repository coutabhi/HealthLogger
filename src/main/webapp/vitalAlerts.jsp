<%@page import="com.entities.Doctor"%>
<%@page import="com.entities.Patient"%>
<%@ page import="java.util.List"%>
<%@ page import="com.entities.Vitals"%>
<%@ page import="com.services.PatientService"%>

<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>Vital Alerts</title>
<style>
.buttons {
	border-radius: 10px;
	height: 5vh;
	text-align: center;
	margin: 10px;
	border-color: white;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
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

tbody tr.critical {
	color: #e74c3c;
}
</style>
</head>
<body>
	<%
	HttpSession httpSession = request.getSession();
	Doctor loggedDoctor = (Doctor) httpSession.getAttribute("loggedDoctor");
	%>
	<br>
	<h2 align="center">Vital Alerts</h2>
	<button class="buttons"
		onclick="window.location.href='doctorDashboard.jsp'">Home</button>

	<%
	PatientService patientService = new PatientService();
	List<Vitals> vitalsWithCriticalValues = patientService.getVitalsWithCriticalValues(loggedDoctor.getDoctorId());

	if (vitalsWithCriticalValues != null && !vitalsWithCriticalValues.isEmpty()) {
	%>

	<table>
		<thead>
			<tr>
				<th>Patient Name</th>
				<th>Blood Pressure (High)</th>
				<th>Blood Pressure (Low)</th>
				<th>SPO2</th>
				<th>Recorded Date</th>
			</tr>
		</thead>
		<tbody>
			<%
			for (Vitals vitals : vitalsWithCriticalValues) {
			%>
			<tr>
				<td><%=vitals.getPatient().getPatientName()%></td>
				<td><%=(vitals.getBp_high() > 160) ? "<span style='color: #e74c3c;'>" + vitals.getBp_high() + "</span>"
		: vitals.getBp_high()%></td>
				<td><%=vitals.getBp_low()%></td>
				<td><%=(vitals.getSpo2() < 90) ? "<b style='color: red;'>" + vitals.getSpo2() + "</b>" : vitals.getSpo2()%></td>
				<td><%=vitals.getRecordedDateFormatted()%></td>
			</tr>
			<%
			}
			%>
		</tbody>
	</table>

	<%
	} else {
	%>

	<p>No patients with critical vitals.</p>

	<%
	}
	%>
</body>
</html>
