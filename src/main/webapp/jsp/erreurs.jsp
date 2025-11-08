<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Erreur - Une erreur s'est produite</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .error-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            max-width: 600px;
            width: 100%;
            padding: 40px;
            text-align: center;
        }

        .error-icon {
            font-size: 80px;
            margin-bottom: 20px;
        }

        .error-code {
            font-size: 72px;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 10px;
        }

        .error-title {
            font-size: 28px;
            color: #333;
            margin-bottom: 15px;
        }

        .error-message {
            font-size: 16px;
            color: #666;
            line-height: 1.6;
            margin-bottom: 30px;
        }

        .error-details {
            background: #f8f9fa;
            border-left: 4px solid #dc3545;
            padding: 15px;
            margin: 20px 0;
            text-align: left;
            border-radius: 5px;
        }

        .error-details strong {
            color: #dc3545;
        }

        .error-details p {
            margin: 5px 0;
            font-size: 14px;
            color: #555;
            word-break: break-word;
        }

        .button-group {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 25px;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary {
            background: #f8f9fa;
            color: #333;
            border: 2px solid #ddd;
        }

        .btn-secondary:hover {
            background: #e9ecef;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
<div class="error-container">
    <div class="error-icon">⚠️</div>

    <%
        // Récupération des informations d'erreur
        Integer statusCode = (Integer) request.getAttribute("javax.servlet.error.status_code");
        String errorMessage = (String) request.getAttribute("javax.servlet.error.message");

        String requestUri = (String) request.getAttribute("javax.servlet.error.request_uri");

        // Valeurs par défaut
        if (statusCode == null) statusCode = 500;
        if (errorMessage == null || errorMessage.isEmpty()) errorMessage = "Une erreur inattendue s'est produite";
        if (requestUri == null) requestUri = "Non disponible";

        // Messages personnalisés selon le code d'erreur
        String title = "Erreur";
        String description = "";

        switch (statusCode) {
            case 400:
                title = "Requête invalide";
                description = "La requête envoyée au serveur est invalide ou mal formée.";
                break;
            case 401:
                title = "Non autorisé";
                description = "Vous devez vous authentifier pour accéder à cette ressource.";
                break;
            case 403:
                title = "Accès interdit";
                description = "Vous n'avez pas les permissions nécessaires pour accéder à cette page.";
                break;
            case 404:
                title = "Page non trouvée";
                description = "La page que vous recherchez n'existe pas ou a été déplacée.";
                break;
            case 500:
                title = "Erreur serveur";
                description = "Une erreur interne s'est produite sur le serveur.";
                break;
            case 503:
                title = "Service indisponible";
                description = "Le serveur est temporairement indisponible. Veuillez réessayer plus tard.";
                break;
            default:
                title = "Erreur " + statusCode;
                description = "Une erreur s'est produite lors du traitement de votre requête.";
        }
    %>

    <div class="error-code"><%= statusCode %></div>
    <h1 class="error-title"><%= title %></h1>
    <p class="error-message"><%= description %></p>

    <% if (exception != null || !errorMessage.equals("Une erreur inattendue s'est produite")) { %>
    <div class="error-details">
        <strong>Détails techniques :</strong>
        <% if (exception != null) { %>
        <p><strong>Exception:</strong> <%= exception.getClass().getName() %></p>
        <p><strong>Message:</strong> <%= exception.getMessage() != null ? exception.getMessage() : "Aucun message" %></p>
        <% } else { %>
        <p><strong>Message:</strong> <%= errorMessage %></p>
        <% } %>
        <p><strong>URI:</strong> <%= requestUri %></p>
    </div>
    <% } %>

    <div class="button-group">
        <a href="<%= request.getContextPath() %>/" class="btn btn-primary">
            🏠 Retour à l'accueil
        </a>
        <button onclick="history.back()" class="btn btn-secondary">
            ← Page précédente
        </button>
    </div>
</div>
</body>
</html>