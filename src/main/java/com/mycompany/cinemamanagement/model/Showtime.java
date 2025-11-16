package com.mycompany.cinemamanagement.model;

import java.sql.Date;
import java.sql.Time;

public class Showtime {

    private int id;
    private Date showDate;     // map với show_date
    private Time startTime;    // map với start_time
    private Time endTime;      // map với end_time

    private Room room;         // map với room_id
    private Movie movie;       // map với movie_id

    private double price;      // map với price

    public Showtime() {}

    // ===== Getter & Setter =====

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getShowDate() {
        return showDate;
    }

    public void setShowDate(Date showDate) {
        this.showDate = showDate;
    }

    public Time getStartTime() {
        return startTime;
    }

    public void setStartTime(Time startTime) {
        this.startTime = startTime;
    }

    public Time getEndTime() {
        return endTime;
    }

    public void setEndTime(Time endTime) {
        this.endTime = endTime;
    }

    public Room getRoom() {
        return room;
    }

    public void setRoom(Room room) {
        this.room = room;
    }

    public Movie getMovie() {
        return movie;
    }

    public void setMovie(Movie movie) {
        this.movie = movie;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
}
