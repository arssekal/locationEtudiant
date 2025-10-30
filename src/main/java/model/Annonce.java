package model;

import jakarta.persistence.*;  // ✅ Jakarta, pas javax
import java.util.Date;

@Entity
@Table(name = "annonces")
public class Annonce {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 200)
    private String titre;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(nullable = false)
    private Double prix;

    @Column(nullable = false, length = 100)
    private String ville;

    @Column(length = 100)
    private String quartier;

    @Column(length = 50)
    private String typeLogement;

    private Integer superficie;

    private Integer nombreChambres;

    @Column(length = 500)
    private String photoUrl;

    @Column(length = 20)
    private String telephone;

    @ManyToOne
    @JoinColumn(name = "utilisateur_id")
    private Utilisateur proprietaire;

    @Temporal(TemporalType.TIMESTAMP)
    private Date dateCreation;

    @Column(nullable = false)
    private Boolean disponible = true;

    // Constructeurs
    public Annonce() {
        this.dateCreation = new Date();
    }

    public Annonce(String titre, String description, Double prix, String ville) {
        this.titre = titre;
        this.description = description;
        this.prix = prix;
        this.ville = ville;
        this.dateCreation = new Date();
    }

    // Getters et Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getTitre() { return titre; }
    public void setTitre(String titre) { this.titre = titre; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Double getPrix() { return prix; }
    public void setPrix(Double prix) { this.prix = prix; }

    public String getVille() { return ville; }
    public void setVille(String ville) { this.ville = ville; }

    public String getQuartier() { return quartier; }
    public void setQuartier(String quartier) { this.quartier = quartier; }

    public String getTypeLogement() { return typeLogement; }
    public void setTypeLogement(String typeLogement) { this.typeLogement = typeLogement; }

    public Integer getSuperficie() { return superficie; }
    public void setSuperficie(Integer superficie) { this.superficie = superficie; }

    public Integer getNombreChambres() { return nombreChambres; }
    public void setNombreChambres(Integer nombreChambres) { this.nombreChambres = nombreChambres; }

    public String getPhotoUrl() { return photoUrl; }
    public void setPhotoUrl(String photoUrl) { this.photoUrl = photoUrl; }

    public String getTelephone() { return telephone; }
    public void setTelephone(String telephone) { this.telephone = telephone; }

    public Utilisateur getProprietaire() { return proprietaire; }
    public void setProprietaire(Utilisateur proprietaire) { this.proprietaire = proprietaire; }

    public Date getDateCreation() { return dateCreation; }
    public void setDateCreation(Date dateCreation) { this.dateCreation = dateCreation; }

    public Boolean getDisponible() { return disponible; }
    public void setDisponible(Boolean disponible) { this.disponible = disponible; }
}