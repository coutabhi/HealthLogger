<%@page import="com.entities.Doctor"%>
<%@page import="com.entities.Gender"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Health Logger</title>
<style>
* {
	margin: 0;
	box-sizing: border-box;
}

body {
	height: 100vh;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
}

h1 {
	margin-top: 300px;
}

p {
	color: #a0a0a0;
	margin: 4px 0 24px 0;
}

form {
	display: flex;
	flex-direction: column;
	gap: 24px;
}

.form-group {
	display: flex;
	flex-direction: column;
	align-items: start;
	gap: 8px;
}

input:not([type="radio"]), textarea {
	width: 350px;
	padding: 10px;
	border: 1px solid #b9b9b9;
	border-radius: 8px;
}

input[type="radio"] {
	width: max-content;
}

button {
	width: 350px;
	border-radius: 12px;
	background: #32C732;
	color: #fff;
	font-weight: 700;
	padding: 10px 20px;
	border: none;
	cursor: pointer;
}

button:hover {
	background: #28A228;
}
</style>
</head>
<body>
	<%
	// Retrieve the doctor object from the session
	HttpSession httpSession = request.getSession();
	Doctor loggedInDoctor = (Doctor) httpSession.getAttribute("loggedInDoctor");
	if (loggedInDoctor != null) {
		out.print("<h1>Health Logger</h1>");
		
	} else {
		response.sendRedirect("doctorLogin.jsp");
	}
	%>
	<p>Add Patient Information</p>

	<form action="AddPatientServlet" method="post">
		<div class="form-group">
			<label> Name</label> <input type="text" name="patientName"
				placeholder="John Peterson" required>
		</div>
		<div class="form-group">
			<label>Email</label> <input type="email" name="patientEmail"
				placeholder="abc@example.com">
		</div>
		<div class="form-group">
			<label>Phone</label> <input type="text" name="patientPhone"
				placeholder="+91 ***** *****" required>
		</div>
		<div class="form-group">
			<label>Age</label> <input type="number" name="patientAge" id="age"
				placeholder="eg: 22">
		</div>
		<div class="form-group">
			<label>Diagnosis</label> <input type="text" name="patientDiagnosis"
				placeholder="eg: Blood Pressure">
		</div>
		<div class="form-group">
			<label>Remark</label>
			<textarea rows="5" name="patientRemarks" id="remarks"></textarea>
		</div>

		<div class="form-group">
			<span>Gender</span>
			<div style="display: flex; gap: 12px;">
				<input type="radio" name="patientGender" id="male"
					value="<%=Gender.MALE%>"> <label for="male">Male</label>
			</div>
			<div style="display: flex; gap: 12px;">
				<input type="radio" name="patientGender" id="female"
					value="<%=Gender.FEMALE%>"> <label for="female">Female</label>
			</div>
			<div style="display: flex; gap: 12px;">
				<input type="radio" name="patientGender" id="female"
					value="<%=Gender.OTHER%>"> <label for="female">Other</label>
			</div>
		</div>

		<div role="alert">
			<small>${message}</small>
		</div>
		<button type="submit">Sumbit</button>

	</form>

</body>
</html>