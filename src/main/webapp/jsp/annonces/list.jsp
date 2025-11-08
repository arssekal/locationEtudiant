<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : 'Liste des annonces'} - Location Étudiant</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #667eea;
            --secondary-color: #764ba2;
            --accent-color: #f093fb;
            --dark-color: #2d3748;
            --light-bg: #f7fafc;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
        }

        /* ========== NAVIGATION ========== */
        .navbar {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%) !important;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
            padding: 1rem 0;
            backdrop-filter: blur(10px);
        }

        .navbar-brand {
            font-weight: 800;
            font-size: 1.6rem;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.3);
            transition: all 0.3s ease;
        }

        .navbar-brand:hover {
            transform: scale(1.08);
            text-shadow: 3px 3px 12px rgba(0, 0, 0, 0.4);
        }

        .navbar-brand i {
            margin-right: 8px;
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.1); }
        }

        .nav-link {
            font-weight: 600;
            padding: 0.5rem 1.2rem !important;
            margin: 0 0.3rem;
            border-radius: 25px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .nav-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.2);
            transition: left 0.3s ease;
        }

        .nav-link:hover::before {
            left: 100%;
        }

        .nav-link:hover {
            background: rgba(255, 255, 255, 0.15);
            transform: translateY(-2px);
        }

        .nav-link.active {
            background: rgba(255, 255, 255, 0.25);
        }

        /* ========== SECTION RECHERCHE ========== */
        .search-section {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            padding: 50px 0;
            margin-bottom: 50px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            position: relative;
            overflow: hidden;
        }

        .search-section::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -10%;
            width: 500px;
            height: 500px;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.15) 0%, transparent 70%);
            border-radius: 50%;
            animation: float 20s ease-in-out infinite;
        }

        .search-section::after {
            content: '';
            position: absolute;
            bottom: -30%;
            left: -10%;
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, transparent 70%);
            border-radius: 50%;
            animation: float 15s ease-in-out infinite reverse;
        }

        @keyframes float {
            0%, 100% { transform: translate(0, 0) scale(1); }
            50% { transform: translate(30px, -30px) scale(1.1); }
        }

        .search-section h2 {
            font-weight: 800;
            font-size: 2.5rem;
            text-shadow: 3px 3px 10px rgba(0, 0, 0, 0.3);
            position: relative;
            z-index: 1;
            margin-bottom: 2rem;
        }

        .search-section h2 i {
            margin-right: 15px;
            animation: rotate 3s linear infinite;
        }

        @keyframes rotate {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        .search-form {
            position: relative;
            z-index: 1;
            background: rgba(255, 255, 255, 0.1);
            padding: 30px;
            border-radius: 20px;
            backdrop-filter: blur(10px);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }

        .search-section .form-control,
        .search-section .form-select {
            border-radius: 30px;
            border: 2px solid rgba(255, 255, 255, 0.3);
            padding: 14px 24px;
            font-size: 1rem;
            background: rgba(255, 255, 255, 0.95);
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .search-section .form-control:focus,
        .search-section .form-select:focus {
            border-color: white;
            box-shadow: 0 6px 25px rgba(0, 0, 0, 0.2);
            transform: translateY(-3px);
            background: white;
        }

        .search-section .btn-light {
            border-radius: 30px;
            font-weight: 700;
            padding: 14px 30px;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            border: 3px solid white;
            background: white;
            color: var(--primary-color);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        .search-section .btn-light:hover {
            background: transparent;
            color: white;
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
        }

        /* ========== CARTES ANNONCES ========== */
        .annonce-card {
            border: none;
            border-radius: 20px;
            overflow: hidden;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            height: 100%;
            background: white;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            position: relative;
        }

        .annonce-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            opacity: 0;
            transition: opacity 0.4s ease;
            z-index: 0;
        }

        .annonce-card:hover {
            transform: translateY(-15px) scale(1.02);
            box-shadow: 0 20px 50px rgba(102, 126, 234, 0.4);
        }

        .annonce-card:hover::before {
            opacity: 0.03;
        }

        .annonce-image {
            height: 250px;
            object-fit: cover;
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            transition: transform 0.5s ease;
            position: relative;
        }

        .annonce-card:hover .annonce-image {
            transform: scale(1.1);
        }

        .image-wrapper {
            overflow: hidden;
            position: relative;
        }

        .image-wrapper::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(to bottom, transparent 0%, rgba(0, 0, 0, 0.3) 100%);
        }

        .price-tag {
            position: absolute;
            top: 15px;
            right: 15px;
            background: linear-gradient(135deg, #fff 0%, #f8f9fa 100%);
            padding: 10px 20px;
            border-radius: 30px;
            font-weight: 800;
            color: var(--primary-color);
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.3);
            z-index: 10;
            font-size: 1.1rem;
            transition: all 0.3s ease;
        }

        .annonce-card:hover .price-tag {
            transform: scale(1.1) rotate(-3deg);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.4);
        }

        .card-body {
            padding: 1.5rem;
            position: relative;
            z-index: 1;
        }

        .card-title {
            font-weight: 700;
            font-size: 1.3rem;
            color: var(--dark-color);
            margin-bottom: 0.8rem;
        }

        .location-badge {
            display: inline-flex;
            align-items: center;
            background: linear-gradient(135deg, #667eea15 0%, #764ba215 100%);
            padding: 8px 16px;
            border-radius: 20px;
            margin-bottom: 1rem;
            color: var(--primary-color);
            font-weight: 600;
        }

        .location-badge i {
            margin-right: 8px;
        }

        .card-text {
            color: #718096;
            line-height: 1.6;
            margin-bottom: 1rem;
            height: 45px;
            overflow: hidden;
        }

        .property-features {
            display: flex;
            justify-content: space-around;
            padding: 15px 0;
            margin: 15px 0;
            background: linear-gradient(135deg, #f7fafc 0%, #edf2f7 100%);
            border-radius: 15px;
        }

        .feature-item {
            text-align: center;
            flex: 1;
        }

        .feature-item i {
            color: var(--primary-color);
            font-size: 1.2rem;
            margin-bottom: 5px;
            display: block;
        }

        .feature-item span {
            color: var(--dark-color);
            font-weight: 600;
            font-size: 0.9rem;
        }

        .card-footer-custom {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 15px;
            border-top: 2px solid #e2e8f0;
        }

        .owner-info {
            display: flex;
            align-items: center;
            color: #718096;
            font-size: 0.9rem;
        }

        .owner-info i {
            margin-right: 8px;
            color: var(--primary-color);
        }

        .btn-view-details {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            border: none;
            border-radius: 25px;
            padding: 10px 25px;
            font-weight: 700;
            color: white;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .btn-view-details:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.5);
            color: white;
        }

        /* ========== MESSAGES ========== */
        .alert {
            border-radius: 15px;
            border: none;
            padding: 20px;
            font-weight: 600;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            animation: slideDown 0.5s ease;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .alert i {
            margin-right: 10px;
            font-size: 1.3rem;
        }

        /* ========== HEADER SECTION ========== */
        .content-header {
            background: white;
            padding: 25px;
            border-radius: 20px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
            margin-bottom: 30px;
        }

        .content-header h3 {
            font-weight: 700;
            color: var(--dark-color);
            margin: 0;
        }

        .content-header h3 i {
            margin-right: 12px;
            color: var(--primary-color);
        }

        .badge-count {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            padding: 12px 25px;
            border-radius: 30px;
            font-size: 1.1rem;
            font-weight: 700;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        /* ========== EMPTY STATE ========== */
        .empty-state {
            background: white;
            border-radius: 20px;
            padding: 60px 40px;
            text-align: center;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
        }

        .empty-state i {
            color: var(--primary-color);
            margin-bottom: 20px;
            animation: bounce 2s ease-in-out infinite;
        }

        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-20px); }
        }

        .empty-state h4 {
            color: var(--dark-color);
            font-weight: 700;
            margin-bottom: 15px;
        }

        .empty-state p {
            color: #718096;
            font-size: 1.1rem;
        }

        /* ========== FOOTER ========== */
        footer {
            background: linear-gradient(135deg, var(--dark-color) 0%, #1a202c 100%);
            padding: 40px 0;
            margin-top: 80px;
            box-shadow: 0 -5px 20px rgba(0, 0, 0, 0.1);
        }

        footer p {
            margin: 0;
            font-size: 1.1rem;
            font-weight: 600;
        }

        /* ========== RESPONSIVE ========== */
        @media (max-width: 768px) {
            .search-section h2 {
                font-size: 1.8rem;
            }

            .search-form {
                padding: 20px;
            }

            .annonce-image {
                height: 200px;
            }

            .property-features {
                flex-direction: column;
                gap: 10px;
            }
        }
    </style>
</head>
<body>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            <i class="fas fa-home"></i> Location Étudiant
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/annonce?action=list">
                        <i class="fas fa-list"></i> Annonces
                    </a>
                </li>
                <c:if test="${sessionScope.utilisateur != null}">
                    <c:if test="${sessionScope.utilisateur.role == 'PROPRIETAIRE'}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/annonce?action=MesAnnonces">
                                <i class="fas fa-briefcase"></i> Mes Annonces
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/annonce?action=new">
                                <i class="fas fa-plus-circle"></i> Nouvelle Annonce
                            </a>
                        </li>
                    </c:if>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/utilisateur/deconnexion">
                            <i class="fas fa-sign-out-alt"></i> Déconnexion
                        </a>
                    </li>
                </c:if>
                <c:if test="${sessionScope.utilisateur == null}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/utilisateur/login">
                            <i class="fas fa-sign-in-alt"></i> Connexion
                        </a>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>

<!-- Section de recherche -->
<div class="search-section">
    <div class="container">
        <h2 class="text-center text-white">
            <i class="fas fa-search"></i> Trouvez votre logement idéal
        </h2>
        <form action="${pageContext.request.contextPath}/annonce?action=search" method="post" class="search-form">
            <input type="hidden" name="action" value="search">
            <div class="row g-3">
                <div class="col-md-3">
                    <input type="text" class="form-control" name="ville" placeholder="🏙️ Ville"
                           value="${param.ville}">
                </div>

                <div class="col-md-2">
                    <input type="number" class="form-control" name="prixMax" placeholder="💰 Prix max"
                           value="${param.prixMax}" step="0.01">
                </div>

                <div class="col-md-3">
                    <select class="form-select" name="type">
                        <option value="">🏠 Type de logement</option>
                        <option value="Studio" ${param.type == 'Studio' ? 'selected' : ''}>Studio</option>
                        <option value="T1" ${param.type == 'T1' ? 'selected' : ''}>T1</option>
                        <option value="T2" ${param.type == 'T2' ? 'selected' : ''}>T2</option>
                        <option value="T3" ${param.type == 'T3' ? 'selected' : ''}>T3</option>
                        <option value="Appartement" ${param.type == 'Appartement' ? 'selected' : ''}>Appartement</option>
                        <option value="Chambre" ${param.type == 'Chambre' ? 'selected' : ''}>Chambre</option>
                    </select>
                </div>

                <div class="col-md-2">
                    <input type="number" class="form-control" name="nbChambresMin" placeholder="🛏️ Chambres"
                           value="${param.nbChambresMin}" min="0">
                </div>

                <div class="col-md-2">
                    <button type="submit" class="btn btn-light w-100">
                        <i class="fas fa-search"></i> Rechercher
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- Contenu principal -->
<div class="container my-5">
    <!-- Messages -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fas fa-exclamation-circle"></i> ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="fas fa-check-circle"></i> ${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Titre et statistiques -->
    <div class="content-header d-flex justify-content-between align-items-center">
        <h3>
            <c:choose>
                <c:when test="${searchPerformed}">
                    <i class="fas fa-search"></i> Résultats de recherche
                </c:when>
                <c:otherwise>
                    <i class="fas fa-home"></i> Toutes les annonces disponibles
                </c:otherwise>
            </c:choose>
        </h3>
        <span class="badge badge-count">
            ${totalAnnonces != null ? totalAnnonces : 0} annonce(s)
        </span>
    </div>

    <!-- Liste des annonces -->
    <c:choose>
        <c:when test="${empty annonces}">
            <div class="empty-state">
                <i class="fas fa-home-lg-alt fa-5x"></i>
                <h4>Aucune annonce disponible</h4>
                <p>
                    <c:choose>
                        <c:when test="${searchPerformed}">
                            Aucune annonce ne correspond à vos critères de recherche.
                        </c:when>
                        <c:otherwise>
                            Il n'y a pas d'annonces disponibles pour le moment.
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row g-4">
                <c:forEach items="${annonces}" var="annonce">
                    <div class="col-md-6 col-lg-4">
                        <div class="card annonce-card">
                            <div class="image-wrapper position-relative">
                                <c:choose>
                                    <c:when test="${not empty annonce.imageUrl}">
                                        <img src="${annonce.imageUrl}" class="card-img-top annonce-image"
                                             alt="${annonce.titre}">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="card-img-top annonce-image d-flex align-items-center justify-content-center">
                                            <i class="fas fa-building fa-4x text-white"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                <span class="price-tag">
                                    <fmt:formatNumber value="${annonce.prix}" type="number" maxFractionDigits="2"/> MAD
                                </span>
                            </div>

                            <div class="card-body">
                                <h5 class="card-title">${annonce.titre}</h5>

                                <div class="location-badge">
                                    <i class="fas fa-map-marker-alt"></i> ${annonce.ville}
                                </div>

                                <p class="card-text">
                                        ${annonce.description}
                                </p>

                                <div class="property-features">
                                    <div class="feature-item">
                                        <i class="fas fa-expand"></i>
                                        <span>${annonce.superficie}m²</span>
                                    </div>
                                    <div class="feature-item">
                                        <i class="fas fa-bed"></i>
                                        <span>${annonce.nbChambres} ch.</span>
                                    </div>
                                    <div class="feature-item">
                                        <i class="fas fa-tag"></i>
                                        <span>${annonce.type}</span>
                                    </div>
                                </div>

                                <div class="card-footer-custom">
                                    <div class="owner-info">
                                        <i class="fas fa-user-circle"></i>
                                        <span>${annonce.proprietaire.nom}</span>

                                    </div>
                                    <a href="${pageContext.request.contextPath}/annonce?action=view&id=${annonce.id}"
                                       class="btn btn-view-details">
                                        <i class="fas fa-eye"></i> Détails
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- Footer -->
<footer class="text-white text-center">
    <div class="container">
        <p>&copy; 2024 Location Étudiant - Tous droits réservés</p>
        <div class="mt-3">
            <a href="#" class="text-white mx-2"><i class="fab fa-facebook fa-lg"></i></a>
            <a href="#" class="text-white mx-2"><i class="fab fa-twitter fa-lg"></i></a>
            <a href="#" class="text-white mx-2"><i class="fab fa-instagram fa-lg"></i></a>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>