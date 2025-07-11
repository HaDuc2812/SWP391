<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Store Order Request</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f0f2f5;
                margin: 0;
                padding: 20px;
            }
            .form-container {
                background: white;
                padding: 30px;
                max-width: 900px;
                margin: auto;
                border-radius: 8px;
                box-shadow: 0 0 15px rgba(0,0,0,0.1);
            }
            h1 {
                text-align: center;
                color: #333;
            }
            .form-group {
                margin: 20px 0;
            }
            label {
                font-weight: bold;
                display: block;
                margin-bottom: 5px;
            }
            select, input[type="number"] {
                width: 100%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                padding: 12px;
                border: 1px solid #ccc;
            }
            th {
                background-color: #e67e22;
                color: white;
            }
            .btn {
                background-color: #e67e22;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                margin-top: 20px;
                cursor: pointer;
            }
            .btn:hover {
                background-color: #d35400;
            }
        </style>
    </head>
    <body>
        <div class="form-container">
            <h1>Store Order Request</h1>
            <form action="${pageContext.request.contextPath}/shoporder" method="post">
                <input type="hidden" name="orderType" value="STORE">

                <div class="form-group">
                    <label for="storeId">Requesting Store:</label>
                    <select id="storeId" name="storeId" required>
                        <option value="">-- Select Store --</option>
                        <c:forEach items="${stores}" var="store">
                            <option value="${store.storeId}">
                                ${store.storeName} (${store.location})
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <table id="itemsTable">
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th>Available Qty</th>
                            <th>Request Qty</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <select name="goodId[]" required onchange="updateAvailable(this)">
                                    <option value="">-- Select Product --</option>
                                    <c:forEach items="${furnitureList}" var="f">
                                        <option value="${f.comboID}" data-stock="${f.stockQuantity}">
                                            ${f.comboName} (${f.brand})
                                        </option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td class="available">-</td>
                            <td><input type="number" name="quantity[]" min="1" required></td>
                            <td><button type="button" class="btn" onclick="addRow()">Add</button></td>
                        </tr>
                    </tbody>
                </table>

                <div style="text-align: right;">
                    <button type="submit" class="btn">Submit Order</button>
                </div>
            </form>
        </div>

        <script>
            function addRow() {
                const tbody = document.querySelector("#itemsTable tbody");
                const firstRow = tbody.rows[0];
                const newRow = firstRow.cloneNode(true);
                newRow.querySelectorAll("select, input").forEach(el => el.value = "");
                newRow.querySelector(".available").textContent = "-";
                tbody.appendChild(newRow);
            }

            function updateAvailable(select) {
                const stock = select.options[select.selectedIndex].getAttribute("data-stock");
                const td = select.closest("tr").querySelector(".available");
                td.textContent = stock || "0";
            }
        </script>
    </body>
</html>
