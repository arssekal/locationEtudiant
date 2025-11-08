<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nouveau message - Messagerie</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .message-container {
            max-width: 900px;
            margin: 20px auto;
            padding: 20px;
        }

        .message-header {
            margin-bottom: 20px;
        }

        .btn-back {
            display: inline-block;
            padding: 8px 15px;
            background: #6c757d;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin-bottom: 15px;
        }

        .btn-back:hover {
            background: #5a6268;
        }

        .compose-card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            padding: 30px;
        }

        .compose-card h2 {
            margin-top: 0;
            color: #333;
            margin-bottom: 25px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 5px;
            font-size: 14px;
            font-family: inherit;
            box-sizing: border-box;
        }

        .form-control:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1);
        }

        textarea.form-control {
            min-height: 250px;
            resize: vertical;
        }

        .form-control[readonly] {
            background-color: #e9ecef;
            cursor: not-allowed;
        }

        .form-actions {
            display: flex;
            gap: 10px;
            margin-top: 25px;
        }

        .btn-send {
            padding: 12px 30px;
            background: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
        }

        .btn-send:hover {
            background: #218838;
        }

        .btn-cancel {
            padding: 12px 30px;
            background: #6c757d;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            display: inline-block;
        }

        .btn-cancel:hover {
            background: #5a6268;
        }

        .alert {
            padding: 12px 20px;
            margin-bottom: 20px;
            border-radius: 5px;
        }

        .alert-danger {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .annonce-info {
            background: #e7f3ff;
            border-left: 4px solid #007bff;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
        }

        .annonce-info h4 {
            margin: 0 0 10px 0;
            color: #007bff;
        }

        .required {
            color: #dc3545;
            margin-left: 3px;
        }
    </style>
</head>
<body>
<div class="message-container">
    <div class="message-header">
        <a href="message?action=inbox" class="btn-back">← Retour</a>
    </div>

    <!-- Message d'erreur -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
                ${error}
        </div>
    </c:if>

    <div class="compose-card">
        <h2>✉ Nouveau message</h2>

        <!-- Information sur l'annonce si existe -->
        <c:if test="${not empty annonce}">
            <div class="annonce-info">
                <h4>📋 Concernant l'annonce :</h4>
                <strong>${annonce.titre}</strong>
            </div>
        </c:if>

        <form action="message?action=send" method="post">
            <!-- Destinataire -->
            <div class="form-group">
                <label class="form-label">
                    Destinataire <span class="required">*</span>
                </label>
                <c:choose>
                    <c:when test="${not empty destinataire}">
                        <input type="text" class="form-control"
                               value="${destinataire.nom} ${destinataire.prenom} (${destinataire.email})"
                               readonly>
                        <input type="hidden" name="destinataireId" value="${destinataire.id}">
                    </c:when>
                    <c:otherwise>
                        <input type="number" class="form-control" name="destinataireId"
                               placeholder="ID du destinataire" required>
                        <small style="color: #6c757d;">
                            Entrez l'ID de l'utilisateur destinataire
                        </small>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Sujet -->
            <div class="form-group">
                <label class="form-label">
                    Sujet <span class="required">*</span>
                </label>
                <input type="text" class="form-control" name="sujet"
                       placeholder="Sujet du message" required
                       value="${not empty param.sujet ? param.sujet : ''}">
            </div>

            <!-- Contenu -->
            <div class="form-group">
                <label class="form-label">
                    Message <span class="required">*</span>
                </label>
                <textarea class="form-control" name="contenu"
                          placeholder="Écrivez votre message ici..."
                          required>${not empty param.contenu ? param.contenu : ''}</textarea>
            </div>

            <!-- ID de l'annonce si existe -->
            <c:if test="${not empty annonce}">
                <input type="hidden" name="annonceId" value="${annonce.id}">
            </c:if>

            <!-- Actions -->
            <div class="form-actions">
                <button type="submit" class="btn-send">
                    📤 Envoyer
                </button>
                <a href="message?action=inbox" class="btn-cancel">
                    Annuler
                </a>
            </div>
        </form>
    </div>
</div>
</body>
</html>