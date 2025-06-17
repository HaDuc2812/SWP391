<%-- 
    Document   : MainPage
    Created on : Jun 17, 2025, 3:15:46 PM
    Author     : HA DUC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <h2>Search Results for "${searchKey}"</h2>
    <c:forEach var="goods" items="${results}">
        <div>
            <h3>${goods.name}</h3>
            <p>Price: ${goods.price}</p>
            <img src="${goods.image}" width="100"/>
        </div>
    </c:forEach>
    <c:if test="${empty results}">
        <p>No results found.</p>
    </c:if>
</html>
