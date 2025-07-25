<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Storage Order</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 20px;
                background-color: #f5f5f5;
            }
            .container {
                max-width: 1200px;
                margin: 0 auto;
                background-color: white;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            h1 {
                color: #333;
                border-bottom: 2px solid #333;
                padding-bottom: 10px;
            }
            .form-group {
                margin-bottom: 15px;
            }
            label {
                display: inline-block;
                width: 150px;
                font-weight: bold;
            }
            select, input[type="number"], input[type="text"] {
                padding: 8px;
                width: 250px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            .btn {
                background-color: #4CAF50;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                text-decoration: none;
                margin-right: 10px;
            }
            .btn:hover {
                background-color: #45a049;
            }
            .btn-secondary {
                background-color: #6c757d;
            }
            .btn-secondary:hover {
                background-color: #5a6268;
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
                background-color: #f2f2f2;
            }
            .add-item-btn {
                background-color: #2196F3;
                margin-bottom: 20px;
            }
            .add-item-btn:hover {
                background-color: #0b7dda;
            }
            .remove-btn {
                background-color: #f44336;
            }
            .remove-btn:hover {
                background-color: #d32f2f;
            }
            .total-row {
                font-weight: bold;
                background-color: #f2f2f2;
            }
            .message {
                padding: 10px;
                margin-bottom: 15px;
                border-radius: 4px;
            }
            .success {
                background-color: #dff0d8;
                color: #3c763d;
            }
            .error {
                background-color: #f2dede;
                color: #a94442;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Create Storage Order to Supplier</h1>

            <form id="orderForm" action="${pageContext.request.contextPath}/orderToSupplier" method="POST">
                <div class="form-group">
                    <label for="supplierId">Supplier:</label>
                    <!-- Dropdown for supplier selection -->
                    <select id="supplierId" name="supplierId" required>
                        <option value="supplier">-- Select Supplier --</option>
                        <c:forEach items="${suppliers}" var="s">
                            <option value="${s.supplierID}">${s.sname}</option>
                        </c:forEach>
                    </select>
                </div>

                <h3>Order Items</h3>
                <button type="button" class="btn add-item-btn" onclick="addItemRow()">Add Item</button>

                <table id="itemsTable">
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th>Quantity</th>
                            <th>Unit Price ($)</th>
                            <th>Total ($)</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <select name="goodId" class="product-select" required onchange="updatePrice(this)">
                                    <option value="">-- Select Product --</option>
                                    <c:forEach items="${products}" var="p">
                                        <c:forEach items="${products}" var="p"> 
                                            <option value="${p.furnitureID}" data-price="${p.cost}"> 
                                                ${p.furnitureName} (${p.brand}) - $${p.cost} 
                                            </option> 
                                        </c:forEach>
                                    </c:forEach>
                                </select>
                            </td>
                            <td><input type="number" name="quantity" min="1" value="1" class="quantity" required onchange="calculateRowTotal(this)"></td>
                            <td class="unit-price">0.00</td>
                            <td class="item-total">0.00</td>
                            <td><button type="button" class="btn remove-btn" onclick="removeItemRow(this)">Remove</button></td>
                        </tr>
                    </tbody>
                    <tfoot>
                        <tr class="total-row">
                            <td colspan="3" style="text-align: right;">Grand Total:</td>
                            <td id="grand-total">0.00</td>
                            <td></td>
                        </tr>
                    </tfoot>
                </table>

                <input type="hidden" id="totalAmount" name="totalAmount" value="0">

                <div class="form-group">
                    <input type="submit" class="btn" value="Place Order">
                    <a href="inventoryDashboard.jsp" class="btn btn-secondary">Cancel</a>
                </div>


                <script>
                    // Clone and add a new item row
                    function addItemRow() {
                        const tbody = document.querySelector('#itemsTable tbody');
                        const firstRow = tbody.querySelector('tr');
                        const newRow = firstRow.cloneNode(true);

                        // Reset fields
                        const select = newRow.querySelector('.product-select');
                        select.selectedIndex = 0;

                        newRow.querySelector('.quantity').value = 1;
                        newRow.querySelector('.unit-price').textContent = '0.00';
                        newRow.querySelector('.item-total').textContent = '0.00';

                        // Reattach event listeners
                        select.onchange = function () {
                            updatePrice(this);
                        };
                        newRow.querySelector('.quantity').onchange = function () {
                            calculateRowTotal(this);
                        };
                        newRow.querySelector('.remove-btn').onclick = function () {
                            removeItemRow(this);
                        };

                        tbody.appendChild(newRow);
                    }

                    // Remove a row or reset if it's the last one
                    function removeItemRow(button) {
                        const row = button.closest('tr');
                        const tbody = document.querySelector('#itemsTable tbody');
                        if (tbody.rows.length > 1) {
                            row.remove();
                        } else {
                            // Reset the only row
                            row.querySelector('.product-select').selectedIndex = 0;
                            row.querySelector('.quantity').value = 1;
                            row.querySelector('.unit-price').textContent = '0.00';
                            row.querySelector('.item-total').textContent = '0.00';
                        }
                        calculateGrandTotal();
                    }

                    // Update unit price and recalculate total
                    function updatePrice(select) {
                        const selectedOption = select.options[select.selectedIndex];
                        const price = parseFloat(selectedOption.getAttribute('data-price')) || 0;
                        const row = select.closest('tr');
                        row.querySelector('.unit-price').textContent = price.toFixed(2);

                        calculateRowTotal(row.querySelector('.quantity'));
                    }

                    // Calculate total for one row
                    function calculateRowTotal(input) {
                        const row = input.closest('tr');
                        const price = parseFloat(row.querySelector('.unit-price').textContent) || 0;
                        const quantity = parseInt(row.querySelector('.quantity').value) || 0;
                        const total = price * quantity;
                        row.querySelector('.item-total').textContent = total.toFixed(2);
                        calculateGrandTotal();
                    }

                    // Calculate grand total
                    function calculateGrandTotal() {
                        let grandTotal = 0;
                        document.querySelectorAll('#itemsTable tbody tr').forEach(row => {
                            const total = parseFloat(row.querySelector('.item-total').textContent) || 0;
                            grandTotal += total;
                        });
                        document.getElementById('grand-total').textContent = grandTotal.toFixed(2);
                        document.getElementById('totalAmount').value = grandTotal.toFixed(2);
                    }

                    // Initial setup
                    document.addEventListener('DOMContentLoaded', function () {
                        document.querySelector('.product-select').onchange = function () {
                            updatePrice(this);
                        };
                        document.querySelector('.quantity').onchange = function () {
                            calculateRowTotal(this);
                        };
                        document.querySelector('.remove-btn').onclick = function () {
                            removeItemRow(this);
                        };
                        calculateGrandTotal();
                    });
                </script>
                </body>
                </html>