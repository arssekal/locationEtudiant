<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <meta name="referrer" content="no-referrer-when-downgrade">
    <title>${annonce.titre} - Location Étudiant</title>
    <!-- ... reste du code ... -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            font-family: 'Poppins', sans-serif;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            padding-bottom: 50px;
        }

        /* Navbar */
        .navbar-custom {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
            padding: 15px 0;
        }

        .navbar-custom .navbar-brand,
        .navbar-custom .nav-link {
            color: white !important;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .navbar-custom .nav-link:hover {
            transform: translateY(-2px);
            opacity: 0.8;
        }

        /* Breadcrumb */
        .breadcrumb-custom {
            background: white;
            border-radius: 15px;
            padding: 20px 30px;
            margin: 20px 0;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        .breadcrumb-custom a {
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .breadcrumb-custom a:hover {
            color: #764ba2;
        }

        .breadcrumb-custom i {
            color: #a0aec0;
            margin: 0 10px;
        }

        /* Main Content */
        .annonce-container {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }

        /* Image Gallery */
        .image-gallery {
            position: relative;
            height: 500px;
            overflow: hidden;
        }

        .main-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .availability-badge {
            position: absolute;
            top: 30px;
            right: 30px;
            padding: 15px 30px;
            border-radius: 50px;
            font-size: 1rem;
            font-weight: 600;
            backdrop-filter: blur(10px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.3);
            z-index: 10;
        }

        .badge-disponible {
            background: rgba(72, 187, 120, 0.95);
            color: white;
        }

        .badge-non-disponible {
            background: rgba(245, 101, 101, 0.95);
            color: white;
        }

        /* Content Section */
        .content-section {
            padding: 40px;
        }

        .annonce-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 30px;
            padding-bottom: 30px;
            border-bottom: 2px solid #f7fafc;
        }

        .annonce-title {
            flex: 1;
        }

        .annonce-title h1 {
            font-size: 2.5rem;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 15px;
        }

        .annonce-location {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #718096;
            font-size: 1.1rem;
        }

        .annonce-location i {
            color: #667eea;
        }

        .annonce-price-box {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 25px 35px;
            border-radius: 15px;
            text-align: center;
            color: white;
            min-width: 200px;
        }

        .price-label {
            font-size: 0.9rem;
            opacity: 0.9;
            margin-bottom: 5px;
        }

        .price-amount {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .price-period {
            font-size: 1rem;
            opacity: 0.9;
        }

        /* Features Grid */
        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }

        .feature-box {
            background: #f7fafc;
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            transition: all 0.3s ease;
        }

        .feature-box:hover {
            background: #edf2f7;
            transform: translateY(-5px);
        }

        .feature-icon {
            width: 60px;
            height: 60px;
            margin: 0 auto 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            color: white;
        }

        .feature-label {
            font-size: 0.9rem;
            color: #718096;
            margin-bottom: 5px;
        }

        .feature-value {
            font-size: 1.3rem;
            font-weight: 600;
            color: #2d3748;
        }

        /* Description */
        .description-section {
            margin-bottom: 40px;
        }

        .section-title {
            font-size: 1.8rem;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .section-title::after {
            content: '';
            flex: 1;
            height: 2px;
            background: linear-gradient(90deg, #667eea 0%, transparent 100%);
        }

        .description-text {
            font-size: 1.05rem;
            line-height: 1.8;
            color: #4a5568;
            padding: 20px;
            background: #f7fafc;
            border-radius: 15px;
            border-left: 4px solid #667eea;
        }

        /* Amenities */
        .amenities-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 15px;
        }

        .amenity-item {
            background: #f7fafc;
            padding: 15px 20px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            gap: 15px;
            transition: all 0.3s ease;
        }

        .amenity-item:hover {
            background: #edf2f7;
            transform: translateX(5px);
        }

        .amenity-icon {
            width: 45px;
            height: 45px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.2rem;
        }

        .amenity-name {
            font-weight: 500;
            color: #2d3748;
        }

        /* Contact Section */
        .contact-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 20px;
            padding: 40px;
            margin: 40px 0;
            color: white;
        }

        .contact-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }

        .contact-box {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            transition: all 0.3s ease;
        }

        .contact-box:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-5px);
        }

        .contact-icon {
            font-size: 2.5rem;
            margin-bottom: 15px;
        }

        .contact-label {
            font-size: 0.9rem;
            opacity: 0.9;
            margin-bottom: 10px;
        }

        .contact-value {
            font-size: 1.2rem;
            font-weight: 600;
        }

        .contact-btn {
            background: white;
            color: #667eea;
            border: none;
            padding: 12px 30px;
            border-radius: 50px;
            font-weight: 600;
            margin-top: 15px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            cursor: pointer;
            display: inline-block;
            text-decoration: none;
            text-align: center;
        }

        .contact-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.3);
            color: #667eea;
            text-decoration: none;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            padding: 30px 40px;
            background: #f7fafc;
            border-radius: 20px;
            margin: 30px 0;
        }

        .btn-action {
            flex: 1;
            min-width: 200px;
            padding: 15px 30px;
            border: none;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            cursor: pointer;
        }

        .btn-primary-custom {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .btn-primary-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary-custom {
            background: #edf2f7;
            color: #4a5568;
        }

        .btn-secondary-custom:hover {
            background: #e2e8f0;
            transform: translateY(-2px);
        }

        .btn-warning-custom {
            background: #feebc8;
            color: #c05621;
        }

        .btn-warning-custom:hover {
            background: #fbd38d;
            transform: translateY(-2px);
        }

        .btn-danger-custom {
            background: #fed7d7;
            color: #c53030;
        }

        .btn-danger-custom:hover {
            background: #fc8181;
            transform: translateY(-2px);
        }

        /* Map Section */
        .map-section {
            margin: 40px 0;
        }

        .map-container {
            background: #f7fafc;
            border-radius: 20px;
            padding: 40px;
            text-align: center;
            min-height: 400px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .contact-btn {
            background: white;
            color: #667eea;
            border: none;
            padding: 12px 30px;
            border-radius: 50px;
            font-weight: 600;
            margin-top: 15px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            display: inline-block;
            text-decoration: none;
            cursor: pointer;
        }

        .map-container i {
            font-size: 5rem;
            color: #cbd5e0;
            margin-bottom: 20px;
        }

        /* Sidebar */
        .sidebar {
            position: sticky;
            top: 20px;
        }

        .sidebar-box {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }

        .sidebar-title {
            font-size: 1.3rem;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f7fafc;
        }

        .info-item {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #f7fafc;
        }

        .info-item:last-child {
            border-bottom: none;
        }

        .info-label {
            color: #718096;
            font-weight: 500;
        }

        .info-value {
            color: #2d3748;
            font-weight: 600;
        }

        /* Share Buttons */
        .share-section {
            padding: 25px;
            background: #f7fafc;
            border-radius: 15px;
            margin-top: 20px;
        }

        .share-title {
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 15px;
        }

        .share-buttons {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .share-btn {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            border: none;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            color: white;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .share-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        }

        .share-facebook { background: #3b5998; }
        .share-twitter { background: #1da1f2; }
        .share-whatsapp { background: #25d366; }
        .share-email { background: #ea4335; }
        .share-copy { background: #667eea; }

        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .fade-in {
            animation: fadeInUp 0.6s ease-out;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .image-gallery {
                height: 300px;
            }

            .content-section {
                padding: 25px;
            }

            .annonce-header {
                flex-direction: column;
                gap: 20px;
            }

            .annonce-title h1 {
                font-size: 1.8rem;
            }

            .annonce-price-box {
                width: 100%;
            }

            .features-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .action-buttons {
                padding: 20px;
            }

            .btn-action {
                min-width: 100%;
            }
        }
    </style>
</head>
<body>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-custom">
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
                    <a class="nav-link" href="${pageContext.request.contextPath}/annonce?action=list">
                        <i class="fas fa-list"></i> Toutes les Annonces
                    </a>
                </li>
                <c:if test="${not empty sessionScope.utilisateur}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/annonce?action=mesAnnonces">
                            <i class="fas fa-briefcase"></i> Mes Annonces
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/utilisateur/profil">
                            <i class="fas fa-user"></i> Profil
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/utilisateur/deconnexion">
                            <i class="fas fa-sign-out-alt"></i> Déconnexion
                        </a>
                    </li>
                </c:if>
                <c:if test="${empty sessionScope.utilisateur}">
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

<!-- Main Content -->
<div class="container">
    <!-- Breadcrumb -->
    <div class="breadcrumb-custom fade-in">
        <a href="${pageContext.request.contextPath}/"><i class="fas fa-home"></i> Accueil</a>
        <i class="fas fa-chevron-right"></i>
        <a href="${pageContext.request.contextPath}/annonce?action=list">Annonces</a>
        <i class="fas fa-chevron-right"></i>
        <span style="color: #718096;">${annonce.titre}</span>
    </div>

    <div class="row">
        <!-- Main Content -->
        <div class="col-lg-8">
            <!-- Annonce Container -->
            <div class="annonce-container fade-in">
                <!-- Image Gallery -->
                <div class="image-gallery">
                    <c:choose>
                        <c:when test="${not empty annonce.imageUrl}">
                            <img src="${annonce.imageUrl}" alt="${annonce.titre}" class="main-image"
                                 onerror="this.src='https://via.placeholder.com/1200x500/667eea/ffffff?text=Image+Non+Disponible'">
                        </c:when>
                        <c:otherwise>
                            <img src="https://via.placeholder.com/1200x500/667eea/ffffff?text=Image+Non+Disponible"
                                 alt="Pas d'image" class="main-image">
                        </c:otherwise>
                    </c:choose>

                    <span class="availability-badge ${annonce.disponible ? 'badge-disponible' : 'badge-non-disponible'}">
                        <i class="fas ${annonce.disponible ? 'fa-check-circle' : 'fa-times-circle'} me-2"></i>
                        ${annonce.disponible ? 'Disponible' : 'Non Disponible'}
                    </span>
                </div>

                <!-- Content -->
                <div class="content-section">
                    <!-- Header -->
                    <div class="annonce-header">
                        <div class="annonce-title">
                            <h1>${annonce.titre}</h1>
                            <div class="annonce-location">
                                <i class="fas fa-map-marker-alt"></i>
                                <span>${annonce.adresse}, ${annonce.ville}</span>
                            </div>
                        </div>
                        <div class="annonce-price-box">
                            <div class="price-label">Prix de Location</div>
                            <div class="price-amount">
                                <fmt:formatNumber value="${annonce.prix}" type="number" maxFractionDigits="0"/>
                            </div>
                            <div class="price-period">MAD / mois</div>
                        </div>
                    </div>

                    <!-- Features -->
                    <div class="features-grid">
                        <div class="feature-box">
                            <div class="feature-icon">
                                <i class="fas fa-ruler-combined"></i>
                            </div>
                            <div class="feature-label">Superficie</div>
                            <div class="feature-value">${annonce.superficie} m²</div>
                        </div>
                        <div class="feature-box">
                            <div class="feature-icon">
                                <i class="fas fa-bed"></i>
                            </div>
                            <div class="feature-label">Chambres</div>
                            <div class="feature-value">${annonce.nbChambres}</div>
                        </div>
                        <div class="feature-box">
                            <div class="feature-icon">
                                <i class="fas fa-home"></i>
                            </div>
                            <div class="feature-label">Type</div>
                            <div class="feature-value">${annonce.type}</div>
                        </div>
                    </div>

                    <!-- Description -->
                    <div class="description-section">
                        <h2 class="section-title">
                            <i class="fas fa-align-left"></i>
                            Description
                        </h2>
                        <div class="description-text">
                            ${annonce.description}
                        </div>
                    </div>

                    <!-- Amenities -->
                    <c:if test="${not empty annonce.equipements}">
                        <div class="amenities-section">
                            <h2 class="section-title">
                                <i class="fas fa-star"></i>
                                Équipements
                            </h2>
                            <div class="amenities-grid">
                                <c:forEach var="equipement" items="${fn:split(annonce.equipements, ',')}">
                                    <div class="amenity-item">
                                        <div class="amenity-icon">
                                            <i class="fas fa-check"></i>
                                        </div>
                                        <div class="amenity-name">${fn:trim(equipement)}</div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- Contact Section -->

            <!-- Contact Section - Avec messagerie interne -->
            <c:if test="${empty sessionScope.utilisateur || sessionScope.utilisateur.role != 'proprietaire'}">
                <div class="contact-section fade-in">
                    <h2 style="text-align: center; margin-bottom: 10px;">
                        <i class="fas fa-phone-alt me-2"></i>
                        Intéressé par cette annonce ?
                    </h2>
                    <p style="text-align: center; opacity: 0.9; margin-bottom: 0;">
                        Contactez le propriétaire pour plus d'informations
                    </p>

                    <div class="contact-grid">
                        <div class="contact-box">
                            <div class="contact-icon">
                                <i class="fas fa-user"></i>
                            </div>
                            <div class="contact-label">Propriétaire</div>
                            <div class="contact-value">${annonce.propriataire.nom}</div>
                        </div>

                        <!-- Section Messagerie Interne -->
                        <div class="contact-box">
                            <div class="contact-icon">
                                <i class="fas fa-envelope"></i>
                            </div>
                            <div class="contact-label">Message</div>
                            <div class="contact-value" style="font-size: 1rem; word-break: break-word;">
                                Envoyer un message
                            </div>
                            <c:choose>
                                <c:when test="${not empty sessionScope.utilisateur}">
                                    <!-- Utilisateur connecté : lien vers la messagerie -->
                                    <a href="${pageContext.request.contextPath}/message?action=compose&to=${annonce.propriataire.id}&annonce=${annonce.id}"
                                       class="contact-btn"
                                       style="display: inline-block; text-decoration: none;">
                                        <i class="fas fa-envelope me-2"></i> Envoyer un Message
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <!-- Utilisateur non connecté : redirection vers login -->
                                    <a href="${pageContext.request.contextPath}/login.jsp?redirect=annonce?action=detail%26id=${annonce.id}"
                                       class="contact-btn"
                                       style="display: inline-block; text-decoration: none;">
                                        <i class="fas fa-sign-in-alt me-2"></i> Se connecter pour contacter
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- Section Téléphone -->
                        <c:if test="${not empty annonce.contactTelephone}">
                            <div class="contact-box">
                                <div class="contact-icon">
                                    <i class="fas fa-phone"></i>
                                </div>
                                <div class="contact-label">Téléphone</div>
                                <div class="contact-value">${annonce.contactTelephone}</div>
                                <a href="tel:${annonce.contactTelephone}"
                                   class="contact-btn"
                                   style="display: inline-block; text-decoration: none;">
                                    <i class="fas fa-phone me-2"></i> Appeler
                                </a>
                            </div>
                        </c:if>
                    </div>
                </div>
            </c:if>



            <!-- Map Section -->
            <div class="map-section fade-in">
                <h2 class="section-title">
                    <i class="fas fa-map-marked-alt"></i>
                    Localisation
                </h2>
                <div class="map-container">
                    <i class="fas fa-map-marker-alt"></i>
                    <h4 style="color: #2d3748; margin-bottom: 10px;">${annonce.adresse}</h4>
                    <p style="color: #718096;">${annonce.ville}</p>
                    <button class="contact-btn" style="color: #667eea;"
                            onclick="window.open('https://www.google.com/maps/search/?api=1&query=${fn:replace(annonce.adresse, ' ', '+')}+${fn:replace(annonce.ville, ' ', '+')}', '_blank')">
                        <i class="fas fa-external-link-alt me-2"></i> Voir sur Google Maps
                    </button>
                </div>
            </div>

            <!-- Action Buttons (Owner Only) -->
            <c:if test="${not empty sessionScope.utilisateur && sessionScope.utilisateur.id == annonce.propriataire.id}">
                <div class="action-buttons fade-in">
                    <a href="${pageContext.request.contextPath}/annonce?action=edit&id=${annonce.id}"
                       class="btn-action btn-primary-custom">
                        <i class="fas fa-edit"></i> Modifier l'Annonce
                    </a>
                    <a href="${pageContext.request.contextPath}/annonce?action=toggleDisponibilite&id=${annonce.id}"
                       class="btn-action btn-warning-custom"
                       onclick="return confirm('Voulez-vous vraiment changer la disponibilité de cette annonce ?')">
                        <i class="fas fa-exchange-alt"></i> Changer Disponibilité
                    </a>
                    <button class="btn-action btn-danger-custom"
                            onclick="confirmDelete(${annonce.id}, '${fn:escapeXml(annonce.titre)}')">
                        <i class="fas fa-trash"></i> Supprimer l'Annonce
                    </button>
                </div>
            </c:if>
        </div>

        <!-- Sidebar -->
        <div class="col-lg-4">
            <div class="sidebar">
                <div class="sidebar-box fade-in">
                    <h3 class="sidebar-title">
                        <i class="fas fa-info-circle me-2"></i>
                        Informations Détaillées
                    </h3>
                    <div class="info-item">
                        <span class="info-label">
                            <i class="fas fa-tag me-2"></i>Type
                        </span>
                        <span class="info-value">${annonce.type}</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">
                            <i class="fas fa-ruler-combined me-2"></i>Superficie
                        </span>
                        <span class="info-value">${annonce.superficie} m²</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">
                            <i class="fas fa-bed me-2"></i>Chambres
                        </span>
                        <span class="info-value">${annonce.nbChambres}</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">
                            <i class="fas fa-map-marker-alt me-2"></i>Ville
                        </span>
                        <span class="info-value">${annonce.ville}</span>
                    </div>
                    <div class="info-item">
                        <span class="info-label">
                            <i class="fas fa-circle me-2"></i>Statut
                        </span>
                        <span class="info-value" style="color: ${annonce.disponible ? '#48bb78' : '#f56565'};">
                            ${annonce.disponible ? 'Disponible' : 'Non Disponible'}
                        </span>
                    </div>
                </div>

                <!-- Share Box -->
                <div class="sidebar-box fade-in">
                    <h3 class="sidebar-title">
                        <i class="fas fa-share-alt me-2"></i>
                        Partager cette Annonce
                    </h3>
                    <div class="share-buttons">
                        <button class="share-btn share-facebook"
                                onclick="shareOnFacebook()"
                                title="Partager sur Facebook">
                            <i class="fab fa-facebook-f"></i>
                        </button>
                        <button class="share-btn share-twitter"
                                onclick="shareOnTwitter()"
                                title="Partager sur Twitter">
                            <i class="fab fa-twitter"></i>
                        </button>
                        <button class="share-btn share-whatsapp"
                                onclick="shareOnWhatsApp()"
                                title="Partager sur WhatsApp">
                            <i class="fab fa-whatsapp"></i>
                        </button>
                        <button class="share-btn share-email"
                                onclick="shareByEmail()"
                                title="Partager par Email"
                                rel="noopener noreferrer">
                            <i class="fas fa-envelope"></i>
                        </button>
                        <button class="share-btn share-copy"
                                onclick="copyLink()"
                                title="Copier le lien">
                            <i class="fas fa-link"></i>
                        </button>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="sidebar-box fade-in">
                    <h3 class="sidebar-title">
                        <i class="fas fa-bolt me-2"></i>
                        Actions Rapides
                    </h3>
                    <div style="display: flex; flex-direction: column; gap: 10px;">
                        <button class="btn-action btn-secondary-custom" onclick="window.print()">
                            <i class="fas fa-print"></i> Imprimer l'Annonce
                        </button>
                        <button class="btn-action btn-secondary-custom" onclick="saveFavorite()">
                            <i class="fas fa-heart"></i> Sauvegarder
                        </button>
                        <a href="${pageContext.request.contextPath}/annonce?action=list"
                           class="btn-action btn-secondary-custom">
                            <i class="fas fa-arrow-left"></i> Retour aux Annonces
                        </a>
                    </div>
                </div>

                <!-- Tips Box -->
                <div class="sidebar-box fade-in" style="background: linear-gradient(135deg, #fff5eb 0%, #ffe8cc 100%); border: 2px solid #fbd38d;">
                    <h3 class="sidebar-title" style="color: #c05621;">
                        <i class="fas fa-lightbulb me-2"></i>
                        Conseils de Sécurité
                    </h3>
                    <div style="color: #744210; font-size: 0.9rem; line-height: 1.6;">
                        <p style="margin-bottom: 10px;">
                            <i class="fas fa-check-circle" style="color: #dd6b20;"></i>
                            Visitez toujours le bien avant de signer
                        </p>
                        <p style="margin-bottom: 10px;">
                            <i class="fas fa-check-circle" style="color: #dd6b20;"></i>
                            Ne payez jamais sans avoir signé de contrat
                        </p>
                        <p style="margin-bottom: 10px;">
                            <i class="fas fa-check-circle" style="color: #dd6b20;"></i>
                            Vérifiez l'identité du propriétaire
                        </p>
                        <p style="margin-bottom: 0;">
                            <i class="fas fa-check-circle" style="color: #dd6b20;"></i>
                            Demandez une quittance pour chaque paiement
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header" style="background: linear-gradient(135deg, #f56565 0%, #c53030 100%); color: white;">
                <h5 class="modal-title">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    Confirmer la Suppression
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body text-center py-4">
                <i class="fas fa-trash-alt" style="font-size: 4rem; color: #fc8181; margin-bottom: 20px;"></i>
                <h5 style="color: #2d3748; margin-bottom: 15px;">Êtes-vous sûr de vouloir supprimer cette annonce ?</h5>
                <p style="color: #718096; margin-bottom: 0;" id="deleteAnnonceTitle"></p>
                <p style="color: #e53e3e; font-size: 0.9rem; margin-top: 15px;">
                    <i class="fas fa-info-circle"></i> Cette action est irréversible !
                </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="fas fa-times"></i> Annuler
                </button>
                <a href="#" id="confirmDeleteBtn" class="btn btn-danger">
                    <i class="fas fa-trash"></i> Supprimer Définitivement
                </a>
            </div>
        </div>
    </div>
</div>

<!-- Success Toast -->
<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
    <div id="successToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;">
            <i class="fas fa-check-circle me-2"></i>
            <strong class="me-auto">Succès</strong>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
        </div>
        <div class="toast-body" id="toastMessage">
            Action effectuée avec succès !
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Variables pour le partage
    const currentUrl = window.location.href;
    const annonceTitle = "${fn:escapeXml(annonce.titre)}";
    const annoncePrice = "${annonce.prix}";
    const annonceVille = "${fn:escapeXml(annonce.ville)}";
    const annonceId = "${annonce.id}";

    // Share Functions
    function shareOnFacebook() {
        const facebookUrl = 'https://www.facebook.com/sharer/sharer.php?u=' + encodeURIComponent(currentUrl);
        window.open(facebookUrl, '_blank', 'width=600,height=400');
    }

    function shareOnTwitter() {
        const text = 'Découvrez cette annonce: ' + annonceTitle + ' - ' + annoncePrice + ' MAD à ' + annonceVille;
        const twitterUrl = 'https://twitter.com/intent/tweet?url=' + encodeURIComponent(currentUrl) + '&text=' + encodeURIComponent(text);
        window.open(twitterUrl, '_blank', 'width=600,height=400');
    }

    function shareOnWhatsApp() {
        const text = 'Découvrez cette annonce: ' + annonceTitle + ' - ' + annoncePrice + ' MAD à ' + annonceVille + '\n' + currentUrl;
        const whatsappUrl = 'https://wa.me/?text=' + encodeURIComponent(text);
        window.open(whatsappUrl, '_blank');
    }

    function shareByEmail() {
        const subject = 'Annonce: ' + annonceTitle;
        const body = 'Bonjour,\n\nJe voulais partager cette annonce avec vous:\n\n' +
            annonceTitle + '\nPrix: ' + annoncePrice + ' MAD/mois\nVille: ' +
            annonceVille + '\n\nLien: ' + currentUrl + '\n\nCordialement';

        // Créer un lien temporaire
        const mailtoLink = document.createElement('a');
        mailtoLink.href = 'mailto:?subject=' + encodeURIComponent(subject) +
            '&body=' + encodeURIComponent(body);
        mailtoLink.rel = 'noopener noreferrer';
        mailtoLink.style.display = 'none';

        // Ajouter au DOM, cliquer, puis supprimer
        document.body.appendChild(mailtoLink);
        mailtoLink.click();

        // Supprimer après un court délai
        setTimeout(() => {
            document.body.removeChild(mailtoLink);
        }, 100);
    }

    function copyLink() {
        navigator.clipboard.writeText(currentUrl).then(() => {
            showToast('Lien copié dans le presse-papiers !');
        }).catch(err => {
            console.error('Erreur lors de la copie:', err);
            const textArea = document.createElement('textarea');
            textArea.value = currentUrl;
            document.body.appendChild(textArea);
            textArea.select();
            try {
                document.execCommand('copy');
                showToast('Lien copié dans le presse-papiers !');
            } catch (err) {
                showToast('Erreur lors de la copie du lien', 'error');
            }
            document.body.removeChild(textArea);
        });
    }

    // Toast notification
    function showToast(message, type = 'success') {
        const toast = document.getElementById('successToast');
        const toastMessage = document.getElementById('toastMessage');
        toastMessage.textContent = message;

        const toastHeader = toast.querySelector('.toast-header');
        if (type === 'error') {
            toastHeader.style.background = 'linear-gradient(135deg, #f56565 0%, #c53030 100%)';
        } else {
            toastHeader.style.background = 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)';
        }

        const bsToast = new bootstrap.Toast(toast);
        bsToast.show();
    }

    // Delete confirmation
    function confirmDelete(annonceId, annonceTitle) {
        const deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
        document.getElementById('deleteAnnonceTitle').textContent = annonceTitle;
        document.getElementById('confirmDeleteBtn').href = '${pageContext.request.contextPath}/annonce?action=delete&id=' + annonceId;
        deleteModal.show();
    }

    // Save to favorites
    function saveFavorite() {
        const favorites = JSON.parse(localStorage.getItem('favorites') || '[]');

        if (favorites.includes(annonceId)) {
            showToast('Cette annonce est déjà dans vos favoris', 'error');
        } else {
            favorites.push(annonceId);
            localStorage.setItem('favorites', JSON.stringify(favorites));
            showToast('Annonce ajoutée aux favoris !');

            const btn = event.target.closest('button');
            if (btn) {
                btn.innerHTML = '<i class="fas fa-heart" style="color: #f56565;"></i> Sauvegardé';
            }
        }
    }

    // Smooth scroll for internal links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });

    // Check if coming from favorites
    window.addEventListener('load', function() {
        const favorites = JSON.parse(localStorage.getItem('favorites') || '[]');

        if (favorites.includes(annonceId)) {
            const saveBtn = document.querySelector('[onclick="saveFavorite()"]');
            if (saveBtn) {
                saveBtn.innerHTML = '<i class="fas fa-heart" style="color: #f56565;"></i> Sauvegardé';
            }
        }
    });

    // Keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            window.history.back();
        }

        if ((e.ctrlKey || e.metaKey) && e.key === 'p') {
            e.preventDefault();
            window.print();
        }

        if ((e.ctrlKey || e.metaKey) && e.key === 's') {
            e.preventDefault();
            saveFavorite();
        }
    });

    // Scroll animations
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);

    document.querySelectorAll('.fade-in').forEach(element => {
        element.style.opacity = '0';
        element.style.transform = 'translateY(30px)';
        element.style.transition = 'all 0.6s ease';
        observer.observe(element);
    });

    // Feature boxes hover effect
    document.querySelectorAll('.feature-box').forEach(box => {
        box.addEventListener('mouseenter', function() {
            const icon = this.querySelector('.feature-icon');
            if (icon) {
                icon.style.transform = 'rotate(360deg) scale(1.1)';
                icon.style.transition = 'all 0.6s ease';
            }
        });

        box.addEventListener('mouseleave', function() {
            const icon = this.querySelector('.feature-icon');
            if (icon) {
                icon.style.transform = 'rotate(0deg) scale(1)';
            }
        });
    });

    // Mobile touch optimizations
    if ('ontouchstart' in window) {
        document.querySelectorAll('.btn-action, .contact-btn, .share-btn').forEach(btn => {
            btn.style.cursor = 'pointer';
            btn.addEventListener('touchstart', function() {
                this.style.transform = 'scale(0.95)';
            });
            btn.addEventListener('touchend', function() {
                this.style.transform = 'scale(1)';
            });
        });
    }

    // Add bounce effect to price box on load
    window.addEventListener('load', function() {
        const priceBox = document.querySelector('.annonce-price-box');
        if (priceBox) {
            priceBox.style.animation = 'bounce 1s ease';
        }
    });

    // Bounce animation
    const style = document.createElement('style');
    style.textContent = `
        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }
    `;
    document.head.appendChild(style);

    console.log('✅ Page chargée avec succès');
    console.log('📄 Annonce ID:', annonceId);
    console.log('💰 Prix:', annoncePrice + ' MAD');
    console.log('📍 Ville:', annonceVille);
</script>
</body>
</html>