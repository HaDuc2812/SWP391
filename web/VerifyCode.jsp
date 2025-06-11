<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
