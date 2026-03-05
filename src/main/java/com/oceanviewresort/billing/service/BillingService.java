package com.oceanviewresort.billing.service;

import com.oceanviewresort.billing.dao.BillingDAO;
import com.oceanviewresort.billing.model.Billing;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class BillingService {

    private BillingDAO billingDAO = new BillingDAO();

    public Billing calculateBill(int reservationId) {

        Billing bill = billingDAO.getBillingDetails(reservationId);

        if (bill == null) return null;

        LocalDate checkIn = LocalDate.parse(bill.getCheckInDate());
        LocalDate checkOut = LocalDate.parse(bill.getCheckOutDate());

        long nights = ChronoUnit.DAYS.between(checkIn, checkOut);

        bill.setNights((int) nights);

        BigDecimal total = bill.getPricePerNight()
                .multiply(BigDecimal.valueOf(nights));

        bill.setTotalAmount(total);

        return bill;
    }
}