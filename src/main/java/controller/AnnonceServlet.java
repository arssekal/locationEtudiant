package controller;

import dao.AnnonceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Annonce;
import model.Utilisateur;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/annonce")
public class AnnonceServlet extends HttpServlet {

    private AnnonceDAO annonceDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        annonceDAO = new AnnonceDAO();
        System.out.println("AnnonceServlet init");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null || action.isEmpty()) action = "list";
        System.out.println("Action GET: " + action);

        try {
            switch (action) {
                case "list": listAnnonce(req, resp); break;
                case "view": viewAnnonce(req, resp); break;
                case "new": showNewForm(req, resp); break;
                case "edit": showEditForm(req, resp); break;
                case "delete": deleteAnnonce(req, resp); break;
                case "MesAnnonces":listMesAnnonces(req, resp); break;
                case "search": searchAnnonces(req, resp); break;
                case "toggleDisponibilite": toggleDisponibilite(req, resp); break;
                default: listAnnonce(req, resp); break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Une erreur est survenue : " + e.getMessage());
            req.getRequestDispatcher("/jsp/erreurs.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");
        if (action == null || action.isEmpty()) action = "list";

        System.out.println("Action POST: " + action);

        try {
            switch (action) {
                case "create": createAnnonce(req, resp); break;
                case "update": updateAnnonce(req, resp); break;
                case "search": searchAnnonces(req, resp); break;
                default: listAnnonce(req, resp); break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Une erreur est survenue : " + e.getMessage());
            req.getRequestDispatcher("/jsp/erreurs.jsp").forward(req, resp);
        }
    }

    // ==================== HELPER METHOD ====================
    /**
     * Vérifie si l'utilisateur est propriétaire (insensible à la casse)
     */
    private boolean isProprietaire(Utilisateur utilisateur) {
        if (utilisateur == null || utilisateur.getRole() == null) {
            return false;
        }
        String role = utilisateur.getRole().toUpperCase();
        return "PROPRIETAIRE".equals(role);
    }

    // ==================== GET HANDLERS ====================
    private void listAnnonce(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // Récupérer les annonces
            System.out.println("📥 Récupération des annonces depuis le DAO...");
            List<Annonce> annonces = annonceDAO.getAllAnnoncesDisponibles();

            System.out.println("✅ Nombre d'annonces récupérées: " + (annonces != null ? annonces.size() : "NULL"));

            if (annonces != null && !annonces.isEmpty()) {
                System.out.println("📋 Détails des annonces:");
                for (int i = 0; i < Math.min(3, annonces.size()); i++) {
                    Annonce a = annonces.get(i);
                    System.out.println("   [" + i + "] " + a.getTitre() + " - " + a.getVille() + " - " + a.getPrix() + " MAD");
                    if (a.getProprietaire() != null) {
                        System.out.println("       Propriétaire: " + a.getProprietaire().getNom());
                    } else {
                        System.out.println("       ⚠️ Propriétaire NULL");
                    }
                }
            } else {
                System.out.println("⚠️ Aucune annonce disponible");
            }

            // Mettre les attributs
            req.setAttribute("annonces", annonces != null ? annonces : new ArrayList<>());
            req.setAttribute("totalAnnonces", annonces != null ? annonces.size() : 0);
            req.setAttribute("pageTitle", "Toutes les annonces");

            System.out.println("✅ Attributs définis:");
            System.out.println("   - annonces: " + req.getAttribute("annonces"));
            System.out.println("   - totalAnnonces: " + req.getAttribute("totalAnnonces"));
            System.out.println("   - pageTitle: " + req.getAttribute("pageTitle"));

            // Forward vers la JSP
            String jspPath = "/jsp/annonces/list.jsp";
            System.out.println("📂 Forward vers: " + jspPath);

            req.getRequestDispatcher(jspPath).forward(req, resp);

            System.out.println("✅ Forward effectué avec succès");
            System.out.println("=== FIN listAnnonce ===");

        } catch (Exception e) {
            System.err.println("❌ ERREUR dans listAnnonce:");
            e.printStackTrace();

            // En cas d'erreur, rediriger vers une page d'erreur
            req.setAttribute("error", "Erreur lors du chargement des annonces: " + e.getMessage());
            req.getRequestDispatcher("/jsp/error.jsp").forward(req, resp);
        }
    }

    private void viewAnnonce(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // 1. Vérifier que l'ID existe
            String idParam = req.getParameter("id");
            if (idParam == null || idParam.trim().isEmpty()) {
                System.out.println("❌ Erreur: ID manquant");
                req.getSession().setAttribute("error", "ID de l'annonce manquant");
                resp.sendRedirect(req.getContextPath() + "/annonce?action=list");
                return;
            }
            // 2. Parser l'ID
            Long id = Long.parseLong(idParam);
            System.out.println("🔍 Recherche de l'annonce ID: " + id);

            // 3. Récupérer l'annonce
            Annonce annonce = annonceDAO.getAnnonceById(id);
            System.out.println("📄 Annonce trouvée: " + (annonce != null));

            if (annonce != null) {
                // 4. Vérifier que les données de l'annonce sont complètes
                System.out.println("✅ Titre: " + annonce.getTitre());
                System.out.println("✅ Propriétaire: " + (annonce.getProprietaire() != null ? annonce.getProprietaire().getNom() : "null"));

                // 5. Mettre l'annonce en attribut
                req.setAttribute("annonce", annonce);

                // 6. Vérifier si l'utilisateur connecté est le propriétaire
                HttpSession session = req.getSession(false);
                if (session != null) {
                    Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
                    if (utilisateur != null && annonce.getProprietaire() != null
                            && annonce.getProprietaire().getId().equals(utilisateur.getId())) {
                        req.setAttribute("isProprietaire", true);
                        System.out.println("👤 Utilisateur est le propriétaire");
                    } else {
                        req.setAttribute("isProprietaire", false);
                        System.out.println("👤 Utilisateur n'est pas le propriétaire");
                    }
                } else {
                    req.setAttribute("isProprietaire", false);
                    System.out.println("👤 Aucun utilisateur connecté");
                }

                // 7. Vérifier le chemin du JSP
                String jspPath = "/jsp/annonces/view.jsp";
                System.out.println("📂 Chemin JSP: " + jspPath);

                // 8. Forward vers la page JSP
                req.getRequestDispatcher(jspPath).forward(req, resp);
                System.out.println("✅ Forward effectué vers view.jsp");

            } else {
                // Annonce non trouvée
                System.out.println("❌ Erreur: Annonce non trouvée pour l'ID: " + id);
                req.getSession().setAttribute("error", "Annonce introuvable");
                resp.sendRedirect(req.getContextPath() + "/annonce?action=list");
            }

        } catch (NumberFormatException e) {
            System.out.println("❌ Erreur: Format d'ID invalide - " + e.getMessage());
            e.printStackTrace();
            req.getSession().setAttribute("error", "ID invalide");
            resp.sendRedirect(req.getContextPath() + "/annonce?action=list");

        } catch (Exception e) {
            System.out.println("❌ Erreur inattendue: " + e.getMessage());
            e.printStackTrace();
            req.getSession().setAttribute("error", "Erreur lors du chargement de l'annonce: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/annonce?action=list");
        }
    }

    private void listMesAnnonces(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("utilisateur") == null) {
            req.getRequestDispatcher("/jsp/login.jsp").forward(req, resp);
            return;
        }

        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        System.out.println("DEBUG - listMesAnnonces - Role: " + utilisateur.getRole());
        System.out.println(utilisateur.getId());

        if (!isProprietaire(utilisateur)) {
            req.setAttribute("error", "Accès refusé - Vous devez être propriétaire");
            listAnnonce(req, resp);
            return;
        }

        List<Annonce> annonces = annonceDAO.getAnnoncesByProprietaire(utilisateur.getId());
        Long totalAnnonce = annonceDAO.countAnnoncesByProprietaire(utilisateur.getId());
        Long annonceDisponibles = annonceDAO.countAnnoncesDisponiblesByProprietaire(utilisateur.getId());

        req.setAttribute("annonces", annonces);
        req.setAttribute("totalAnnonce", totalAnnonce);
        req.setAttribute("totalAnnonceDisponibles", annonceDisponibles);
        req.setAttribute("annoncesNonDisponible", totalAnnonce - annonceDisponibles);
        req.setAttribute("pageTitle", "Mes annonces");

        req.getRequestDispatcher("/jsp/annonces/MesAnnonces.jsp").forward(req, resp);
    }

    private void showNewForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("utilisateur") == null) {
            req.getRequestDispatcher("/jsp/login.jsp").forward(req, resp);
            return;
        }

        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        System.out.println("DEBUG - showNewForm - Rôle utilisateur: " + utilisateur.getRole());
        System.out.println("DEBUG - showNewForm - isProprietaire: " + isProprietaire(utilisateur));

        if (!isProprietaire(utilisateur)) {
            req.setAttribute("error", "Seuls les propriétaires peuvent créer des annonces. Votre rôle actuel: " + utilisateur.getRole());
            listAnnonce(req, resp);
            return;
        }

        req.setAttribute("action", "create");
        req.setAttribute("pageTitle", "Créer une annonce");
        req.getRequestDispatcher("/jsp/annonces/form.jsp").forward(req, resp);
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("utilisateur") == null) {
            req.getRequestDispatcher("/jsp/login.jsp").forward(req, resp);
            return;
        }

        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        if (!isProprietaire(utilisateur)) {
            req.setAttribute("error", "Accès refusé");
            listAnnonce(req, resp);
            return;
        }

        try {
            Long id = Long.parseLong(req.getParameter("id"));
            Annonce annonce = annonceDAO.getAnnonceById(id);
            if (annonce == null || !annonce.getProprietaire().getId().equals(utilisateur.getId())) {
                req.setAttribute("error", "Annonce introuvable ou accès refusé");
                listMesAnnonces(req, resp);
                return;
            }
            req.setAttribute("annonce", annonce);
            req.setAttribute("action", "update");
            req.setAttribute("pageTitle", "Modifier l'annonce");
            req.getRequestDispatcher("/jsp/annonces/form.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            req.setAttribute("error", "ID invalide");
            listMesAnnonces(req, resp);
        }
    }

    private void searchAnnonces(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String ville = req.getParameter("ville");
        String prixMaxStr = req.getParameter("prixMax");
        String type = req.getParameter("type");
        String nbChambresMinStr = req.getParameter("nbChambresMin");

        Double prixMax = null;
        Integer nbChambresMin = null;

        try {
            if (prixMaxStr != null && !prixMaxStr.trim().isEmpty()) prixMax = Double.parseDouble(prixMaxStr);
            if (nbChambresMinStr != null && !nbChambresMinStr.trim().isEmpty()) nbChambresMin = Integer.parseInt(nbChambresMinStr);
        } catch (NumberFormatException e) {
            req.setAttribute("error", "Valeurs de recherche invalides");
        }

        List<Annonce> annonces = annonceDAO.rechercheAvancee(ville, prixMax, type, nbChambresMin);

        req.setAttribute("annonces", annonces);
        req.setAttribute("totalAnnonces", annonces.size());
        req.setAttribute("searchPerformed", true);
        req.setAttribute("ville", ville);
        req.setAttribute("prixMax", prixMax);
        req.setAttribute("type", type);
        req.setAttribute("nbChambresMin", nbChambresMin);
        req.setAttribute("pageTitle", "Résultats de recherche");
        req.getRequestDispatcher("/jsp/annonces/list.jsp").forward(req, resp);
    }

    // ==================== POST HANDLERS ====================
    private void createAnnonce(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("utilisateur") == null) {
            req.getRequestDispatcher("/jsp/login.jsp").forward(req, resp);
            return;
        }

        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        System.out.println("DEBUG - createAnnonce - Role: " + utilisateur.getRole());

        if (!isProprietaire(utilisateur)) {
            req.setAttribute("error", "Accès refusé - Seuls les propriétaires peuvent créer des annonces");
            listAnnonce(req, resp);
            return;
        }

        try {
            Annonce annonce = new Annonce();
            annonce.setTitre(req.getParameter("titre"));
            annonce.setDescription(req.getParameter("description"));
            annonce.setAdresse(req.getParameter("adresse"));
            annonce.setVille(req.getParameter("ville"));
            annonce.setPrix(Double.parseDouble(req.getParameter("prix")));
            annonce.setSuperficie(Integer.parseInt(req.getParameter("superficie")));
            annonce.setNbChambres(Integer.parseInt(req.getParameter("nbChambres")));
            annonce.setType(req.getParameter("type"));
            annonce.setEquipements(req.getParameter("equipements"));
            annonce.setProprietaire(utilisateur);

            String contactEmail = req.getParameter("contactEmail");
            String contactTelephone = req.getParameter("contactTelephone");
            String imageUrl = req.getParameter("imageUrl");

            if (contactEmail != null && !contactEmail.trim().isEmpty()) {
                annonce.setContactEmail(contactEmail);
            } else {
                annonce.setContactEmail(utilisateur.getEmail());
            }

            if (contactTelephone != null && !contactTelephone.trim().isEmpty()) {
                annonce.setContactTelephone(contactTelephone);
            }

            if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                annonce.setImageUrl(imageUrl);
            }

            boolean success = annonceDAO.CreateAnnonce(annonce);
            if (success) {
                session.setAttribute("success", "Annonce créée avec succès !");
                resp.sendRedirect(req.getContextPath() + "/annonce?action=MesAnnonces");
            } else {
                req.setAttribute("error", "Erreur lors de la création de l'annonce");
                req.setAttribute("annonce", annonce);
                req.setAttribute("action", "create");
                req.getRequestDispatcher("/jsp/annonces/form.jsp").forward(req, resp);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur de format dans les champs numériques: " + e.getMessage());
            req.setAttribute("action", "create");
            req.getRequestDispatcher("/jsp/annonces/form.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur lors de la création: " + e.getMessage());
            req.setAttribute("action", "create");
            req.getRequestDispatcher("/jsp/annonces/form.jsp").forward(req, resp);
        }
    }

    private void updateAnnonce(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("utilisateur") == null) {
            req.getRequestDispatcher("/jsp/login.jsp").forward(req, resp);
            return;
        }

        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        if (!isProprietaire(utilisateur)) {
            req.setAttribute("error", "Accès refusé");
            listAnnonce(req, resp);
            return;
        }

        try {
            Long id = Long.parseLong(req.getParameter("id"));
            Annonce annonce = annonceDAO.getAnnonceById(id);
            if (annonce == null || !annonce.getProprietaire().getId().equals(utilisateur.getId())) {
                req.setAttribute("error", "Annonce introuvable ou accès refusé");
                listMesAnnonces(req, resp);
                return;
            }

            annonce.setTitre(req.getParameter("titre"));
            annonce.setDescription(req.getParameter("description"));
            annonce.setAdresse(req.getParameter("adresse"));
            annonce.setVille(req.getParameter("ville"));
            annonce.setPrix(Double.parseDouble(req.getParameter("prix")));
            annonce.setSuperficie(Integer.parseInt(req.getParameter("superficie")));
            annonce.setNbChambres(Integer.parseInt(req.getParameter("nbChambres")));
            annonce.setType(req.getParameter("type"));
            annonce.setEquipements(req.getParameter("equipements"));

            String contactEmail = req.getParameter("contactEmail");
            String contactTelephone = req.getParameter("contactTelephone");
            String imageUrl = req.getParameter("imageUrl");

            if (contactEmail != null && !contactEmail.trim().isEmpty()) {
                annonce.setContactEmail(contactEmail);
            }
            if (contactTelephone != null && !contactTelephone.trim().isEmpty()) {
                annonce.setContactTelephone(contactTelephone);
            }
            if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                annonce.setImageUrl(imageUrl);
            }

            boolean success = annonceDAO.updateAnnonce(annonce, utilisateur.getId());
            if (success) {
                session.setAttribute("success", "Annonce modifiée avec succès !");
                resp.sendRedirect(req.getContextPath() + "/annonce?action=MesAnnonces");
            } else {
                req.setAttribute("error", "Erreur lors de la modification");
                req.setAttribute("annonce", annonce);
                req.setAttribute("action", "update");
                req.getRequestDispatcher("/jsp/annonces/form.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur: " + e.getMessage());
            listMesAnnonces(req, resp);
        }
    }

    private void deleteAnnonce(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("utilisateur") == null) {
            req.getRequestDispatcher("/jsp/login.jsp").forward(req, resp);
            return;
        }

        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        if (!isProprietaire(utilisateur)) {
            req.setAttribute("error", "Accès refusé");
            listAnnonce(req, resp);
            return;
        }

        try {
            Long id = Long.parseLong(req.getParameter("id"));
            boolean success = annonceDAO.deleteAnnonce(id, utilisateur.getId());
            if (success) {
                session.setAttribute("success", "Annonce supprimée avec succès !");
            } else {
                session.setAttribute("error", "Erreur lors de la suppression");
            }
            resp.sendRedirect(req.getContextPath() + "/annonce?action=MesAnnonces");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Erreur: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/annonce?action=MesAnnonces");
        }
    }

    private void toggleDisponibilite(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("utilisateur") == null) {
            req.getRequestDispatcher("/jsp/login.jsp").forward(req, resp);
            return;
        }

        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        if (!isProprietaire(utilisateur)) {
            req.setAttribute("error", "Accès refusé");
            listAnnonce(req, resp);
            return;
        }

        try {
            Long id = Long.parseLong(req.getParameter("id"));
            Annonce annonce = annonceDAO.getAnnonceById(id);
            if (annonce == null || !annonce.getProprietaire().getId().equals(utilisateur.getId())) {
                session.setAttribute("error", "Annonce introuvable ou accès refusé");
                resp.sendRedirect(req.getContextPath() + "/annonce?action=MesAnnonces");
                return;
            }

            boolean success = annonce.getDisponible()
                    ? annonceDAO.marquerNonDisponible(id, utilisateur.getId())
                    : annonceDAO.reactiverAnnonce(id, utilisateur.getId());

            if (success) {
                session.setAttribute("success", "Disponibilité modifiée avec succès !");
            } else {
                session.setAttribute("error", "Erreur lors de la modification");
            }

            resp.sendRedirect(req.getContextPath() + "/annonce?action=MesAnnonces");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Erreur: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/annonce?action=MesAnnonces");
        }
    }

    @Override
    public void destroy() {
        if (annonceDAO != null) {
            annonceDAO.close();
        }
        super.destroy();
        System.out.println("AnnonceServlet détruit et DAO fermé");
    }
}