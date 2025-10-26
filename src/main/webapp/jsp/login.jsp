<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Connexion - Location Étudiante</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<h2>Connexion</h2>

<!-- Message d'erreur -->
<% String messageErreur = (String) request.getAttribute("messageErreur");
   if(messageErreur != null) { %>
    <div class="erreur"><%= messageErreur %></div>
<% } %>

<!-- Message de succès après inscription -->
<% String success = request.getParameter("success");
   if("1".equals(success)) { %>
    <div class="success">Inscription réussie ! Connectez-vous maintenant.</div>
<% } %>

<form action="<%=request.getContextPath()%>/utilisateur" method="post">
    <input type="hidden" name="action" value="connexion">

    <label>Email :</label>
    <input type="email" name="email" required><br><br>

    <label>Mot de passe :</label>
    <input type="password" name="motDePasse" required><br><br>

    <button type="submit">Se connecter</button>
</form>

<p>Pas encore inscrit ? <a href="jsp/inscription.jsp">Inscrivez-vous ici</a></p>
</body>
</html>
