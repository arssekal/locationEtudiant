package model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "annonces")
public class Annonce {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String titre;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String description;

    @Column(nullable = false)
    private String adresse;

    @Column(nullable = false)
    private String ville;

    @Column(nullable = false)
    private Double prix;

    @Column(nullable = false)
    private Integer superficie;

    @Column(nullable = false)
    private Integer nbChambres;

    @Column(nullable = false)
    private String type; // Studio, Appartement, etc.

    @Column
    private String imageUrl;

    @Column(nullable = false)
    private Boolean disponible = true;

    @Column
    private String equipements;

    @Column
    private String contactEmail;

    @Column
    private String contactTelephone;

    @Column(name = "nombre_vues")
    private Integer nombreVues;

    @Column(name = "date_creation")
    private LocalDateTime dateCreation;

    private LocalDateTime datePublication;

    // ✅ Relation correcte avec Utilisateur (propriétaire)
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "proprietaire_id", nullable = false)
    private Utilisateur proprietaire;

    @OneToMany(mappedBy = "annonce")
    private List<Message> messages;

    @OneToMany(mappedBy = "annonce")
    private List<Favori> favoris;

    // --- Constructeurs ---
    public Annonce() {}

    public Annonce(Long id, String titre, String description, String adresse, String ville,
                   Double prix, Integer superficie, Integer nbChambres, String type,
                   String imageUrl, Boolean disponible, Utilisateur proprietaire,
                   String equipements, String contactEmail, String contactTelephone) {
        this.id = id;
        this.titre = titre;
        this.description = description;
        this.adresse = adresse;
        this.ville = ville;
        this.prix = prix;
        this.superficie = superficie;
        this.nbChambres = nbChambres;
        this.type = type;
        this.imageUrl = imageUrl;
        this.disponible = disponible;
        this.proprietaire = proprietaire;
        this.equipements = equipements;
        this.contactEmail = contactEmail;
        this.contactTelephone = contactTelephone;
        this.dateCreation = LocalDateTime.now();
    }

    // --- Getters et Setters ---
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTitre() { return titre; }
    public void setTitre(String titre) { this.titre = titre; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getAdresse() { return adresse; }
    public void setAdresse(String adresse) { this.adresse = adresse; }

    public String getVille() { return ville; }
    public void setVille(String ville) { this.ville = ville; }

    public Double getPrix() { return prix; }
    public void setPrix(Double prix) { this.prix = prix; }

    public Integer getSuperficie() { return superficie; }
    public void setSuperficie(Integer superficie) { this.superficie = superficie; }

    public Integer getNbChambres() { return nbChambres; }
    public void setNbChambres(Integer nbChambres) { this.nbChambres = nbChambres; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public Boolean getDisponible() { return disponible; }
    public void setDisponible(Boolean disponible) { this.disponible = disponible; }

    public String getEquipements() { return equipements; }
    public void setEquipements(String equipements) { this.equipements = equipements; }

    public String getContactEmail() { return contactEmail; }
    public void setContactEmail(String contactEmail) { this.contactEmail = contactEmail; }

    public String getContactTelephone() { return contactTelephone; }
    public void setContactTelephone(String contactTelephone) { this.contactTelephone = contactTelephone; }

    public Integer getNombreVues() { return nombreVues; }
    public void setNombreVues(Integer nombreVues) { this.nombreVues = nombreVues; }

    public LocalDateTime getDateCreation() { return dateCreation; }
    public void setDateCreation(LocalDateTime dateCreation) { this.dateCreation = dateCreation; }

    public LocalDateTime getDatePublication() { return datePublication; }
    public void setDatePublication(LocalDateTime datePublication) { this.datePublication = datePublication; }

    public Utilisateur getProprietaire() { return proprietaire; }
    public void setProprietaire(Utilisateur proprietaire) { this.proprietaire = proprietaire; }

    public List<Message> getMessages() { return messages; }
    public void setMessages(List<Message> messages) { this.messages = messages; }

    public List<Favori> getFavoris() { return favoris; }
    public void setFavoris(List<Favori> favoris) { this.favoris = favoris; }

    @Override
    public String toString() {
        return "Annonce{" +
                "id=" + id +
                ", titre='" + titre + '\'' +
                ", description='" + description + '\'' +
                ", adresse='" + adresse + '\'' +
                ", ville='" + ville + '\'' +
                ", prix=" + prix +
                ", superficie=" + superficie +
                ", nbChambres=" + nbChambres +
                ", type='" + type + '\'' +
                ", imageUrl='" + imageUrl + '\'' +
                ", disponible=" + disponible +
                ", proprietaire=" + proprietaire +
                ", equipements='" + equipements + '\'' +
                ", contactEmail='" + contactEmail + '\'' +
                ", contactTelephone='" + contactTelephone + '\'' +
                ", dateCreation=" + dateCreation +
                ", nombreVues=" + nombreVues +
                '}';
    }
}
