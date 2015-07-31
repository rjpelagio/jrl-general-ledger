
<%@ page import="com.cash.CashVoucher" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'cashVoucher.label', default: 'CashVoucher')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td  class="name"><g:message code="cashVoucher.id.label" default="Id" /></td>
                            
                            <td  class="value">${fieldValue(bean: cashVoucherInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  class="name"><g:message code="cashVoucher.status.label" default="Status" /></td>
                            
                            <td  class="value">${fieldValue(bean: cashVoucherInstance, field: "status")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  class="name"><g:message code="cashVoucher.approvalStatus.label" default="Approval Status" /></td>
                            
                            <td  class="value">${fieldValue(bean: cashVoucherInstance, field: "approvalStatus")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  class="name"><g:message code="cashVoucher.cashVoucherNumber.label" default="Cash Voucher Number" /></td>
                            
                            <td  class="value">${fieldValue(bean: cashVoucherInstance, field: "cashVoucherNumber")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  class="name"><g:message code="cashVoucher.change.label" default="Change" /></td>
                            
                            <td  class="value">${fieldValue(bean: cashVoucherInstance, field: "change")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  class="name"><g:message code="cashVoucher.dateCreated.label" default="Date Created" /></td>
                            
                            <td  class="value"><g:formatDate date="${cashVoucherInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  class="name"><g:message code="cashVoucher.party.label" default="Party" /></td>
                            
                            <td  class="value"><g:link controller="party" action="show" id="${cashVoucherInstance?.party?.id}">${cashVoucherInstance?.party?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  class="name"><g:message code="cashVoucher.total.label" default="Total" /></td>
                            
                            <td  class="value">${fieldValue(bean: cashVoucherInstance, field: "total")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  class="name"><g:message code="cashVoucher.transType.label" default="Trans Type" /></td>
                            
                            <td  class="value">${fieldValue(bean: cashVoucherInstance, field: "transType")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${cashVoucherInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
