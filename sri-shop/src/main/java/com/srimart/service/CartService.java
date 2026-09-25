package com.srimart.service;

import com.srimart.dao.CartDAO;
import com.srimart.model.CartItem;

import java.sql.SQLException;
import java.util.List;

public class CartService {

    private final CartDAO cartDAO;

    public CartService() {
        this.cartDAO = new CartDAO();
    }

    // Add product to cart
    public boolean addToCart(long buyerId, long productId, int quantity)
            throws SQLException {

        if (buyerId <= 0 || productId <= 0 || quantity <= 0) {
            return false;
        }

        CartItem cartItem = new CartItem(
                buyerId,
                productId,
                quantity
        );

        return cartDAO.addToCart(cartItem);
    }

    // Get buyer's cart
    public List<CartItem> getCartItems(long buyerId)
            throws SQLException {

        if (buyerId <= 0) {
            return List.of();
        }

        return cartDAO.getCartItems(buyerId);
    }

    // Update quantity
    public boolean updateQuantity(
            long buyerId,
            long productId,
            int quantity) throws SQLException {

        if (buyerId <= 0 || productId <= 0 || quantity <= 0) {
            return false;
        }

        return cartDAO.updateQuantity(
                buyerId,
                productId,
                quantity
        );
    }

    // Remove product from cart
    public boolean removeFromCart(
            long buyerId,
            long productId) throws SQLException {

        if (buyerId <= 0 || productId <= 0) {
            return false;
        }

        return cartDAO.removeFromCart(
                buyerId,
                productId
        );
    }

    // Clear complete cart
    public boolean clearCart(long buyerId)
            throws SQLException {

        if (buyerId <= 0) {
            return false;
        }

        return cartDAO.clearCart(buyerId);
    }
}