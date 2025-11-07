<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Vérification du code</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/verification.css">
</head>
<body>
<!-- Background animé -->
<ul class="background">
    <li></li>
    <li></li>
    <li></li>
    <li></li>
    <li></li>
    <li></li>
    <li></li>
    <li></li>
    <li></li>
    <li></li>
</ul>
<div class="card">
    <div class="card-header">
        <h2>Vérifiez votre adresse e-mail</h2>
    </div>

    <% String messageErreur = (String) request.getAttribute("erreur");
        if (messageErreur != null) { %>
    <div class="erreur"><%= messageErreur %></div>
    <% } %>

    <form action="<%= request.getContextPath()%>/verification" method="post" novalidate>
        <label for="code">Entrez le code reçu par email :</label>
        <input id="code" type="text" name="code" required autocomplete="one-time-code" inputmode="numeric" pattern="[0-9]{4,8}">
        <button type="submit">Vérifier</button>
    </form>

    <p class="help">Nous avons envoyé un code à votre adresse e-mail.</p>
</div>
</body>
</html>