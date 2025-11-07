package controller;

import dao.MessageDAO;
import dao.UtilisateurDAO;
import dao.AnnonceDAO;
import model.Message;
import model.Utilisateur;
import model.Annonce;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/message")
public class MessageServlet extends HttpServlet {
    private MessageDAO messageDAO;
    private UtilisateurDAO utilisateurDAO;
    private AnnonceDAO annonceDAO;

    @Override
    public void init() throws ServletException {
        messageDAO = new MessageDAO();
        utilisateurDAO = new UtilisateurDAO();
        annonceDAO = new AnnonceDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Utilisateur utilisateurConnecte = (Utilisateur) session.getAttribute("utilisateur");

        // Vérifier si l'utilisateur est connecté
        if (utilisateurConnecte == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "inbox";
        }

        try {
            switch (action) {
                case "inbox":
                    afficherBoiteReception(request, response, utilisateurConnecte);
                    break;
                case "sent":
                    afficherMessagesEnvoyes(request, response, utilisateurConnecte);
                    break;
                case "view":
                    afficherMessage(request, response, utilisateurConnecte);
                    break;
                case "compose":
                    afficherFormulaireComposition(request, response);
                    break;
                case "delete":
                    supprimerMessage(request, response, utilisateurConnecte);
                    break;
                case "markAsRead":
                    marquerCommeLu(request, response, utilisateurConnecte);
                    break;
                default:
                    afficherBoiteReception(request, response, utilisateurConnecte);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Une erreur est survenue: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Utilisateur utilisateurConnecte = (Utilisateur) session.getAttribute("utilisateur");

        if (utilisateurConnecte == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("send".equals(action)) {
                envoyerMessage(request, response, utilisateurConnecte);
            } else {
                response.sendRedirect("message?action=inbox");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Une erreur est survenue: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    /**
     * Afficher la boîte de réception (messages reçus)
     */
    private void afficherBoiteReception(HttpServletRequest request, HttpServletResponse response,
                                        Utilisateur utilisateur) throws ServletException, IOException {

        List<Message> messages = messageDAO.getMessagesRecus(utilisateur.getId());
        long messagesNonLus = messageDAO.compterMessagesNonLus(utilisateur.getId());

        request.setAttribute("messages", messages);
        request.setAttribute("messagesNonLus", messagesNonLus);
        request.setAttribute("currentPage", "inbox");

        request.getRequestDispatcher("/WEB-INF/jsp/Message/inbox.jsp").forward(request, response);
    }

    /**
     * Afficher les messages envoyés
     */
    private void afficherMessagesEnvoyes(HttpServletRequest request, HttpServletResponse response,
                                         Utilisateur utilisateur) throws ServletException, IOException {

        List<Message> messages = messageDAO.getMessagesEnvoyes(utilisateur.getId());

        request.setAttribute("messages", messages);
        request.setAttribute("currentPage", "sent");

        request.getRequestDispatcher("/WEB-INF/jsp/Message/sent.jsp").forward(request, response);
    }

    /**
     * Afficher un message spécifique
     */
    private void afficherMessage(HttpServletRequest request, HttpServletResponse response,
                                 Utilisateur utilisateur) throws ServletException, IOException {

        String messageIdStr = request.getParameter("id");
        if (messageIdStr == null || messageIdStr.isEmpty()) {
            response.sendRedirect("message?action=inbox");
            return;
        }

        try {
            Long messageId = Long.parseLong(messageIdStr);
            Message message = messageDAO.getMessageById(messageId);

            if (message == null) {
                request.getSession().setAttribute("errorMessage", "Message introuvable");
                response.sendRedirect("message?action=inbox");
                return;
            }

            // Vérifier que l'utilisateur est bien le destinataire ou l'expéditeur
            boolean estDestinataire = message.getDestinataire().getId().equals(utilisateur.getId());
            boolean estExpediteur = message.getExpediteur().getId().equals(utilisateur.getId());

            if (!estDestinataire && !estExpediteur) {
                request.getSession().setAttribute("errorMessage", "Vous n'avez pas accès à ce message");
                response.sendRedirect("message?action=inbox");
                return;
            }

            // Marquer comme lu si l'utilisateur est le destinataire et que le message n'est pas encore lu
            if (estDestinataire && !message.isLu()) {
                messageDAO.marquerCommeLu(messageId);
                message.setLu(true); // Mettre à jour l'objet en mémoire
            }

            request.setAttribute("message", message);
            request.setAttribute("estDestinataire", estDestinataire);

            request.getRequestDispatcher("/WEB-INF/jsp/Message/view.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("message?action=inbox");
        }
    }

    /**
     * Afficher le formulaire de composition d'un nouveau message
     */
    private void afficherFormulaireComposition(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String destinataireIdStr = request.getParameter("to");
        String annonceIdStr = request.getParameter("annonce");

        // Si un destinataire est spécifié
        if (destinataireIdStr != null && !destinataireIdStr.isEmpty()) {
            try {
                Long destinataireId = Long.parseLong(destinataireIdStr);
                Utilisateur destinataire = utilisateurDAO.findById(destinataireId);
                if (destinataire != null) {
                    request.setAttribute("destinataire", destinataire);
                }
            } catch (NumberFormatException e) {
                // Ignorer si l'ID n'est pas valide
            }
        }

        // Si une annonce est spécifiée
        if (annonceIdStr != null && !annonceIdStr.isEmpty()) {
            try {
                Long annonceId = Long.parseLong(annonceIdStr);
                Annonce annonce = annonceDAO.getAnnonceById(annonceId);
                if (annonce != null) {
                    request.setAttribute("annonce", annonce);
                    // Si pas de destinataire spécifié, utiliser le propriétaire de l'annonce
                    if (destinataireIdStr == null || destinataireIdStr.isEmpty()) {
                        request.setAttribute("destinataire", annonce.getProprietaire());
                    }
                }
            } catch (NumberFormatException e) {
                // Ignorer si l'ID n'est pas valide
            }
        }

        request.getRequestDispatcher("/WEB-INF/jsp/Message/compose.jsp").forward(request, response);
    }

    /**
     * Envoyer un nouveau message
     */
    private void envoyerMessage(HttpServletRequest request, HttpServletResponse response,
                                Utilisateur expediteur) throws ServletException, IOException {

        String destinataireIdStr = request.getParameter("destinataireId");
        String sujet = request.getParameter("sujet");
        String contenu = request.getParameter("contenu");
        String annonceIdStr = request.getParameter("annonceId");

        // Validation des champs
        if (destinataireIdStr == null || destinataireIdStr.isEmpty()) {
            request.setAttribute("error", "Destinataire requis");
            afficherFormulaireComposition(request, response);
            return;
        }

        if (sujet == null || sujet.trim().isEmpty()) {
            request.setAttribute("error", "Sujet requis");
            afficherFormulaireComposition(request, response);
            return;
        }

        if (contenu == null || contenu.trim().isEmpty()) {
            request.setAttribute("error", "Contenu requis");
            afficherFormulaireComposition(request, response);
            return;
        }

        try {
            Long destinataireId = Long.parseLong(destinataireIdStr);

            // Vérifier que l'utilisateur n'envoie pas un message à lui-même
            if (destinataireId.equals(expediteur.getId())) {
                request.setAttribute("error", "Vous ne pouvez pas vous envoyer un message à vous-même");
                afficherFormulaireComposition(request, response);
                return;
            }

            Utilisateur destinataire = utilisateurDAO.findById(destinataireId);

            if (destinataire == null) {
                request.setAttribute("error", "Destinataire introuvable");
                afficherFormulaireComposition(request, response);
                return;
            }

            // Créer le nouveau message
            Message message = new Message();
            message.setSujet(sujet.trim());
            message.setContenu(contenu.trim());
            message.setExpediteur(expediteur);
            message.setDestinataire(destinataire);

            // Associer une annonce si spécifiée
            if (annonceIdStr != null && !annonceIdStr.isEmpty()) {
                Long annonceId = Long.parseLong(annonceIdStr);
                Annonce annonce = annonceDAO.getAnnonceById(annonceId);
                if (annonce != null) {
                    message.setAnnonce(annonce);
                }
            }

            messageDAO.creerMessage(message);

            request.getSession().setAttribute("successMessage", "Message envoyé avec succès");
            response.sendRedirect("message?action=sent");

        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID destinataire invalide");
            afficherFormulaireComposition(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors de l'envoi du message: " + e.getMessage());
            afficherFormulaireComposition(request, response);
        }
    }

    /**
     * Supprimer un message
     */
    private void supprimerMessage(HttpServletRequest request, HttpServletResponse response,
                                  Utilisateur utilisateur) throws ServletException, IOException {

        String messageIdStr = request.getParameter("id");
        String referer = request.getHeader("Referer");

        if (messageIdStr == null || messageIdStr.isEmpty()) {
            response.sendRedirect("message?action=inbox");
            return;
        }

        try {
            Long messageId = Long.parseLong(messageIdStr);
            Message message = messageDAO.getMessageById(messageId);

            if (message != null) {
                // Vérifier que l'utilisateur est bien le destinataire ou l'expéditeur
                boolean peutSupprimer = message.getDestinataire().getId().equals(utilisateur.getId()) ||
                        message.getExpediteur().getId().equals(utilisateur.getId());

                if (peutSupprimer) {
                    messageDAO.supprimerMessage(messageId);
                    request.getSession().setAttribute("successMessage", "Message supprimé avec succès");
                } else {
                    request.getSession().setAttribute("errorMessage", "Vous n'avez pas la permission de supprimer ce message");
                }
            }

            // Rediriger vers la page d'origine (inbox ou sent) selon le referer
            if (referer != null && referer.contains("sent")) {
                response.sendRedirect("message?action=sent");
            } else {
                response.sendRedirect("message?action=inbox");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("message?action=inbox");
        }
    }

    /**
     * Marquer un message comme lu
     */
    private void marquerCommeLu(HttpServletRequest request, HttpServletResponse response,
                                Utilisateur utilisateur) throws ServletException, IOException {

        String messageIdStr = request.getParameter("id");
        if (messageIdStr == null || messageIdStr.isEmpty()) {
            response.sendRedirect("message?action=inbox");
            return;
        }

        try {
            Long messageId = Long.parseLong(messageIdStr);
            Message message = messageDAO.getMessageById(messageId);

            if (message != null && message.getDestinataire().getId().equals(utilisateur.getId())) {
                messageDAO.marquerCommeLu(messageId);
            }

            response.sendRedirect("message?action=inbox");

        } catch (NumberFormatException e) {
            response.sendRedirect("message?action=inbox");
        }
    }
}