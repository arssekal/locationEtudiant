<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Utilisateur" %>
<%
    Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
    if (utilisateur == null) {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Profil Utilisateur</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/profil.css">
</head>
<body>

<div class="profile-container">
    <h2>Mon Profil</h2>

    <%
        String messageErreur = (String) request.getAttribute("messageErreur");
        if (messageErreur != null) {
    %>
        <div class="message error"><%= messageErreur %></div>
    <% } %>

    <%
        String messageSuccess = (String) request.getAttribute("messageSuccess");
        if (messageSuccess != null) {
    %>
        <div class="message success"><%= messageSuccess %></div>
    <% } %>

    <form action="<%=request.getContextPath()%>/utilisateur" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="<%= utilisateur.getId() %>">
        <input type="hidden" name="role" value="<%= utilisateur.getRole() %>">

        <div class="form-group">
            <label>Nom :</label>
            <input type="text" name="nom" value="<%= utilisateur.getNom() %>">
        </div>

        <div class="form-group">
            <label>Email :</label>
            <input type="email" name="email" value="<%= utilisateur.getEmail() %>"  readonly>
        </div>

        <div class="form-group">
            <label>Mot de passe (laisser vide pour conserver le mot de passe actuel) :</label>
            <input type="password" name="motDePasse" placeholder="••••••">
        </div>

        <div class="form-group">
            <label>Rôle :</label>
            <input type="text" value="<%= utilisateur.getRole() %>" readonly>
        </div>

        <button type="submit" class="btn">Mettre à jour</button>
    </form>
    <div class="back-button-container">
        <form action="<%=request.getContextPath()%>/utilisateur/dashboard" method="get">
            <button type="submit" class="btn back">Quitter le profil</button>
        </form>
    </div>
</div>
</body>
</html>
