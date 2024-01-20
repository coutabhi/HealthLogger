package com.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.entities.Patient;
import com.services.PatientService;

/**
 * Servlet implementation class DeletePatientServlet
 */
@WebServlet("/DeletePatientServlet")
public class DeletePatientServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DeletePatientServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Long patientId = Long.parseLong(request.getParameter("patientId"));
		PatientService patientService = new PatientService();
		try {
			Patient patient = patientService.getPatientDetails(patientId);
			boolean deleted = patientService.deletePatient(patient);

			if (deleted) {
				response.setStatus(HttpServletResponse.SC_OK);
			} else {
				// If the deletion fails, send a 500 Internal Server Error response
				response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			}
		} catch (Exception e) {
			// Handle exceptions appropriately, log them, etc.
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
	}

}
