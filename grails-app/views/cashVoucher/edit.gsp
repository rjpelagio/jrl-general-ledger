

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
                <div class="table-header">
                    <g:message code="default.button.details.label" args="[entityName]" />
                </div>
                <g:hiddenField name="id" value="${cashVoucherInstance?.id}" />
                <g:hiddenField name="version" value="${cashVoucherInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="cashVoucherNumber"><g:message code="cashVoucher.cashVoucherNumber.label" default="Cash Voucher Number" /></label>
                                </td>
                                <td valign="top" class="value">
                                    ${cashVoucherInstance?.cashVoucherNumber}
                                    <input type="hidden" name="cashVoucherNumber" value="${cashVoucherInstance?.cashVoucherNumber}"/>
                                </td>

                                <td valign="top" class="name">
                                  <label for="status"><g:message code="cashVoucher.status.label" default="Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: cashVoucherInstance, field: 'status', 'errors')}">
                                    ${cashVoucherInstance?.status}
                                </td>

                            </tr>

                            <tr class="prop">
                                <td  class="name">
                                    <label for="party"><g:message code="default.amount.label" default="Amount" /></label>
                                </td>
                                 <td style="text-align:left" ><g:textField id="total" name="total" value="${cashVoucherInstance?.total}" onchange="this.value=validateInteger(this.value)" style="text-align:right" /></td>

                                 <td valign="top" class="name">
                                  <label for="approvalStatus"><g:message code="cashVoucher.approvalStatus.label" default="Approval Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: cashVoucherInstance, field: 'approvalStatus', 'errors')}">
                                    ${cashVoucherInstance?.approvalStatus}
                                </td>
                            </tr> 

                            <tr class="prop">
                                <td  class="name">
                                    <label for="party"><g:message code="cashVoucher.requestedBy.label" default="Party" /></label>
                                </td>
                                <td class="value">
                                    <g:textField name="payeeText" id="payeeText" value="${cashVoucherInstance?.requestedBy?.name}"/>
                                </td>
                            </tr>

                        
                            <tr class="prop">
                                <td  class="name">
                                    <label for="party"><g:message code="cashVoucher.preparedBy.label" default="Party" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: cashVoucherInstance, field: 'preparedBy', 'errors')}">
                                    ${cashVoucherInstance?.preparedBy?.name}
                                </td>
                            </tr>

                            <tr class="prop">
                                <td  class="name" >
                                    <label for="description"><g:message code="cashVoucher.description.label" default="Description" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: cashVoucherInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" value="${fieldValue(bean:cashVoucherInstance, field:'description')}"/>
                                </td>
                            </tr>

                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>

                    <g:actionSubmit id="submit" name="submit" class="save" value="Submit" action="submit" />
                    <g:if test="${approvalItems}">
                        <span class="button"><g:actionSubmit class="delete" action="cancel" value="${message(code: 'default.button.cancel.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.cancel.confirm.message', default: 'Are you sure?')}');" /></span>
                    </g:if>
                </div>
            </g:form>
        </div>
    </body>
</html>
