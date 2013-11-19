

<%@ page import="com.gl.GlAccountingTransaction" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'glAccountingTransaction.label', default: 'GlAccountingTransaction')}" />
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
                <div class="search">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="voucherNo"><g:message code="glAccountingTransaction.voucherNo.label" default="Voucher No." /></label>
                                </td>
                                <td valign="top">
                                    <g:textField name="voucherNo" value="" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="acctgTransType"><g:message code="glAccountingTransaction.acctgTransType.label" default="Voucher Type" /></label>
                                </td>
                                <td valign="top">
                                    <select name="acctgTransType">
                                        <option value="null"></option>
                                        <option value="JV">JV</option>
                                        <option value="CKV">CKV</option>
                                        <option value="AJV">AJV</option>
                                    </select>
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td class="name">
                                    <label for="description"><g:message code="glAccountingTransaction.description.label" default="Description" /></label>
                                </td>
                                <td valign="top">
                                    <g:textField name="description" value="" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td class="name">
                                    <label for="description"><g:message code="glAccountingTransaction.status.label" default="Status" /></label>
                                </td>
                                <td valign="top">
                                    <g:select name="status" from="${glAccountingTransactionInstance.constraints.status.inList}" value="${acctgPeriodInstance?.status}" valueMessagePrefix="acctgPeriod.status" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name" >
                                    <label for="status"><g:message code="glAccountingTransactionInstance.transactionDate.label" default="Transaction Date" /></label>
                                </td>
                                <td valign="top">
                                    <calendar:datePicker name="transactionDate" precision="day" value=""  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="postedDate"><g:message code="glAccountingTransaction.postedDate.label" default="Posted Date" /></label>
                                </td>
                                <td valign="top">
                                    <calendar:datePicker name="postedDate" precision="day" value="${glAccountingTransactionInstance?.postedDate}" default="none" noSelection="['': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="entryDate"><g:message code="glAccountingTransaction.entryDate.label" default="Entry Date" /></label>
                                </td>
                                <td valign="top">
                                    <calendar:datePicker name="entryDate" precision="day" value=""  />
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
                        
                            <g:sortableColumn property="voucherNo" title="${message(code: 'glAccountingTransaction.voucherNo.label', default: 'Voucher No.')}" />
                        
                            <g:sortableColumn property="acctgTransType" title="${message(code: 'glAccountingTransaction.acctgTransType.label', default: 'Voucher Type')}" />

                            <g:sortableColumn property="description" title="${message(code: 'glAccountingTransaction.description.label', default: 'Description')}" />
                        
                            <th>Status</th>
                            <g:sortableColumn property="transactionDate" title="${message(code: 'glAccountingTransaction.transactionDate.label', default: 'Transaction Date')}" />
                        
                            <g:sortableColumn property="postedDate" title="${message(code: 'glAccountingTransaction.postedDate.label', default: 'Posted Date')}" />
                        
                            <g:sortableColumn property="entryDate" title="${message(code: 'glAccountingTransaction.entryDate.label', default: 'Entry Date')}" />
                        
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:if test="${glAccountingTransactionInstanceTotal==0}">
                      <tr>
                          <td colspan="8"> <g:message code="default.nomatch.message"/></td>
                      </tr>
                    </g:if>
                    <g:else>
                        <g:each in="${glAccountingTransactionInstanceList}" status="i" var="glAccountingTransactionInstance">
                            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                                <td><g:link action="show" id="${glAccountingTransactionInstance.id}">${fieldValue(bean: glAccountingTransactionInstance, field: "voucherNo")}</g:link></td>

                                <td>${fieldValue(bean: glAccountingTransactionInstance, field: "acctgTransType")}</td>

                                <td>${fieldValue(bean: glAccountingTransactionInstance, field: "description")}</td>

                                <td>${fieldValue(bean: glAccountingTransactionInstance, field: "status")}</td>
                                
                                <td><g:formatDate format="yyyy-MM-dd" date="${glAccountingTransactionInstance.transactionDate}" /></td>

                                <td><g:formatDate format="yyyy-MM-dd" date="${glAccountingTransactionInstance.postedDate}" /></td>

                                <td><g:formatDate format="yyyy-MM-dd" date="${glAccountingTransactionInstance.entryDate}" /></td>

                                <td>
                                    <g:if test="${glAccountingTransactionInstance.status!='Approved'}">
                                    <g:link action="edit" id="${glAccountingTransactionInstance.id}">
                                        Edit
                                    </g:link>
                                    </g:if>
                                </td>
                            </tr>
                        </g:each>
                    </g:else>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${glAccountingTransactionInstanceTotal}" />Record ${recordCount} of ${glAccountingTransactionInstanceTotal}
            </div>
        </div>
    </body>
</html>
