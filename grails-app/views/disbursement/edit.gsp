

<%@ page import="com.cash.Disbursement" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'disbursement.label', default: 'Disbursement')}" />
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
            <g:hasErrors bean="${disbursementInstance}">
            <div class="errors">
                <g:renderErrors bean="${disbursementInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${disbursementInstance?.id}" />
                <g:hiddenField name="version" value="${disbursementInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="status"><g:message code="disbursement.status.label" default="Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: disbursementInstance, field: 'status', 'errors')}">
                                    <g:select name="status" from="${disbursementInstance.constraints.status.inList}" value="${disbursementInstance?.status}" valueMessagePrefix="disbursement.status"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="description"><g:message code="disbursement.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: disbursementInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${disbursementInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="disbursementNumber"><g:message code="disbursement.disbursementNumber.label" default="Disbursement Number" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: disbursementInstance, field: 'disbursementNumber', 'errors')}">
                                    <g:textField name="disbursementNumber" value="${disbursementInstance?.disbursementNumber}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="preparedBy"><g:message code="disbursement.preparedBy.label" default="Prepared By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: disbursementInstance, field: 'preparedBy', 'errors')}">
                                    <g:select name="preparedBy.id" from="${com.app.Party.list()}" optionKey="id" value="${disbursementInstance?.preparedBy?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="total"><g:message code="disbursement.total.label" default="Total" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: disbursementInstance, field: 'total', 'errors')}">
                                    <g:textField name="total" value="${fieldValue(bean: disbursementInstance, field: 'total')}" />
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
