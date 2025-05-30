<%-- 
    Document   : editProfile
    Created on : May 30, 2025, 2:13:06 PM
    Author     : HA DUC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <main class="row justify-content-center">
        <div class="col-md-6">
            <h2 class="text-center">Edit Profile</h2>
            <c:if test="${not empty mess}">
                <p class="text-center" style="">${mess}</p>
            </c:if>
            <form action="updateuser" method="POST" class="mb-3">
                <input type="hidden" name="field" value="name">
                <div class="mb-3 d-flex align-items-center">
                    <input type="text" id="name" name="value" class="form-control me-2" style="width: 70%;" placeholder="Name">
                    <button type="submit" class="btn btn-primary" style="width: 20%;">Update</button>
                </div>
            </form>
            <form action="updateuser" method="POST" class="mb-3">
                <input type="hidden" name="field" value="phone">
                <div class="mb-3 d-flex align-items-center">
                    <input type="text" id="phone" name="value" class="form-control me-2" style="width: 70%;" placeholder="Phone">
                    <button type="submit" class="btn btn-primary" style="width: 20%;">Update</button>
                </div>
            </form>
            <form action="updateuser" method="POST" class="mb-3">
                <input type="hidden" name="field" value="address">
                <div class="mb-3 d-flex align-items-center">
                    <input type="text" id="address" name="value" class="form-control me-2" style="width: 70%;" placeholder="Address">
                    <button type="submit" class="btn btn-primary" style="width: 20%;">Update</button>
                </div>
            </form>
            <form action="updateuser" method="POST" class="mb-3">
                <input type="hidden" name="field" value="password">
                <div class="mb-3 d-flex align-items-center">
                    <input type="password" id="password" name="value" class="form-control me-2" style="width: 70%;" placeholder="Password">
                    <button type="submit" class="btn btn-primary" style="width: 20%;">Update</button>
                </div>
            </form>
        </div>
    </main>
    </body>
</html>
