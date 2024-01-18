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
import java.io.IOException;

@WebServlet("/adminAddServlet")
public class adminAddServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String adminEmail = request.getParameter("adminEmail");
		String adminPassword = request.getParameter("adminPassword");
		String adminName = request.getParameter("adminName");

		Configuration cfg = new Configuration();
		cfg.configure("hibernate.cfg.xml");

		try (SessionFactory sf = cfg.buildSessionFactory(); Session session = sf.openSession()) {

			Transaction trans = session.beginTransaction();

			Admin admin = new Admin();
			admin.setAdminEmail(adminEmail);
			admin.setAdminPassword(adminPassword);
			admin.setAdminName(adminName);

			session.persist(admin);

			trans.commit();

			request.setAttribute("message", "Admin added successfully.");
			request.getRequestDispatcher("index.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("error.jsp");
		}
	}
}
