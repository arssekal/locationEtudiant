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
    <title>Tableau de bord - Location Étudiante</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/tableau_de_bord.css">
</head>
<body>
<div class="dashboard-container">
    <header>
        <h1>Bienvenue, <%= utilisateur.getNom() %> 👋</h1>
        <p class="role">Rôle : <%= utilisateur.getRole().substring(0,1).toUpperCase() + utilisateur.getRole().substring(1).toLowerCase() %></p>
    </header>

    <main>
        <% if (utilisateur.getRole().equalsIgnoreCase("etudiant")) { %>
            <section class="card">
                <h2>Espace Étudiant 🎓</h2>
                <p>Consultez les logements disponibles et envoyez vos demandes.</p>
                <a href="<%=request.getContextPath()%>/jsp/annonces.jsp" class="btn">Voir les annonces</a>
            </section>

        <% } else if (utilisateur.getRole().equalsIgnoreCase("proprietaire")) { %>
            <section class="card">
                <h2>Espace Propriétaire 🏠</h2>
                <p>Ajoutez et gérez vos annonces de location.</p>
                <a href="<%=request.getContextPath()%>/jsp/ajouterAnnonce.jsp" class="btn">Gérer mes annonces</a>
            </section>

        <% } else if (utilisateur.getRole().equalsIgnoreCase("admin")) { %>
            <section class="card">
                <h2>Espace Administrateur 👨‍💼</h2>
                <p>Gérez les utilisateurs et surveillez les activités du site.</p>
                <a href="<%=request.getContextPath()%>/jsp/gestionUtilisateurs.jsp" class="btn">Gérer les utilisateurs</a>
            </section>
        <% } %>
    </main>

    <footer>
        <a href="<%=request.getContextPath()%>/utilisateur/deconnexion" class="logout-btn">Déconnexion</a>
    </footer>
</div>
</body>
</html>
