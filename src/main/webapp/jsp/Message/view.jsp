<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${message.sujet} - Messagerie</title>
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

        .btn-reply {
            display: inline-block;
            padding: 10px 20px;
            background: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 20px;
        }

        .btn-reply:hover {
            background: #0056b3;
        }

        .btn-delete {
            display: inline-block;
            padding: 10px 20px;
            background: #dc3545;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 20px;
            margin-left: 10px;
            border: none;
            cursor: pointer;
        }

        .btn-delete:hover {
            background: #c82333;
        }

        .message-card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .message-meta {
            background: #f8f9fa;
            padding: 20px;
            border-bottom: 2px solid #dee2e6;
        }

        .message-subject {
            font-size: 24px;
            font-weight: 600;
            color: #333;
            margin-bottom: 15px;
        }

        .message-info {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .info-row {
            display: flex;
            align-items: center;
            color: #6c757d;
            font-size: 14px;
        }

        .info-label {
            font-weight: 600;
            margin-right: 10px;
            min-width: 100px;
        }

        .info-value {
            color: #333;
        }

        .message-content {
            padding: 30px;
            line-height: 1.6;
            color: #333;
            white-space: pre-wrap;
            word-wrap: break-word;
        }

        .annonce-card {
            background: #e7f3ff;
            border-left: 4px solid #007bff;
            padding: 15px;
            margin: 20px;
            border-radius: 5px;
        }

        .annonce-card h4 {
            margin: 0 0 10px 0;
            color: #007bff;
        }

        .annonce-link {
            color: #007bff;
            text-decoration: none;
            font-weight: 600;
        }

        .annonce-link:hover {
            text-decoration: underline;
        }

        .message-actions {
            padding: 20px;
            background: #f8f9fa;
            border-top: 1px solid #dee2e6;
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

    <c:if test="${not empty message}">
        <div class="message-card">
            <!-- En-tête du message -->
            <div class="message-meta">
                <div class="message-subject">
                        ${message.sujet}
                </div>
                <div class="message-info">
                    <div class="info-row">
                        <span class="info-label">De :</span>
                        <span class="info-value">
                            <strong>${message.expediteur.nom} ${message.expediteur.prenom}</strong>
                            &lt;${message.expediteur.email}&gt;
                        </span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">À :</span>
                        <span class="info-value">
                            <strong>${message.destinataire.nom} ${message.destinataire.prenom}</strong>
                            &lt;${message.destinataire.email}&gt;
                        </span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Date :</span>
                        <span class="info-value">
                            <fmt:formatDate value="${message.dateEnvoi}" pattern="dd/MM/yyyy 'à' HH:mm"/>
                        </span>
                    </div>
                </div>
            </div>

            <!-- Annonce liée si existe -->
            <c:if test="${not empty message.annonce}">
                <div class="annonce-card">
                    <h4>📋 Concernant l'annonce :</h4>
                    <a href="annonce?action=detail&id=${message.annonce.id}" class="annonce-link">
                            ${message.annonce.titre}
                    </a>
                </div>
            </c:if>

            <!-- Contenu du message -->
            <div class="message-content">
                    ${message.contenu}
            </div>

            <!-- Actions -->
            <div class="message-actions">
                <c:if test="${estDestinataire}">
                    <a href="message?action=compose&to=${message.expediteur.id}<c:if test='${not empty message.annonce}'>&annonce=${message.annonce.id}</c:if>"
                       class="btn-reply">
                        ↩ Répondre
                    </a>
                </c:if>

                <form action="message?action=delete" method="get" style="display: inline;"
                      onsubmit="return confirm('Êtes-vous sûr de vouloir supprimer ce message ?');">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" value="${message.id}">
                    <button type="submit" class="btn-delete">🗑 Supprimer</button>
                </form>
            </div>
        </div>
    </c:if>
</div>
</body>
</html>