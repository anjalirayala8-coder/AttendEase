<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Sign in · AttendEase</title><link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head><body class="login-body">
<div class="login-shell">
  <section class="login-art">
    <div class="brand brand-light"><span class="brand-mark">A</span><span>AttendEase</span></div>
    <div class="art-copy"><span class="eyebrow">SMART ATTENDANCE PORTAL</span><h1>Every class.<br>Every student.<br><em>In sync.</em></h1><p>A simpler, more beautiful way to manage campus attendance.</p></div>
    <div class="art-footer">Organised classrooms start here.</div>
  </section>
  <section class="login-panel">
    <div class="mobile-brand brand"><span class="brand-mark">A</span><span>AttendEase</span></div>
    <div class="login-card">
      <div class="eyebrow purple">WELCOME BACK</div><h2>Sign in to your account</h2><p class="muted">Enter your admin details to continue.</p>
      <% if (request.getAttribute("error") != null) { %><div class="alert error"><%= request.getAttribute("error") %></div><% } %>
      <form method="post" action="${pageContext.request.contextPath}/login" class="form-stack">
        <label>Username<input type="text" name="username" placeholder="Enter admin username" required autocomplete="username"></label>
        <label>Password<input type="password" name="password" placeholder="Enter password" required autocomplete="current-password"></label>
        <button class="btn btn-primary btn-full" type="submit">Sign in <span>→</span></button>
      </form>
      <div class="demo-hint"><strong>Demo credentials</strong><br>Username: <code>admin</code> · Password: <code>Admin@123</code></div>
      <p class="tiny muted center">AttendEase · Attendance made effortless</p>
    </div>
  </section>
</div></body></html>
