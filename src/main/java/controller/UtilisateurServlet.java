package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Utilisateur;
import org.hibernate.Session;
import service.UtilisateurService;
import util.EmailUtil;

import java.io.IOException;
import java.util.List;

public class UtilisateurServlet extends HttpServlet {
    private final UtilisateurService utilisateurService = new UtilisateurService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        String path = request.getPathInfo(); // Retourne la partie de l’URL après le mapping du servlet

        if (path == null || path.equals("/login")) {
            request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
        } else if (path.equals("/verification")) {
            request.getRequestDispatcher("/jsp/verifier_code.jsp").forward(request, response);
        } else if (path.equals("/inscription")) {
            request.getRequestDispatcher("/jsp/inscription.jsp").forward(request, response);
        }
        else if (path.equals("/dashboard")) {
            request.getRequestDispatcher("/jsp/tableau_de_bord.jsp").forward(request, response);
        }
        else if (path.equals("/deconnexion")) {
            HttpSession session = request.getSession(false);
            if (session != null) session.invalidate(); // Supprimer une session (déconnexion) si une session existe Le cookie JSESSIONID devient invalide. L’utilisateur devra se reconnecter.
            response.sendRedirect(request.getContextPath() + "/utilisateur/login?logout=1");
        } else if(path.equals("/profil")) {
            request.getRequestDispatcher("/jsp/profil.jsp").forward(request, response);
        }
        else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Page non trouvée !");
        }
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String action = request.getParameter("action");

        if(action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action inconnue");
            return;
        }
        if("inscription".equalsIgnoreCase(action)) {
            traiterInscription(request, response);
        }
        else if("connexion".equalsIgnoreCase(action)) {
            traiterConnexion(request, response);
        } else if ("update".equalsIgnoreCase(action)) {
            traiterModification(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action inconnue");
        }
    }

    private void traiterModification(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nom = request.getParameter("nom");
        String motDePasse = request.getParameter("motDePasse");
        String role = request.getParameter("role");

        Utilisateur utilisateurExistant = utilisateurService.getUtilisateurParId(id);

        if (utilisateurExistant == null) {
            request.setAttribute("messageErreur", "Utilisateur introuvable.");
            request.getRequestDispatcher("jsp/profil.jsp").forward(request, response);
            return;
        }

        if (motDePasse == null || motDePasse.trim().isEmpty()) {
            motDePasse = utilisateurExistant.getMotDePasse();
        }

        utilisateurExistant.setNom(nom);
        utilisateurExistant.setMotDePasse(motDePasse);
        utilisateurExistant.setRole(role);

        List<String> erreurs = utilisateurService.updateUtilisateur(utilisateurExistant);

        if (erreurs.isEmpty()) {
            HttpSession session = request.getSession();
            session.setAttribute("utilisateur", utilisateurExistant);
            request.setAttribute("messageSuccess", "modification réussite des informations");
            request.getRequestDispatcher("jsp/profil.jsp").forward(request, response);
        } else {
            request.setAttribute("messageErreur", erreurs.get(0));
            request.getRequestDispatcher("jsp/profil.jsp").forward(request, response);
        }
    }

    private void traiterInscription(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String motDePasse = request.getParameter("motDePasse");
        String confirmerMotPass = request.getParameter("confirmerMotDePasse");
        String role = request.getParameter("role");

        Utilisateur utilisateur = new Utilisateur(nom, email, motDePasse, role);
        List<String> erreurs = utilisateurService.inscrire(utilisateur, confirmerMotPass);

        if (erreurs.isEmpty()) {
            response.sendRedirect("jsp/login.jsp?success=1");
        } else {
            request.setAttribute("messageErreur", erreurs.get(0));
            request.getRequestDispatcher("jsp/inscription.jsp").forward(request, response);
        }
    }

    private void traiterConnexion(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String motDePasse = request.getParameter("motDePasse");
        Utilisateur utilisateur = utilisateurService.connecter(email, motDePasse);

        if(utilisateur != null) {
            /*
            Quand tu fais response.sendRedirect(...), la requête actuelle se termine et une nouvelle requête démarre.
            . Les attributs mis avec request.setAttribute() sont donc perdus.
            . D’où la nécessité d’utiliser la session si tu veux conserver les données d’un utilisateur connecté
             */
            // Après vérification du mot de passe correct
            int codeVerification = (int) (Math.random() * 900000) + 100000; // 6 chiffres

            // Enregistrer le code et l'utilisateur dans la session temporairement
            request.getSession().setAttribute("codeVerification", codeVerification);
            request.getSession().setAttribute("emailUtilisateur", utilisateur.getEmail());
            request.getSession().setAttribute("utilisateur", utilisateur);
            request.getSession().setAttribute("isVerified", false);

            // Envoyer l'email
            String sujet = "Code de vérification - Location Étudiante";
            String corps = "Bonjour " + utilisateur.getNom() + ",\n\nVotre code de vérification est : " + codeVerification + "\n\nCe code est valable 10 minutes.";
            EmailUtil.sendEmail(utilisateur.getEmail(), sujet, corps);

            // Rediriger vers la page de vérification du code
            response.sendRedirect(request.getContextPath() + "/utilisateur/verification");
        } else {
            request.setAttribute("messageErreur", "Email ou mot de passe incorrect !");
            request.getRequestDispatcher("jsp/login.jsp").forward(request, response);
        }
    }
}
