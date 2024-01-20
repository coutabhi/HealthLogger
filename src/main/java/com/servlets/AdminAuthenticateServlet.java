package com.servlets;

import com.entities.Admin;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/AdminAuthenticateServlet")
public class AdminAuthenticateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String adminEmail = request.getParameter("adminEmail");
		String adminPassword = request.getParameter("adminPassword");

		Configuration cfg = new Configuration();
		cfg.configure("hibernate.cfg.xml");

		try (SessionFactory sf = cfg.buildSessionFactory(); Session session = sf.openSession()) {

			Transaction trans = session.beginTransaction();

			Admin admin = (Admin) session
					.createQuery("FROM Admin WHERE adminEmail = :email AND adminPassword = :password")
					.setParameter("email", adminEmail).setParameter("password", adminPassword).uniqueResult();
			trans.commit();
			if (admin != null) {
				HttpSession httpSession = request.getSession();
				httpSession.invalidate();
				int sessionTimeoutInSeconds = 10 * 60;
				HttpSession httpSession2 = request.getSession();
				httpSession2.setMaxInactiveInterval(sessionTimeoutInSeconds);
				httpSession2.setAttribute("loggedInAdmin", admin);
				System.out.println("The session attribute is " + httpSession2.getAttribute("loggedInAdmin"));
				response.sendRedirect("adminDashboard.jsp");
			} else {
				response.sendRedirect("adminLogin.jsp?error=true");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("error.jsp");
		}
	}
}
