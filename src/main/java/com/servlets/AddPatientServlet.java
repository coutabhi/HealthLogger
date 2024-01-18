package com.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import com.entities.Doctor;
import com.entities.Gender;
import com.entities.Patient;

/**
 * Servlet implementation class AddPatientServlet
 */
@WebServlet("/AddPatientServlet")
public class AddPatientServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddPatientServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession httpSession = request.getSession();
		Doctor loggedInDoctor = (Doctor) httpSession.getAttribute("loggedInDoctor");
		if (loggedInDoctor != null) {
			Configuration cfg = new Configuration();
			cfg.configure("hibernate.cfg.xml");
			try (SessionFactory sf = cfg.buildSessionFactory(); Session session = sf.openSession()) {
				Transaction trans = session.beginTransaction();
				String patientName = request.getParameter("patientName");
				String patientEmail = request.getParameter("patientEmail");
				String patientPhoneNo = request.getParameter("patientPhoneNo");
				int patientAge = Integer.parseInt(request.getParameter("patientAge"));
				String patientDiagnosis = request.getParameter("patientDiagnosis");
				String patientRemarks = request.getParameter("patientRemarks");
				Gender patientGender = Gender.valueOf(request.getParameter("patientGender"));

				Patient patient = new Patient();
				patient.setPatientName(patientName);
				patient.setPatientEmail(patientEmail);
				patient.setPatientPhoneNo(patientPhoneNo);
				patient.setPatientAge(patientAge);
				patient.setPatientDiagnosis(patientDiagnosis);
				patient.setPatientRemarks(patientRemarks);
				patient.setPatientGender(patientGender);

				patient.setDoctor(loggedInDoctor);

				session.persist(patient);
				trans.commit();
				request.setAttribute("message", "Patient added successfully.");
				request.getRequestDispatcher("doctorDashboard.jsp").forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("error.jsp");
			}

		} else {
			response.sendRedirect("doctorLogin.jsp");
		}
	}

}
