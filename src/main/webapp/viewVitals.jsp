<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.entities.Patient"%>
<%@ page import="com.entities.Vitals"%>
<%@ page import="java.util.List"%>
<%@ page import="com.services.PatientService"%>
<%@ page import="com.services.VitalsService"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>View Patient Vitals</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 20px;
	background-color: #f0f2f1;
}

h4 {
	display: inline;
}

.buttons-container {
	display: flex;
	justify-content: space-between;
	margin-bottom: 20px;
}

.buttons {
	border-radius: 10px;
	height: 5vh;
	text-align: center;
	margin: 10px;
	border-color: white;
}

h1 {
	display: block;
	text-align: center;
	color: blue;
}

h2 {
	color: #3498db;
}

h3 {
	display: inline;
	justify-content: space-between;
	color: #333;
	margin: 40px;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	font-style: italic;
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

canvas {
	max-width: 800px;
	margin-top: 20px;
}

p {
	color: #333;
	margin-top: 20px;
}

a {
	color: #e74c3c;
	text-decoration: none;
	cursor: pointer;
}

a:hover {
	text-decoration: underline;
}
</style>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
	<h1>Health Logger</h1>
	<h2>View Patient Vitals</h2>
	<div class="buttons-container">
		<h4>Vitals</h4>

		<div>
			<button class="buttons"
				onclick="window.location.href='doctorDashboard.jsp'">Home</button>
			<button class="buttons">Logout</button>
			<button class="buttons">Manage Patients</button>
			<button class="buttons" onclick="exportToCSV()">Export</button>
			<button class="buttons">Record New Vital</button>
		</div>
	</div>
	<br>
	<br>

	<%
	Long patientId = Long.parseLong(request.getParameter("patientId"));
	%>

	<%
	PatientService patientService = new PatientService();
	Patient patient = patientService.getPatientDetails(patientId);
	List<Vitals> vitalsList = patient.getVitals();
	%>

	<%
	if (vitalsList != null && !vitalsList.isEmpty()) {
	%>

	<h3>
		Patient Name:
		<%=patient.getPatientName()%></h3>
	<h3>
		Patient Email:
		<%=patient.getPatientEmail()%></h3>
	<h3>
		Patient Phone Number:
		<%=patient.getPatientPhoneNo()%></h3>

	<canvas id="lineChart" width="800" height="400"></canvas>

	<table>
		<thead>
			<tr>
				<th>Vital ID</th>
				<th>BP High</th>
				<th>BP Low</th>
				<th>SPO2</th>
				<th>Recorded Date</th>
				<th>Action</th>
			</tr>
		</thead>
		<tbody>
			<%
			for (Vitals vitals : vitalsList) {
			%>
			<tr>
				<td><%=vitals.getVitalId()%></td>
				<td><%=vitals.getBp_high()%></td>
				<td><%=vitals.getBp_low()%></td>
				<td><%=vitals.getSpo2()%></td>
				<td><%=vitals.getRecordedDate()%></td>
				<td><a href="javascript:void(0);"
					onclick="deleteVitals(<%=vitals.getVitalId()%>)">Delete</a></td>
			</tr>
			<%
			}
			%>
		</tbody>
	</table>

	<script>
        // Get the vital data for the chart
        var vitalData = {
            labels: [<%for (Vitals vitals : vitalsList) {%>'<%=vitals.getRecordedDateFormatted()%>', <%}%>],
            datasets: [{
                label: 'BP High',
                data: [<%for (Vitals vitals : vitalsList) {%><%=vitals.getBp_high()%>, <%}%>],
                borderColor: 'rgba(255, 99, 132, 1)',
                borderWidth: 2,
                fill: false
            }, {
                label: 'BP Low',
                data: [<%for (Vitals vitals : vitalsList) {%><%=vitals.getBp_low()%>, <%}%>],
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 2,
                fill: false
            }, {
                label: 'SPO2',
                data: [<%for (Vitals vitals : vitalsList) {%><%=vitals.getSpo2()%>, <%}%>],
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 2,
                fill: false
            }]
        };

        var formattedDates = [<%for (Vitals vitals : vitalsList) {%>'<%=vitals.getRecordedDate()%>', <%}%>];

        var ctx = document.getElementById('lineChart').getContext('2d');

        var myLineChart = new Chart(ctx, {
            type: 'line',
            data: vitalData,
            options: {
                responsive: false,
                maintainAspectRatio: false,
            }
        });

        function deleteVitals(vitalId) {
            if (confirm("Are you sure you want to delete this vital record?")) {
                fetch('DeleteVitalsServlet?vitalId=' + vitalId, {
                    method: 'DELETE'
                })
                .then(response => {
                    if (response.ok) {
                        location.reload();
                    } else {
                        console.error('Error deleting vitals');
                    }
                })
                .catch(error => console.error('Error:', error));
            }
        }
    </script>

	<%
	} else {
	%>

	<p>No vitals available for this patient.</p>

	<%
	}
	%>
	<script>
        function exportToCSV() {
            // Fetch the data from the server (assuming you have a servlet to handle CSV export)
            fetch('ExportVitalsToCSVServlet?patientId=<%=patientId%>', {
                method: 'GET'
            })
            .then(response => response.blob())
            .then(blob => {
                // Create a temporary anchor element to trigger the download
                var a = document.createElement('a');
                var url = window.URL.createObjectURL(blob);
                a.href = url;
                a.download = 'vitals_data.csv';
                document.body.appendChild(a);
                a.click();
                window.URL.revokeObjectURL(url);
                document.body.removeChild(a);
            })
            .catch(error => console.error('Error exporting data:', error));
        }
    </script>
</body>
</html>
