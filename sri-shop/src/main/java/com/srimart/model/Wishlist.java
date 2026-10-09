package com.srimart.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Wishlist {

    private int wishlistId;
    private int buyerId;
    private int productId;
    private Timestamp createdAt;

    private String productName;
    private BigDecimal productPrice;
    private String productImage;

    public Wishlist() {
    }

    public Wishlist(int wishlistId, int buyerId, int productId,
                    Timestamp createdAt) {
        this.wishlistId = wishlistId;
        this.buyerId = buyerId;
        this.productId = productId;
        this.createdAt = createdAt;
    }

    public Wishlist(int buyerId, int productId) {
        this.buyerId = buyerId;
        this.productId = productId;
    }

    public int getWishlistId() {
        return wishlistId;
    }

    public void setWishlistId(int wishlistId) {
        this.wishlistId = wishlistId;
    }

    public int getBuyerId() {
        return buyerId;
    }

    public void setBuyerId(int buyerId) {
        this.buyerId = buyerId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public BigDecimal getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(BigDecimal productPrice) {
        this.productPrice = productPrice;
    }

    public String getProductImage() {
        return productImage;
    }

    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }
}