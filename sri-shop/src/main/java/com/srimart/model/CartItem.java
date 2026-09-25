package com.srimart.model;

public class CartItem {

    private long cartItemId;
    private long buyerId;
    private long productId;
    private int quantity;

    // NEW: Selected size and color
    private String size;
    private String color;

    public CartItem() {
    }

    public CartItem(long buyerId, long productId, int quantity) {
        this.buyerId = buyerId;
        this.productId = productId;
        this.quantity = quantity;
    }

    // Constructor with size and color
    public CartItem(long buyerId, long productId, int quantity,
                    String size, String color) {

        this.buyerId = buyerId;
        this.productId = productId;
        this.quantity = quantity;
        this.size = size;
        this.color = color;
    }

    public long getCartItemId() {
        return cartItemId;
    }

    public void setCartItemId(long cartItemId) {
        this.cartItemId = cartItemId;
    }

    public long getBuyerId() {
        return buyerId;
    }

    public void setBuyerId(long buyerId) {
        this.buyerId = buyerId;
    }

    public long getProductId() {
        return productId;
    }

    public void setProductId(long productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    // Size getter
    public String getSize() {
        return size;
    }

    // Size setter
    public void setSize(String size) {
        this.size = size;
    }

    // Color getter
    public String getColor() {
        return color;
    }

    // Color setter
    public void setColor(String color) {
        this.color = color;
    }
}