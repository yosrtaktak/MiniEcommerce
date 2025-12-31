<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String user = (String) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Accueil</title>
</head>
<body>

<h2>Bienvenue <%= user %> !</h2>

<a href="logout">Se déconnecter</a>

</body>
</html>
