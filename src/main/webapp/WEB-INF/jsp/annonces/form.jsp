<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : 'Formulaire Annonce'} - Location Étudiant</title>
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

        .form-container {
            margin-top: 30px;
            margin-bottom: 30px;
        }

        .form-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .form-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px;
            text-align: center;
        }

        .form-header h2 {
            margin: 0;
            font-size: 2rem;
            font-weight: 700;
        }

        .form-header p {
            margin: 10px 0 0;
            opacity: 0.9;
        }

        .form-body {
            padding: 40px;
        }

        .section-title {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 1.3rem;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #e2e8f0;
        }

        .section-title i {
            color: #667eea;
            font-size: 1.5rem;
        }

        .form-label {
            font-weight: 600;
            color: #4a5568;
            margin-bottom: 8px;
        }

        .required:after {
            content: " *";
            color: #e53e3e;
            font-weight: bold;
        }

        .form-control, .form-select {
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            padding: 12px 15px;
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .form-control::placeholder {
            color: #cbd5e0;
        }

        textarea.form-control {
            resize: vertical;
            min-height: 120px;
        }

        .input-group-text {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            font-weight: 600;
        }

        .btn-submit {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 40px;
            border-radius: 50px;
            border: none;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-cancel {
            padding: 15px 40px;
            border-radius: 50px;
            border: 2px solid #e2e8f0;
            background: white;
            color: #4a5568;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
        }

        .btn-cancel:hover {
            background: #f7fafc;
            border-color: #cbd5e0;
        }

        .form-text {
            color: #718096;
            font-size: 0.85rem;
            margin-top: 5px;
        }

        .field-error {
            color: #e53e3e;
            font-size: 0.85rem;
            margin-top: 5px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .alert {
            border-radius: 15px;
            border: none;
            padding: 15px 20px;
            margin-bottom: 25px;
        }

        .alert-danger {
            background: #fff5f5;
            color: #c53030;
        }

        .alert-success {
            background: #f0fff4;
            color: #22543d;
        }

        .navbar-custom {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .navbar-custom .navbar-brand,
        .navbar-custom .nav-link {
            color: white !important;
            font-weight: 500;
        }

        .navbar-custom .nav-link:hover {
            opacity: 0.8;
        }

        .progress-indicator {
            display: flex;
            justify-content: space-between;
            margin-bottom: 40px;
            padding: 0 20px;
        }

        .progress-step {
            flex: 1;
            text-align: center;
            position: relative;
        }

        .progress-step:not(:last-child)::after {
            content: '';
            position: absolute;
            top: 20px;
            left: 50%;
            width: 100%;
            height: 2px;
            background: #e2e8f0;
            z-index: 0;
        }

        .progress-step.active:not(:last-child)::after {
            background: #667eea;
        }

        .progress-circle {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #e2e8f0;
            color: #a0aec0;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            position: relative;
            z-index: 1;
            transition: all 0.3s ease;
        }

        .progress-step.active .progress-circle {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            transform: scale(1.1);
        }

        .progress-label {
            display: block;
            margin-top: 8px;
            font-size: 0.85rem;
            color: #718096;
            font-weight: 500;
        }

        .progress-step.active .progress-label {
            color: #667eea;
            font-weight: 600;
        }

        .image-preview {
            margin-top: 15px;
            display: none;
        }

        .image-preview img {
            max-width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .char-counter {
            text-align: right;
            font-size: 0.85rem;
            color: #718096;
            margin-top: 5px;
        }

        .equipements-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 10px;
        }

        .equipement-tag {
            background: #edf2f7;
            color: #4a5568;
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
            display: inline-flex;
            align-items: center;
            gap: 8px;
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
                        <i class="fas fa-list"></i> Annonces
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/annonce?action=MesAnnonces">
                        <i class="fas fa-briefcase"></i> Mes Annonces
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

<!-- Contenu principal -->
<div class="container form-container">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="form-card">
                <!-- En-tête du formulaire -->
                <div class="form-header">
                    <c:choose>
                        <c:when test="${action == 'create'}">
                            <i class="fas fa-plus-circle fa-3x mb-3"></i>
                            <h2>Créer une Nouvelle Annonce</h2>
                            <p>Publiez votre logement et trouvez le locataire idéal</p>
                        </c:when>
                        <c:otherwise>
                            <i class="fas fa-edit fa-3x mb-3"></i>
                            <h2>Modifier l'Annonce</h2>
                            <p>Mettez à jour les informations de votre annonce</p>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="form-body">
                    <!-- Messages d'erreur -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-circle me-2"></i>
                            <strong>Erreur !</strong> ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <!-- Indicateur de progression -->
                    <div class="progress-indicator">
                        <div class="progress-step active" data-step="1">
                            <span class="progress-circle">1</span>
                            <span class="progress-label">Informations</span>
                        </div>
                        <div class="progress-step" data-step="2">
                            <span class="progress-circle">2</span>
                            <span class="progress-label">Localisation</span>
                        </div>
                        <div class="progress-step" data-step="3">
                            <span class="progress-circle">3</span>
                            <span class="progress-label">Caractéristiques</span>
                        </div>
                        <div class="progress-step" data-step="4">
                            <span class="progress-circle">4</span>
                            <span class="progress-label">Contact</span>
                        </div>
                    </div>

                    <!-- Formulaire -->
                    <form action="${pageContext.request.contextPath}/annonce" method="post" id="annonceForm">
                        <input type="hidden" name="action" value="${action}">
                        <c:if test="${action == 'update'}">
                            <input type="hidden" name="id" value="${annonce.id}">
                        </c:if>

                        <!-- Section 1: Informations générales -->
                        <div class="form-section" data-section="1">
                            <h5 class="section-title">
                                <i class="fas fa-info-circle"></i>
                                Informations Générales
                            </h5>

                            <div class="mb-4">
                                <label for="titre" class="form-label required">Titre de l'annonce</label>
                                <input type="text" class="form-control" id="titre" name="titre"
                                       value="${annonce.titre}" required maxlength="200"
                                       placeholder="Ex: Studio meublé proche université Mohamed V">
                                <div class="char-counter">
                                    <span id="titreCount">0</span>/200 caractères
                                </div>
                            </div>

                            <div class="mb-4">
                                <label for="description" class="form-label required">Description détaillée</label>
                                <textarea class="form-control" id="description" name="description"
                                          rows="6" required
                                          placeholder="Décrivez votre bien : équipements, état, proximité transports, commerces...">${annonce.description}</textarea>
                                <div class="char-counter">
                                    <span id="descCount">0</span> caractères (minimum 20)
                                </div>
                                <small class="form-text">
                                    <i class="fas fa-lightbulb"></i>
                                    Conseil : Plus votre description est détaillée, plus vous aurez de chances d'attirer des locataires
                                </small>
                            </div>
                        </div>

                        <!-- Section 2: Localisation -->
                        <div class="form-section" data-section="2">
                            <h5 class="section-title">
                                <i class="fas fa-map-marker-alt"></i>
                                Localisation
                            </h5>

                            <div class="row mb-4">
                                <div class="col-md-8">
                                    <label for="adresse" class="form-label required">Adresse complète</label>
                                    <input type="text" class="form-control" id="adresse" name="adresse"
                                           value="${annonce.adresse}" required
                                           placeholder="Numéro, rue, quartier">
                                    <small class="form-text">
                                        <i class="fas fa-info-circle"></i>
                                        L'adresse exacte ne sera visible qu'après contact
                                    </small>
                                </div>
                                <div class="col-md-4">
                                    <label for="ville" class="form-label required">Ville</label>
                                    <input type="text" class="form-control" id="ville" name="ville"
                                           value="${annonce.ville}" required
                                           placeholder="Ex: Casablanca"
                                           list="villesList">
                                    <datalist id="villesList">
                                        <option value="Casablanca">
                                        <option value="Rabat">
                                        <option value="Marrakech">
                                        <option value="Fès">
                                        <option value="Tanger">
                                        <option value="Agadir">
                                        <option value="Meknès">
                                        <option value="Oujda">
                                        <option value="Kenitra">
                                        <option value="Tétouan">
                                    </datalist>
                                </div>
                            </div>
                        </div>

                        <!-- Section 3: Caractéristiques -->
                        <div class="form-section" data-section="3">
                            <h5 class="section-title">
                                <i class="fas fa-home"></i>
                                Caractéristiques du Logement
                            </h5>

                            <div class="row mb-4">
                                <div class="col-md-4">
                                    <label for="type" class="form-label required">Type de logement</label>
                                    <select class="form-select" id="type" name="type" required>
                                        <option value="">Sélectionner...</option>
                                        <option value="Studio" ${annonce.type == 'Studio' ? 'selected' : ''}>Studio</option>
                                        <option value="T1" ${annonce.type == 'T1' ? 'selected' : ''}>T1 (1 pièce)</option>
                                        <option value="T2" ${annonce.type == 'T2' ? 'selected' : ''}>T2 (2 pièces)</option>
                                        <option value="T3" ${annonce.type == 'T3' ? 'selected' : ''}>T3 (3 pièces)</option>
                                        <option value="Appartement" ${annonce.type == 'Appartement' ? 'selected' : ''}>Appartement</option>
                                        <option value="Chambre" ${annonce.type == 'Chambre' ? 'selected' : ''}>Chambre individuelle</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label for="superficie" class="form-label required">Superficie (m²)</label>
                                    <input type="number" class="form-control" id="superficie" name="superficie"
                                           value="${annonce.superficie}" required min="1" max="500"
                                           placeholder="50">
                                </div>
                                <div class="col-md-4">
                                    <label for="nbChambres" class="form-label required">Nombre de chambres</label>
                                    <input type="number" class="form-control" id="nbChambres" name="nbChambres"
                                           value="${annonce.nbChambres}" required min="0" max="10"
                                           placeholder="2">
                                </div>
                            </div>

                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <label for="prix" class="form-label required">Loyer mensuel</label>
                                    <div class="input-group">
                                        <input type="number" class="form-control" id="prix" name="prix"
                                               value="${annonce.prix}" required min="0" step="0.01"
                                               placeholder="2500">
                                        <span class="input-group-text">MAD</span>
                                    </div>
                                    <small class="form-text">
                                        <i class="fas fa-info-circle"></i>
                                        Charges incluses ou non ? Précisez-le dans la description
                                    </small>
                                </div>
                                <div class="col-md-6">
                                    <label for="imageUrl" class="form-label">URL de l'image principale</label>
                                    <input type="url" class="form-control" id="imageUrl" name="imageUrl"
                                           value="${annonce.imageUrl}"
                                           placeholder="https://exemple.com/image.jpg">
                                    <small class="form-text">
                                        <i class="fas fa-camera"></i>
                                        Lien vers une photo de qualité (optionnel)
                                    </small>
                                    <div class="image-preview" id="imagePreview">
                                        <img src="" alt="Aperçu" id="previewImg">
                                    </div>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label for="equipements" class="form-label">Équipements et commodités</label>
                                <input type="text" class="form-control" id="equipements" name="equipements"
                                       value="${annonce.equipements}"
                                       placeholder="WiFi, Meublé, Parking, Cuisine équipée, Climatisation">
                                <small class="form-text">
                                    <i class="fas fa-wrench"></i>
                                    Séparez les équipements par des virgules
                                </small>
                                <div class="equipements-tags" id="equipementsTags"></div>
                            </div>
                        </div>

                        <!-- Section 4: Contact -->
                        <div class="form-section" data-section="4">
                            <h5 class="section-title">
                                <i class="fas fa-phone"></i>
                                Informations de Contact
                            </h5>

                            <div class="row mb-4">
                                <div class="col-md-6">
                                    <label for="contactEmail" class="form-label">Email de contact</label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="fas fa-envelope"></i>
                                        </span>
                                        <input type="email" class="form-control" id="contactEmail" name="contactEmail"
                                               value="${annonce.contactEmail != null ? annonce.contactEmail : sessionScope.utilisateur.email}"
                                               placeholder="contact@email.com">
                                    </div>
                                    <small class="form-text">
                                        <i class="fas fa-info-circle"></i>
                                        Laissez vide pour utiliser votre email (${sessionScope.utilisateur.email})
                                    </small>
                                </div>
                                <div class="col-md-6">
                                    <label for="contactTelephone" class="form-label">Numéro de téléphone</label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="fas fa-phone"></i>
                                        </span>
                                        <input type="tel" class="form-control" id="contactTelephone" name="contactTelephone"
                                               value="${annonce.contactTelephone}"
                                               placeholder="0612345678">
                                    </div>
                                    <small class="form-text">
                                        <i class="fas fa-info-circle"></i>
                                        Format: 10 chiffres sans espaces (optionnel)
                                    </small>
                                </div>
                            </div>

                            <div class="alert alert-info">
                                <i class="fas fa-shield-alt me-2"></i>
                                <strong>Confidentialité :</strong> Vos coordonnées ne seront visibles que par les utilisateurs intéressés par votre annonce.
                            </div>
                        </div>

                        <!-- Boutons d'action -->
                        <div class="d-flex justify-content-between align-items-center mt-5 pt-4 border-top">
                            <a href="${pageContext.request.contextPath}/annonce?action=mesAnnonces"
                               class="btn btn-cancel">
                                <i class="fas fa-times"></i> Annuler
                            </a>
                            <button type="submit" class="btn btn-submit">
                                <c:choose>
                                    <c:when test="${action == 'create'}">
                                        <i class="fas fa-plus-circle"></i> Créer l'Annonce
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-save"></i> Enregistrer les Modifications
                                    </c:otherwise>
                                </c:choose>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Character counters
    const titreInput = document.getElementById('titre');
    const descInput = document.getElementById('description');
    const titreCount = document.getElementById('titreCount');
    const descCount = document.getElementById('descCount');

    function updateCharCount() {
        if (titreInput && titreCount) {
            titreCount.textContent = titreInput.value.length;
        }
        if (descInput && descCount) {
            descCount.textContent = descInput.value.length;
        }
    }

    titreInput?.addEventListener('input', updateCharCount);
    descInput?.addEventListener('input', updateCharCount);
    updateCharCount();

    // Image preview
    const imageUrlInput = document.getElementById('imageUrl');
    const imagePreview = document.getElementById('imagePreview');
    const previewImg = document.getElementById('previewImg');

    imageUrlInput?.addEventListener('blur', function() {
        const url = this.value.trim();
        if (url) {
            previewImg.src = url;
            previewImg.onerror = function() {
                imagePreview.style.display = 'none';
            };
            previewImg.onload = function() {
                imagePreview.style.display = 'block';
            };
        } else {
            imagePreview.style.display = 'none';
        }
    });

    // Equipements tags display
    const equipementsInput = document.getElementById('equipements');
    const equipementsTags = document.getElementById('equipementsTags');

    function updateEquipementsTags() {
        const value = equipementsInput.value.trim();
        if (value) {
            const items = value.split(',').map(item => item.trim()).filter(item => item);
            equipementsTags.innerHTML = items.map(item =>
                `<span class="equipement-tag">
                    <i class="fas fa-check-circle"></i> ${item}
                </span>`
            ).join('');
            equipementsTags.style.display = items.length > 0 ? 'flex' : 'none';
        } else {
            equipementsTags.innerHTML = '';
            equipementsTags.style.display = 'none';
        }
    }

    equipementsInput?.addEventListener('input', updateEquipementsTags);
    updateEquipementsTags();

    // ============ CORRECTED FORM VALIDATION ============
    document.getElementById('annonceForm').addEventListener('submit', function(event) {
        const titre = document.getElementById('titre').value.trim();
        const description = document.getElementById('description').value.trim();
        const adresse = document.getElementById('adresse').value.trim();
        const ville = document.getElementById('ville').value.trim();
        const type = document.getElementById('type').value;
        const prix = parseFloat(document.getElementById('prix').value);
        const superficie = parseInt(document.getElementById('superficie').value);
        const nbChambres = parseInt(document.getElementById('nbChambres').value);

        let errors = [];

        // Validation du titre
        if (!titre || titre.length < 5) {
            errors.push('Le titre doit contenir au moins 5 caractères');
        }

        // Validation de la description
        if (!description || description.length < 20) {
            errors.push('La description doit contenir au moins 20 caractères');
        }

        // Validation de l'adresse
        if (!adresse || adresse.length < 5) {
            errors.push('L\'adresse doit contenir au moins 5 caractères');
        }

        // Validation de la ville
        if (!ville || ville.length < 2) {
            errors.push('Veuillez saisir une ville valide');
        }

        // Validation du type
        if (!type) {
            errors.push('Veuillez sélectionner un type de logement');
        }

        // Validation du prix
        if (isNaN(prix) || prix <= 0) {
            errors.push('Le prix doit être un nombre supérieur à 0');
        }

        // Validation de la superficie
        if (isNaN(superficie) || superficie <= 0 || superficie > 500) {
            errors.push('La superficie doit être entre 1 et 500 m²');
        }

        // Validation du nombre de chambres
        if (isNaN(nbChambres) || nbChambres < 0 || nbChambres > 10) {
            errors.push('Le nombre de chambres doit être entre 0 et 10');
        }

        // Validation du téléphone UNIQUEMENT s'il est renseigné
        const telephone = document.getElementById('contactTelephone').value.trim();
        if (telephone) {
            // Remove all non-digit characters
            const cleanedPhone = telephone.replace(/\D/g, '');
            if (cleanedPhone.length !== 10) {
                errors.push('Le numéro de téléphone doit contenir exactement 10 chiffres (actuellement: ' + cleanedPhone.length + ' chiffres)');
            }
        }

        // Validation de l'email UNIQUEMENT s'il est renseigné
        const email = document.getElementById('contactEmail').value.trim();
        if (email) {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                errors.push('L\'adresse email n\'est pas valide');
            }
        }

        // Validation de l'URL d'image UNIQUEMENT si renseignée
        const imageUrl = document.getElementById('imageUrl').value.trim();
        if (imageUrl) {
            try {
                new URL(imageUrl);
            } catch (e) {
                errors.push('L\'URL de l\'image n\'est pas valide');
            }
        }

        // Afficher les erreurs si présentes
        if (errors.length > 0) {
            event.preventDefault();

            // Create a more user-friendly error message
            let errorMessage = '⚠️ Veuillez corriger les erreurs suivantes :\n\n';
            errors.forEach((err, idx) => {
                errorMessage += `${idx + 1}. ${err}\n`;
            });
            errorMessage += '\n💡 Vérifiez tous les champs obligatoires marqués d\'un astérisque (*)';

            alert(errorMessage);

            // Scroll to first error
            const firstErrorField = getFirstErrorField();
            if (firstErrorField) {
                firstErrorField.focus();
                firstErrorField.scrollIntoView({ behavior: 'smooth', block: 'center' });
                firstErrorField.style.borderColor = '#e53e3e';
                firstErrorField.style.borderWidth = '2px';
            }

            return false;
        }

        return true;
    });

    // Helper function to find the first field with an error
    function getFirstErrorField() {
        const titre = document.getElementById('titre').value.trim();
        const description = document.getElementById('description').value.trim();
        const adresse = document.getElementById('adresse').value.trim();
        const ville = document.getElementById('ville').value.trim();
        const type = document.getElementById('type').value;
        const prix = parseFloat(document.getElementById('prix').value);
        const superficie = parseInt(document.getElementById('superficie').value);
        const nbChambres = parseInt(document.getElementById('nbChambres').value);

        if (!titre || titre.length < 5) return document.getElementById('titre');
        if (!description || description.length < 20) return document.getElementById('description');
        if (!adresse || adresse.length < 5) return document.getElementById('adresse');
        if (!ville || ville.length < 2) return document.getElementById('ville');
        if (!type) return document.getElementById('type');
        if (isNaN(prix) || prix <= 0) return document.getElementById('prix');
        if (isNaN(superficie) || superficie <= 0) return document.getElementById('superficie');
        if (isNaN(nbChambres) || nbChambres < 0) return document.getElementById('nbChambres');

        return null;
    }

    // Auto-format phone number - only keep digits
    const phoneInput = document.getElementById('contactTelephone');
    phoneInput?.addEventListener('input', function(e) {
        // Only keep digits
        let value = e.target.value.replace(/\D/g, '');
        if (value.length > 10) {
            value = value.substring(0, 10);
        }
        e.target.value = value;
    });

    // Add real-time validation feedback
    document.querySelectorAll('[required]').forEach(input => {
        input.addEventListener('blur', function() {
            validateField(this);
        });

        input.addEventListener('input', function() {
            // Only re-validate if field was marked as error
            if (this.style.borderColor === 'rgb(252, 129, 129)' || this.style.borderColor === '#fc8181') {
                validateField(this);
            }
        });
    });

    function validateField(field) {
        const value = field.value.trim();
        let isValid = true;
        let errorMsg = '';

        switch(field.id) {
            case 'titre':
                isValid = value.length >= 5;
                errorMsg = 'Minimum 5 caractères';
                break;
            case 'description':
                isValid = value.length >= 20;
                errorMsg = 'Minimum 20 caractères';
                break;
            case 'adresse':
                isValid = value.length >= 5;
                errorMsg = 'Minimum 5 caractères';
                break;
            case 'ville':
                isValid = value.length >= 2;
                errorMsg = 'Ville requise';
                break;
            case 'type':
                isValid = value !== '';
                errorMsg = 'Type requis';
                break;
            case 'prix':
                isValid = !isNaN(parseFloat(value)) && parseFloat(value) > 0;
                errorMsg = 'Prix invalide';
                break;
            case 'superficie':
                isValid = !isNaN(parseInt(value)) && parseInt(value) > 0 && parseInt(value) <= 500;
                errorMsg = 'Entre 1 et 500 m²';
                break;
            case 'nbChambres':
                isValid = !isNaN(parseInt(value)) && parseInt(value) >= 0 && parseInt(value) <= 10;
                errorMsg = 'Entre 0 et 10';
                break;
        }

        if (!isValid && field.hasAttribute('required')) {
            field.style.borderColor = '#fc8181';
            field.style.borderWidth = '2px';
            showFieldError(field, errorMsg);
        } else {
            field.style.borderColor = '#48bb78';
            field.style.borderWidth = '2px';
            hideFieldError(field);
            // Reset border after animation
            setTimeout(() => {
                if (field.style.borderColor === 'rgb(72, 187, 120)') {
                    field.style.borderColor = '';
                    field.style.borderWidth = '';
                }
            }, 2000);
        }
    }

    function showFieldError(field, message) {
        let errorDiv = field.parentElement.querySelector('.field-error');
        if (!errorDiv) {
            errorDiv = document.createElement('div');
            errorDiv.className = 'field-error';
            field.parentElement.appendChild(errorDiv);
        }
        errorDiv.innerHTML = '<i class="fas fa-exclamation-circle"></i> ' + message;
    }

    function hideFieldError(field) {
        const errorDiv = field.parentElement.querySelector('.field-error');
        if (errorDiv) {
            errorDiv.remove();
        }
    }

    // Progress indicator based on scroll
    window.addEventListener('scroll', function() {
        const sections = document.querySelectorAll('.form-section');
        const progressSteps = document.querySelectorAll('.progress-step');

        let currentSection = 1;
        sections.forEach((section, index) => {
            const rect = section.getBoundingClientRect();
            if (rect.top <= 200 && rect.bottom >= 200) {
                currentSection = index + 1;
            }
        });

        progressSteps.forEach((step, index) => {
            if (index + 1 <= currentSection) {
                step.classList.add('active');
            } else {
                step.classList.remove('active');
            }
        });
    });

    // Smooth scroll to sections when clicking progress steps
    document.querySelectorAll('.progress-step').forEach(step => {
        step.addEventListener('click', function() {
            const sectionNumber = this.getAttribute('data-step');
            const targetSection = document.querySelector(`.form-section[data-section="${sectionNumber}"]`);
            if (targetSection) {
                const offset = 100;
                const elementPosition = targetSection.getBoundingClientRect().top;
                const offsetPosition = elementPosition + window.pageYOffset - offset;

                window.scrollTo({
                    top: offsetPosition,
                    behavior: 'smooth'
                });
            }
        });
    });

    // Price formatting
    const prixInput = document.getElementById('prix');
    prixInput?.addEventListener('blur', function() {
        if (this.value) {
            const value = parseFloat(this.value);
            if (!isNaN(value) && value > 0) {
                this.value = value.toFixed(2);
            }
        }
    });

    // Superficie suggestions based on type
    const typeSelect = document.getElementById('type');
    const superficieInput = document.getElementById('superficie');

    typeSelect?.addEventListener('change', function() {
        const suggestions = {
            'Studio': 25,
            'T1': 35,
            'T2': 50,
            'T3': 70,
            'Chambre': 15,
            'Appartement': 60
        };

        if (!superficieInput.value && suggestions[this.value]) {
            superficieInput.value = suggestions[this.value];
            superficieInput.style.borderColor = '#667eea';
            setTimeout(() => {
                superficieInput.style.borderColor = '';
            }, 2000);
        }
    });

    // Keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        // Ctrl+S or Cmd+S to save
        if ((e.ctrlKey || e.metaKey) && e.key === 's') {
            e.preventDefault();
            document.querySelector('.btn-submit').click();
        }

        // Escape to cancel
        if (e.key === 'Escape') {
            const cancelBtn = document.querySelector('.btn-cancel');
            if (confirm('Voulez-vous vraiment annuler ? Les modifications non enregistrées seront perdues.')) {
                window.location.href = cancelBtn.href;
            }
        }
    });

    // Warn user before leaving if form has changes
    let formChanged = false;
    const formInputs = document.querySelectorAll('#annonceForm input, #annonceForm textarea, #annonceForm select');

    formInputs.forEach(input => {
        if (input.type !== 'hidden') {
            input.addEventListener('change', function() {
                formChanged = true;
            });
        }
    });

    window.addEventListener('beforeunload', function(e) {
        if (formChanged) {
            e.preventDefault();
            e.returnValue = '';
            return '';
        }
    });

    // Remove warning on submit
    document.getElementById('annonceForm').addEventListener('submit', function() {
        formChanged = false;
    });

    // Add animation to form sections
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -100px 0px'
    };

    const sectionObserver = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);

    document.querySelectorAll('.form-section').forEach(section => {
        section.style.opacity = '0';
        section.style.transform = 'translateY(30px)';
        section.style.transition = 'all 0.6s ease';
        sectionObserver.observe(section);
    });

    // Initialize on page load
    if (imageUrlInput?.value) {
        imageUrlInput.dispatchEvent(new Event('blur'));
    }

    // Tooltip for help icons
    const helpIcons = document.querySelectorAll('.form-text i.fa-info-circle, .form-text i.fa-lightbulb');
    helpIcons.forEach(icon => {
        icon.style.cursor = 'help';
        icon.title = 'Cliquez pour plus d\'informations';
    });


</script>
</body>
</html>