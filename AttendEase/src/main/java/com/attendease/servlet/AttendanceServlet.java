package com.attendease.servlet;

import com.attendease.util.DBUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.util.*;

@WebServlet("/attendance")
public class AttendanceServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String date = req.getParameter("date");
        if (date == null || date.isBlank()) date = LocalDate.now().toString();
        req.setAttribute("selectedDate", date);
        List<Map<String,Object>> rows = new ArrayList<>();
        String sql = "SELECT s.id, s.roll_no, s.full_name, a.status FROM students s " +
                "LEFT JOIN attendance a ON a.student_id=s.id AND a.attendance_date=? ORDER BY s.roll_no";
        try (Connection con = DBUtil.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, java.sql.Date.valueOf(date));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String,Object> row = new LinkedHashMap<>();
                    row.put("id", rs.getInt("id")); row.put("rollNo", rs.getString("roll_no"));
                    row.put("name", rs.getString("full_name"));
                    String status = rs.getString("status");
                    row.put("status", status == null ? "PRESENT" : status);
                    rows.add(row);
                }
            }
        } catch (SQLException | IllegalArgumentException e) {
            throw new ServletException("Unable to load attendance. Check the selected date.", e);
        }
        req.setAttribute("students", rows);
        req.getRequestDispatcher("/WEB-INF/views/attendance.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String date = req.getParameter("attendanceDate");
        if (date == null || date.isBlank()) date = LocalDate.now().toString();
        String[] ids = req.getParameterValues("studentId");
        Connection con = null;
        try {
            con = DBUtil.getConnection();
            con.setAutoCommit(false);
            String sql = "INSERT INTO attendance(student_id, attendance_date, status) VALUES(?,?,?) " +
                    "ON DUPLICATE KEY UPDATE status=VALUES(status), marked_at=CURRENT_TIMESTAMP";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                if (ids != null) {
                    for (String id : ids) {
                        String status = req.getParameter("status_" + id);
                        if (!"ABSENT".equals(status) && !"LATE".equals(status)) status = "PRESENT";
                        ps.setInt(1, Integer.parseInt(id));
                        ps.setDate(2, java.sql.Date.valueOf(date));
                        ps.setString(3, status);
                        ps.addBatch();
                    }
                    ps.executeBatch();
                }
            }
            con.commit();
            resp.sendRedirect(req.getContextPath() + "/attendance?date=" + date + "&saved=1");
        } catch (Exception e) {
            if (con != null) try { con.rollback(); } catch (SQLException ignored) {}
            throw new ServletException("Unable to save attendance.", e);
        } finally {
            if (con != null) {
                try { con.setAutoCommit(true); con.close(); } catch (SQLException ignored) {}
            }
        }
    }
}
