

<%@ page import="com.cash.CashVoucher" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'cashVoucher.label', default: 'CashVoucher')}" />
        <title>Liquidation</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/dashBoard/list')}"><g:message code="default.home.label"/></a></span>
        </div>
        <div class="body">
            <h1><g:message code="liquidation.label" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:if test="${flash.errors}">
                <div class="errors"><ul><li>${flash.errors}</li></ul></div>
            </g:if>
            <div class="table-header">
              <g:message code="default.button.search.label" args="[entityName]" />
            </div>
            <g:form action="list">
                <div class="dialog">
                    <table>
                        <tbody>

                            <tr class="prop">
                                <td  class="sub">
                                    <label for="cashVoucherNumber"><g:message code="cashVoucher.cashVoucherNumber.label" default="Cash Voucher Number" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: cashVoucherInstance, field: 'cashVoucherNumber', 'errors')}">
                                    <g:textField name="cashVoucherNumber" value="${cashVoucherInstance?.cashVoucherNumber}" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td  class="sub">
                                    <label for="approvalStatus"><g:message code="cashVoucher.dateCreated.label" default="Approval Status" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: cashVoucherInstance, field: 'approvalStatus', 'errors')}">
                                    <calendar:datePicker name="dateCreated" precision="day" value="${cashVoucherInstance?.dateCreated}"  />
                                </td>
                            </tr>
                            
                            <tr>
                                <td></td>
                                <td>
                                    <g:submitButton name="search" class="search" value="Search" /></span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </g:form>
            <br/>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                            <g:sortableColumn property="cashVoucherNumber" title="${message(code: 'cashAdvance.number', default: 'Cash Voucher Number')}" />
                        
                        
                            <g:sortableColumn property="status" title="${message(code: 'cashVoucher.status.label', default: 'Status')}" />
                        
                            <g:sortableColumn property="approvalStatus" title="${message(code: 'cashVoucher.approvalStatus.label', default: 'Approval Status')}" />
                        
                        
                            <g:sortableColumn property="dateCreated" title="${message(code: 'cashVoucher.dateCreated.label', default: 'Date Created')}" />

                            <th><g:message code="cashVoucher.preparedBy.label" default="Status" /></th>

                            <th><g:message code="cashVoucher.requestedBy.label" default="Status" /></th>

                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${cashVoucherInstanceList}" status="i" var="cashVoucherInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${cashVoucherInstance.id}">
                                ${cashVoucherInstance?.cashVoucherNumber}</g:link></td>
                        
                            <td>${cashVoucherInstance?.status}</td>
                        
                            <td>${cashVoucherInstance?.approvalStatus}</td>
                        
                            <td><g:formatDate format="yyyy-MM-dd" date="${cashVoucherInstance.dateCreated}" /></td>

                            <td>${cashVoucherInstance?.preparedBy}</td>

                            <td>${cashVoucherInstance?.requestedBy}</td>

                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${cashVoucherInstanceTotal}" />
            </div>
        </div>
    </body>
</html>