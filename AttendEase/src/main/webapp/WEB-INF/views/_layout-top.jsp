<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.attendease.util.HtmlUtil" %>
<!DOCTYPE html><html lang="en"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title><%= request.getAttribute("pageTitle") == null ? "AttendEase" : request.getAttribute("pageTitle") %> · AttendEase</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css">
</head><body class="app-body"><div class="app-shell">
<aside class="sidebar">
  <a class="brand" href="<%= request.getContextPath() %>/dashboard"><span class="brand-mark">A</span><span>AttendEase</span></a>
  <div class="side-label">WORKSPACE</div>
  <nav class="nav-menu">
    <a class="<%= "dashboard".equals(request.getAttribute("activePage")) ? "active" : "" %>" href="<%= request.getContextPath() %>/dashboard"><span>▦</span> Dashboard</a>
    <a class="<%= "students".equals(request.getAttribute("activePage")) ? "active" : "" %>" href="<%= request.getContextPath() %>/students"><span>♙</span> Students</a>
    <a class="<%= "attendance".equals(request.getAttribute("activePage")) ? "active" : "" %>" href="<%= request.getContextPath() %>/attendance"><span>✓</span> Mark attendance</a>
    <a class="<%= "reports".equals(request.getAttribute("activePage")) ? "active" : "" %>" href="<%= request.getContextPath() %>/reports"><span>▥</span> Reports</a>
  </nav>
  <div class="sidebar-bottom"><div class="help-card"><span class="help-icon">✦</span><strong>Stay organised</strong><p>Keep every class on track with AttendEase.</p></div>
    <a class="logout-link" href="<%= request.getContextPath() %>/logout"><span>↪</span> Sign out</a>
  </div>
</aside>
<main class="main-area">
<header class="topbar"><div><div class="top-kicker">ATTENDANCE WORKSPACE</div><div class="top-heading"><%= request.getAttribute("pageTitle") == null ? "Dashboard" : request.getAttribute("pageTitle") %></div></div>
<div class="profile"><div class="profile-avatar">A</div><div><strong><%= HtmlUtil.escape((String) session.getAttribute("adminUser")) %></strong><small>Administrator</small></div></div></header>
<div class="page-content">
