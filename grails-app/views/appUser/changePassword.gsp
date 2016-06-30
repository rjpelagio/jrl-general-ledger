

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
            <span class="menuButton"><a class="home" href="${createLink(uri: '/dashBoard/list')}"><g:message code="default.home.label"/></a></span>
        </div>
        <div class="body">
            <h1><g:message code="appUser.changepassword.label" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${appUserInstance}">
            <div class="errors">
                <g:renderErrors bean="${appUserInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post">
                <g:hiddenField name="id" value="${appUserInstance?.id}" />
                <g:hiddenField name="version" value="${appUserInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td  class="value ${hasErrors(bean: appUserInstance, field: 'oldpassword', 'errors')}">
                                  <label for="oldpassword"><g:message code="appUser.oldpassword.label" default="Old Password" /></label>
                                </td>
                                <td  class="value">
                                    <g:passwordField name="oldpassword" value="" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td  class="value ${hasErrors(bean: appUserInstance, field: 'password', 'errors')}">
                                  <label for="password"><g:message code="appUser.password.label" default="New Password" /></label>
                                </td>
                                <td  class="value">
                                    <g:passwordField name="password" value="" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td  class="value ${hasErrors(bean: appUserInstance, field: 'confirmpassword', 'errors')}">
                                  <label for="confirmpassword"><g:message code="appUser.confirmpassword.label" default="Confirm Password" /></label>
                                </td>
                                <td  class="value">
                                    <g:passwordField name="confirmpassword" value="" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="savepassword" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
