package com.srimart.dao;

import com.srimart.model.Product;
import com.srimart.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    // ADD PRODUCT
    public boolean addProduct(Product product) {

        String sql = """
                INSERT INTO products
                (seller_id, name, description, category, size, color,
                 price, stock_quantity, image_url)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setLong(1, product.getSellerId());
            statement.setString(2, product.getName());
            statement.setString(3, product.getDescription());
            statement.setString(4, product.getCategory());
            statement.setString(5, product.getSize());
            statement.setString(6, product.getColor());
            statement.setBigDecimal(7, product.getPrice());
            statement.setInt(8, product.getStockQuantity());
            statement.setString(9, product.getImageUrl());

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    // GET ALL PRODUCTS
    public List<Product> getAllProducts() {

        List<Product> products = new ArrayList<>();

        String sql = """
                SELECT product_id,
                       seller_id,
                       name,
                       description,
                       category,
                       size,
                       color,
                       price,
                       stock_quantity,
                       image_url
                FROM products
                ORDER BY product_id DESC
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet =
                     statement.executeQuery()) {

            while (resultSet.next()) {

                Product product = new Product();

                product.setProductId(
                        resultSet.getLong("product_id"));

                product.setSellerId(
                        resultSet.getLong("seller_id"));

                product.setName(
                        resultSet.getString("name"));

                product.setDescription(
                        resultSet.getString("description"));

                product.setCategory(
                        resultSet.getString("category"));

                product.setSize(
                        resultSet.getString("size"));

                product.setColor(
                        resultSet.getString("color"));

                product.setPrice(
                        resultSet.getBigDecimal("price"));

                product.setStockQuantity(
                        resultSet.getInt("stock_quantity"));

                product.setImageUrl(
                        resultSet.getString("image_url"));

                products.add(product);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }


    // SEARCH PRODUCTS
    public List<Product> searchProducts(String searchTerm) {

        List<Product> products = new ArrayList<>();

        String sql = """
                SELECT product_id,
                       seller_id,
                       name,
                       description,
                       category,
                       size,
                       color,
                       price,
                       stock_quantity,
                       image_url
                FROM products
                WHERE LOWER(name) LIKE LOWER(?)
                   OR LOWER(description) LIKE LOWER(?)
                   OR LOWER(category) LIKE LOWER(?)
                   OR LOWER(color) LIKE LOWER(?)
                   OR LOWER(size) LIKE LOWER(?)
                ORDER BY product_id DESC
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            String keyword = "%" + searchTerm.trim() + "%";

            statement.setString(1, keyword);
            statement.setString(2, keyword);
            statement.setString(3, keyword);
            statement.setString(4, keyword);
            statement.setString(5, keyword);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                while (resultSet.next()) {

                    Product product = new Product();

                    product.setProductId(
                            resultSet.getLong("product_id"));

                    product.setSellerId(
                            resultSet.getLong("seller_id"));

                    product.setName(
                            resultSet.getString("name"));

                    product.setDescription(
                            resultSet.getString("description"));

                    product.setCategory(
                            resultSet.getString("category"));

                    product.setSize(
                            resultSet.getString("size"));

                    product.setColor(
                            resultSet.getString("color"));

                    product.setPrice(
                            resultSet.getBigDecimal("price"));

                    product.setStockQuantity(
                            resultSet.getInt("stock_quantity"));

                    product.setImageUrl(
                            resultSet.getString("image_url"));

                    products.add(product);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }


    // GET PRODUCTS BY SELLER
    public List<Product> getProductsBySeller(Long sellerId) {

        List<Product> products = new ArrayList<>();

        String sql = """
                SELECT product_id,
                       seller_id,
                       name,
                       description,
                       category,
                       size,
                       color,
                       price,
                       stock_quantity,
                       image_url
                FROM products
                WHERE seller_id = ?
                ORDER BY product_id DESC
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setLong(1, sellerId);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                while (resultSet.next()) {

                    Product product = new Product();

                    product.setProductId(
                            resultSet.getLong("product_id"));

                    product.setSellerId(
                            resultSet.getLong("seller_id"));

                    product.setName(
                            resultSet.getString("name"));

                    product.setDescription(
                            resultSet.getString("description"));

                    product.setCategory(
                            resultSet.getString("category"));

                    product.setSize(
                            resultSet.getString("size"));

                    product.setColor(
                            resultSet.getString("color"));

                    product.setPrice(
                            resultSet.getBigDecimal("price"));

                    product.setStockQuantity(
                            resultSet.getInt("stock_quantity"));

                    product.setImageUrl(
                            resultSet.getString("image_url"));

                    products.add(product);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }


    // GET SINGLE PRODUCT BY ID
    public Product getProductById(long productId) {

        String sql = """
                SELECT product_id,
                       seller_id,
                       name,
                       description,
                       category,
                       size,
                       color,
                       price,
                       stock_quantity,
                       image_url
                FROM products
                WHERE product_id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setLong(1, productId);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                if (resultSet.next()) {

                    Product product = new Product();

                    product.setProductId(
                            resultSet.getLong("product_id"));

                    product.setSellerId(
                            resultSet.getLong("seller_id"));

                    product.setName(
                            resultSet.getString("name"));

                    product.setDescription(
                            resultSet.getString("description"));

                    product.setCategory(
                            resultSet.getString("category"));

                    product.setSize(
                            resultSet.getString("size"));

                    product.setColor(
                            resultSet.getString("color"));

                    product.setPrice(
                            resultSet.getBigDecimal("price"));

                    product.setStockQuantity(
                            resultSet.getInt("stock_quantity"));

                    product.setImageUrl(
                            resultSet.getString("image_url"));

                    return product;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }


    // UPDATE PRODUCT
    public boolean updateProduct(Product product, long sellerId) {

        String sql = """
                UPDATE products
                SET name = ?,
                    description = ?,
                    category = ?,
                    size = ?,
                    color = ?,
                    price = ?,
                    stock_quantity = ?,
                    image_url = ?
                WHERE product_id = ?
                  AND seller_id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, product.getName());
            statement.setString(2, product.getDescription());
            statement.setString(3, product.getCategory());
            statement.setString(4, product.getSize());
            statement.setString(5, product.getColor());
            statement.setBigDecimal(6, product.getPrice());
            statement.setInt(7, product.getStockQuantity());
            statement.setString(8, product.getImageUrl());
            statement.setLong(9, product.getProductId());
            statement.setLong(10, sellerId);

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    // TOTAL PRODUCTS OF SELLER
    public int getProductCountBySeller(long sellerId)
            throws SQLException {

        String sql = """
                SELECT COUNT(*)
                FROM products
                WHERE seller_id = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setLong(1, sellerId);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                if (resultSet.next()) {
                    return resultSet.getInt(1);
                }

                return 0;
            }
        }
    }


    // LOW STOCK PRODUCTS OF SELLER
    public int getLowStockCountBySeller(long sellerId)
            throws SQLException {

        String sql = """
                SELECT COUNT(*)
                FROM products
                WHERE seller_id = ?
                AND stock_quantity <= 5
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setLong(1, sellerId);

            try (ResultSet resultSet =
                         statement.executeQuery()) {

                if (resultSet.next()) {
                    return resultSet.getInt(1);
                }

                return 0;
            }
        }
    }
}