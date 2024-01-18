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

import com.entities.Admin;
import com.entities.Doctor;

@WebServlet("/AddDoctorServlet")
public class AddDoctorServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AddDoctorServlet() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession httpSession = request.getSession();
		Admin loggedInAdmin = (Admin) httpSession.getAttribute("loggedInAdmin");
		System.out.println("The loggedin admin is" + loggedInAdmin);
		if (loggedInAdmin != null) {
			String doctorName = request.getParameter("doctorName");
			String doctorEmail = request.getParameter("doctorEmail");
			String doctorPhoneNo = request.getParameter("doctorPhoneNo");
			String doctorPassword = request.getParameter("doctorPassword");
			String doctorSpeciality = request.getParameter("doctorSpeciality");

			Configuration cfg = new Configuration();
			cfg.configure("hibernate.cfg.xml");

			try (SessionFactory sf = cfg.buildSessionFactory(); Session session = sf.openSession()) {

				Transaction trans = session.beginTransaction();

				Doctor doctor = new Doctor();
				doctor.setDoctorName(doctorName);
				doctor.setDoctorEmail(doctorEmail);
				doctor.setDoctorPassword(doctorPassword);
				doctor.setDoctorPhoneNo(doctorPhoneNo);
				doctor.setDoctorSpeciality(doctorSpeciality);
				doctor.setAdmin(loggedInAdmin);

				session.persist(doctor);

				trans.commit();

				request.setAttribute("message", "Doctor added successfully.");
				request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				response.sendRedirect("error.jsp");
			}
		} else {
			response.sendRedirect("adminLogin.jsp");
		}

	}

}
