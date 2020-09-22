<%-- 
    Document   : Header
    Created on : 22-sep-2020, 13:08:31
    Author     : ADMIN
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
 <nav class="main-navbar navbar navbar-expand-lg">
    <a class="navbar-brand" href="index.htm">
        <img class="img-fluid" src="images/logo-kiotrack-blanco.png" alt="kiotrack-logo">
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#mainNavContent"
            aria-controls="mainNavContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="main-navbar_content collapse navbar-collapse" id="mainNavContent">
        <ul class="navbar-nav">
            <li class="nav-item center">
                Arcos
            </li>
        </ul>
        <ul class="main-navbar_options navbar-nav">
            <li class="nav-item center">
                <button class="btn btn-mute-action" onclick="this.classList.toggle('muted')">
                    <div class="mn-option-icon"></div>
                    <span class="mn-option-text-sm">silenciar <br> asistente</span>
                </button>
            </li>
            <li class="nav-item d-flex center">
                <div>
                    <span class="d-block"> <%= session.getAttribute("usuario")%> </span>
                    <a class="mn-logout-link" href="<c:url value="logout.htm" />">Cerrar sesión</a>
                </div>
                <div class="mn-option-profile-img">
                    <img width="50px" height="50px" style="border-radius: 20px;" src="images/persona.png" alt="user">
                    <!--<i class="fas fa-user-circle"></i>-->
                </div>
            </li>
        </ul>
    </div>
</nav>
                
<nav class="content-navbar">
    <div class="container-fluid">
        <div class="row no-gutters">
            <div class="col-md-2">
                <div class="cn-wrapper no-border">
                    <a class="cn-bars d-flex flex-no-wrap align-items-center" href="" data-toggle="slide-menu"
                       data-target="#main-slide-nav">
                        <i class="fas fa-bars"></i>
                        <div class="cn-title">
                            <h5>MENU</h5>
                        </div>
                    </a>
                </div>
            </div>

            <!-- AQUI SE PONE EL PORCENTAJE DE CRITICO, ALERTA, INFORMATIVO -->

            <div id="div_promedio">
            </div>
            
            <div class="col-md-5">

                <div class="dropdown">

                    <div class="ds-success btn" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="margin-top: 4px;">
                        <div class="display-status">
                            <i class="ds-icon ds-success" style="font-size:25px;"></i>
                            <p style="color:white; font-weight:bold;margin-top: 27px; position:absolute; font-size:12px;margin-left: 2px;">${counterErrorDB}</p>
                        </div>
                    </div>
                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                        <c:forEach var="bdd" items="${bddRemotas}">
                            <c:if test = "${bdd.getAccesodatos() == 1}">
                                <div class="dropdown-item">
                                    <div class="display-status">
                                        <i class="ds-icon ds-success" id="${bdd.getId()}"></i>
                                        <span class="ds-msg"> ${bdd.getNombre()}</span>
                                    </div>
                                </div>

                            </c:if>
                            <c:if test = "${bdd.getAccesodatos() == 0}">
                                <div class="dropdown-item">
                                    <div class="display-status">
                                        <i class="ds-icon ds-danger" id="${bdd.getId()}"></i>
                                        <span class="ds-msg"> ${bdd.getNombre()}</span>
                                    </div>
                                </div>

                            </c:if>
                        </c:forEach>  

                    </div>
                  </div>

            </div>
        </div>
    </div>
</nav>