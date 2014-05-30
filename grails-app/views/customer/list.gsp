

<%@ page import="com.ar.Customer" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'customer.label', default: 'Customer')}" />
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
                                    <label for="customerCode"><g:message code="customer.customerCode.label" default="Customer Code" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'customerCode', 'errors')}">
                                    <g:textField name="customerCode" value="${customerInstance?.customerCode}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="customerName"><g:message code="customer.customerName.label" default="Customer Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'customerName', 'errors')}">
                                    <g:textField name="customerName" value="${customerInstance?.customerName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="creditLimit"><g:message code="customer.creditLimit.label" default="Credit Limit" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'creditLimit', 'errors')}">
                                    <g:textField name="creditLimit" value="${fieldValue(bean: customerInstance, field: 'creditLimit')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="creditTerm"><g:message code="customer.creditTerm.label" default="Credit Term" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: customerInstance, field: 'creditTerm', 'errors')}">
                                    <g:textField name="creditTerm" value="${customerInstance?.creditTerm}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'customer.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="customerCode" title="${message(code: 'customer.customerCode.label', default: 'Customer Code')}" />
                        
                            <g:sortableColumn property="customerName" title="${message(code: 'customer.customerName.label', default: 'Customer Name')}" />
                        
                            <g:sortableColumn property="creditLimit" title="${message(code: 'customer.creditLimit.label', default: 'Credit Limit')}" />
                        
                            <g:sortableColumn property="creditTerm" title="${message(code: 'customer.creditTerm.label', default: 'Credit Term')}" />
                        
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${customerInstanceList}" status="i" var="customerInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${customerInstance.id}">${fieldValue(bean: customerInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: customerInstance, field: "customerCode")}</td>
                        
                            <td>${fieldValue(bean: customerInstance, field: "customerName")}</td>
                        
                            <td>${fieldValue(bean: customerInstance, field: "creditLimit")}</td>
                        
                            <td>${fieldValue(bean: customerInstance, field: "creditTerm")}</td>
                        
                            <td>
                                <g:link action="edit" id="${customerInstance.id}">
                                    Edit
                                </g:link>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${customerInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
