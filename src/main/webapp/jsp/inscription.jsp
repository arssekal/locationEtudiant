<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription - Location Étudiante</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/inscription.css">
</head>
<body>
<div class="page-container">

    <!-- Section gauche avec image -->
    <div class="image-side">
        <img src="<%=request.getContextPath()%>/images/house.png" alt="Location Étudiante">
        <div class="overlay-text">
            <h1>Location Étudiante</h1>
            <p>Trouvez facilement votre logement universitaire.</p>
        </div>
    </div>

    <!-- Section droite : formulaire -->
    <div class="form-container">
        <!-- Background animé -->
        <ul class="background">
            <%-- 50 <li> pour animation --%>
            <% for(int i=0; i<45; i++) { %>
            <li></li>
            <% } %>
        </ul>
        <div class="sous-container">
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
                        <label for="confirmerMotDePasse">Confirmer le mot de passe</label>
                        <input type="password" id="confirmerMotDePasse" name="confirmerMotDePasse" placeholder="Répétez le mot de passe" required>
                    </div>
                </div>

                <div class="row">
                    <div class="input-group">
                        <label for="role">Rôle</label>
                        <select id="role" name="role" required>
                            <option value="" disabled selected>Choisissez un rôle</option>
                            <option value="etudiant">Étudiant</option>
                            <option value="proprietaire">Propriétaire</option>
                        </select>
                    </div>
                </div>

                <button type="submit" class="btn-grad ">S’inscrire</button>
            </form>

            <p class="redirect">Déjà inscrit ?
                <a href="<%=request.getContextPath()%>/utilisateur/login">Connectez-vous ici</a>
            </p>
        </div>

    </div>
</div>
</body>
</html>