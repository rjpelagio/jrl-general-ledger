

<%@ page import="com.ar.Salesman" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'salesman.label', default: 'Salesman')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="table-header">
              <g:message code="default.button.search.label" args="[entityName]" />
            </div>
            <g:form action="list">
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="agentCode"><g:message code="salesman.agentCode.label" default="Agent Code" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: salesmanInstance, field: 'agentCode', 'errors')}">
                                    <g:textField name="agentCode" value="${salesmanInstance?.agentCode}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastName"><g:message code="salesman.lastName.label" default="Last Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: salesmanInstance, field: 'lastName', 'errors')}">
                                    <g:textField name="lastName" maxlength="50" value="${salesmanInstance?.lastName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="firstName"><g:message code="salesman.firstName.label" default="First Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: salesmanInstance, field: 'firstName', 'errors')}">
                                    <g:textField name="firstName" maxlength="50" value="${salesmanInstance?.firstName}" />
                                </td>
                            </tr>
                        
                            <tr>
                                <td></td>
                                <td>
                                    <g:submitButton name="search" class="save" value="Search" /></span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </g:form>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'salesman.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="agentCode" title="${message(code: 'salesman.agentCode.label', default: 'Agent Code')}" />
                        
                            <g:sortableColumn property="lastName" title="${message(code: 'salesman.lastName.label', default: 'Last Name')}" />
                        
                            <g:sortableColumn property="firstName" title="${message(code: 'salesman.firstName.label', default: 'First Name')}" />
                        
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${salesmanInstanceList}" status="i" var="salesmanInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${salesmanInstance.id}">${fieldValue(bean: salesmanInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: salesmanInstance, field: "agentCode")}</td>
                        
                            <td>${fieldValue(bean: salesmanInstance, field: "lastName")}</td>
                        
                            <td>${fieldValue(bean: salesmanInstance, field: "firstName")}</td>
                        
                            <td>
                                <g:link action="edit" id="${salesmanInstance.id}">
                                    Edit
                                </g:link>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${salesmanInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
