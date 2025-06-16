<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .verify-container {
            background-color: #ffffff;
            padding: 40px 30px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
            text-align: center;
        }

        .verify-container h2 {
            font-size: 24px;
            color: #2c3e50;
            margin-bottom: 20px;
        }

        .verify-container input[type="text"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }

        .verify-container button {
            width: 100%;
            background-color: #2980b9;
            color: white;
            padding: 12px;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .verify-container button:hover {
            background-color: #1f6391;
        }

        .verify-container .error {
            margin-top: 10px;
            color: #e74c3c;
            font-size: 14px;
            background-color: #fcecec;
            padding: 10px;
            border-radius: 4px;
        }
    </style>
<html>
<head>
    <title>Verify Code</title>
</head>
<body>
    <h2>
        <c:choose>
            <c:when test="${sessionScope.verificationFor eq 'reset'}">
                Verify Reset Code
            </c:when>
            <c:otherwise>
                Verify Registration Code
            </c:otherwise>
        </c:choose>
    </h2>
    <form action="verify" method="post">
        <input type="text" name="code" placeholder="Enter code" required />
        <button type="submit">Verify</button>
    </form>
    <c:if test="${not empty error}"><p style="color:red;">${error}</p></c:if>
</body>
</html>
