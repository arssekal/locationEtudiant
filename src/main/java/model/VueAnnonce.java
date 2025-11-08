package model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "vues_annonces")
public class VueAnnonce {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "annonce_id", nullable = false)
    private Annonce annonce;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "utilisateur_id")
    private Utilisateur utilisateur;

    @Column(name = "date_vue", nullable = false)
    private LocalDateTime dateVue;

    @Column(name = "ipAddress", length = 255)
    private String ipAddress;

    @Column(name = "user_agent", length = 255)
    private String userAgent;

    // Constructeurs
    public VueAnnonce() {
        this.dateVue = LocalDateTime.now();
    }

    public VueAnnonce(Annonce annonce, Utilisateur utilisateur) {
        this.annonce = annonce;
        this.utilisateur = utilisateur;
        this.dateVue = LocalDateTime.now();
    }

    public VueAnnonce(Annonce annonce, Utilisateur utilisateur, String ipAddress, String userAgent) {
        this.annonce = annonce;
        this.utilisateur = utilisateur;
        this.dateVue = LocalDateTime.now();
        this.ipAddress = ipAddress;
        this.userAgent = userAgent;
    }

    // Getters et Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Annonce getAnnonce() {
        return annonce;
    }

    public void setAnnonce(Annonce annonce) {
        this.annonce = annonce;
    }

    public Utilisateur getUtilisateur() {
        return utilisateur;
    }

    public void setUtilisateur(Utilisateur utilisateur) {
        this.utilisateur = utilisateur;
    }

    public LocalDateTime getDateVue() {
        return dateVue;
    }

    public void setDateVue(LocalDateTime dateVue) {
        this.dateVue = dateVue;
    }

    public String getIpAddress() {
        return ipAddress;
    }

    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }

    public String getUserAgent() {
        return userAgent;
    }

    public void setUserAgent(String userAgent) {
        this.userAgent = userAgent;
    }

    @Override
    public String toString() {
        return "VueAnnonce{" +
                "id=" + id +
                ", annonce=" + (annonce != null ? annonce.getId() : null) +
                ", utilisateur=" + (utilisateur != null ? utilisateur.getId() : null) +
                ", dateVue=" + dateVue +
                ", ipAddress='" + ipAddress + '\'' +
                '}';
    }
}