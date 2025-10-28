<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Inscription - Location Étudiante</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/inscription.css">
</head>
<body>
<div class="form-container">
    <h2>Créer un compte</h2>

    <%
        String messageErreur = (String) request.getAttribute("messageErreur");
        if (messageErreur != null) {
    %>
        <div class="erreur"><%= messageErreur %></div>
    <% } %>

    <form action="<%=request.getContextPath()%>/utilisateur" method="post">
        <input type="hidden" name="action" value="inscription">

        <div class="row">
            <div class="input-group">
                <label for="nom">Nom complet</label>
                <input type="text" id="nom" name="nom" placeholder="Entrez votre nom" autocomplete="off" required>
            </div>

            <div class="input-group">
                <label for="email">Adresse e-mail</label>
                <input type="email" id="email" name="email" placeholder="exemple@email.com" autocomplete="off" required>
            </div>
        </div>

        <div class="row">
            <div class="input-group">
                <label for="motDePasse">Mot de passe</label>
                <input type="password" id="motDePasse" name="motDePasse" placeholder="Minimum 8 caractères" autocomplete="new-password" required>
            </div>

            <div class="input-group">
                <label for="role">Rôle</label>
                <select id="role" name="role" required>
                    <option value="" disabled selected>Choisissez un rôle</option>
                    <option value="etudiant">Étudiant</option>
                    <option value="proprietaire">Proprietaire</option>
                </select>
            </div>
        </div>

        <button type="submit">S’inscrire</button>
    </form>

    <p class="redirect">Déjà inscrit ?
        <a href="<%=request.getContextPath()%>/utilisateur/login">Connectez-vous ici</a>
    </p>
</div>
</body>
</html>
