<% request.setAttribute("pageTitle", "Mark attendance"); request.setAttribute("activePage", "attendance"); %>
<%@ include file="_layout-top.jsp" %>
<section class="welcome-row"><div><div class="eyebrow purple">DAILY CLASS REGISTER</div><h1>Mark attendance</h1><p class="muted">Select a date and record each student's status.</p></div></section>
<% if ("1".equals(request.getParameter("saved"))) { %><div class="alert success">Attendance saved successfully.</div><% } %>
<section class="panel table-panel">
<div class="table-toolbar"><div><h3>Class attendance</h3><p class="muted">Choose a date to view or update records.</p></div>
<form method="get" action="<%= request.getContextPath() %>/attendance" class="search-form"><label class="inline-label">Date <input type="date" name="date" value="${selectedDate}" required></label><button class="btn btn-soft" type="submit">Load date</button></form></div>
<form method="post" action="<%= request.getContextPath() %>/attendance" id="attendanceForm">
<input type="hidden" name="attendanceDate" value="${selectedDate}">
<div class="attendance-tools"><span class="muted"><strong>${students.size()}</strong> students listed</span><div><button type="button" class="btn btn-soft btn-small" data-set-all="PRESENT">All present</button><button type="button" class="btn btn-soft btn-small" data-set-all="ABSENT">All absent</button></div></div>
<div class="table-scroll"><table><thead><tr><th>STUDENT</th><th>ROLL NUMBER</th><th>ATTENDANCE STATUS</th></tr></thead><tbody>
<% java.util.List<java.util.Map<String,Object>> students = (java.util.List<java.util.Map<String,Object>>) request.getAttribute("students"); if (students.isEmpty()) { %><tr><td colspan="3" class="empty-state">No students registered yet. Add students first.</td></tr><% } else { for (java.util.Map<String,Object> s : students) { String id=String.valueOf(s.get("id")); String name=String.valueOf(s.get("name")); String status=String.valueOf(s.get("status")); %>
<tr><td><div class="student-cell"><span class="student-avatar"><%= name.isEmpty() ? "S" : name.substring(0,1).toUpperCase() %></span><strong><%= com.attendease.util.HtmlUtil.escape(name) %></strong></div><input type="hidden" name="studentId" value="<%= id %>"></td><td><span class="roll-pill"><%= com.attendease.util.HtmlUtil.escape(String.valueOf(s.get("rollNo"))) %></span></td><td><div class="status-picker">
<label class="status-option present-option <%= "PRESENT".equals(status) ? "selected" : "" %>"><input type="radio" name="status_<%= id %>" value="PRESENT" <%= "PRESENT".equals(status) ? "checked" : "" %>><span>✓ Present</span></label>
<label class="status-option absent-option <%= "ABSENT".equals(status) ? "selected" : "" %>"><input type="radio" name="status_<%= id %>" value="ABSENT" <%= "ABSENT".equals(status) ? "checked" : "" %>><span>× Absent</span></label>
<label class="status-option late-option <%= "LATE".equals(status) ? "selected" : "" %>"><input type="radio" name="status_<%= id %>" value="LATE" <%= "LATE".equals(status) ? "checked" : "" %>><span>◷ Late</span></label>
</div></td></tr>
<% } } %>
</tbody></table></div>
<div class="form-submit-row"><span class="muted">You can change any status before saving.</span><button class="btn btn-primary" type="submit" <%= students.isEmpty() ? "disabled" : "" %>>Save attendance →</button></div>
</form></section>
<%@ include file="_layout-bottom.jsp" %>
