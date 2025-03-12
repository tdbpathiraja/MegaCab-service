package com.megacabproject.models;

import java.sql.Timestamp;

/**
 * DiscountCode Model Class
 * - Represents a discount code entry in the database.
 * - **OOP Concepts Used:** Encapsulation (private fields with public getters/setters),
 *   Abstraction (hiding implementation details).
 * - **Design Patterns:** Plain POJO (Plain Old Java Object) used as a Data Model.
 */
public class DiscountCode {
    private int id;
    private String discountCode;
    private double percentage;
    private Timestamp createdAt;

    // Default constructor
    public DiscountCode() {}

    // Full constructor
    public DiscountCode(int id, String discountCode, double percentage, Timestamp createdAt) {
        this.id = id;
        this.discountCode = discountCode;
        this.percentage = percentage;
        this.createdAt = createdAt;
    }

    // Getters and Setters (Public Accessors)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDiscountCode() {
        return discountCode;
    }

    public void setDiscountCode(String discountCode) {
        this.discountCode = discountCode;
    }

    public double getPercentage() {
        return percentage;
    }

    public void setPercentage(double percentage) {
        this.percentage = percentage;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}