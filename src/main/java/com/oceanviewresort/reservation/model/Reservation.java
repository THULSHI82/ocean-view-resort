package com.oceanviewresort.reservation.model;

import java.time.LocalDate;

public class Reservation {
    private int id;

    private int customerId;
    private int roomId;

    private String customerName;
    private String customerPhone;
    private String customerEmail;

    private LocalDate checkIn;
    private LocalDate checkOut;

    private double totalPrice;

    public Reservation() {}

    public Reservation(int id, int customerId, int roomId, String customerName,
                       String customerPhone, String customerEmail,
                       LocalDate checkIn, LocalDate checkOut, double totalPrice) {
        this.id = id;
        this.customerId = customerId;
        this.roomId = roomId;
        this.customerName = customerName;
        this.customerPhone = customerPhone;
        this.customerEmail = customerEmail;
        this.checkIn = checkIn;
        this.checkOut = checkOut;
        this.totalPrice = totalPrice;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public int getRoomId() { return roomId; }
    public void setRoomId(int roomId) { this.roomId = roomId; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getCustomerPhone() { return customerPhone; }
    public void setCustomerPhone(String customerPhone) { this.customerPhone = customerPhone; }

    public String getCustomerEmail() { return customerEmail; }
    public void setCustomerEmail(String customerEmail) { this.customerEmail = customerEmail; }

    public LocalDate getCheckIn() { return checkIn; }
    public void setCheckIn(LocalDate checkIn) { this.checkIn = checkIn; }

    public LocalDate getCheckOut() { return checkOut; }
    public void setCheckOut(LocalDate checkOut) { this.checkOut = checkOut; }

    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }
}