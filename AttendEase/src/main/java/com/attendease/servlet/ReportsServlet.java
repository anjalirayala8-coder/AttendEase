package com.attendease.servlet;

import com.attendease.util.DBUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/reports")
public class ReportsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Map<String,Object>> rows = new ArrayList<>();
        String sql = "SELECT s.roll_no, s.full_name, " +
                "SUM(CASE WHEN a.status IN ('PRESENT','LATE') THEN 1 ELSE 0 END) AS attended, " +
                "COUNT(a.id) AS marked, " +
                "ROUND(100.0 * SUM(CASE WHEN a.status IN ('PRESENT','LATE') THEN 1 ELSE 0 END) / NULLIF(COUNT(a.id),0), 1) AS pct " +
                "FROM students s LEFT JOIN attendance a ON a.student_id=s.id " +
                "GROUP BY s.id, s.roll_no, s.full_name ORDER BY s.roll_no";
        try (Connection con = DBUtil.getConnection(); PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String,Object> row = new LinkedHashMap<>();
                row.put("rollNo", rs.getString("roll_no")); row.put("name", rs.getString("full_name"));
                row.put("attended", rs.getInt("attended")); row.put("marked", rs.getInt("marked"));
                Object pct = rs.getObject("pct");
                row.put("pct", pct == null ? null : rs.getDouble("pct"));
                rows.add(row);
            }
        } catch (SQLException e) {
            throw new ServletException("Unable to load attendance reports.", e);
        }
        req.setAttribute("reports", rows);
        req.getRequestDispatcher("/WEB-INF/views/reports.jsp").forward(req, resp);
    }
}
