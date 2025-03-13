package com.megacabproject.services;

import com.megacabproject.dao.DiscountCodeDAO;
import com.megacabproject.models.DiscountCode;


public class DiscountCodeService {
    private final DiscountCodeDAO discountCodeDAO = new DiscountCodeDAO();


    public DiscountCode validateDiscountCode(String discountCode) {
        return discountCodeDAO.getDiscountByCode(discountCode);
    }
}