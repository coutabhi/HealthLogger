package com.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.services.VitalsService;

/**
 * Servlet implementation class DeleteVitalsServlet
 */
@WebServlet("/DeleteVitalsServlet")
public class DeleteVitalsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteVitalsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
            // Retrieve vitalId parameter from the request
            Long vitalId = Long.parseLong(request.getParameter("vitalId"));

            // Call the service method to delete vitals
            VitalsService vitalsService = new VitalsService();
            vitalsService.deleteByVitalId(vitalId);

            // Set a success response
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            e.printStackTrace();
            // Set an error response
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().println("Error deleting vitals");
        }
	}

}
