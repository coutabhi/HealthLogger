package com.servlets;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.entities.Vitals;
import com.services.VitalsService;

@WebServlet("/ExportVitalsToCSVServlet")
public class ExportVitalsToCSVServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=vitals_data.csv");

        PrintWriter writer = response.getWriter();

        // Assuming you have a service method to get vitals data by patientId
        VitalsService vitalsService = new VitalsService();
        Long patientId = Long.parseLong(request.getParameter("patientId"));
        List<Vitals> vitalsList = vitalsService.getVitalsByPatientId(patientId);

        // Write CSV header
        writer.println("Vital ID,BP High,BP Low,SPO2,Recorded Date");

        // Write CSV data
        for (Vitals vitals : vitalsList) {
            writer.println(
                    vitals.getVitalId() + "," +
                    vitals.getBp_high() + "," +
                    vitals.getBp_low() + "," +
                    vitals.getSpo2() + "," +
                    vitals.getRecordedDateFormatted()
            );
        }

        writer.close();
    }
}
