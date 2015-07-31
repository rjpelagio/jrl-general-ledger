

<%@ page import="com.cash.CashVoucher" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'cashVoucher.label', default: 'CashVoucher')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="cashAdvance.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${cashVoucherInstance}">
            <div class="errors">
                <g:renderErrors bean="${cashVoucherInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="table-header">
                    <g:message code="default.button.details.label" args="[entityName]" />
                </div>
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td  class="name">
                                    <label for="party"><g:message code="default.amount.label" default="Amount" /></label>
                                </td>
                                 <td style="text-align:left" ><g:textField id="total" name="total" onchange="this.value=validateInteger(this.value)" style="text-align:right" value="0.00"/></td>
                            </tr> 

                            <tr class="prop">
                                <td  class="name">
                                    <label for="party"><g:message code="cashVoucher.requested.label" default="Party" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: cashVoucherInstance, field: 'requestedBy', 'errors')}">
                                    <g:textField name="requestedBy" value="${fieldValue(bean:cashVoucherInstance, field:'requestedBy')}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="name">
                                    <label for="party"><g:message code="cashVoucher.prepared.label" default="Party" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: cashVoucherInstance, field: 'preparedBy', 'errors')}">
                                    ${session.user.party.name}
                                </td>
                            </tr>

                            <tr class="prop">
                                <td  class="name">
                                    <label for="description"><g:message code="default.description.label" default="Description" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: cashVoucherInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" value="${fieldValue(bean:cashVoucherInstance, field:'description')}"/>
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
