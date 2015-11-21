<!DOCTYPE html>
<html>
    <head>
        <title><g:layoutTitle default="Grails" /></title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'default.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'navMenu.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css/custom-theme',file:'jquery-ui-1.8.16.custom.css')}" />
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        <calendar:resources lang="en" theme="tiger"/>
        <g:javascript library="application" />
        <g:javascript library="jquery-1.6.2.min"/>
        <g:javascript library="jquery-ui-1.8.16.custom.min"/>
        <g:javascript library="validator"/>
        <g:layoutHead />
        <script type="text/javascript">
        $(function(){
            if ( $(document).height() > $(".leftnav").height() ) {
                $(".leftnav").height($(document).height() - 50)
            } else {
                $(".leftnav").height($(".leftnav").height() - 50)
            }
            $(".rightnav").height($(".leftnav").height());
        });
        </script>
    </head>
    <body>
        <div id="mainwrapper">
            <div id="mainwrapper2">
                <div id="spinner" class="spinner" style="display:none;">
                    <img src="${resource(dir:'images',file:'spinner.gif')}" alt="${message(code:'spinner.alt',default:'Loading...')}" />
                </div>
             <!-- Header Snippet -->
                <g:render template="/layouts/header" />
                
                <g:if test="${session.user != null}">
                    <g:render template="/layouts/appPanel" />
                </g:if>
                <g:if test="${session.user != null}">
                    <div id="leftnav" class="leftnav">
                    </div> 
                    <div id="rightnav" class="rightnav">
                    </div> 
                </g:if>
                
                <g:layoutBody />

                <!-- Footer Snippet -->
                <g:render template="/layouts/footer" />
            </div>
        </div>
     </body>
     
</html>
