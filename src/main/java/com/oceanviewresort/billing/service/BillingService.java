package com.oceanviewresort.billing.service;

import com.oceanviewresort.billing.dao.BillingDAO;
import com.oceanviewresort.billing.model.Billing;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class BillingService {

    private final BillingDAO billingDAO = new BillingDAO();

    public Billing calculateBill(int reservationId) {

        Billing bill = billingDAO.getBillingDetails(reservationId);

        if (bill == null) {
            return null;
        }

        LocalDate checkIn = LocalDate.parse(bill.getCheckInDate());
        LocalDate checkOut = LocalDate.parse(bill.getCheckOutDate());

        long nights = ChronoUnit.DAYS.between(checkIn, checkOut);

        if (nights <= 0) {
            nights = 1;
        }

        bill.setNights((int) nights);

        BigDecimal subTotal = bill.getPricePerNight()
                .multiply(BigDecimal.valueOf(nights))
                .setScale(2, RoundingMode.HALF_UP);

        BigDecimal serviceCharge = subTotal
                .multiply(new BigDecimal("0.10"))
                .setScale(2, RoundingMode.HALF_UP);

        BigDecimal tax = subTotal
                .multiply(new BigDecimal("0.02"))
                .setScale(2, RoundingMode.HALF_UP);

        BigDecimal grandTotal = subTotal
                .add(serviceCharge)
                .add(tax)
                .setScale(2, RoundingMode.HALF_UP);

        bill.setSubTotal(subTotal);
        bill.setServiceCharge(serviceCharge);
        bill.setTax(tax);
        bill.setGrandTotal(grandTotal);

        // compatibility with previous field
        bill.setTotalAmount(grandTotal);

        return bill;
    }
}