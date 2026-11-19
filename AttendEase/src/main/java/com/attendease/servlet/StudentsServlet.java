package com.attendease.servlet;

import com.attendease.util.DBUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/students")
public class StudentsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String search = req.getParameter("q");
        if (search == null) search = "";
        req.setAttribute("search", search);
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     "SELECT id, roll_no, full_name, email, department, year_level, section_name FROM students " +
                     "WHERE roll_no LIKE ? OR full_name LIKE ? OR department LIKE ? ORDER BY full_name")) {
            String pattern = "%" + search.trim() + "%";
            ps.setString(1, pattern); ps.setString(2, pattern); ps.setString(3, pattern);
            try (ResultSet rs = ps.executeQuery()) {
                java.util.List<java.util.Map<String,Object>> rows = new java.util.ArrayList<>();
                while (rs.next()) {
                    java.util.Map<String,Object> row = new java.util.LinkedHashMap<>();
                    row.put("id", rs.getInt("id")); row.put("rollNo", rs.getString("roll_no"));
                    row.put("name", rs.getString("full_name")); row.put("email", rs.getString("email"));
                    row.put("department", rs.getString("department")); row.put("year", rs.getInt("year_level"));
                    row.put("section", rs.getString("section_name")); rows.add(row);
                }
                req.setAttribute("students", rows);
            }
        } catch (SQLException e) {
            throw new ServletException("Unable to load students.", e);
        }
        req.getRequestDispatcher("/WEB-INF/views/students.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        try (Connection con = DBUtil.getConnection()) {
            if ("delete".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                try (PreparedStatement ps = con.prepareStatement("DELETE FROM students WHERE id = ?")) {
                    ps.setInt(1, id); ps.executeUpdate();
                }
            } else {
                String roll = req.getParameter("rollNo");
                String name = req.getParameter("fullName");
                String email = req.getParameter("email");
                String dept = req.getParameter("department");
                String yearText = req.getParameter("yearLevel");
                String section = req.getParameter("sectionName");
                if (roll == null || roll.isBlank() || name == null || name.isBlank()) {
                    resp.sendRedirect(req.getContextPath() + "/students?error=required");
                    return;
                }
                int year = Integer.parseInt(yearText == null || yearText.isBlank() ? "3" : yearText);
                String sql = "INSERT INTO students(roll_no, full_name, email, department, year_level, section_name) VALUES(?,?,?,?,?,?)";
                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.setString(1, roll.trim()); ps.setString(2, name.trim());
                    ps.setString(3, email == null ? "" : email.trim());
                    ps.setString(4, dept == null || dept.isBlank() ? "CSE" : dept.trim());
                    ps.setInt(5, year); ps.setString(6, section == null || section.isBlank() ? "A" : section.trim());
                    ps.executeUpdate();
                }
            }
            resp.sendRedirect(req.getContextPath() + "/students?success=1");
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/students?error=invalid");
        } catch (SQLIntegrityConstraintViolationException e) {
            resp.sendRedirect(req.getContextPath() + "/students?error=duplicate");
        } catch (SQLException e) {
            throw new ServletException("Unable to save student.", e);
        }
    }
}
