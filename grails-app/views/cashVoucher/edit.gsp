

<%@ page import="com.cash.CashVoucher" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'cashVoucher.label', default: 'CashVoucher')}" />
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
            <g:hasErrors bean="${cashVoucherInstance}">
            <div class="errors">
                <g:renderErrors bean="${cashVoucherInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${cashVoucherInstance?.id}" />
                <g:hiddenField name="version" value="${cashVoucherInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="status"><g:message code="cashVoucher.status.label" default="Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: cashVoucherInstance, field: 'status', 'errors')}">
                                    <g:select name="status" from="${cashVoucherInstance.constraints.status.inList}" value="${cashVoucherInstance?.status}" valueMessagePrefix="cashVoucher.status"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="approvalStatus"><g:message code="cashVoucher.approvalStatus.label" default="Approval Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: cashVoucherInstance, field: 'approvalStatus', 'errors')}">
                                    <g:select name="approvalStatus" from="${cashVoucherInstance.constraints.approvalStatus.inList}" value="${cashVoucherInstance?.approvalStatus}" valueMessagePrefix="cashVoucher.approvalStatus"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="cashVoucherNumber"><g:message code="cashVoucher.cashVoucherNumber.label" default="Cash Voucher Number" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: cashVoucherInstance, field: 'cashVoucherNumber', 'errors')}">
                                    <g:textField name="cashVoucherNumber" value="${cashVoucherInstance?.cashVoucherNumber}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="change"><g:message code="cashVoucher.change.label" default="Change" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: cashVoucherInstance, field: 'change', 'errors')}">
                                    <g:textField name="change" value="${fieldValue(bean: cashVoucherInstance, field: 'change')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="party"><g:message code="cashVoucher.party.label" default="Party" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: cashVoucherInstance, field: 'party', 'errors')}">
                                    <g:select name="party.id" from="${com.app.Party.list()}" optionKey="id" value="${cashVoucherInstance?.party?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="total"><g:message code="cashVoucher.total.label" default="Total" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: cashVoucherInstance, field: 'total', 'errors')}">
                                    <g:textField name="total" value="${fieldValue(bean: cashVoucherInstance, field: 'total')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="transType"><g:message code="cashVoucher.transType.label" default="Trans Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: cashVoucherInstance, field: 'transType', 'errors')}">
                                    <g:textField name="transType" value="${cashVoucherInstance?.transType}" />
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
