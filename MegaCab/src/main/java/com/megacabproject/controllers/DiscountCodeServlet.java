package com.megacabproject.controllers;

import com.megacabproject.models.DiscountCode;
import com.megacabproject.services.DiscountCodeService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import org.json.JSONObject;

/**
 * DiscountCodeServlet handles discount code validation via GET method.
 * - **Presentation Layer (Controller):** Delegates business logic to DiscountCodeService.
 * - **Design Patterns:** Singleton (Service instance), DAO via Service.
 * - **OOP Concepts:** Encapsulation (private fields), Abstraction (service methods).
 * - **Web Services:** Only GET and POST methods (no REST API).
 */
@WebServlet("/DiscountCodeServlet")
public class DiscountCodeServlet extends HttpServlet {
    private final DiscountCodeService discountCodeService = new DiscountCodeService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String discountCode = request.getParameter("discountCode");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        JSONObject jsonResponse = new JSONObject();

        if (discountCode == null || discountCode.trim().isEmpty()) {
            jsonResponse.put("error", "Discount code is missing.");
        } else {
            DiscountCode code = discountCodeService.validateDiscountCode(discountCode.trim());
            if (code != null) {
                jsonResponse.put("valid", true);
                jsonResponse.put("percentage", code.getPercentage());
            } else {
                jsonResponse.put("valid", false);
                jsonResponse.put("error", "Invalid discount code.");
            }
        }
        out.print(jsonResponse.toString());
        out.flush();
    }
}