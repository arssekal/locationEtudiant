<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nouveau message - Messagerie</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
        }

        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .message-container {
            max-width: 900px;
            margin: 0 auto;
        }

        .message-header {
            margin-bottom: 20px;
        }

        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            text-decoration: none;
            border-radius: 10px;
            font-weight: 500;
            transition: all 0.3s ease;
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .btn-back:hover {
            background: rgba(255, 255, 255, 0.3);
            color: white;
            transform: translateX(-5px);
        }

        .compose-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            padding: 40px;
            animation: slideUp 0.5s ease;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .compose-card h2 {
            margin-top: 0;
            color: #2d3748;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            gap: 15px;
            font-size: 1.8rem;
        }

        .compose-card h2 i {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-label {
            display: block;
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 8px;
            font-size: 0.95rem;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            font-size: 0.95rem;
            font-family: inherit;
            box-sizing: border-box;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
        }

        textarea.form-control {
            min-height: 200px;
            resize: vertical;
            font-family: inherit;
        }

        .form-control[readonly] {
            background-color: #f7fafc;
            cursor: not-allowed;
            color: #4a5568;
        }

        .form-actions {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn-send {
            flex: 1;
            padding: 14px 30px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-send:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.6);
        }

        .btn-send:active {
            transform: translateY(0);
        }

        .btn-cancel {
            padding: 14px 30px;
            background: #e2e8f0;
            color: #4a5568;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-size: 1rem;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-cancel:hover {
            background: #cbd5e0;
            color: #2d3748;
            text-decoration: none;
        }

        .alert {
            padding: 15px 20px;
            margin-bottom: 25px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            gap: 12px;
            animation: slideDown 0.3s ease;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .alert-danger {
            background: #fff5f5;
            color: #c53030;
            border: 1px solid #fc8181;
        }

        .alert-danger i {
            font-size: 1.3rem;
        }

        .annonce-info {
            background: linear-gradient(135deg, #e6f2ff 0%, #f0f7ff 100%);
            border-left: 4px solid #667eea;
            padding: 20px;
            margin-bottom: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(102, 126, 234, 0.1);
        }

        .annonce-info h4 {
            margin: 0 0 10px 0;
            color: #667eea;
            font-size: 1rem;
            font-weight: 600;
        }

        .annonce-info strong {
            color: #2d3748;
            font-size: 1.1rem;
        }

        .required {
            color: #e53e3e;
            margin-left: 3px;
        }

        .char-counter {
            text-align: right;
            font-size: 0.85rem;
            color: #718096;
            margin-top: 5px;
        }

        .form-help {
            font-size: 0.85rem;
            color: #718096;
            margin-top: 5px;
        }

        .destinataire-info {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px;
            background: #f7fafc;
            border-radius: 8px;
            margin-top: 8px;
        }

        .destinataire-info i {
            color: #667eea;
            font-size: 1.2rem;
        }

        .destinataire-info .info {
            flex: 1;
        }

        .destinataire-info .name {
            font-weight: 600;
            color: #2d3748;
        }

        .destinataire-info .email {
            font-size: 0.85rem;
            color: #718096;
        }

        @media (max-width: 768px) {
            body {
                padding: 10px;
            }

            .compose-card {
                padding: 25px;
            }

            .compose-card h2 {
                font-size: 1.5rem;
            }

            .form-actions {
                flex-direction: column;
            }

            .btn-send, .btn-cancel {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<div class="message-container">
    <div class="message-header">
        <a href="${pageContext.request.contextPath}/message?action=inbox" class="btn-back">
            <i class="fas fa-arrow-left"></i> Retour à la messagerie
        </a>
    </div>

    <!-- Message d'erreur -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle"></i>
            <span>${error}</span>
        </div>
    </c:if>

    <div class="compose-card">
        <h2>
            <i class="fas fa-paper-plane"></i>
            Nouveau message
        </h2>

        <!-- Information sur l'annonce si existe -->
        <c:if test="${not empty annonce}">
            <div class="annonce-info">
                <h4><i class="fas fa-home"></i> Concernant l'annonce :</h4>
                <strong>${annonce.titre}</strong>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/message?action=sent" method="post" id="composeForm">
            <!-- Destinataire -->
            <div class="form-group">
                <label class="form-label">
                    <i class="fas fa-user"></i> Destinataire <span class="required">*</span>
                </label>
                <c:choose>
                    <c:when test="${not empty destinataire}">
                        <div class="destinataire-info">
                            <i class="fas fa-user-circle"></i>
                            <div class="info">
                                <div class="name">${destinataire.nom} ${destinataire.prenom}</div>
                                <div class="email">${destinataire.email}</div>
                            </div>
                        </div>
                        <input type="hidden" name="destinataireId" value="${destinataire.id}">
                    </c:when>
                    <c:otherwise>
                        <input type="number"
                               class="form-control"
                               name="destinataireId"
                               placeholder="ID du destinataire"
                               required
                               value="${not empty param.destinataireId ? param.destinataireId : ''}">
                        <div class="form-help">
                            <i class="fas fa-info-circle"></i> Entrez l'ID de l'utilisateur destinataire
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Sujet -->
            <div class="form-group">
                <label class="form-label">
                    <i class="fas fa-tag"></i> Sujet <span class="required">*</span>
                </label>
                <input type="text"
                       class="form-control"
                       name="sujet"
                       placeholder="Objet de votre message"
                       required
                       maxlength="200"
                       value="${not empty param.sujet ? param.sujet : ''}"
                       id="sujetInput">
                <div class="char-counter">
                    <span id="sujetCounter">0</span> / 200 caractères
                </div>
            </div>

            <!-- Contenu -->
            <div class="form-group">
                <label class="form-label">
                    <i class="fas fa-align-left"></i> Message <span class="required">*</span>
                </label>
                <textarea class="form-control"
                          name="contenu"
                          placeholder="Écrivez votre message ici..."
                          required
                          maxlength="2000"
                          id="contenuInput">${not empty param.contenu ? param.contenu : ''}</textarea>
                <div class="char-counter">
                    <span id="contenuCounter">0</span> / 2000 caractères
                </div>
            </div>

            <!-- ID de l'annonce si existe -->
            <c:if test="${not empty annonce}">
                <input type="hidden" name="annonceId" value="${annonce.id}">
            </c:if>

            <!-- Actions -->
            <div class="form-actions">
                <button type="submit" class="btn-send">
                    <i class="fas fa-paper-plane"></i> Envoyer le message
                </button>
                <a href="${pageContext.request.contextPath}/message?action=inbox" class="btn-cancel">
                    <i class="fas fa-times"></i> Annuler
                </a>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Compteur de caractères pour le sujet
    const sujetInput = document.getElementById('sujetInput');
    const sujetCounter = document.getElementById('sujetCounter');

    if (sujetInput) {
        // Initialiser le compteur
        sujetCounter.textContent = sujetInput.value.length;

        sujetInput.addEventListener('input', function() {
            sujetCounter.textContent = this.value.length;

            // Changer la couleur si proche de la limite
            if (this.value.length > 180) {
                sujetCounter.style.color = '#e53e3e';
            } else {
                sujetCounter.style.color = '#718096';
            }
        });
    }

    // Compteur de caractères pour le contenu
    const contenuInput = document.getElementById('contenuInput');
    const contenuCounter = document.getElementById('contenuCounter');

    if (contenuInput) {
        // Initialiser le compteur
        contenuCounter.textContent = contenuInput.value.length;

        contenuInput.addEventListener('input', function() {
            contenuCounter.textContent = this.value.length;

            // Changer la couleur si proche de la limite
            if (this.value.length > 1800) {
                contenuCounter.style.color = '#e53e3e';
            } else {
                contenuCounter.style.color = '#718096';
            }
        });
    }

    // Validation du formulaire
    const form = document.getElementById('composeForm');
    if (form) {
        form.addEventListener('submit', function(e) {
            const sujet = sujetInput.value.trim();
            const contenu = contenuInput.value.trim();

            if (!sujet || !contenu) {
                e.preventDefault();
                alert('Veuillez remplir tous les champs obligatoires');
                return false;
            }

            if (sujet.length < 3) {
                e.preventDefault();
                alert('Le sujet doit contenir au moins 3 caractères');
                sujetInput.focus();
                return false;
            }

            if (contenu.length < 10) {
                e.preventDefault();
                alert('Le message doit contenir au moins 10 caractères');
                contenuInput.focus();
                return false;
            }

            // Afficher un loader pendant l'envoi
            const btnSend = form.querySelector('.btn-send');
            if (btnSend) {
                btnSend.disabled = true;
                btnSend.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Envoi en cours...';
            }
        });
    }

    // Auto-resize du textarea
    if (contenuInput) {
        contenuInput.addEventListener('input', function() {
            this.style.height = 'auto';
            this.style.height = (this.scrollHeight) + 'px';
        });
    }

    // Raccourci clavier Ctrl+Enter pour envoyer
    document.addEventListener('keydown', function(e) {
        if ((e.ctrlKey || e.metaKey) && e.key === 'Enter') {
            if (form) {
                form.submit();
            }
        }
    });

    // Confirmation avant de quitter si le formulaire est rempli
    let formModified = false;

    if (sujetInput) {
        sujetInput.addEventListener('input', () => formModified = true);
    }
    if (contenuInput) {
        contenuInput.addEventListener('input', () => formModified = true);
    }

    window.addEventListener('beforeunload', function(e) {
        if (formModified && sujetInput.value.trim() !== '' && contenuInput.value.trim() !== '') {
            e.preventDefault();
            e.returnValue = '';
        }
    });

    // Empêcher la confirmation lors de la soumission
    if (form) {
        form.addEventListener('submit', function() {
            formModified = false;
        });
    }
</script>
</body>
</html>