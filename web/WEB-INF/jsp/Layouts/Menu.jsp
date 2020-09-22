<%-- 
    Document   : Menu
    Created on : 22-sep-2020, 16:29:37
    Author     : ADMIN
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="slide-menu main-slide-nav" id="main-slide-nav">
    <nav class="nav flex-column">
        <a class="nav-link active" href="index.htm"><i class="fas fa-home"></i> TABLERO</a>
        <a class="nav-link" href="lecturas_vehiculo.htm" ><i class="fas fa-car"></i> LECTURAS POR VEHÍCULO</a>
        <a class="nav-link" href= "<c:url value="lecturas_arco.htm" />"><i class="fas fa-archway"></i> LECTURAS POR ARCO</a>
    </nav>
</div>