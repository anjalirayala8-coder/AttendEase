package com.attendease.servlet;

import com.attendease.util.DBUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int students = 0, present = 0, absent = 0, late = 0;
        String today = LocalDate.now().toString();
        try (Connection con = DBUtil.getConnection()) {
            try (PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM students");
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) students = rs.getInt(1);
            }
            String sql = "SELECT status, COUNT(*) total FROM attendance WHERE attendance_date = ? GROUP BY status";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setDate(1, Date.valueOf(today));
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        switch (rs.getString("status")) {
                            case "PRESENT" -> present = rs.getInt("total");
                            case "ABSENT" -> absent = rs.getInt("total");
                            case "LATE" -> late = rs.getInt("total");
                        }
                    }
                }
            }
        } catch (SQLException e) {
            throw new ServletException("Unable to load dashboard data.", e);
        }
        int marked = present + absent + late;
        double rate = marked == 0 ? 0 : (present + late) * 100.0 / marked;
        req.setAttribute("studentCount", students);
        req.setAttribute("presentCount", present);
        req.setAttribute("absentCount", absent);
        req.setAttribute("lateCount", late);
        req.setAttribute("attendanceRate", Math.round(rate));
        req.setAttribute("today", today);
        req.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(req, resp);
    }
}
