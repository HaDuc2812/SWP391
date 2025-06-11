<%-- 
    Document   : forgotPassword
    Created on : Jun 6, 2025, 10:08:47 PM
    Author     : HA DUC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <form action="SendResetCodeServlet" method="post">
        <label>Email:</label>
        <input type="email" name="email" required />
        <input type="submit" value="Send Verification Code" />
    </form>
    <c:if test="${not empty error}"><p style="color:red;">${error}</p></c:if>
    F
</html>
