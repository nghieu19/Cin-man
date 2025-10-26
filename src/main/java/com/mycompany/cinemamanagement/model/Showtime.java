package com.mycompany.cinemamanagement.model;

import java.util.Date;

public class Showtime {
    private int id;
    private Date showtimeDate;
    private String timeSlot;
    private Room room;
    private Movie movie;

    public Showtime() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getShowtimeDate() {
        return showtimeDate;
    }

    public void setShowtimeDate(Date showtimeDate) {
        this.showtimeDate = showtimeDate;
    }

    public String getTimeSlot() {
        return timeSlot;
    }

    public void setTimeSlot(String timeSlot) {
        this.timeSlot = timeSlot;
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
}
