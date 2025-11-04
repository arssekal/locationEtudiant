<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Connexion - Location Étudiante</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/login.css">
</head>
<body>
<div class="page-container">
    <div class="image-side">
        <img src="<%=request.getContextPath()%>/images/test.jpg" alt="Étudiants se rencontrant">
    </div>

    <div class="form-side">
        <div class="form-container">
            <h1>Location Étudiante</h1>
            <p class="subtitle">Connectez-vous pour accéder à votre tableau de bord</p>

            <% String messageErreur = (String) request.getAttribute("messageErreur");
                if(messageErreur != null) { %>
            <div class="message erreur"><%= messageErreur %></div>
            <% } %>

            <% String success = request.getParameter("success");
                if("1".equals(success)) { %>
            <div class="message success">Inscription réussie ! Connectez-vous maintenant.</div>
            <% } %>

            <% if ("1".equals(request.getParameter("logout"))) { %>
            <div class="message success">Vous avez été déconnecté avec succès.</div>
            <% } %>

            <form action="<%=request.getContextPath()%>/utilisateur" method="post">
                <input type="hidden" name="action" value="connexion">

                <div class="input-group">
                    <label>Email</label>
                    <input type="email" name="email" placeholder="exemple@email.com" required autocomplete="off">
                </div>

                <div class="input-group">
                    <label>Mot de passe</label>
                    <input type="password" name="motDePasse" placeholder="********" required autocomplete="new-password">
                </div>

                <button type="submit" class="btn-login">Se connecter</button>
            </form>

            <p class="register-link">Pas encore inscrit ?
                <a href="<%=request.getContextPath()%>/utilisateur/inscription">Créer un compte</a>
            </p>
        </div>
    </div>
</div>
</body>
</html>
