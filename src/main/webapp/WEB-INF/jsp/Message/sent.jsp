<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Messages envoyés - Messagerie</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .message-container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
        }

        .message-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #007bff;
        }

        .nav-tabs {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }

        .nav-tab {
            padding: 10px 20px;
            text-decoration: none;
            color: #333;
            border: 1px solid #ddd;
            border-radius: 5px;
            background: white;
        }

        .nav-tab.active {
            background: #007bff;
            color: white;
            border-color: #007bff;
        }

        .btn-compose {
            padding: 10px 20px;
            background: #28a745;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            border: none;
        }

        .message-table {
            width: 100%;
            background: white;
            border-collapse: collapse;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .message-table th {
            background: #f8f9fa;
            padding: 12px;
            text-align: left;
            font-weight: 600;
            border-bottom: 2px solid #dee2e6;
        }

        .message-table td {
            padding: 12px;
            border-bottom: 1px solid #dee2e6;
        }

        .message-row {
            cursor: pointer;
            transition: background 0.2s;
        }

        .message-row:hover {
            background: #f8f9fa;
        }

        .message-subject {
            color: #007bff;
            text-decoration: none;
        }

        .message-subject:hover {
            text-decoration: underline;
        }

        .message-date {
            color: #6c757d;
            font-size: 14px;
        }

        .btn-delete {
            padding: 5px 10px;
            background: #dc3545;
            color: white;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            font-size: 12px;
        }

        .btn-delete:hover {
            background: #c82333;
        }

        .alert {
            padding: 12px 20px;
            margin-bottom: 20px;
            border-radius: 5px;
        }

        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-danger {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .no-messages {
            text-align: center;
            padding: 40px;
            color: #6c757d;
        }

        .annonce-link {
            color: #6c757d;
            font-size: 12px;
            text-decoration: none;
        }

        .annonce-link:hover {
            color: #007bff;
        }
    </style>
</head>
<body>
<div class="message-container">
    <div class="message-header">
        <div>
            <h1>Messagerie</h1>
        </div>
        <a href="message?action=compose" class="btn-compose">✉ Nouveau message</a>
    </div>

    <!-- Navigation Tabs -->
    <div class="nav-tabs">
        <a href="message?action=inbox" class="nav-tab">
            📥 Boîte de réception
        </a>
        <a href="message?action=sent" class="nav-tab active">
            📤 Messages envoyés
        </a>
    </div>

    <!-- Messages de succès/erreur -->
    <c:if test="${not empty sessionScope.successMessage}">
        <div class="alert alert-success">
                ${sessionScope.successMessage}
        </div>
        <c:remove var="successMessage" scope="session"/>
    </c:if>

    <c:if test="${not empty sessionScope.errorMessage}">
        <div class="alert alert-danger">
                ${sessionScope.errorMessage}
        </div>
        <c:remove var="errorMessage" scope="session"/>
    </c:if>

    <!-- Liste des messages envoyés -->
    <c:choose>
        <c:when test="${empty messages}">
            <div class="no-messages">
                <h3>📭 Aucun message envoyé</h3>
                <p>Vous n'avez pas encore envoyé de messages</p>
            </div>
        </c:when>
        <c:otherwise>
            <table class="message-table">
                <thead>
                <tr>
                    <th style="width: 25%;">Destinataire</th>
                    <th style="width: 35%;">Sujet</th>
                    <th style="width: 20%;">Annonce</th>
                    <th style="width: 15%;">Date</th>
                    <th style="width: 5%;">Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="message" items="${messages}">
                    <tr class="message-row"
                        onclick="window.location.href='message?action=view&id=${message.id}'">
                        <td>
                            <strong>${message.destinataire.nom} ${message.destinataire.prenom}</strong>
                            <br>
                            <small style="color: #6c757d;">${message.destinataire.email}</small>
                        </td>
                        <td>
                            <a href="message?action=view&id=${message.id}" class="message-subject">
                                    ${message.sujet}
                            </a>
                        </td>
                        <td>
                            <c:if test="${not empty message.annonce}">
                                <a href="annonce?action=view&id=${message.annonce.id}"
                                   class="annonce-link"
                                   onclick="event.stopPropagation()">
                                    📋 ${message.annonce.titre}
                                </a>
                            </c:if>
                        </td>
                        <td class="message-date">
                            <fmt:formatDate value="${message.dateEnvoi}" pattern="dd/MM/yyyy HH:mm"/>
                        </td>
                        <td onclick="event.stopPropagation()">
                            <form action="message?action=delete" method="get"
                                  style="display: inline;"
                                  onsubmit="return confirm('Êtes-vous sûr de vouloir supprimer ce message ?');">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="${message.id}">
                                <button type="submit" class="btn-delete">🗑</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>