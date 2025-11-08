<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mes Annonces - Location Étudiant</title>
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

        /* Header Section */
        .page-header {
            background: white;
            border-radius: 20px;
            padding: 40px;
            margin: 30px 0;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            position: relative;
            overflow: hidden;
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 300px;
            height: 300px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            opacity: 0.1;
            border-radius: 50%;
            transform: translate(50%, -50%);
        }

        .page-header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 10px;
        }

        .page-header p {
            color: #718096;
            font-size: 1.1rem;
            margin: 0;
        }

        /* Stats Cards */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.2);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            margin-bottom: 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 5px;
        }

        .stat-label {
            color: #718096;
            font-size: 0.95rem;
            font-weight: 500;
        }

        /* Action Buttons */
        .actions-bar {
            background: white;
            border-radius: 15px;
            padding: 20px 30px;
            margin-bottom: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .btn-create {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 12px 30px;
            border-radius: 50px;
            border: none;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .btn-create:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
            color: white;
        }

        .search-box {
            position: relative;
            flex: 1;
            max-width: 400px;
        }

        .search-box input {
            width: 100%;
            padding: 12px 45px 12px 20px;
            border: 2px solid #e2e8f0;
            border-radius: 50px;
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }

        .search-box input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .search-box i {
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: #a0aec0;
        }

        /* Annonces Grid */
        .annonces-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
        }

        .annonce-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            transition: all 0.4s ease;
            position: relative;
        }

        .annonce-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(102, 126, 234, 0.2);
        }

        .annonce-image {
            width: 100%;
            height: 220px;
            object-fit: cover;
            position: relative;
        }

        .annonce-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .annonce-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            padding: 8px 15px;
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 600;
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }

        .badge-disponible {
            background: rgba(72, 187, 120, 0.95);
            color: white;
        }

        .badge-non-disponible {
            background: rgba(245, 101, 101, 0.95);
            color: white;
        }

        .annonce-content {
            padding: 25px;
        }

        .annonce-title {
            font-size: 1.3rem;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 15px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .annonce-details {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 12px;
            margin-bottom: 20px;
        }

        .detail-item {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #718096;
            font-size: 0.9rem;
        }

        .detail-item i {
            color: #667eea;
            font-size: 1rem;
        }

        .annonce-price {
            font-size: 1.8rem;
            font-weight: 700;
            color: #667eea;
            margin-bottom: 20px;
        }

        .annonce-price span {
            font-size: 0.9rem;
            font-weight: 500;
            color: #718096;
        }

        .annonce-actions {
            display: flex;
            gap: 10px;
            padding-top: 20px;
            border-top: 2px solid #f7fafc;
        }

        .btn-action {
            flex: 1;
            padding: 10px;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .btn-view {
            background: #edf2f7;
            color: #4a5568;
        }

        .btn-view:hover {
            background: #e2e8f0;
            transform: translateY(-2px);
        }

        .btn-edit {
            background: #bee3f8;
            color: #2c5282;
        }

        .btn-edit:hover {
            background: #90cdf4;
            transform: translateY(-2px);
        }

        .btn-toggle {
            background: #feebc8;
            color: #c05621;
        }

        .btn-toggle:hover {
            background: #fbd38d;
            transform: translateY(-2px);
        }

        .btn-delete {
            background: #fed7d7;
            color: #c53030;
        }

        .btn-delete:hover {
            background: #fc8181;
            transform: translateY(-2px);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        .empty-state i {
            font-size: 5rem;
            color: #cbd5e0;
            margin-bottom: 25px;
        }

        .empty-state h3 {
            font-size: 1.8rem;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 15px;
        }

        .empty-state p {
            color: #718096;
            font-size: 1.1rem;
            margin-bottom: 30px;
        }

        /* Alerts */
        .alert-custom {
            border-radius: 15px;
            border: none;
            padding: 20px 25px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        }

        .alert-custom i {
            font-size: 1.5rem;
        }

        .alert-success {
            background: #f0fff4;
            color: #22543d;
        }

        .alert-error {
            background: #fff5f5;
            color: #c53030;
        }

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
            .annonces-grid {
                grid-template-columns: 1fr;
            }

            .stats-container {
                grid-template-columns: 1fr;
            }

            .actions-bar {
                flex-direction: column;
            }

            .search-box {
                max-width: 100%;
            }

            .page-header h1 {
                font-size: 2rem;
            }
        }

        /* Loading Skeleton */
        .skeleton {
            background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
            background-size: 200% 100%;
            animation: loading 1.5s ease-in-out infinite;
        }

        @keyframes loading {
            0% { background-position: 200% 0; }
            100% { background-position: -200% 0; }
        }

        /* Modal Custom */
        .modal-content {
            border-radius: 20px;
            border: none;
        }

        .modal-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 20px 20px 0 0;
            border: none;
        }

        .modal-footer {
            border: none;
            padding: 20px 30px;
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
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/annonce?action=mesAnnonces">
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
            </ul>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container">
    <!-- Page Header -->
    <div class="page-header fade-in">
        <h1><i class="fas fa-briefcase me-3"></i>Mes Annonces</h1>
        <p>Gérez et suivez toutes vos annonces de location</p>
    </div>

    <!-- Alerts -->
    <c:if test="${not empty sessionScope.success}">
        <div class="alert-custom alert-success fade-in" role="alert">
            <i class="fas fa-check-circle"></i>
            <div>
                <strong>Succès !</strong> ${sessionScope.success}
            </div>
            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="success" scope="session"/>
    </c:if>

    <c:if test="${not empty sessionScope.error}">
        <div class="alert-custom alert-error fade-in" role="alert">
            <i class="fas fa-exclamation-circle"></i>
            <div>
                <strong>Erreur !</strong> ${sessionScope.error}
            </div>
            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="error" scope="session"/>
    </c:if>

    <!-- Statistics Cards -->
    <div class="stats-container fade-in">
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-home"></i>
            </div>
            <div class="stat-number">${totalAnnonce != null ? totalAnnonce : 0}</div>
            <div class="stat-label">Total des Annonces</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-check-circle"></i>
            </div>
            <div class="stat-number">${totalAnnonceDisponibles != null ? totalAnnonceDisponibles : 0}</div>
            <div class="stat-label">Annonces Disponibles</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">
                <i class="fas fa-times-circle"></i>
            </div>
            <div class="stat-number">${annoncesNonDisponible != null ? annoncesNonDisponible : 0}</div>
            <div class="stat-label">Non Disponibles</div>
        </div>
    </div>

    <!-- Actions Bar -->
    <div class="actions-bar fade-in">
        <a href="${pageContext.request.contextPath}/annonce?action=new" class="btn-create">
            <i class="fas fa-plus-circle"></i> Créer une Nouvelle Annonce
        </a>
        <div class="search-box">
            <input type="text" id="searchInput" placeholder="Rechercher dans mes annonces..." class="form-control">
            <i class="fas fa-search"></i>
        </div>
    </div>

    <!-- Annonces List -->
    <c:choose>
        <c:when test="${empty annonces}">
            <div class="empty-state fade-in">
                <i class="fas fa-home"></i>
                <h3>Aucune Annonce</h3>
                <p>Vous n'avez pas encore créé d'annonce. Commencez dès maintenant !</p>
                <a href="${pageContext.request.contextPath}/annonce?action=new" class="btn-create">
                    <i class="fas fa-plus-circle"></i> Créer ma Première Annonce
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="annonces-grid" id="annoncesGrid">
                <c:forEach var="annonce" items="${annonces}" varStatus="status">
                    <div class="annonce-card fade-in" style="animation-delay: ${status.index * 0.1}s" data-title="${annonce.titre}" data-ville="${annonce.ville}">
                        <!-- Image -->
                        <div class="annonce-image">
                            <c:choose>
                                <c:when test="${not empty annonce.imageUrl}">
                                    <img src="${annonce.imageUrl}" alt="${annonce.titre}" onerror="this.src='https://via.placeholder.com/400x220/667eea/ffffff?text=Pas+d%27image'">
                                </c:when>
                                <c:otherwise>
                                    <img src="https://via.placeholder.com/400x220/667eea/ffffff?text=Pas+d%27image" alt="Pas d'image">
                                </c:otherwise>
                            </c:choose>
                            <span class="annonce-badge ${annonce.disponible ? 'badge-disponible' : 'badge-non-disponible'}">
                                <i class="fas ${annonce.disponible ? 'fa-check-circle' : 'fa-times-circle'}"></i>
                                ${annonce.disponible ? 'Disponible' : 'Non Disponible'}
                            </span>
                        </div>

                        <!-- Content -->
                        <div class="annonce-content">
                            <h3 class="annonce-title">${annonce.titre}</h3>

                            <div class="annonce-details">
                                <div class="detail-item">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <span>${annonce.ville}</span>
                                </div>
                                <div class="detail-item">
                                    <i class="fas fa-home"></i>
                                    <span>${annonce.type}</span>
                                </div>
                                <div class="detail-item">
                                    <i class="fas fa-ruler-combined"></i>
                                    <span>${annonce.superficie} m²</span>
                                </div>
                                <div class="detail-item">
                                    <i class="fas fa-bed"></i>
                                    <span>${annonce.nbChambres} chambre(s)</span>
                                </div>
                            </div>

                            <div class="annonce-price">
                                <fmt:formatNumber value="${annonce.prix}" type="number" maxFractionDigits="0"/> MAD
                                <span>/mois</span>
                            </div>

                            <!-- Actions -->
                            <div class="annonce-actions">
                                <a href="${pageContext.request.contextPath}/annonce?action=view&id=${annonce.id}"
                                   class="btn-action btn-view" title="Voir les détails">
                                    <i class="fas fa-eye"></i>
                                    <span>Voir</span>
                                </a>
                                <a href="${pageContext.request.contextPath}/annonce?action=edit&id=${annonce.id}"
                                   class="btn-action btn-edit" title="Modifier">
                                    <i class="fas fa-edit"></i>
                                    <span>Modifier</span>
                                </a>
                                <a href="${pageContext.request.contextPath}/annonce?action=toggleDisponibilite&id=${annonce.id}"
                                   class="btn-action btn-toggle" title="Changer la disponibilité"
                                   onclick="return confirm('Voulez-vous vraiment changer la disponibilité de cette annonce ?')">
                                    <i class="fas fa-exchange-alt"></i>
                                </a>
                                <button class="btn-action btn-delete"
                                        onclick="confirmDelete(${annonce.id}, '${annonce.titre}')"
                                        title="Supprimer">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Search functionality
    const searchInput = document.getElementById('searchInput');
    const annoncesGrid = document.getElementById('annoncesGrid');

    if (searchInput && annoncesGrid) {
        searchInput.addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            const cards = annoncesGrid.querySelectorAll('.annonce-card');

            cards.forEach(card => {
                const title = card.getAttribute('data-title').toLowerCase();
                const ville = card.getAttribute('data-ville').toLowerCase();

                if (title.includes(searchTerm) || ville.includes(searchTerm)) {
                    card.style.display = 'block';
                    card.style.animation = 'fadeInUp 0.4s ease-out';
                } else {
                    card.style.display = 'none';
                }
            });

            // Show "no results" message
            const visibleCards = Array.from(cards).filter(card => card.style.display !== 'none');
            if (visibleCards.length === 0 && searchTerm !== '') {
                if (!document.getElementById('noResults')) {
                    const noResults = document.createElement('div');
                    noResults.id = 'noResults';
                    noResults.className = 'empty-state';
                    noResults.innerHTML = `
                        <i class="fas fa-search"></i>
                        <h3>Aucun Résultat</h3>
                        <p>Aucune annonce ne correspond à votre recherche "${searchTerm}"</p>
                    `;
                    annoncesGrid.parentElement.appendChild(noResults);
                }
            } else {
                const noResults = document.getElementById('noResults');
                if (noResults) noResults.remove();
            }
        });
    }

    // Delete confirmation
    function confirmDelete(annonceId, annonceTitle) {
        const deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
        document.getElementById('deleteAnnonceTitle').textContent = annonceTitle;
        document.getElementById('confirmDeleteBtn').href =
            '${pageContext.request.contextPath}/annonce?action=delete&id=' + annonceId;
        deleteModal.show();
    }

    // Auto-dismiss alerts after 5 seconds
    setTimeout(() => {
        const alerts = document.querySelectorAll('.alert-custom');
        alerts.forEach(alert => {
            const bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        });
    }, 5000);

    // Add fade-in animation to cards on scroll
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

    document.querySelectorAll('.annonce-card').forEach(card => {
        card.style.opacity = '0';
        card.style.transform = 'translateY(30px)';
        card.style.transition = 'all 0.6s ease';
        observer.observe(card);
    });

    // Smooth scroll
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

    // Image lazy loading with fade effect
    document.querySelectorAll('.annonce-image img').forEach(img => {
        img.addEventListener('load', function() {
            this.style.opacity = '0';
            this.style.transition = 'opacity 0.5s ease';
            setTimeout(() => {
                this.style.opacity = '1';
            }, 100);
        });
    });

    // Tooltip initialization
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[title]'));
    tooltipTriggerList.forEach(function (tooltipTriggerEl) {
        new bootstrap.Tooltip(tooltipTriggerEl);
    });

    // Stats counter animation
    function animateCounter(element) {
        const target = parseInt(element.textContent);
        const duration = 1500;
        const increment = target / (duration / 16);
        let current = 0;

        const updateCounter = () => {
            current += increment;
            if (current < target) {
                element.textContent = Math.floor(current);
                requestAnimationFrame(updateCounter);
            } else {
                element.textContent = target;
            }
        };

        updateCounter();
    }

    // Animate stats on page load
    window.addEventListener('load', () => {
        document.querySelectorAll('.stat-number').forEach(counter => {
            animateCounter(counter);
        });
    });

    // Keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        // Ctrl+N or Cmd+N to create new annonce
        if ((e.ctrlKey || e.metaKey) && e.key === 'n') {
            e.preventDefault();
            window.location.href = '${pageContext.request.contextPath}/annonce?action=new';
        }

        // Focus search with Ctrl+F or Cmd+F
        if ((e.ctrlKey || e.metaKey) && e.key === 'f') {
            e.preventDefault();
            searchInput.focus();
        }

        // Escape to clear search
        if (e.key === 'Escape' && document.activeElement === searchInput) {
            searchInput.value = '';
            searchInput.dispatchEvent(new Event('input'));
        }
    });

    // Card hover effects
    document.querySelectorAll('.annonce-card').forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.zIndex = '10';
        });

        card.addEventListener('mouseleave', function() {
            this.style.zIndex = '1';
        });
    });

    // Dynamic background color for stat cards based on value
    document.querySelectorAll('.stat-card').forEach((card, index) => {
        const colors = [
            'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
            'linear-gradient(135deg, #48bb78 0%, #38a169 100%)',
            'linear-gradient(135deg, #f56565 0%, #e53e3e 100%)'
        ];
        card.querySelector('.stat-icon').style.background = colors[index] || colors[0];
    });

    // Print functionality
    function printAnnonces() {
        window.print();
    }

    // Export to CSV (bonus feature)
    function exportToCSV() {
        const cards = document.querySelectorAll('.annonce-card');
        let csv = 'Titre,Ville,Type,Superficie,Chambres,Prix,Disponibilité\n';

        cards.forEach(card => {
            const title = card.querySelector('.annonce-title').textContent.trim();
            const details = card.querySelectorAll('.detail-item span');
            const ville = details[0].textContent.trim();
            const type = details[1].textContent.trim();
            const superficie = details[2].textContent.trim();
            const chambres = details[3].textContent.trim();
            const prix = card.querySelector('.annonce-price').textContent.trim().split(' ')[0];
            const disponible = card.querySelector('.annonce-badge').textContent.trim();

            csv += `"${title}","${ville}","${type}","${superficie}","${chambres}","${prix}","${disponible}"\n`;
        });

        const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
        const link = document.createElement('a');
        const url = URL.createObjectURL(blob);
        link.setAttribute('href', url);
        link.setAttribute('download', 'mes_annonces_' + new Date().toISOString().split('T')[0] + '.csv');
        link.style.visibility = 'hidden';
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    }

    // Add export button dynamically (optional)
    const actionsBar = document.querySelector('.actions-bar');
    if (actionsBar && document.querySelectorAll('.annonce-card').length > 0) {
        const exportBtn = document.createElement('button');
        exportBtn.className = 'btn-create';
        exportBtn.style.background = 'linear-gradient(135deg, #48bb78 0%, #38a169 100%)';
        exportBtn.innerHTML = '<i class="fas fa-download"></i> Exporter CSV';
        exportBtn.onclick = exportToCSV;
        actionsBar.appendChild(exportBtn);
    }

    // Refresh button
    function refreshPage() {
        location.reload();
    }

    // Session storage for search persistence
    if (searchInput) {
        // Load saved search
        const savedSearch = sessionStorage.getItem('annonceSearch');
        if (savedSearch) {
            searchInput.value = savedSearch;
            searchInput.dispatchEvent(new Event('input'));
        }

        // Save search on input
        searchInput.addEventListener('input', function() {
            sessionStorage.setItem('annonceSearch', this.value);
        });
    }

    // Clear session storage on page unload if search is empty
    window.addEventListener('beforeunload', function() {
        if (searchInput && searchInput.value === '') {
            sessionStorage.removeItem('annonceSearch');
        }
    });

    // Copy link functionality
    function copyAnnonceLink(annonceId) {
        const url = window.location.origin + '${pageContext.request.contextPath}/annonce?action=view&id=' + annonceId;
        navigator.clipboard.writeText(url).then(() => {
            // Show temporary notification
            const notification = document.createElement('div');
            notification.className = 'alert-custom alert-success';
            notification.style.position = 'fixed';
            notification.style.top = '20px';
            notification.style.right = '20px';
            notification.style.zIndex = '9999';
            notification.innerHTML = `
                <i class="fas fa-check-circle"></i>
                <div>Lien copié dans le presse-papiers !</div>
            `;
            document.body.appendChild(notification);

            setTimeout(() => {
                notification.style.opacity = '0';
                notification.style.transition = 'opacity 0.5s ease';
                setTimeout(() => notification.remove(), 500);
            }, 2000);
        });
    }

    // Performance monitoring
    console.log('✅ MesAnnonces.jsp chargé avec succès');
    console.log('📊 Nombre d\'annonces affichées:', document.querySelectorAll('.annonce-card').length);

    // Log stats
    const stats = {
        total: '${totalAnnonce != null ? totalAnnonce : 0}',
        disponibles: '${totalAnnonceDisponibles != null ? totalAnnonceDisponibles : 0}',
        nonDisponibles: '${annoncesNonDisponible != null ? annoncesNonDisponible : 0}'
    };
    console.log('📈 Statistiques:', stats);
</script>

<!-- Print Styles -->
<style media="print">
    body {
        background: white;
    }

    .navbar-custom,
    .actions-bar,
    .annonce-actions,
    .page-header::before,
    .btn-close {
        display: none !important;
    }

    .annonce-card {
        break-inside: avoid;
        page-break-inside: avoid;
        box-shadow: none;
        border: 1px solid #e2e8f0;
        margin-bottom: 20px;
    }

    .annonces-grid {
        display: block;
    }

    .page-header {
        box-shadow: none;
        border-bottom: 2px solid #e2e8f0;
    }

    .stat-card {
        box-shadow: none;
        border: 1px solid #e2e8f0;
    }
</style>

<!-- Additional Features Section (Hidden by default) -->
<div id="additionalFeatures" style="display: none;">
    <!-- Filter Panel -->
    <div class="filter-panel" style="background: white; border-radius: 15px; padding: 25px; margin-bottom: 30px; box-shadow: 0 5px 20px rgba(0,0,0,0.08);">
        <h5 style="color: #2d3748; margin-bottom: 20px;">
            <i class="fas fa-filter"></i> Filtres Avancés
        </h5>
        <div class="row g-3">
            <div class="col-md-3">
                <select class="form-select" id="filterStatus">
                    <option value="">Toutes</option>
                    <option value="disponible">Disponibles</option>
                    <option value="non-disponible">Non Disponibles</option>
                </select>
            </div>
            <div class="col-md-3">
                <select class="form-select" id="filterType">
                    <option value="">Tous les types</option>
                    <option value="Studio">Studio</option>
                    <option value="T1">T1</option>
                    <option value="T2">T2</option>
                    <option value="T3">T3</option>
                    <option value="Appartement">Appartement</option>
                    <option value="Chambre">Chambre</option>
                </select>
            </div>
            <div class="col-md-3">
                <select class="form-select" id="filterSort">
                    <option value="recent">Plus récentes</option>
                    <option value="price-asc">Prix croissant</option>
                    <option value="price-desc">Prix décroissant</option>
                    <option value="title">Titre A-Z</option>
                </select>
            </div>
            <div class="col-md-3">
                <button class="btn btn-secondary w-100" onclick="resetFilters()">
                    <i class="fas fa-redo"></i> Réinitialiser
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    // Show filters button (you can add this to actions-bar if needed)
    function toggleFilters() {
        const panel = document.getElementById('additionalFeatures');
        if (panel.style.display === 'none') {
            panel.style.display = 'block';
            panel.style.animation = 'fadeInUp 0.4s ease-out';
        } else {
            panel.style.display = 'none';
        }
    }

    // Filter functionality
    function applyFilters() {
        const status = document.getElementById('filterStatus')?.value;
        const type = document.getElementById('filterType')?.value;
        const cards = document.querySelectorAll('.annonce-card');

        cards.forEach(card => {
            let show = true;

            if (status) {
                const badge = card.querySelector('.annonce-badge');
                const isDisponible = badge.classList.contains('badge-disponible');
                if (status === 'disponible' && !isDisponible) show = false;
                if (status === 'non-disponible' && isDisponible) show = false;
            }

            if (type) {
                const cardType = card.querySelector('.detail-item:nth-child(2) span').textContent.trim();
                if (cardType !== type) show = false;
            }

            card.style.display = show ? 'block' : 'none';
        });
    }

    // Sort functionality
    function sortAnnonces(sortType) {
        const grid = document.getElementById('annoncesGrid');
        const cards = Array.from(grid.querySelectorAll('.annonce-card'));

        cards.sort((a, b) => {
            switch(sortType) {
                case 'price-asc':
                    return parseFloat(a.querySelector('.annonce-price').textContent) -
                        parseFloat(b.querySelector('.annonce-price').textContent);
                case 'price-desc':
                    return parseFloat(b.querySelector('.annonce-price').textContent) -
                        parseFloat(a.querySelector('.annonce-price').textContent);
                case 'title':
                    return a.getAttribute('data-title').localeCompare(b.getAttribute('data-title'));
                default:
                    return 0;
            }
        });

        cards.forEach(card => grid.appendChild(card));
    }

    // Event listeners for filters
    document.getElementById('filterStatus')?.addEventListener('change', applyFilters);
    document.getElementById('filterType')?.addEventListener('change', applyFilters);
    document.getElementById('filterSort')?.addEventListener('change', function() {
        sortAnnonces(this.value);
    });

    function resetFilters() {
        document.getElementById('filterStatus').value = '';
        document.getElementById('filterType').value = '';
        document.getElementById('filterSort').value = 'recent';
        applyFilters();
        location.reload();
    }
</script>

</body>
</html>