package com.oceanviewresort.billing.model;

import java.math.BigDecimal;


public class Billing {

    private int reservationId;
    private String customerName;
    private String roomNumber;
    private String checkInDate;
    private String checkOutDate;
    private int nights;
    private BigDecimal pricePerNight;
    private BigDecimal totalAmount;
    private java.math.BigDecimal subTotal;
    private java.math.BigDecimal serviceCharge;
    private java.math.BigDecimal tax;
    private java.math.BigDecimal grandTotal;

    public int getReservationId() {
        return reservationId;
    }

    public void setReservationId(int reservationId) {
        this.reservationId = reservationId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public String getCheckInDate() {
        return checkInDate;
    }

    public void setCheckInDate(String checkInDate) {
        this.checkInDate = checkInDate;
    }

    public String getCheckOutDate() {
        return checkOutDate;
    }

    public void setCheckOutDate(String checkOutDate) {
        this.checkOutDate = checkOutDate;
    }

    public int getNights() {
        return nights;
    }

    public void setNights(int nights) {
        this.nights = nights;
    }

    public BigDecimal getPricePerNight() {
        return pricePerNight;
    }

    public void setPricePerNight(BigDecimal pricePerNight) {
        this.pricePerNight = pricePerNight;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public java.math.BigDecimal getSubTotal() { return subTotal; }
    public void setSubTotal(java.math.BigDecimal subTotal) { this.subTotal = subTotal; }

    public java.math.BigDecimal getServiceCharge() { return serviceCharge; }
    public void setServiceCharge(java.math.BigDecimal serviceCharge) { this.serviceCharge = serviceCharge; }

    public java.math.BigDecimal getTax() { return tax; }
    public void setTax(java.math.BigDecimal tax) { this.tax = tax; }

    public java.math.BigDecimal getGrandTotal() { return grandTotal; }
    public void setGrandTotal(java.math.BigDecimal grandTotal) { this.grandTotal = grandTotal; }

}