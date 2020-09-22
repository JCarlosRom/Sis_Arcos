document.addEventListener('DOMContentLoaded', function() {
    fixMainHeight();

    window.addEventListener('resize', function(){
        fixMainHeight();
    });
});

function fixMainHeight() {
    if(window.innerHeight < document.body.offsetHeight) {
        const mainSlideMenu = document.getElementsByClassName('main-slide-menu')[0];
        const mainContainer = document.getElementsByTagName('main')[0];
        
        if(!mainSlideMenu || !mainContainer) return;
        
        const mainSlideMenuHeight = mainSlideMenu.offsetHeight;
        
        mainContainer.style.minHeight = mainSlideMenuHeight+"px";
    }
}

$("#danger").on("click", function(){
    
    
    
    if($("#CheckDanger").css("display")=="none"){
        $("#CheckDanger").css("display","block");
        $("#danger").css("textShadow","white 1px 1px 1px");
    }else{
        $("#CheckDanger").css("display","none");
        $("#danger").css("textShadow","white 0px 0px 0px");
    }

})


$("#Info").on("click", function(){
    
    if($("#CheckInfo").css("display")=="none"){
        $("#CheckInfo").css("display","block");
        $("#Info").css("textShadow","white 1px 1px 1px");
    }else{
        $("#CheckInfo").css("display","none");
        $("#Info").css("textShadow","white 0px 0px 0px");
    }

})

$("#Alert").on("click", function(){
    
    if($("#CheckAlert").css("display")=="none"){
        $("#CheckAlert").css("display","block");
        $("#Alert").css("textShadow","white 1px 1px 1px");
    }else{
        $("#CheckAlert").css("display","none");
        $("#Alert").css("textShadow","white 0px 0px 0px");
    }

})