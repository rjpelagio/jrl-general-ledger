

<%@ page import="com.app.AppUser" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'appUser.label', default: 'AppUser')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${appUserInstance}">
            <div class="errors">
                <g:renderErrors bean="${appUserInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${appUserInstance?.id}" />
                <g:hiddenField name="version" value="${appUserInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td  class="name">
                                  <label for="party"><g:message code="appUser.party.label" default="Employee" /></label>
                                </td>
                                <td>${appUserInstance.party.name}</td>
                            </tr>
                            
                            <tr class="prop">
                                <td  class="name">
                                  <label for="username"><g:message code="appUser.username.label" default="Username" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: appUserInstance, field: 'username', 'errors')}">
                                    ${appUserInstance.username}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="name">
                                  <label for="role"><g:message code="appUser.role.label" default="Role" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: appUserInstance, field: 'role', 'errors')}">
                                    <g:select name="role" from="${roleList}" optionKey="id" 
                                        optionValue="roleName" value="${appUserInstance?.role?.id}"  />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
