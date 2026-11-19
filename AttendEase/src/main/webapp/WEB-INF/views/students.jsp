<% request.setAttribute("pageTitle", "Students"); request.setAttribute("activePage", "students"); %>
<%@ include file="_layout-top.jsp" %>
<section class="welcome-row"><div><div class="eyebrow purple">YOUR CLASSROOM</div><h1>Student directory</h1><p class="muted">Manage your students in one organised place.</p></div><button class="btn btn-primary" type="button" data-modal-open="studentModal">＋ Add student</button></section>
<% if ("1".equals(request.getParameter("success"))) { %><div class="alert success">Student information saved successfully.</div><% } %>
<% if ("duplicate".equals(request.getParameter("error"))) { %><div class="alert error">That roll number already exists. Use a unique roll number.</div><% } %>
<% if ("required".equals(request.getParameter("error"))) { %><div class="alert error">Roll number and full name are required.</div><% } %>
<% if ("invalid".equals(request.getParameter("error"))) { %><div class="alert error">Please enter a valid year.</div><% } %>
<section class="panel table-panel"><div class="table-toolbar"><div><h3>All students <span class="count-pill">${students.size()}</span></h3><p class="muted">Search or manage student records</p></div>
<form class="search-form" method="get" action="<%= request.getContextPath() %>/students"><input type="search" name="q" value="<%= com.attendease.util.HtmlUtil.escape((String) request.getAttribute("search")) %>" placeholder="Search students…"><button class="btn btn-soft" type="submit">Search</button></form></div>
<div class="table-scroll"><table><thead><tr><th>STUDENT</th><th>ROLL NUMBER</th><th>DEPARTMENT</th><th>YEAR / SECTION</th><th>EMAIL</th><th>ACTION</th></tr></thead><tbody>
<% java.util.List<java.util.Map<String,Object>> students = (java.util.List<java.util.Map<String,Object>>) request.getAttribute("students"); if (students.isEmpty()) { %><tr><td colspan="6" class="empty-state">No students found. Add your first student to get started.</td></tr><% } else { for (java.util.Map<String,Object> s : students) { String name = String.valueOf(s.get("name")); %>
<tr><td><div class="student-cell"><span class="student-avatar"><%= name.isEmpty() ? "S" : name.substring(0,1).toUpperCase() %></span><strong><%= com.attendease.util.HtmlUtil.escape(name) %></strong></div></td><td><span class="roll-pill"><%= com.attendease.util.HtmlUtil.escape(String.valueOf(s.get("rollNo"))) %></span></td><td><%= com.attendease.util.HtmlUtil.escape(String.valueOf(s.get("department"))) %></td><td>Year <%= s.get("year") %> · <%= com.attendease.util.HtmlUtil.escape(String.valueOf(s.get("section"))) %></td><td><%= com.attendease.util.HtmlUtil.escape(String.valueOf(s.get("email"))) %></td><td><form method="post" action="<%= request.getContextPath() %>/students" onsubmit="return confirm('Delete this student and their attendance records?')"><input type="hidden" name="action" value="delete"><input type="hidden" name="id" value="<%= s.get("id") %>"><button class="icon-btn danger-text" title="Delete student" type="submit">⌫</button></form></td></tr>
<% } } %>
</tbody></table></div></section>
<div class="modal-backdrop" id="studentModal" aria-hidden="true"><div class="modal-card"><div class="modal-head"><div><h2>Add a student</h2><p class="muted">Fill in the student details below.</p></div><button type="button" class="icon-btn" data-modal-close>×</button></div>
<form method="post" action="<%= request.getContextPath() %>/students" class="form-stack">
<label>Full name<input name="fullName" required maxlength="120" placeholder="e.g. Ananya Reddy"></label>
<label>Roll number<input name="rollNo" required maxlength="30" placeholder="e.g. 23CS006"></label>
<label>Email<input name="email" type="email" maxlength="120" placeholder="student@example.com"></label>
<div class="form-row"><label>Department<input name="department" value="CSE" required></label><label>Year<select name="yearLevel"><option value="1">1st year</option><option value="2">2nd year</option><option value="3" selected>3rd year</option><option value="4">4th year</option></select></label></div>
<label>Section<input name="sectionName" value="A" required maxlength="10"></label>
<div class="modal-actions"><button type="button" class="btn btn-soft" data-modal-close>Cancel</button><button class="btn btn-primary" type="submit">Save student</button></div>
</form></div></div>
<%@ include file="_layout-bottom.jsp" %>
