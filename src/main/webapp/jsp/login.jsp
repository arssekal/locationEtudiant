<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Connexion - Location Étudiante</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/login.css">
</head>
<body>
<div class="container">
    <h2>Connexion</h2>

    <% String messageErreur = (String) request.getAttribute("messageErreur");
       if(messageErreur != null) { %>
        <div class="message erreur"><%= messageErreur %></div>
    <% } %>

    <% String success = request.getParameter("success");
       if("1".equals(success)) { %>
        <div class="message success">Inscription réussie ! Connectez-vous maintenant.</div>
    <% } %>

    <% if ("1".equals(request.getParameter("logout"))) { %>
        <div class="success">Vous avez été déconnecté avec succès.</div>
    <% } %>

    <form action="<%=request.getContextPath()%>/utilisateur" method="post">
        <input type="hidden" name="action" value="connexion">

        <label>Email</label>
        <input type="email" name="email" placeholder="exemple@email.com" autocomplete="off" required>

        <label>Mot de passe</label>
        <input type="password" name="motDePasse" placeholder="********" autocomplete="new-password" required>

        <button type="submit">Se connecter</button>
    </form>

    <p>Pas encore inscrit ? <a href="<%=request.getContextPath()%>/utilisateur/inscription">Inscrivez-vous ici</a></p>
</div>
</body>
</html>
