

<%@ page import="com.app.AppRole" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'appRole.label', default: 'AppRole')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/dashBoard/list')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="roleCode" title="${message(code: 'appRole.roleCode.label', default: 'Role Code')}" />
                        
                            <g:sortableColumn property="roleName" title="${message(code: 'appRole.roleName.label', default: 'Role Name')}" />
                        
                            <th><g:message code="appRole.parent.label" default="Parent" /></th>
                        
                            <g:sortableColumn property="dateCreated" title="${message(code: 'appRole.dateCreated.label', default: 'Date Created')}" />
                        
                            <g:sortableColumn property="lastUpdated" title="${message(code: 'appRole.lastUpdated.label', default: 'Last Updated')}" />
                        
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${appRoleInstanceList}" status="i" var="appRoleInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${appRoleInstance.id}">${fieldValue(bean: appRoleInstance, field: "roleCode")}</g:link></td>
                        
                            <td>${fieldValue(bean: appRoleInstance, field: "roleName")}</td>
                        
                            <td>${fieldValue(bean: appRoleInstance, field: "parent")}</td>
                        
                            <td><g:formatDate format="yyyy-MM-dd" date="${appRoleInstance.dateCreated}" /></td>
                        
                            <td><g:formatDate format="yyyy-MM-dd" date="${appRoleInstance.lastUpdated}" /></td>
                        
                            <td>
                                <g:link action="edit" id="${appRoleInstance.id}">
                                    Edit
                                </g:link>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${appRoleInstanceTotal}" /> Record ${appRoleInstanceTotal} of ${appRoleInstanceTotal}
            </div>
        </div>
    </body>
</html>
