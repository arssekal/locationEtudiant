<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Inscription - Location Étudiante</title>
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
    <h2>Inscription</h2>

    <!-- Affichage message d'erreur si existant -->
    <% String messageErreur = (String) request.getAttribute("messageErreur");
       if(messageErreur != null) { %>
        <div class="erreur"><%= messageErreur %></div>
    <% } %>

    <form action="<%=request.getContextPath()%>/utilisateur" method="post">
        <input type="hidden" name="action" value="inscription">

        <label>Nom :</label>
        <input type="text" name="nom" required><br><br>

        <label>Email :</label>
        <input type="email" name="email" required><br><br>

        <label>Mot de passe :</label>
        <input type="password" name="motDePasse" required><br><br>

        <label>Rôle :</label>
        <select name="role" required>
            <option value="etudiant">Étudiant</option>
            <option value="admin">Admin</option>
        </select><br><br>

        <button type="submit">S’inscrire</button>
    </form>

    <p>Déjà inscrit ? <a href="login.jsp">Connectez-vous ici</a></p>
    </body>
</html>
