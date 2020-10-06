S<%-- 
    Document   : Header
    Created on : 22-sep-2020, 13:08:31
    Author     : ADMIN
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="css/header.css" />
 <nav class="main-navbar navbar navbar-expand-lg">
    <a class="navbar-brand" href="index.htm">
        <img class="img-fluid" style="height:40px; width:185px;" src="images/XilionLogo.jpeg" alt="kiotrack-logo">
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#mainNavContent"
            aria-controls="mainNavContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="main-navbar_content collapse navbar-collapse" id="mainNavContent">
        <ul class="navbar-nav">
         
        </ul>
        <ul class="main-navbar_options navbar-nav">
          
            </li>
            <li class="nav-item d-flex center">
              
                <div class="mn-option-profile-img">
                    <img width="50px" height="50px" style="border-radius: 20px;" src="images/persona.png" alt="user">
                    <!--<i class="fas fa-user-circle"></i>-->
                </div>
            </li>
        </ul>
    </div>
</nav>

 <div class="row" style="background-color:rgb(26,117,207);">
    
     <div class="col-md-4">
        <ul class="nav">
            <li class="nav-item">
              <a class="nav-link" href="#">Inicio</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">Análitica</a>
            </li>
            <li class="nav-item">
              <a class="nav-link active" href="#">Consulta</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">Ayuda</a>
            </li>
      </ul>
     </div>
    
 </div>
 
 <div class="row" style="position:absolute; width: 100%;">
    <div class="col-md-1"></div>
    
    <div class="col-md-2">
    
    </div>
    
    <div class="col-md-6"></div>
    
    <div class="col-md-2" style="margin-left:10px; z-index: 2;">
        <div style="margin-top:10px;">
            <img src="images/Grafica.PNG"></img>
        </div>
        <div class="row">
            <div class="col-md-3">
                 <div class="dropdown">
                    <div class="ds-success btn" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="margin-top: 4px;">
                        <div class="display-status">
                            <i class="ds-icon ds-success" style="font-size:25px; color: rgb(26,117,207);"></i>
                            <p style="color:white; font-weight:bold;margin-top: 27px; position:absolute; font-size:12px;margin-left: 2px;">${counterErrorDB}</p>
                        </div>
                    </div>
                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton" style="background-color: black;">
                        <c:forEach var="bdd" items="${bddRemotas}">
                            <c:if test = "${bdd.getAccesodatos() == 1}">
                                <div class="dropdown-item">
                                    <div class="display-status">
                                        <i class="ds-icon ds-success" id="${bdd.getId()}" style="font-size:25px; color: white;"></i>
                                        <span class="ds-msg"> ${bdd.getNombre()}</span>
                                    </div>
                                </div>

                            </c:if>
                            <c:if test = "${bdd.getAccesodatos() == 0}">
                                <div class="dropdown-item">
                                    <div class="display-status">
                                        <i class="ds-icon ds-danger" id="${bdd.getId()}" style="font-size:20px; color: white;"></i>
                                        <span class="ds-msg"> ${bdd.getNombre()}</span>
                                    </div>
                                </div>

                            </c:if>
                        </c:forEach>  
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="dropdown">
                    <div class="ds-success btn" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="margin-top: 4px;">
                        <div class="display-status">
                            <i class="fas fa-layer-group ds-success iconDrowpdownLect"></i>
                            <i class="far fa-circle iconDrowpdownLectStatus" aria-hidden="true" ></i>
                            <p class="lectNo" >${counterLecturas}</p>
                        </div>
                    </div>
                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton" style="background-color: black; width: 110%;">
                        <c:forEach var="Lectura" items="${lecturas}">
                            <c:if test = "${Lectura.getStatus()==1}">
                                <div class="dropdown-item">
                                    <div class="display-status">
                                        <img src="images/ico-arcos-white.png" alt="" >
                                        <i class="far fa-circle lecturaError" aria-hidden="true" ></i>
                                        <i class="ds-success"> </i>
                                        <span class="ds-msg" style="width:35px;"> ${Lectura.getClave()}</span>
                                        <span class="ds-msg"> ${Lectura.getNombre()} </span>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test = "${Lectura.getStatus()==2}">
                                <div class="dropdown-item">
                                    <div class="display-status">
                                        <img src="images/ico-arcos-white.png" alt="" >
                                        <i class="far fa-circle lecturaWarning" aria-hidden="true" ></i>
                                        <i class="ds-success"> </i>
                                        <span class="ds-msg" style="width:35px;"> ${Lectura.getClave()}</span>
                                        <span class="ds-msg"> ${Lectura.getNombre()} </span>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test = "${Lectura.getStatus()==3}">
                                <div class="dropdown-item">
                                    <div class="display-status">
                                        <img src="images/ico-arcos-white.png" alt="" >
                                        <i class="far fa-circle lecturaSuccess" aria-hidden="true"  ></i>
                                        <i class="ds-success"> </i>
                                        <span class="ds-msg" style="width:35px;"> ${Lectura.getClave()}</span>
                                        <span class="ds-msg"> ${Lectura.getNombre()} </span>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                     
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="dropdown">
                    <div class="ds-success btn" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="margin-top: 4px;">
                        <div class="display-status">
                            <i class="fas fa-exclamation-triangle ds-success iconDrowpdownLect"></i>
                            <i class="far fa-circle iconDrowpdownLectStatus" aria-hidden="true" ></i>
                            <p class="lectNo" >${counterAlertasPendientes}</p>
                        </div>
                    </div>
                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton" style="background-color: black; width: 210px;">
                        <c:forEach var="alertasPendientes" items="${alertasPendientes}">
                   
                                <div class="dropdown-item">
                                    <div class="display-status">
                                        <i class="ds-success"> </i>
                                        <span class="ds-msg"> ${alertasPendientes.getClave()} </span>
                                        <span class="ds-msg" style="width:35px;"> ${alertasPendientes.getNombre()}</span>
                                    </div>
                                </div>
                
                        </c:forEach>
                     
                    </div>
                </div>
            </div>
        </div>
        <div class="row" style="width:330px;" id="alertasNotification">
        
          
            
        </div>   
                     
       
    </div>

 </div>
