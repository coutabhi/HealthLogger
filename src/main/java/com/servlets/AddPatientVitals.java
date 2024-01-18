package com.servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Hibernate;

import com.entities.Patient;
import com.entities.Vitals;
import com.services.PatientService;
import com.services.VitalsService;

/**
 * Servlet implementation class AddPatientVitals
 */
@WebServlet("/AddPatientVitals")
public class AddPatientVitals extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddPatientVitals() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			Long patientId = Long.parseLong(request.getParameter("patientId"));
			int bpHigh = Integer.parseInt(request.getParameter("bp_high"));
			int bpLow = Integer.parseInt(request.getParameter("bp_low"));
			int spo2 = Integer.parseInt(request.getParameter("spo2"));

			Vitals vitals = new Vitals();
			vitals.setBp_high(bpHigh);
			vitals.setBp_low(bpLow);
			vitals.setSpo2(spo2);

			PatientService patientService = new PatientService();
			Patient patient = patientService.getPatientDetails(patientId);
			
			Hibernate.initialize(patient.getVitals());

			vitals.setPatient(patient);
			
			VitalsService vitalsService = new VitalsService();
			vitalsService.saveVitals(vitals);
		
            List<Vitals> patientVitals = patient.getVitals();
            patientVitals.add(vitals);

            patient.setVitals(patientVitals);
            
            patientService.updatePatient(patient);
			
			
			response.sendRedirect("managePatients.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("error.jsp");
		}
	}

}
