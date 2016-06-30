

<%@ page import="com.app.AppOrganization" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'appOrganization.label', default: 'AppOrganization')}" />
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
                        
                            <g:sortableColumn property="organizationCode" title="${message(code: 'appOrganization.organizationCode.label', default: 'Organization Code')}" />
                        
                            <g:sortableColumn property="organizationName" title="${message(code: 'appOrganization.organizationName.label', default: 'Organization Name')}" />
                        
                            <g:sortableColumn property="organizationType" title="${message(code: 'appOrganization.organizationType.label', default: 'Organization Type')}" />
                        
                            <th><g:message code="appOrganization.party.label" default="Party" /></th>
                        
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${appOrganizationInstanceList}" status="i" var="appOrganizationInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${appOrganizationInstance.id}">${fieldValue(bean: appOrganizationInstance, field: "organizationCode")}</g:link></td>
                        
                            <td>${fieldValue(bean: appOrganizationInstance, field: "organizationName")}</td>
                        
                            <td>${fieldValue(bean: appOrganizationInstance, field: "organizationType")}</td>
                        
                            <td>${fieldValue(bean: appOrganizationInstance, field: "party")}</td>
                        
                            <td>
                                <g:link action="edit" id="${appOrganizationInstance.id}">
                                    Edit
                                </g:link>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${appOrganizationInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
