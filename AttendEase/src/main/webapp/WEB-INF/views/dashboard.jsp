<% request.setAttribute("pageTitle", "Dashboard"); request.setAttribute("activePage", "dashboard"); %>
<%@ include file="_layout-top.jsp" %>
<section class="welcome-row"><div><div class="eyebrow purple">OVERVIEW · TODAY</div><h1>Good day, <%= com.attendease.util.HtmlUtil.escape((String) session.getAttribute("adminUser")) %> <span class="wave">✦</span></h1><p class="muted">Here’s what’s happening with your students today.</p></div><a class="btn btn-primary" href="<%= request.getContextPath() %>/attendance">＋ Mark attendance</a></section>
<div class="stat-grid">
 <article class="stat-card"><div class="stat-top"><span>Total students</span><span class="stat-icon lilac">♙</span></div><div class="stat-value">${studentCount}</div><div class="stat-foot">Registered students</div></article>
 <article class="stat-card"><div class="stat-top"><span>Present today</span><span class="stat-icon mint">✓</span></div><div class="stat-value">${presentCount}</div><div class="stat-foot"><span class="dot green"></span> Marked present</div></article>
 <article class="stat-card"><div class="stat-top"><span>Absent today</span><span class="stat-icon rose">×</span></div><div class="stat-value">${absentCount}</div><div class="stat-foot"><span class="dot red"></span> Needs follow-up</div></article>
 <article class="stat-card"><div class="stat-top"><span>Attendance rate</span><span class="stat-icon amber">↗</span></div><div class="stat-value">${attendanceRate}%</div><div class="stat-foot">Present + late / marked</div></article>
</div>
<div class="content-grid">
 <section class="panel"><div class="panel-heading"><div><h3>Today’s attendance</h3><p class="muted">Daily attendance snapshot</p></div><span class="date-chip">${today}</span></div>
  <div class="donut-wrap"><div class="donut" style="--rate:${attendanceRate}%"><div class="donut-inner"><strong>${attendanceRate}%</strong><span>attendance</span></div></div>
   <div class="legend"><div><span class="legend-dot present"></span><span>Present</span><strong>${presentCount}</strong></div><div><span class="legend-dot absent"></span><span>Absent</span><strong>${absentCount}</strong></div><div><span class="legend-dot late"></span><span>Late</span><strong>${lateCount}</strong></div></div></div>
 </section>
 <section class="panel quick-panel"><div class="panel-heading"><div><h3>Quick actions</h3><p class="muted">Common tasks, one click away</p></div></div>
  <a class="quick-action" href="<%= request.getContextPath() %>/students"><span class="quick-icon lilac">＋</span><span><strong>Add a student</strong><small>Register a new student</small></span><b>→</b></a>
  <a class="quick-action" href="<%= request.getContextPath() %>/attendance"><span class="quick-icon mint">✓</span><span><strong>Mark attendance</strong><small>Record today's class</small></span><b>→</b></a>
  <a class="quick-action" href="<%= request.getContextPath() %>/reports"><span class="quick-icon amber">▥</span><span><strong>View reports</strong><small>Check student percentages</small></span><b>→</b></a>
 </section>
</div>
<%@ include file="_layout-bottom.jsp" %>
