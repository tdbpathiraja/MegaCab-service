<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    HttpSession sessionObj = request.getSession(false);
    String loggedUser = (sessionObj != null) ? (String) sessionObj.getAttribute("loggedUser") : null;

    if (loggedUser == null) {
        response.sendRedirect("auth.jsp?error=SessionExpired");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Account</title>
</head>
<body>
<h2>Welcome, <%= loggedUser %>!</h2>
<p>You have successfully logged in.</p>
<a href="user-logout.jsp">Logout</a>
</body>
</html>
