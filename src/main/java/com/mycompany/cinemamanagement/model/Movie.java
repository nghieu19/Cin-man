package com.mycompany.cinemamanagement.model;

import java.util.Date;

public class Movie {
    private int id;
    private String name;
    private String type;
    private Date yearOfProduction;
    private String director;
    private String actor;
    private String language;
    private String duration;
    private String description;
    private String notes; // 🔹 mới thêm

    public Movie() {}

    public Movie(String name, String type, Date yearOfProduction, String director,
                 String actor, String language, String duration,
                 String description, String notes) {
        this.name = name;
        this.type = type;
        this.yearOfProduction = yearOfProduction;
        this.director = director;
        this.actor = actor;
        this.language = language;
        this.duration = duration;
        this.description = description;
        this.notes = notes;
    }

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getMovieName() { return name; }
    public void setMovieName(String name) { this.name = name; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public Date getYearOfProduction() { return yearOfProduction; }
    public void setYearOfProduction(Date yearOfProduction) { this.yearOfProduction = yearOfProduction; }

    public String getDirector() { return director; }
    public void setDirector(String director) { this.director = director; }

    public String getActor() { return actor; }
    public void setActor(String actor) { this.actor = actor; }

    public String getLanguage() { return language; }
    public void setLanguage(String language) { this.language = language; }

    public String getDuration() { return duration; }
    public void setDuration(String duration) { this.duration = duration; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
}
