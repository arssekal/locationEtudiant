<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Location Étudiant - Votre Logement Idéal à Portée de Clic</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            font-family: 'Poppins', sans-serif;
        }

        body {
            overflow-x: hidden;
        }

        /* Hero Section avec animation */
        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            position: relative;
            overflow: hidden;
            color: white;
        }

        .hero-section::before {
            content: '';
            position: absolute;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 1px, transparent 1px);
            background-size: 50px 50px;
            animation: moveBackground 20s linear infinite;
        }

        @keyframes moveBackground {
            0% { transform: translate(0, 0); }
            100% { transform: translate(50px, 50px); }
        }

        .hero-content {
            position: relative;
            z-index: 2;
        }

        .hero-title {
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            margin-top:4rem ;
            animation: fadeInUp 1s ease-out;
        }

        .hero-subtitle {
            font-size: 1.5rem;
            font-weight: 300;
            margin-bottom: 2rem;
            animation: fadeInUp 1.2s ease-out;
        }

        .hero-buttons {
            animation: fadeInUp 1.4s ease-out;
        }

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

        .btn-hero {
            padding: 15px 40px;
            font-size: 1.1rem;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s ease;
            border: none;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }

        .btn-hero:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.3);
        }

        .btn-primary-custom {
            background: white;
            color: #667eea;
        }

        .btn-outline-custom {
            background: transparent;
            color: white;
            border: 2px solid white;
        }

        .btn-outline-custom:hover {
            background: white;
            color: #667eea;
        }

        .btn-disabled {
            opacity: 0.6;
            cursor: not-allowed;
            position: relative;
        }

        /* Features Section */
        .features-section {
            padding: 100px 0;
            background: #f8f9fa;
        }

        .section-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            color: #2d3748;
        }

        .section-subtitle {
            font-size: 1.1rem;
            color: #718096;
            margin-bottom: 4rem;
        }

        .feature-card {
            background: white;
            padding: 40px 30px;
            border-radius: 20px;
            transition: all 0.4s ease;
            border: none;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            height: 100%;
            position: relative;
            overflow: hidden;
        }

        .feature-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
            transform: scaleX(0);
            transition: transform 0.4s ease;
        }

        .feature-card:hover::before {
            transform: scaleX(1);
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(102, 126, 234, 0.3);
        }

        .feature-icon {
            width: 80px;
            height: 80px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            margin-bottom: 25px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .feature-title {
            font-size: 1.4rem;
            font-weight: 600;
            margin-bottom: 15px;
            color: #2d3748;
        }

        .feature-text {
            color: #718096;
            line-height: 1.8;
        }

        /* How it works Section */
        .how-it-works {
            padding: 100px 0;
            background: white;
        }

        .step-card {
            text-align: center;
            padding: 30px;
            position: relative;
        }

        .step-number {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            font-size: 2rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 25px;
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
        }

        .step-title {
            font-size: 1.3rem;
            font-weight: 600;
            margin-bottom: 15px;
            color: #2d3748;
        }

        .step-description {
            color: #718096;
            line-height: 1.8;
        }

        /* Stats Section */
        .stats-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 80px 0;
            color: white;
        }

        .stat-item {
            text-align: center;
            padding: 20px;
        }

        .stat-number {
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 10px;
            display: block;
        }

        .stat-label {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        /* Testimonials Section */
        .testimonials-section {
            padding: 100px 0;
            background: #f8f9fa;
        }

        .testimonial-card {
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            height: 100%;
            position: relative;
        }

        .testimonial-quote {
            font-size: 4rem;
            color: #667eea;
            opacity: 0.2;
            position: absolute;
            top: 20px;
            left: 30px;
        }

        .testimonial-text {
            font-style: italic;
            color: #4a5568;
            margin-bottom: 25px;
            position: relative;
            z-index: 1;
        }

        .testimonial-author {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .testimonial-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
            font-weight: 600;
        }

        .testimonial-info h5 {
            margin: 0;
            color: #2d3748;
            font-weight: 600;
        }

        .testimonial-info p {
            margin: 0;
            color: #718096;
            font-size: 0.9rem;
        }

        /* CTA Section */
        .cta-section {
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
            padding: 100px 0;
            color: white;
            text-align: center;
        }

        .cta-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
        }

        .cta-text {
            font-size: 1.2rem;
            margin-bottom: 3rem;
            opacity: 0.95;
        }

        /* Footer */
        .footer {
            background: #1a202c;
            color: white;
            padding: 60px 0 30px;
        }

        .footer-title {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 20px;
        }

        .footer-links {
            list-style: none;
            padding: 0;
        }

        .footer-links li {
            margin-bottom: 10px;
        }

        .footer-links a {
            color: #a0aec0;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer-links a:hover {
            color: #667eea;
        }

        .social-links {
            display: flex;
            gap: 15px;
        }

        .social-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: rgba(255,255,255,0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            transition: all 0.3s ease;
        }

        .social-icon:hover {
            background: #667eea;
            transform: translateY(-3px);
        }

        /* Navbar Custom */
        .navbar-custom {
            padding: 20px 0;
            background: transparent !important;
            position: absolute;
            width: 100%;
            z-index: 100;
            transition: all 0.3s ease;
        }

        .navbar-custom.scrolled {
            background: rgba(102, 126, 234, 0.95) !important;
            backdrop-filter: blur(10px);
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
            position: fixed;
            top: 0;
        }

        .navbar-custom .navbar-brand {
            font-size: 1.5rem;
            font-weight: 700;
            color: white !important;
        }

        .navbar-custom .nav-link {
            color: white !important;
            font-weight: 500;
            padding: 8px 20px !important;
            transition: all 0.3s ease;
        }

        .navbar-custom .nav-link:hover {
            background: rgba(255,255,255,0.1);
            border-radius: 5px;
        }

        /* Animations */
        .animate-on-scroll {
            opacity: 0;
            transform: translateY(30px);
            transition: all 0.6s ease;
        }

        .animate-on-scroll.animated {
            opacity: 1;
            transform: translateY(0);
        }

        /* Alert pour utilisateurs non connectés */
        .login-alert {
            background: rgba(255, 255, 255, 0.95);
            /*border-left: 3px solid #667eea;*/
            padding: 5px 10px;
            border-radius: 10px;
            margin-top: 1rem;
            margin-bottom: 4rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            animation: slideInDown 0.5s ease-out;
        }

        @keyframes slideInDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .login-alert i {
            color: #667eea;
            margin-right: 10px;
        }

        .login-alert strong {
            color: #2d3748;
        }

        .login-alert a {
            color: #667eea;
            font-weight: 600;
            text-decoration: none;
        }

        .login-alert a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<!-- Navbar -->
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
                <c:choose>
                    <c:when test="${sessionScope.utilisateur != null}">
                        <!-- Liens accessibles pour utilisateurs connectés -->
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/utilisateur/dashboard">
                                <i class="fas fa-star"></i> Fonctionnalités
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/annonce?action=list">
                                <i class="fas fa-list"></i> Annonces
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/utilisateur/profil">
                                <i class="fas fa-user"></i> Mon Compte
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <!-- Pour utilisateurs non connectés - liens désactivés avec redirection -->
                        <li class="nav-item">
                            <a class="nav-link" href="#" onclick="showLoginAlert(event)">
                                <i class="fas fa-star"></i> Fonctionnalités
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#how-it-works">
                                <i class="fas fa-info-circle"></i> Comment ça marche
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" onclick="showLoginAlert(event)">
                                <i class="fas fa-list"></i> Annonces
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/utilisateur/login">
                                <i class="fas fa-sign-in-alt"></i> Connexion
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero-section">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-6 hero-content">
                <h1 class="hero-title">
                    Trouvez Votre Logement Étudiant Parfait
                </h1>
                <p class="hero-subtitle">
                    La plateforme qui connecte étudiants et propriétaires pour une recherche de logement simplifiée et sécurisée
                </p>

                <c:choose>
                    <c:when test="${sessionScope.utilisateur != null}">
                        <!-- Boutons pour utilisateurs connectés -->
                        <div class="hero-buttons d-flex gap-3 flex-wrap">
                            <a href="${pageContext.request.contextPath}/annonce?action=list"
                               class="btn btn-hero btn-primary-custom">
                                <i class="fas fa-search"></i> Explorer les Annonces
                            </a>
                            <c:if test="${sessionScope.utilisateur.role == 'PROPRIETAIRE'}">
                                <a href="${pageContext.request.contextPath}/annonce?action=new"
                                   class="btn btn-hero btn-outline-custom">
                                    <i class="fas fa-plus-circle"></i> Publier une Annonce
                                </a>
                            </c:if>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- Boutons pour utilisateurs NON connectés -->
                        <div class="hero-buttons d-flex gap-3 flex-wrap">
                            <a href="${pageContext.request.contextPath}/utilisateur/login"
                               class="btn btn-hero btn-primary-custom">
                                <i class="fas fa-sign-in-alt"></i> Se Connecter
                            </a>
                            <a href="${pageContext.request.contextPath}/utilisateur/inscription"
                               class="btn btn-hero btn-outline-custom">
                                <i class="fas fa-user-plus"></i> S'inscrire
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="col-lg-6 d-none d-lg-block">
                <div class="text-center">
                    <i class="fas fa-building" style="font-size: 20rem; opacity: 0.2;"></i>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Features Section -->
<section id="features" class="features-section">
    <div class="container">
        <div class="text-center">
            <h2 class="section-title animate-on-scroll">Pourquoi Choisir Notre Plateforme ?</h2>
            <p class="section-subtitle animate-on-scroll">Des fonctionnalités pensées pour vous faciliter la vie</p>
        </div>
        <div class="row g-4">
            <div class="col-md-4 animate-on-scroll">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-search"></i>
                    </div>
                    <h3 class="feature-title">Recherche Intelligente</h3>
                    <p class="feature-text">
                        Filtrez par ville, prix, type de logement et nombre de chambres. Trouvez exactement ce que vous cherchez en quelques clics.
                    </p>
                </div>
            </div>
            <div class="col-md-4 animate-on-scroll">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <h3 class="feature-title">Sécurité Garantie</h3>
                    <p class="feature-text">
                        Annonces vérifiées, profils authentifiés et contact direct avec les propriétaires en toute confiance.
                    </p>
                </div>
            </div>
            <div class="col-md-4 animate-on-scroll">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-bolt"></i>
                    </div>
                    <h3 class="feature-title">Réponse Rapide</h3>
                    <p class="feature-text">
                        Contactez les propriétaires instantanément par email ou téléphone. Obtenez des réponses rapidement.
                    </p>
                </div>
            </div>
            <div class="col-md-4 animate-on-scroll">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-mobile-alt"></i>
                    </div>
                    <h3 class="feature-title">100% Responsive</h3>
                    <p class="feature-text">
                        Accessible depuis n'importe quel appareil. Recherchez votre logement où que vous soyez.
                    </p>
                </div>
            </div>
            <div class="col-md-4 animate-on-scroll">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-dollar-sign"></i>
                    </div>
                    <h3 class="feature-title">Gratuit et Sans Frais</h3>
                    <p class="feature-text">
                        Aucun frais caché. Consultez les annonces et contactez les propriétaires gratuitement.
                    </p>
                </div>
            </div>
            <div class="col-md-4 animate-on-scroll">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-headset"></i>
                    </div>
                    <h3 class="feature-title">Support 24/7</h3>
                    <p class="feature-text">
                        Notre équipe est disponible pour répondre à toutes vos questions et vous accompagner.
                    </p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- How it Works Section -->
<section id="how-it-works" class="how-it-works">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="section-title animate-on-scroll">Comment Ça Marche ?</h2>
            <p class="section-subtitle animate-on-scroll">Trois étapes simples pour trouver votre logement</p>
        </div>
        <div class="row g-4">
            <div class="col-md-4 animate-on-scroll">
                <div class="step-card">
                    <div class="step-number">1</div>
                    <h3 class="step-title">Créez Votre Compte</h3>
                    <p class="step-description">
                        Inscrivez-vous gratuitement en tant qu'étudiant ou propriétaire en quelques secondes.
                    </p>
                </div>
            </div>
            <div class="col-md-4 animate-on-scroll">
                <div class="step-card">
                    <div class="step-number">2</div>
                    <h3 class="step-title">Recherchez ou Publiez</h3>
                    <p class="step-description">
                        Étudiants : parcourez les annonces. Propriétaires : publiez votre logement gratuitement.
                    </p>
                </div>
            </div>
            <div class="col-md-4 animate-on-scroll">
                <div class="step-card">
                    <div class="step-number">3</div>
                    <h3 class="step-title">Contactez et Trouvez</h3>
                    <p class="step-description">
                        Contactez directement les propriétaires et trouvez votre logement idéal rapidement.
                    </p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Stats Section -->
<section class="stats-section">
    <div class="container">
        <div class="row">
            <div class="col-md-3 stat-item animate-on-scroll">
                <span class="stat-number" data-target="150">0</span>
                <span class="stat-label">Logements Disponibles</span>
            </div>
            <div class="col-md-3 stat-item animate-on-scroll">
                <span class="stat-number" data-target="800">0</span>
                <span class="stat-label">Étudiants Satisfaits</span>
            </div>
            <div class="col-md-3 stat-item animate-on-scroll">
                <span class="stat-number" data-target="75">0</span>
                <span class="stat-label">Propriétaires Partenaires</span>
            </div>
            <div class="col-md-3 stat-item animate-on-scroll">
                <span class="stat-number" data-target="95">0</span>
                <span class="stat-label">% de Satisfaction</span>
            </div>
        </div>
    </div>
</section>

<!-- Testimonials Section -->
<section class="testimonials-section">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="section-title animate-on-scroll">Ce Que Disent Nos Utilisateurs</h2>
            <p class="section-subtitle animate-on-scroll">Des milliers d'étudiants nous font confiance</p>
        </div>
        <div class="row g-4">
            <div class="col-md-4 animate-on-scroll">
                <div class="testimonial-card">
                    <i class="fas fa-quote-left testimonial-quote"></i>
                    <p class="testimonial-text">
                        "J'ai trouvé mon studio en moins de 48h ! Interface intuitive et propriétaires réactifs. Je recommande vivement !"
                    </p>
                    <div class="testimonial-author">
                        <div class="testimonial-avatar">AM</div>
                        <div class="testimonial-info">
                            <h5>Amina Mansouri</h5>
                            <p>Étudiante en Médecine</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 animate-on-scroll">
                <div class="testimonial-card">
                    <i class="fas fa-quote-left testimonial-quote"></i>
                    <p class="testimonial-text">
                        "En tant que propriétaire, j'ai publié mon appartement et trouvé un locataire en une semaine. Service excellent !"
                    </p>
                    <div class="testimonial-author">
                        <div class="testimonial-avatar">YB</div>
                        <div class="testimonial-info">
                            <h5>Youssef Benjelloun</h5>
                            <p>Propriétaire</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 animate-on-scroll">
                <div class="testimonial-card">
                    <i class="fas fa-quote-left testimonial-quote"></i>
                    <p class="testimonial-text">
                        "Plateforme sécurisée avec des annonces vérifiées. J'ai pu visiter 3 appartements en 2 jours. Parfait !"
                    </p>
                    <div class="testimonial-author">
                        <div class="testimonial-avatar">SK</div>
                        <div class="testimonial-info">
                            <h5>Sarah Khoury</h5>
                            <p>Étudiante en Informatique</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- CTA Section -->
<section class="cta-section">
    <div class="container">
        <h2 class="cta-title animate-on-scroll">Prêt à Commencer Votre Recherche ?</h2>
        <p class="cta-text animate-on-scroll">
            Rejoignez des milliers d'étudiants qui ont déjà trouvé leur logement idéal
        </p>
        <div class="animate-on-scroll">
            <c:choose>
                <c:when test="${sessionScope.utilisateur != null}">
                    <a href="${pageContext.request.contextPath}/annonce?action=list"
                       class="btn btn-hero btn-primary-custom me-3">
                        <i class="fas fa-rocket"></i> Découvrir les Annonces
                    </a>
                    <c:if test="${sessionScope.utilisateur.role == 'PROPRIETAIRE'}">
                        <a href="${pageContext.request.contextPath}/annonce?action=new"
                           class="btn btn-hero btn-outline-custom">
                            <i class="fas fa-plus-circle"></i> Publier une Annonce
                        </a>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/utilisateur/login"
                       class="btn btn-hero btn-primary-custom me-3">
                        <i class="fas fa-sign-in-alt"></i> Se Connecter
                    </a>
                    <a href="${pageContext.request.contextPath}/utilisateur/login"
                       class="btn btn-hero btn-outline-custom">
                        <i class="fas fa-user-plus"></i> S'inscrire Gratuitement
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="footer">
    <div class="container">
        <div class="row g-4">
            <div class="col-md-4">
                <h4 class="footer-title">
                    <i class="fas fa-home"></i> Location Étudiant
                </h4>
                <p style="color: #a0aec0;">
                    La plateforme de référence pour trouver ou proposer des logements étudiants au Maroc.
                </p>
                <div class="social-links mt-3">
                    <a href="#" class="social-icon"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="social-icon"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="social-icon"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="social-icon"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>
            <div class="col-md-2">
                <h5 class="footer-title">Liens Rapides</h5>
                <ul class="footer-links">
                    <c:choose>
                        <c:when test="${sessionScope.utilisateur != null}">
                            <li><a href="${pageContext.request.contextPath}/annonce?action=list">Annonces</a></li>
                            <li><a href="#features">Fonctionnalités</a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="${pageContext.request.contextPath}/utilisateur/login">Annonces</a></li>
                            <li><a href="${pageContext.request.contextPath}/utilisateur/login">Fonctionnalités</a></li>
                        </c:otherwise>
                    </c:choose>
                    <li><a href="#how-it-works">Comment ça marche</a></li>
                    <li><a href="#">À propos</a></li>
                </ul>
            </div>
            <div class="col-md-3">
                <h5 class="footer-title">Pour les Étudiants</h5>
                <ul class="footer-links">
                    <c:choose>
                        <c:when test="${sessionScope.utilisateur != null}">
                            <li><a href="${pageContext.request.contextPath}/annonce?action=list">Rechercher un logement</a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="${pageContext.request.contextPath}/utilisateur/login">Rechercher un logement</a></li>
                        </c:otherwise>
                    </c:choose>
                    <li><a href="#">Guide du locataire</a></li>
                    <li><a href="#">Conseils pratiques</a></li>
                    <li><a href="#">FAQ Étudiants</a></li>
                </ul>
            </div>
            <div class="col-md-3">
                <h5 class="footer-title">Pour les Propriétaires</h5>
                <ul class="footer-links">
                    <c:choose>
                        <c:when test="${sessionScope.utilisateur != null && sessionScope.utilisateur.role == 'PROPRIETAIRE'}">
                            <li><a href="${pageContext.request.contextPath}/annonce?action=new">Publier une annonce</a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="${pageContext.request.contextPath}/utilisateur/login">Publier une annonce</a></li>
                        </c:otherwise>
                    </c:choose>
                    <li><a href="#">Guide du propriétaire</a></li>
                    <li><a href="#">Tarifs</a></li>
                    <li><a href="#">FAQ Propriétaires</a></li>
                </ul>
            </div>
        </div>
        <hr style="border-color: rgba(255,255,255,0.1); margin: 40px 0 20px;">
        <div class="text-center" style="color: #a0aec0;">
            <p class="mb-0">&copy; 2024 Location Étudiant. Tous droits réservés.</p>
            <p class="mb-0 mt-2">
                <a href="#" style="color: #a0aec0; text-decoration: none;">Mentions légales</a> |
                <a href="#" style="color: #a0aec0; text-decoration: none;">Politique de confidentialité</a> |
                <a href="#" style="color: #a0aec0; text-decoration: none;">CGU</a>
            </p>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Fonction pour afficher l'alerte de connexion
    function showLoginAlert(event) {
        event.preventDefault();

        // Créer une modal Bootstrap
        const modalHTML = `
            <div class="modal fade" id="loginModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;">
                            <h5 class="modal-title">
                                <i class="fas fa-lock"></i> Connexion Requise
                            </h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body text-center py-4">
                            <i class="fas fa-user-lock" style="font-size: 4rem; color: #667eea; margin-bottom: 1.5rem;"></i>
                            <h5 style="color: #2d3748; margin-bottom: 1rem;">Accès Réservé aux Membres</h5>
                            <p style="color: #718096; margin-bottom: 2rem;">
                                Pour accéder aux annonces et fonctionnalités complètes de la plateforme,
                                vous devez d'abord vous connecter ou créer un compte gratuit.
                            </p>
                            <div class="d-grid gap-2">
                                <a href="${pageContext.request.contextPath}/utilisateur/login"
                                   class="btn btn-primary btn-lg"
                                   style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border: none;">
                                    <i class="fas fa-sign-in-alt"></i> Se Connecter
                                </a>
                                <a href="${pageContext.request.contextPath}/utilisateur/inscription"
                                   class="btn btn-outline-secondary btn-lg">
                                    <i class="fas fa-user-plus"></i> Créer un Compte Gratuit
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        `;

        // Supprimer toute modal existante
        const existingModal = document.getElementById('loginModal');
        if (existingModal) {
            existingModal.remove();
        }

        // Ajouter la modal au body
        document.body.insertAdjacentHTML('beforeend', modalHTML);

        // Afficher la modal
        const modal = new bootstrap.Modal(document.getElementById('loginModal'));
        modal.show();

        // Nettoyer après fermeture
        document.getElementById('loginModal').addEventListener('hidden.bs.modal', function() {
            this.remove();
        });
    }

    // Navbar scroll effect
    window.addEventListener('scroll', function() {
        const navbar = document.querySelector('.navbar-custom');
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });

    // Animate on scroll
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animated');
            }
        });
    }, observerOptions);

    document.querySelectorAll('.animate-on-scroll').forEach(element => {
        observer.observe(element);
    });

    // Counter animation
    function animateCounter(element) {
        const target = parseInt(element.getAttribute('data-target'));
        const duration = 2000;
        const increment = target / (duration / 16);
        let current = 0;

        const updateCounter = () => {
            current += increment;
            if (current < target) {
                element.textContent = Math.floor(current);
                requestAnimationFrame(updateCounter);
            } else {
                element.textContent = target + (element.parentElement.querySelector('.stat-label').textContent.includes('%') ? '%' : '+');
            }
        };

        updateCounter();
    }

    // Observe stats section for counter animation
    const statsObserver = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const counters = entry.target.querySelectorAll('.stat-number');
                counters.forEach(counter => {
                    if (counter.textContent === '0') {
                        animateCounter(counter);
                    }
                });
            }
        });
    }, { threshold: 0.5 });

    const statsSection = document.querySelector('.stats-section');
    if (statsSection) {
        statsObserver.observe(statsSection);
    }

    // Smooth scroll for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            const href = this.getAttribute('href');
            if (href !== '#') {
                e.preventDefault();
                const target = document.querySelector(href);
                if (target) {
                    const offsetTop = target.offsetTop - 80;
                    window.scrollTo({
                        top: offsetTop,
                        behavior: 'smooth'
                    });
                }
            }
        });
    });
</script>

</body>
</html>