<%-- 
    Document   : exportForm
    Created on : Aug 1, 2025, 6:10:35 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Export Bill</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
            }
            h1 {
                color: #2c3e50;
            }
            .form-container {
                max-width: 1000px;
                margin: 0 auto;
                background: #f9f9f9;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            .form-group {
                margin-bottom: 15px;
            }
            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }
            select, input {
                width: 100%;
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px 0;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }
            th {
                background-color: #e67e22;
                color: white;
            }
            .btn {
                padding: 8px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                text-decoration: none;
                color: white;
            }
            .btn-primary {
                background-color: #3498db;
            }
            .btn-success {
                background-color: #2ecc71;
            }
            .btn-danger {
                background-color: #e74c3c;
            }
            .total-row {
                font-weight: bold;
                background-color: #f2f2f2;
            }
            .remove-btn {
                background-color: #e74c3c;
                color: white;
                border: none;
                padding: 5px 10px;
                border-radius: 3px;
                cursor: pointer;
            }
            .error {
                color: #e74c3c;
                margin-bottom: 15px;
                padding: 10px;
                background-color: #fadbd8;
                border-radius: 4px;
            }
        </style>
    </head>
    <body>
        <div class="form-container">
            <h1>Create New Export Bill</h1>

            <c:if test="${not empty error}">
                <div class="error">${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/export/create" method="post">
                <div class="form-group">
                    <label for="shopId">Shop:</label>
                    <select id="shopId" name="shopId" required>
                        <option value="">-- Select Shop --</option>
                        <c:forEach items="${shops}" var="shop">
                            <option value="${shop.shopId}">${shop.shopName} (${shop.location})</option>
                        </c:forEach>
                    </select>
                </div>

                <h3>Items</h3>
                <table id="itemsTable">
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th>Available</th>
                            <th>Quantity</th>
                            <th>Unit Price ($)</th>
                            <th>Total ($)</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <select name="productId" class="product-select" required>
                                    <option value="">-- Select Product --</option>
                                    <c:forEach items="${products}" var="product">
                                        <option value="${product.furnitureID}" 
                                                data-stock="${product.stockQuantity}" 
                                                data-price="${product.cost}">
                                            ${product.furnitureName} (${product.brand})
                                        </option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td class="available-stock">-</td>
                            <td><input type="number" name="quantity" min="1" value="1" class="quantity" required></td>
                            <td><input type="number" name="price" step="0.01" min="0" class="unit-price" required></td>
                            <td class="item-total">0.00</td>
                            <td><button type="button" class="remove-btn">Remove</button></td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <tr class="total-row">
                            <td colspan="4" style="text-align: right;">Grand Total:</td>
                            <td id="grand-total">0.00</td>
                            <td></td>
                        </tr>
                    </tfoot>
                </table>

                <button type="button" id="addItem" class="btn btn-primary">Add Item</button>
                <button type="submit" class="btn btn-success">Create Export Bill</button>
                <a href="${pageContext.request.contextPath}/export/list" class="btn btn-danger">Cancel</a>
            </form>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Add new item row
                document.getElementById('addItem').addEventListener('click', function () {
                    const tbody = document.querySelector('#itemsTable tbody');
                    const newRow = tbody.rows[0].cloneNode(true);

                    // Reset values
                    newRow.querySelector('.product-select').selectedIndex = 0;
                    newRow.querySelector('.available-stock').textContent = '-';
                    newRow.querySelector('.quantity').value = 1;
                    newRow.querySelector('.unit-price').value = '';
                    newRow.querySelector('.item-total').textContent = '0.00';

                    // Add event listeners
                    addRowEventListeners(newRow);

                    tbody.appendChild(newRow);
                });

                // Add event listeners to initial row
                const initialRow = document.querySelector('#itemsTable tbody tr');
                addRowEventListeners(initialRow);

                // Function to add event listeners to a row
                function addRowEventListeners(row) {
                    const productSelect = row.querySelector('.product-select');
                    const quantityInput = row.querySelector('.quantity');
                    const priceInput = row.querySelector('.unit-price');
                    const totalCell = row.querySelector('.item-total');
                    const removeBtn = row.querySelector('.remove-btn');
                    const availableStockCell = row.querySelector('.available-stock');

                    // Update stock and price when product changes
                    productSelect.addEventListener('change', function () {
                        const selectedOption = this.options[this.selectedIndex];
                        const stock = selectedOption.getAttribute('data-stock') || '0';
                        const price = selectedOption.getAttribute('data-price') || '0';

                        availableStockCell.textContent = stock;
                        priceInput.value = price;
                        validateQuantity(this);
                        calculateRowTotal(this);
                    });

                    // Validate quantity against available stock
                    quantityInput.addEventListener('input', function () {
                        validateQuantity(this);
                        calculateRowTotal(this);
                    });

                    // Calculate total when price changes
                    priceInput.addEventListener('input', function () {
                        calculateRowTotal(this);
                    });

                    // Remove row
                    removeBtn.addEventListener('click', function () {
                        const tbody = document.querySelector('#itemsTable tbody');
                        if (tbody.rows.length > 1) {
                            row.remove();
                            calculateGrandTotal();
                        }
                    });

                    // Validate quantity doesn't exceed available stock
                    function validateQuantity(input) {
                        const row = input.closest('tr');
                        const availableStock = parseInt(row.querySelector('.available-stock').textContent) || 0;
                        const quantityInput = row.querySelector('.quantity');
                        let quantity = parseInt(quantityInput.value) || 0;

                        if (quantity > availableStock) {
                            quantityInput.setCustomValidity('Quantity cannot exceed available stock');
                            quantityInput.reportValidity();
                        } else {
                            quantityInput.setCustomValidity('');
                        }
                    }
                }

                // Calculate row total
                function calculateRowTotal(input) {
                    const row = input.closest('tr');
                    const quantity = parseFloat(row.querySelector('.quantity').value) || 0;
                    const price = parseFloat(row.querySelector('.unit-price').value) || 0;
                    const total = quantity * price;
                    row.querySelector('.item-total').textContent = total.toFixed(2);
                    calculateGrandTotal();
                }

                // Calculate grand total
                function calculateGrandTotal() {
                    let grandTotal = 0;
                    document.querySelectorAll('#itemsTable .item-total').forEach(cell => {
                        grandTotal += parseFloat(cell.textContent) || 0;
                    });
                    document.getElementById('grand-total').textContent = grandTotal.toFixed(2);
                }
            });
        </script>
    </body>
</html>
