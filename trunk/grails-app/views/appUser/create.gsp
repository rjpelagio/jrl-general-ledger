

<%@ page import="com.app.AppUser" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'appUser.label', default: 'AppUser')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${appUserInstance}">
            <div class="errors">
                <g:renderErrors bean="${appUserInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="party"><g:message code="appUser.party.label" default="Employee" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: appUserInstance, field: 'party', 'errors')}">
                                    <g:select name="party.id" from="${employeeDropDown}" optionKey="party_id" optionValue="name" value="${appUserInstance?.party?.id}" noSelection="['null':'']" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="username"><g:message code="appUser.username.label" default="Username" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: appUserInstance, field: 'username', 'errors')}">
                                    <g:textField name="username" value="${appUserInstance?.username}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="password"><g:message code="appUser.password.label" default="Password" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: appUserInstance, field: 'password', 'errors')}">
                                    <g:passwordField name="password" value="${appUserInstance?.password}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="role"><g:message code="appUser.role.label" default="Role" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: appUserInstance, field: 'role', 'errors')}">
                                    <g:select name="role.id" from="${com.app.AppRole.list()}" optionKey="id" value="${appUserInstance?.role?.id}"  />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
