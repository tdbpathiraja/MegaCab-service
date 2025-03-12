package com.megacabproject.services;

import com.megacabproject.dao.DiscountCodeDAO;
import com.megacabproject.models.DiscountCode;

/**
 * DiscountCodeService handles business logic for discount codes.
 * - **Layered Architecture:** Business Layer abstraction over DAO operations.
 * - **Design Patterns:** Uses DAO (to abstract database details).
 * - **OOP Concepts:** Encapsulation and Abstraction.
 */
public class DiscountCodeService {
    private final DiscountCodeDAO discountCodeDAO = new DiscountCodeDAO();

    /**
     * Validates a discount code and returns the associated discount percentage.
     *
     * @param discountCode The discount code to check.
     * @return DiscountCode object if valid; null if not.
     */
    public DiscountCode validateDiscountCode(String discountCode) {
        return discountCodeDAO.getDiscountByCode(discountCode);
    }
}