package com.servlets;

import com.entities.Patient;
import com.services.PatientService;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class SearchPatientsServlet
 */
@WebServlet("/SearchPatientsServlet")
public class SearchPatientsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchPatientsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 try {
	            String searchQuery = request.getParameter("searchQuery");

	            Long doctorId = Long.parseLong(request.getParameter("doctorId"));
	            if(doctorId != null) {
	            	response.sendRedirect("doctorLogin.jsp?");
	            }

	            List<Patient> searchResults = PatientService.searchPatientsByName(doctorId, searchQuery);

	            String jsonResults = new Gson().toJson(searchResults);

	            response.setContentType("application/json");
	            response.setCharacterEncoding("UTF-8");
	            response.getWriter().write(jsonResults);
	        } catch (Exception e) {
	            e.printStackTrace();
	            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	            response.getWriter().println("Error searching patients");
	        }
	}

}
