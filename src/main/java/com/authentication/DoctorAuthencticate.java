package com.authentication;

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

/**
 * Servlet implementation class DoctorAuthencticate
 */
@WebServlet("/DoctorAuthencticate")
public class DoctorAuthencticate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public DoctorAuthencticate() {
		super();
	}

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String doctorEmail = request.getParameter("doctorEmail");
		String doctorPassword = request.getParameter("doctorPassword");

		System.out.println("Doctot email " + doctorEmail + "Doctor password" + doctorPassword);

		Configuration cfg = new Configuration();
		cfg.configure("hibernate.cfg.xml");
		try (SessionFactory sf = cfg.buildSessionFactory(); Session session = sf.openSession()) {

			Transaction trans = session.beginTransaction();

			Doctor doctor = (Doctor) session
					.createQuery("FROM Doctor WHERE doctorEmail = :email AND doctorPassword = :password")
					.setParameter("email", doctorEmail).setParameter("password", doctorPassword).uniqueResult();

			trans.commit();

			if (doctor != null) {
				HttpSession httpSession = request.getSession();
				int sessionTimeoutInSeconds = 1* 60;
                httpSession.setMaxInactiveInterval(sessionTimeoutInSeconds);
				httpSession.setAttribute("loggedInDoctor", doctor);
				response.sendRedirect("doctorDashboard.jsp");
			} else {
				response.sendRedirect("doctorLogin.jsp?error=true");
			}
		} catch (Exception e) {
			response.sendRedirect("doctoLogin.jsp?exError=" + e);
		}

	}

}
