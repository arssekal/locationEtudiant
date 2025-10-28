package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Utilisateur;
import service.UtilisateurService;

import java.io.IOException;

public class UtilisateurServlet extends HttpServlet {
    private final UtilisateurService utilisateurService = new UtilisateurService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        String path = request.getPathInfo(); // ex: /login, /inscription, /deconnexion, /dashboard

        if (path == null || path.equals("/login")) {
            request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
        }
        else if (path.equals("/inscription")) {
            request.getRequestDispatcher("/jsp/inscription.jsp").forward(request, response);
        }
        else if (path.equals("/dashboard")) {
            request.getRequestDispatcher("/jsp/tableau_de_bord.jsp").forward(request, response);
        }
        else if (path.equals("/deconnexion")) {
            HttpSession session = request.getSession(false);
            if (session != null) session.invalidate();
            response.sendRedirect(request.getContextPath() + "/utilisateur/login?logout=1");
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
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action inconnue");
        }
    }

    private void traiterInscription(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String motDePasse = request.getParameter("motDePasse");
        String role = request.getParameter("role");

        Utilisateur utilisateur = new Utilisateur(nom, email, motDePasse, role);
        boolean success = utilisateurService.inscrire(utilisateur);

        if (success) {
            response.sendRedirect("jsp/login.jsp?success=1");
        } else {
            request.setAttribute("messageErreur", "Inscription échouée. Vérifiez vos informations !");
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
            HttpSession session = request.getSession();
            session.setAttribute("utilisateur", utilisateur);
            response.sendRedirect(request.getContextPath() + "/utilisateur/dashboard");
        } else {
            request.setAttribute("messageErreur", "Email ou mot de passe incorrect !");
            request.getRequestDispatcher("jsp/login.jsp").forward(request, response);
        }
    }




}
