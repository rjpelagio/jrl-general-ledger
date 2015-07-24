

<%@ page import="com.ar.SalesmanArea" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'salesmanArea.label', default: 'SalesmanArea')}" />
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
            <g:hasErrors bean="${salesmanAreaInstance}">
            <div class="errors">
                <g:renderErrors bean="${salesmanAreaInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>

                            <tr class="prop">
                                <td  class="name">
                                    <label for="customerCode"><g:message code="customer.customerCode.label" default="Customer Code" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: customerInstance, field: 'customerCode', 'errors')}">
                                    <g:textField name="customerCode" value="${customerInstance?.customerCode}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="name">
                                    <label for="customerName"><g:message code="customer.customerName.label" default="Customer Name" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: customerInstance, field: 'customerName', 'errors')}">
                                    <g:textField name="customerName" value="${customerInstance?.customerName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="name">
                                    <label for="creditLimit"><g:message code="customer.creditLimit.label" default="Credit Limit" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: customerInstance, field: 'creditLimit', 'errors')}">
                                    <g:textField name="creditLimit" value="${fieldValue(bean: customerInstance, field: 'creditLimit')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="name">
                                    <label for="creditTerm"><g:message code="customer.creditTerm.label" default="Credit Term" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: customerInstance, field: 'creditTerm', 'errors')}">
                                    <g:textField name="creditTerm" value="${customerInstance?.creditTerm}" />
                                </td>

                        
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
