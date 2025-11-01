package model;

import jakarta.persistence.*;

@Entity
@Table(name = "favoris")
public class Favori {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Constructeurs
    public Favori() {}

    // Getters/Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
}