

<%@ page import="com.app.AppRole" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'appRole.label', default: 'AppRole')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/dashBoard/list')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${appRoleInstance}">
            <div class="errors">
                <g:renderErrors bean="${appRoleInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${appRoleInstance?.id}" />
                <g:hiddenField name="version" value="${appRoleInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td  class="sub">
                                  <label for="roleCode"><g:message code="appRole.roleCode.label" default="Role Code" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: appRoleInstance, field: 'roleCode', 'errors')}">
                                    <g:textField name="roleCode" value="${appRoleInstance?.roleCode}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="sub">
                                  <label for="roleName"><g:message code="appRole.roleName.label" default="Role Name" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: appRoleInstance, field: 'roleName', 'errors')}">
                                    <g:textField name="roleName" value="${appRoleInstance?.roleName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="sub">
                                  <label for="parent"><g:message code="appRole.parent.label" default="Parent" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: appRoleInstance, field: 'parent', 'errors')}">
                                    <g:select name="parent.id" from="${com.app.AppRole.list()}" optionKey="id" value="${appRoleInstance?.parent?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
