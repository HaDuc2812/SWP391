<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html> 
<html> 
    <head> 
        <meta charset="UTF-8"> 
        <title>Shop Place Order</title>
        <style>
            .body {
                font-family: Arial, sans-serif;
                margin: 30px;
                background-color: #f5f5f5;
            }
            .form-container {
                background: white;
                padding: 25px;
                border-radius: 8px;
                max-width: 900px;
                margin: auto;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            h1 {
                text-align: center;
                color: #2c3e50;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                padding: 10px;
                border: 1px solid #ddd;
            }
            th {
                background-color: #3498db;
                color: white;
            }
            select, input[type="number"] {
                width: 100%;
                padding: 6px;
                border-radius: 4px;
                border: 1px solid #ccc;
            }
            .btn {
                padding: 8px 16px;
                margin-top: 20px;
                background-color: #3498db;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            .btn:hover {
                background-color: #2980b9;
            }
        </style> 
    </head> 
    <body> 
        <div class="form-container"> <h1>Shop Order to Storage</h1>
            <form method="post" action="${pageContext.request.contextPath}/shoporders">
                <div class="form-group">
                    <label for="shopId">Select Shop:</label>
                    <select name="shopId" id="shopId" required>
                        <option value="">-- Select Shop --</option>
                        <c:forEach items="${shops}" var="s">
                            <option value="${s.shopId}">${s.shopName} (${s.location})</option>
                        </c:forEach>
                    </select>
                </div>

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
                    <tbody> <tr>
                            <td>
                                <select name="goodId[]" class="product-select" required onchange="updatePrice(this)"> 
                                    <option value="">-- Select Product --</option> 
                                    <c:forEach items="${products}" var="p"> 
                                        <option value="${p.comboID}" data-price="${p.cost}"> ${p.comboName} (${p.brand}) - $${p.cost} </option> 
                                    </c:forEach> 
                                </select> 
                            </td> 
                            <td> 
                                <input type="number" name="quantity[]" value="1" min="1" onchange="calculateRowTotal(this)"> 
                            </td> 
                            <td class="unit-price">0.00</td> 
                            <td class="item-total">0.00</td> 
                            <td> <input type="hidden" name="price[]" class="price-field" value="0.00"> 
                                <button type="button" class="btn" onclick="removeRow(this)">Remove</button> 
                            </td> 
                        </tr>
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan="3" style="text-align: right;"><strong>Grand Total:</strong></td>
                            <td id="grand-total">0.00</td>
                            <td></td>
                        </tr>
                    </tfoot>
                </table>

                <input type="hidden" name="totalAmount" id="totalAmount" value="0">
                <button type="button" class="btn" onclick="addRow()">Add Item</button>
                <button type="submit" class="btn">Place Order</button>

            </form>
            <a href="inventoryDashboard.jsp" class="btn">← Return to Dashboard</a>

        </div> 
        <script>
            function updatePrice(select) {
                const price = parseFloat(select.selectedOptions[0].getAttribute("data-price")) || 0;
                const row = select.closest("tr");

                // Set visible unit price
                row.querySelector(".unit-price").textContent = price.toFixed(2);

                // Set hidden input price value
                row.querySelector(".price-field").value = price.toFixed(2);

                calculateRowTotal(select);
            }

            function calculateRowTotal(el) {
                const row = el.closest("tr");

                const qtyInput = row.querySelector("input[name='quantity[]']");
                const qty = parseInt(qtyInput.value) || 0;

                const price = parseFloat(row.querySelector(".unit-price").textContent) || 0;
                const total = qty * price;

                row.querySelector(".item-total").textContent = total.toFixed(2);
                updateGrandTotal();
            }

            function updateGrandTotal() {
                let sum = 0;
                document.querySelectorAll(".item-total").forEach(td => {
                    sum += parseFloat(td.textContent) || 0;
                });
                document.getElementById("grand-total").textContent = sum.toFixed(2);
                document.getElementById("totalAmount").value = sum.toFixed(2);
            }

            function addRow() {
                const tbody = document.querySelector("#itemsTable tbody");
                const newRow = tbody.rows[0].cloneNode(true);

                // Reset select
                const productSelect = newRow.querySelector("select[name='goodId[]']");
                productSelect.selectedIndex = 0;

                // Reset quantity
                newRow.querySelector("input[name='quantity[]']").value = 1;

                // Reset hidden price field
                newRow.querySelector("input[name='price[]']").value = "0.00";

                // Reset displayed prices
                newRow.querySelector(".unit-price").textContent = "0.00";
                newRow.querySelector(".item-total").textContent = "0.00";

                tbody.appendChild(newRow);
            }

            function removeRow(button) {
                const row = button.closest("tr");
                const tbody = document.querySelector("#itemsTable tbody");

                if (tbody.rows.length > 1) {
                    row.remove();
                    updateGrandTotal();
                }
            }
        </script>
    </body> 
</html>