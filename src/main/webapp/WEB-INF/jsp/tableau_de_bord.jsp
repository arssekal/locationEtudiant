<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="model.Utilisateur" %>
<%@ page import="dao.StatistiqueDAO" %>
<%@ page import="java.util.Map" %>
<%
    Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
    if (utilisateur == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    // Utiliser le DAO Hibernate pour récupérer les statistiques
    StatistiqueDAO statistiqueDAO = new StatistiqueDAO();
    Map<String, Object> stats = null;

    try {
        if (utilisateur.getRole().equalsIgnoreCase("etudiant")) {
            stats = statistiqueDAO.getStatistiquesEtudiant(utilisateur.getId());
        } else if (utilisateur.getRole().equalsIgnoreCase("proprietaire")) {
            stats = statistiqueDAO.getStatistiquesProprietaire(utilisateur.getId());
        } else if (utilisateur.getRole().equalsIgnoreCase("admin")) {
            stats = statistiqueDAO.getStatistiquesGlobales();
        }
    } catch (Exception e) {
        e.printStackTrace();
        stats = new java.util.HashMap<>();
    }

    // Mettre les stats dans le request pour y accéder avec JSTL
    request.setAttribute("stats", stats);
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de bord - Location Étudiant</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            background: #f0f2f5;
            min-height: 100vh;
        }

        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            height: 100vh;
            width: 280px;
            background: white;
            box-shadow: 2px 0 10px rgba(0,0,0,0.05);
            padding: 30px 20px;
            overflow-y: auto;
            z-index: 1000;
            transition: all 0.3s ease;
        }

        .sidebar-logo {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 40px;
            padding: 0 10px;
        }

        .sidebar-logo i {
            font-size: 2rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .sidebar-logo h2 {
            font-size: 1.275rem;
            font-weight: 700;
            color: #1a202c;
        }

        .user-profile {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 20px;
            border-radius: 15px;
            margin-bottom: 30px;
            color: white;
        }

        .user-profile-header {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 15px;
        }

        .user-avatar {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            background: rgba(255,255,255,0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.3rem;
            font-weight: 700;
            backdrop-filter: blur(10px);
        }

        .user-name {
            font-size: 1.1rem;
            font-weight: 600;
            margin: 0;
        }

        .user-role {
            font-size: 0.85rem;
            opacity: 0.9;
            margin: 0;
        }

        .user-stats {
            display: flex;
            justify-content: space-around;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid rgba(255,255,255,0.2);
        }

        .user-stat {
            text-align: center;
        }

        .user-stat-number {
            display: block;
            font-size: 1.2rem;
            font-weight: 700;
        }

        .user-stat-label {
            display: block;
            font-size: 0.75rem;
            opacity: 0.9;
            margin-top: 2px;
        }

        .nav-menu {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .nav-item {
            margin-bottom: 5px;
        }

        .nav-link {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 15px;
            color: #4a5568;
            text-decoration: none;
            border-radius: 10px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .nav-link:hover,
        .nav-link.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .nav-link i {
            font-size: 1.1rem;
            width: 20px;
        }

        .nav-divider {
            height: 1px;
            background: #e2e8f0;
            margin: 20px 0;
        }

        .logout-btn {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 15px;
            color: #e53e3e;
            text-decoration: none;
            border-radius: 10px;
            font-weight: 500;
            transition: all 0.3s ease;
            margin-top: 20px;
        }

        .logout-btn:hover {
            background: #fff5f5;
            color: #c53030;
        }

        .main-content {
            margin-left: 280px;
            padding: 30px;
            min-height: 100vh;
        }

        .top-bar {
            background: white;
            padding: 20px 30px;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .top-bar h1 {
            font-size: 1.8rem;
            font-weight: 700;
            color: #1a202c;
            margin: 0;
        }

        .top-bar-actions {
            display: flex;
            gap: 15px;
        }

        .btn-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            border: none;
            background: #f7fafc;
            color: #4a5568;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
        }

        .btn-icon:hover {
            background: #edf2f7;
            color: #667eea;
        }

        .btn-icon .badge {
            position: absolute;
            top: -5px;
            right: -5px;
            width: 18px;
            height: 18px;
            border-radius: 50%;
            background: #e53e3e;
            color: white;
            font-size: 0.7rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 3px;
            background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
        }

        .stat-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 20px;
        }

        .stat-info h3 {
            font-size: 0.85rem;
            font-weight: 600;
            color: #718096;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 10px;
        }

        .stat-value {
            font-size: 2.2rem;
            font-weight: 700;
            color: #1a202c;
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }

        .stat-icon.blue { background: #e6f2ff; color: #667eea; }
        .stat-icon.green { background: #e6fffa; color: #38b2ac; }
        .stat-icon.purple { background: #faf5ff; color: #9f7aea; }
        .stat-icon.orange { background: #fffaf0; color: #f6ad55; }

        .stat-footer {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.85rem;
            color: #718096;
        }

        .stat-change {
            display: flex;
            align-items: center;
            gap: 5px;
            padding: 4px 8px;
            border-radius: 6px;
            font-weight: 600;
        }

        .stat-change.positive {
            background: #f0fff4;
            color: #38a169;
        }

        .stat-change.negative {
            background: #fff5f5;
            color: #e53e3e;
        }

        .section-title {
            font-size: 1.3rem;
            font-weight: 700;
            color: #1a202c;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .actions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .action-card {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }

        .action-card:hover {
            border-color: #667eea;
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.15);
        }

        .action-header {
            display: flex;
            align-items: flex-start;
            gap: 20px;
            margin-bottom: 20px;
        }

        .action-icon-large {
            width: 60px;
            height: 60px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            flex-shrink: 0;
        }

        .action-icon-large.etudiant { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; }
        .action-icon-large.proprietaire { background: linear-gradient(135deg, #38b2ac 0%, #38ef7d 100%); color: white; }
        .action-icon-large.admin { background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); color: white; }

        .action-info h3 {
            font-size: 1.2rem;
            font-weight: 700;
            color: #1a202c;
            margin-bottom: 8px;
        }

        .action-info p {
            font-size: 0.9rem;
            color: #718096;
            line-height: 1.6;
            margin: 0;
        }

        .action-footer {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        .btn-primary-action {
            flex: 1;
            padding: 12px 20px;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            text-decoration: none;
            text-align: center;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .btn-primary-action.etudiant {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary-action.proprietaire {
            background: linear-gradient(135deg, #38b2ac 0%, #38ef7d 100%);
            color: white;
        }

        .btn-primary-action.admin {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
        }

        .btn-primary-action:hover {
            transform: scale(1.02);
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
            color: white;
        }

        .activity-feed {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .activity-item {
            display: flex;
            gap: 15px;
            padding: 15px 0;
            border-bottom: 1px solid #f7fafc;
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        .activity-icon-wrapper {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            background: #f7fafc;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .activity-content {
            flex: 1;
        }

        .activity-content h4 {
            font-size: 0.95rem;
            font-weight: 600;
            color: #1a202c;
            margin-bottom: 5px;
        }

        .activity-content p {
            font-size: 0.85rem;
            color: #718096;
            margin: 0;
        }

        .activity-time {
            font-size: 0.8rem;
            color: #a0aec0;
        }

        .menu-toggle {
            display: none;
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 1100;
            width: 40px;
            height: 40px;
            background: white;
            border: none;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            cursor: pointer;
        }

        @media (max-width: 1024px) {
            .sidebar {
                transform: translateX(-100%);
            }

            .sidebar.active {
                transform: translateX(0);
            }

            .main-content {
                margin-left: 0;
            }

            .menu-toggle {
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .stats-grid,
            .actions-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 640px) {
            .main-content {
                padding: 15px;
            }

            .top-bar {
                flex-direction: column;
                gap: 15px;
                align-items: flex-start;
            }

            .top-bar h1 {
                font-size: 1.4rem;
            }
        }
    </style>
</head>
<body>
<!-- Mobile Menu Toggle -->
<button class="menu-toggle" onclick="toggleSidebar()">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/">
        <i class="fas fa-home"></i>
    </a>
</button>

<!-- Sidebar -->
<aside class="sidebar" id="sidebar">
    <a class="navbar-brand " href="${pageContext.request.contextPath}/">
    <div class="sidebar-logo " style="align-items: center; /* centre verticalement l’icône et le texte */
  gap: 8px;">
        <i class="fas fa-home"></i>
        <h2>Location Etudiant</h2>
    </div>
    </a>

    <div class="user-profile">
        <div class="user-profile-header">
            <div class="user-avatar">
                <%= utilisateur.getNom().substring(0,1).toUpperCase() + utilisateur.getNom().substring(0,1).toUpperCase() %>
            </div>
            <div>
                <p class="user-name"><%= utilisateur.getNom() %> </p>
                <p class="user-role"><%= utilisateur.getRole().substring(0,1).toUpperCase() + utilisateur.getRole().substring(1).toLowerCase() %></p>
            </div>
        </div>
        <div class="user-stats">
            <% if (utilisateur.getRole().equalsIgnoreCase("etudiant")) { %>
            <div class="user-stat">
                <span class="user-stat-number">${stats.recherchesCount != null ? stats.recherchesCount : 0}</span>
                <span class="user-stat-label">Recherches</span>
            </div>
            <div class="user-stat">
                <span class="user-stat-number">${stats.messagesCount != null ? stats.messagesCount : 0}</span>
                <span class="user-stat-label">Messages</span>
            </div>
            <div class="user-stat">
                <span class="user-stat-number">${stats.favorisCount != null ? stats.favorisCount : 0}</span>
                <span class="user-stat-label">Favoris</span>
            </div>
            <% } else if (utilisateur.getRole().equalsIgnoreCase("proprietaire")) { %>
            <div class="user-stat">
                <span class="user-stat-number">${stats.mesAnnonces != null ? stats.mesAnnonces : 0}</span>
                <span class="user-stat-label">Annonces</span>
            </div>
            <div class="user-stat">
                <span class="user-stat-number">${stats.messagesRecus != null ? stats.messagesRecus : 0}</span>
                <span class="user-stat-label">Messages</span>
            </div>
            <div class="user-stat">
                <span class="user-stat-number">${stats.vuesTotal != null ? stats.vuesTotal : 0}</span>
                <span class="user-stat-label">Vues</span>
            </div>
            <% } else { %>
            <div class="user-stat">
                <span class="user-stat-number">${stats.annoncesActives != null ? stats.annoncesActives : 0}</span>
                <span class="user-stat-label">Annonces</span>
            </div>
            <div class="user-stat">
                <span class="user-stat-number">${stats.totalUtilisateurs != null ? stats.totalUtilisateurs : 0}</span>
                <span class="user-stat-label">Utilisateurs</span>
            </div>
            <div class="user-stat">
                <span class="user-stat-number">${stats.totalMessages != null ? stats.totalMessages : 0}</span>
                <span class="user-stat-label">Messages</span>
            </div>
            <% } %>
        </div>
    </div>

    <nav>
        <ul class="nav-menu">
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/" class="nav-link active">
                    <i class="fas fa-home"></i>
                    <span>Tableau de bord</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/annonce?action=list" class="nav-link">
                    <i class="fas fa-search"></i>
                    <span>Rechercher</span>
                </a>
            </li>

            <% if (utilisateur.getRole().equalsIgnoreCase("proprietaire")) { %>
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/annonce?action=MesAnnonces" class="nav-link">
                    <i class="fas fa-clipboard-list"></i>
                    <span>Mes Annonces</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/annonce?action=new" class="nav-link">
                    <i class="fas fa-plus-circle"></i>
                    <span>Nouvelle Annonce</span>
                </a>
            </li>
            <% } %>

            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/message?action=view" class="nav-link">
                    <i class="fas fa-envelope"></i>
                    <span>Messages</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/favoris" class="nav-link">
                    <i class="fas fa-heart"></i>
                    <span>Favoris</span>
                </a>
            </li>
        </ul>

        <div class="nav-divider"></div>

        <ul class="nav-menu">
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/utilisateur/profil" class="nav-link">
                    <i class="fas fa-user-circle"></i>
                    <span>Mon Profil</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/parametres" class="nav-link">
                    <i class="fas fa-cog"></i>
                    <span>Paramètres</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/aide" class="nav-link">
                    <i class="fas fa-question-circle"></i>
                    <span>Aide</span>
                </a>
            </li>
        </ul>

        <a href="<%=request.getContextPath()%>/utilisateur/deconnexion" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i>
            <span>Déconnexion</span>
        </a>
    </nav>
</aside>

<!-- Main Content -->
<main class="main-content">
    <!-- Top Bar -->
    <div class="top-bar">
        <h1>Tableau de bord</h1>
        <div class="top-bar-actions">
            <button class="btn-icon">
                <i class="fas fa-bell"></i>
                <span class="badge">3</span>
            </button>
            <button class="btn-icon">
                <i class="fas fa-envelope"></i>
                <c:if test="${utilisateur.role == 'etudiant'}">
                    <span class="badge">${stats.messagesCount != null ? stats.messagesCount : 0}</span>
                </c:if>
                <c:if test="${utilisateur.role == 'proprietaire'}">
                    <span class="badge">${stats.messagesRecus != null ? stats.messagesRecus : 0}</span>
                </c:if>
            </button>
        </div>
    </div>

    <!-- Stats Grid -->
    <div class="stats-grid">
        <% if (utilisateur.getRole().equalsIgnoreCase("etudiant")) { %>
        <div class="stat-card">
            <div class="stat-header">
                <div class="stat-info">
                    <h3>Mes Favoris</h3>
                    <div class="stat-value">${stats.favorisCount != null ? stats.favorisCount : 0}</div>
                </div>
                <div class="stat-icon blue">
                    <i class="fas fa-heart"></i>
                </div>
            </div>
            <div class="stat-footer">
                <span>Logements sauvegardés</span>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-header">
                <div class="stat-info">
                    <h3>Messages</h3>
                    <div class="stat-value">${stats.messagesCount != null ? stats.messagesCount : 0}</div>
                </div>
                <div class="stat-icon green">
                    <i class="fas fa-envelope"></i>
                </div>
            </div>
            <div class="stat-footer">
                <span>Conversations actives</span>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-header">
                <div class="stat-info">
                    <h3>Recherches</h3>
                    <div class="stat-value">${stats.recherchesCount != null ? stats.recherchesCount : 0}</div>
                </div>
                <div class="stat-icon purple">
                    <i class="fas fa-search"></i>
                </div>
            </div>
            <div class="stat-footer">
                <span>Recherches sauvegardées</span>
            </div>
        </div>

        <% } else if (utilisateur.getRole().equalsIgnoreCase("proprietaire")) { %>
        <div class="stat-card">
            <div class="stat-header">
                <div class="stat-info">
                    <h3>Mes Annonces</h3>
                    <div class="stat-value">${stats.mesAnnonces != null ? stats.mesAnnonces : 0}</div>
                </div>
                <div class="stat-icon blue">
                    <i class="fas fa-home"></i>
                </div>
            </div>
            <div class="stat-footer">
                <span>${stats.annoncesDisponibles != null ? stats.annoncesDisponibles : 0} disponibles</span>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-header">
                <div class="stat-info">
                    <h3>Messages Reçus</h3>
                    <div class="stat-value">${stats.messagesRecus != null ? stats.messagesRecus : 0}</div>
                </div>
                <div class="stat-icon green">
                    <i class="fas fa-envelope"></i>
                </div>
            </div>
            <div class="stat-footer">
                <span>Demandes d'étudiants</span>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-header">
                <div class="stat-info">
                    <h3>Vues Totales</h3>
                    <div class="stat-value">${stats.vuesTotal != null ? stats.vuesTotal : 0}</div>
                </div>
                <div class="stat-icon orange">
                    <i class="fas fa-eye"></i>
                </div>
            </div>
            <div class="stat-footer">
                <span>${stats.vuesThisWeek != null ? stats.vuesThisWeek : 0} cette semaine</span>
            </div>
        </div>

        <% } else if (utilisateur.getRole().equalsIgnoreCase("admin")) { %>
        <div class="stat-card">
            <div class="stat-header">
                <div class="stat-info">
                    <h3>Annonces Actives</h3>
                    <div class="stat-value">${stats.annoncesActives != null ? stats.annoncesActives : 0}</div>
                </div>
                <div class="stat-icon blue">
                    <i class="fas fa-home"></i>
                </div>
            </div>
            <div class="stat-footer">
                <c:set var="evolution" value="${stats.annoncesActivesEvolution != null ? stats.annoncesActivesEvolution : 0}" />
                <div class="stat-change ${evolution >= 0 ? 'positive' : 'negative'}">
                    <i class="fas fa-arrow-${evolution >= 0 ? 'up' : 'down'}"></i>
                    <fmt:formatNumber value="${evolution}" pattern="0.0" />%
                </div>
                <span>vs mois dernier</span>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-header">
                <div class="stat-info">
                    <h3>Utilisateurs</h3>
                    <div class="stat-value">${stats.totalUtilisateurs != null ? stats.totalUtilisateurs : 0}</div>
                </div>
                <div class="stat-icon green">
                    <i class="fas fa-users"></i>
                </div>
            </div>
            <div class="stat-footer">
                <div class="stat-change positive">
                    <i class="fas fa-arrow-up"></i>
                    ${stats.nouveauxUtilisateurs != null ? stats.nouveauxUtilisateurs : 0}
                </div>
                <span>nouveaux ce mois</span>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-header">
                <div class="stat-info">
                    <h3>Messages</h3>
                    <div class="stat-value">${stats.totalMessages != null ? stats.totalMessages : 0}</div>
                </div>
                <div class="stat-icon purple">
                    <i class="fas fa-envelope"></i>
                </div>
            </div>
            <div class="stat-footer">
                <div class="stat-change positive">
                    <i class="fas fa-arrow-up"></i>
                    ${stats.messagesThisWeek != null ? stats.messagesThisWeek : 0}
                </div>
                <span>cette semaine</span>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-header">
                <div class="stat-info">
                    <h3>Satisfaction</h3>
                    <div class="stat-value">${stats.tauxSatisfaction != null ? stats.tauxSatisfaction : 95}%</div>
                </div>
                <div class="stat-icon orange">
                    <i class="fas fa-star"></i>
                </div>
            </div>
            <div class="stat-footer">
                <div class="stat-change positive">
                    <i class="fas fa-arrow-up"></i>
                    +2%
                </div>
                <span>taux global</span>
            </div>
        </div>
        <% } %>
    </div>

    <!-- Action Cards -->
    <h2 class="section-title">
        <i class="fas fa-bolt"></i>
        Actions Rapides
    </h2>

    <div class="actions-grid">
        <% if (utilisateur.getRole().equalsIgnoreCase("etudiant")) { %>
        <div class="action-card">
            <div class="action-header">
                <div class="action-icon-large etudiant">
                    <i class="fas fa-search"></i>
                </div>
                <div class="action-info">
                    <h3>Rechercher un Logement</h3>
                    <p>Explorez des centaines d'annonces vérifiées</p>
                </div>
            </div>
            <div class="action-footer">
                <a href="<%=request.getContextPath()%>/annonce?action=list" class="btn-primary-action etudiant">
                    <i class="fas fa-search"></i>
                    Voir les Annonces
                </a>
            </div>
        </div>

        <div class="action-card">
            <div class="action-header">
                <div class="action-icon-large etudiant">
                    <i class="fas fa-heart"></i>
                </div>
                <div class="action-info">
                    <h3>Mes Favoris</h3>
                    <p>Retrouvez vos logements sauvegardés</p>
                </div>
            </div>
            <div class="action-footer">
                <a href="<%=request.getContextPath()%>/favoris" class="btn-primary-action etudiant">
                    <i class="fas fa-heart"></i>
                    Voir mes Favoris (${stats.favorisCount != null ? stats.favorisCount : 0})
                </a>
            </div>
        </div>

        <div class="action-card">
            <div class="action-header">
                <div class="action-icon-large etudiant">
                    <i class="fas fa-comments"></i>
                </div>
                <div class="action-info">
                    <h3>Mes Conversations</h3>
                    <p>Consultez vos messages avec les propriétaires</p>
                </div>
            </div>
            <div class="action-footer">
                <a href="<%=request.getContextPath()%>/message?action=view" class="btn-primary-action etudiant">
                    <i class="fas fa-envelope"></i>
                    Accéder (${stats.messagesCount != null ? stats.messagesCount : 0})
                </a>
            </div>
        </div>

        <% } else if (utilisateur.getRole().equalsIgnoreCase("proprietaire")) { %>
        <div class="action-card">
            <div class="action-header">
                <div class="action-icon-large proprietaire">
                    <i class="fas fa-plus-circle"></i>
                </div>
                <div class="action-info">
                    <h3>Nouvelle Annonce</h3>
                    <p>Publiez votre logement en quelques clics</p>
                </div>
            </div>
            <div class="action-footer">
                <a href="<%=request.getContextPath()%>/annonce?action=new" class="btn-primary-action proprietaire">
                    <i class="fas fa-plus"></i>
                    Créer une Annonce
                </a>
            </div>
        </div>

        <div class="action-card">
            <div class="action-header">
                <div class="action-icon-large proprietaire">
                    <i class="fas fa-clipboard-list"></i>
                </div>
                <div class="action-info">
                    <h3>Gérer Mes Annonces</h3>
                    <p>Modifiez et suivez vos publications</p>
                </div>
            </div>
            <div class="action-footer">
                <a href="<%=request.getContextPath()%>/annonce?action=MesAnnonces" class="btn-primary-action proprietaire">
                    <i class="fas fa-list"></i>
                    Mes Annonces (${stats.mesAnnonces != null ? stats.mesAnnonces : 0})
                </a>
            </div>
        </div>

        <div class="action-card">
            <div class="action-header">
                <div class="action-icon-large proprietaire">
                    <i class="fas fa-inbox"></i>
                </div>
                <div class="action-info">
                    <h3>Messages Reçus</h3>
                    <p>Répondez aux demandes des étudiants</p>
                </div>
            </div>
            <div class="action-footer">
                <a href="<%=request.getContextPath()%>/message?action=sent" class="btn-primary-action proprietaire">
                    <i class="fas fa-envelope"></i>
                    Voir Messages (${stats.messagesRecus != null ? stats.messagesRecus : 0})
                </a>
            </div>
        </div>

        <% } else if (utilisateur.getRole().equalsIgnoreCase("admin")) { %>
        <div class="action-card">
            <div class="action-header">
                <div class="action-icon-large admin">
                    <i class="fas fa-users-cog"></i>
                </div>
                <div class="action-info">
                    <h3>Gérer Utilisateurs</h3>
                    <p>Administration des comptes et des rôles</p>
                </div>
            </div>
            <div class="action-footer">
                <a href="<%=request.getContextPath()%>/admin/utilisateurs" class="btn-primary-action admin">
                    <i class="fas fa-users"></i>
                    Accéder (${stats.totalUtilisateurs != null ? stats.totalUtilisateurs : 0})
                </a>
            </div>
        </div>

        <div class="action-card">
            <div class="action-header">
                <div class="action-icon-large admin">
                    <i class="fas fa-clipboard-check"></i>
                </div>
                <div class="action-info">
                    <h3>Modérer Annonces</h3>
                    <p>Valider et gérer les publications</p>
                </div>
            </div>
            <div class="action-footer">
                <a href="<%=request.getContextPath()%>/admin/annonces" class="btn-primary-action admin">
                    <i class="fas fa-check-circle"></i>
                    Modérer (${stats.annoncesActives != null ? stats.annoncesActives : 0})
                </a>
            </div>
        </div>

        <div class="action-card">
            <div class="action-header">
                <div class="action-icon-large admin">
                    <i class="fas fa-chart-line"></i>
                </div>
                <div class="action-info">
                    <h3>Statistiques</h3>
                    <p>Rapports et analyses détaillées</p>
                </div>
            </div>
            <div class="action-footer">
                <a href="<%=request.getContextPath()%>/admin/statistiques" class="btn-primary-action admin">
                    <i class="fas fa-chart-bar"></i>
                    Voir Stats
                </a>
            </div>
        </div>
        <% } %>
    </div>

    <!-- Recent Activity -->
    <h2 class="section-title">
        <i class="fas fa-clock"></i>
        Activité Récente
    </h2>

    <div class="activity-feed">
        <% if (utilisateur.getRole().equalsIgnoreCase("etudiant")) { %>
        <div class="activity-item">
            <div class="activity-icon-wrapper">
                <i class="fas fa-heart" style="color: #e53e3e;"></i>
            </div>
            <div class="activity-content">
                <h4>Favoris actifs</h4>
                <p>Vous avez ${stats.favorisCount != null ? stats.favorisCount : 0} logement(s) en favoris</p>
            </div>
            <div class="activity-time">Maintenant</div>
        </div>

        <div class="activity-item">
            <div class="activity-icon-wrapper">
                <i class="fas fa-envelope" style="color: #667eea;"></i>
            </div>
            <div class="activity-content">
                <h4>Messages</h4>
                <p>Vous avez ${stats.messagesCount != null ? stats.messagesCount : 0} conversation(s) active(s)</p>
            </div>
            <div class="activity-time">Maintenant</div>
        </div>

        <div class="activity-item">
            <div class="activity-icon-wrapper">
                <i class="fas fa-search" style="color: #38b2ac;"></i>
            </div>
            <div class="activity-content">
                <h4>Recherches sauvegardées</h4>
                <p>Vous avez ${stats.recherchesCount != null ? stats.recherchesCount : 0} recherche(s) sauvegardée(s)</p>
            </div>
            <div class="activity-time">Maintenant</div>
        </div>

        <% } else if (utilisateur.getRole().equalsIgnoreCase("proprietaire")) { %>
        <div class="activity-item">
            <div class="activity-icon-wrapper">
                <i class="fas fa-home" style="color: #38b2ac;"></i>
            </div>
            <div class="activity-content">
                <h4>Mes annonces</h4>
                <p>${stats.mesAnnonces != null ? stats.mesAnnonces : 0} annonce(s) dont ${stats.annoncesDisponibles != null ? stats.annoncesDisponibles : 0} disponible(s)</p>
            </div>
            <div class="activity-time">Maintenant</div>
        </div>

        <div class="activity-item">
            <div class="activity-icon-wrapper">
                <i class="fas fa-envelope" style="color: #667eea;"></i>
            </div>
            <div class="activity-content">
                <h4>Messages reçus</h4>
                <p>${stats.messagesRecus != null ? stats.messagesRecus : 0} message(s) d'étudiants intéressés</p>
            </div>
            <div class="activity-time">Maintenant</div>
        </div>

        <div class="activity-item">
            <div class="activity-icon-wrapper">
                <i class="fas fa-eye" style="color: #f6ad55;"></i>
            </div>
            <div class="activity-content">
                <h4>Vues sur vos annonces</h4>
                <p>${stats.vuesTotal != null ? stats.vuesTotal : 0} vue(s) totale(s), dont ${stats.vuesThisWeek != null ? stats.vuesThisWeek : 0} cette semaine</p>
            </div>
            <div class="activity-time">Maintenant</div>
        </div>

        <% } else if (utilisateur.getRole().equalsIgnoreCase("admin")) { %>
        <div class="activity-item">
            <div class="activity-icon-wrapper">
                <i class="fas fa-user-plus" style="color: #38b2ac;"></i>
            </div>
            <div class="activity-content">
                <h4>Nouveaux utilisateurs</h4>
                <p>${stats.nouveauxUtilisateurs != null ? stats.nouveauxUtilisateurs : 0} nouvelle(s) inscription(s) ce mois</p>
            </div>
            <div class="activity-time">Maintenant</div>
        </div>

        <div class="activity-item">
            <div class="activity-icon-wrapper">
                <i class="fas fa-home" style="color: #667eea;"></i>
            </div>
            <div class="activity-content">
                <h4>Annonces actives</h4>
                <p>${stats.annoncesActives != null ? stats.annoncesActives : 0} annonce(s) disponible(s) sur la plateforme</p>
            </div>
            <div class="activity-time">Maintenant</div>
        </div>

        <div class="activity-item">
            <div class="activity-icon-wrapper">
                <i class="fas fa-check-circle" style="color: #38a169;"></i>
            </div>
            <div class="activity-content">
                <h4>Activité globale</h4>
                <p>${stats.totalMessages != null ? stats.totalMessages : 0} message(s) échangé(s) sur la plateforme</p>
            </div>
            <div class="activity-time">Maintenant</div>
        </div>
        <% } %>
    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function toggleSidebar() {
        const sidebar = document.getElementById('sidebar');
        sidebar.classList.toggle('active');
    }

    // Close sidebar when clicking outside on mobile
    document.addEventListener('click', function(event) {
        const sidebar = document.getElementById('sidebar');
        const menuToggle = document.querySelector('.menu-toggle');

        if (window.innerWidth <= 1024) {
            if (!sidebar.contains(event.target) && !menuToggle.contains(event.target)) {
                sidebar.classList.remove('active');
            }
        }
    });

    // Animation au chargement
    window.addEventListener('load', function() {
        const statCards = document.querySelectorAll('.stat-card');
        statCards.forEach((card, index) => {
            setTimeout(() => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                setTimeout(() => {
                    card.style.transition = 'all 0.5s ease';
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, 50);
            }, index * 100);
        });
    });
</script>
</body>
</html>