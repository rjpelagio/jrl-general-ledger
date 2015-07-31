

<%@ page import="com.cash.CashVoucher" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'cashVoucher.label', default: 'CashVoucher')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="cashAdvance.new.label"/></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="cashAdvance.label" /></h1>
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
                                <td  class="name">
                                    <label for="cashVoucherNumber"><g:message code="cashAdvance.number" default="Cash Voucher Number" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: cashVoucherInstance, field: 'cashVoucherNumber', 'errors')}">
                                    <g:textField name="cashVoucherNumber" value="${cashVoucherInstance?.cashVoucherNumber}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="name">
                                    <label for="status"><g:message code="cashVoucher.status.label" default="Status" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: cashVoucherInstance, field: 'status', 'errors')}">
                                    <g:select name="status" from="${cashVoucherInstance.constraints.status.inList}" value="${cashVoucherInstance?.status}" valueMessagePrefix="cashVoucher.status" noSelection="['null':'']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="name">
                                    <label for="approvalStatus"><g:message code="cashVoucher.approvalStatus.label" default="Approval Status" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: cashVoucherInstance, field: 'approvalStatus', 'errors')}">

                                    <g:select name="approvalStatus" from="${cashVoucherInstance.constraints.approvalStatus.inList}" value="${cashVoucherInstance?.approvalStatus}" valueMessagePrefix="cashVoucher.approvalStatus" noSelection="['null':'']" />
                                </td>
                            </tr>
                        
                            
                        
                            <tr class="prop">
                                <td  class="name">
                                    <label for="party"><g:message code="cashVoucher.prepared.label" default="Party" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: cashVoucherInstance, field: 'preparedBy', 'errors')}">
                                    <g:textField name="preparedBy" value="${fieldValue(bean:cashVoucherInstance, field:'preparedBy')}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td  class="name">
                                    <label for="party"><g:message code="cashVoucher.requested.label" default="Party" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: cashVoucherInstance, field: 'requestedBy', 'errors')}">
                                    <g:textField name="requestedBy" value="${fieldValue(bean:cashVoucherInstance, field:'requestedBy')}"/>
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
            <br/>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                            <g:sortableColumn property="cashVoucherNumber" title="${message(code: 'cashAdvance.number', default: 'Cash Voucher Number')}" />
                        
                        
                            <g:sortableColumn property="status" title="${message(code: 'cashVoucher.status.label', default: 'Status')}" />
                        
                            <g:sortableColumn property="approvalStatus" title="${message(code: 'cashVoucher.approvalStatus.label', default: 'Approval Status')}" />
                        
                        
                            <g:sortableColumn property="dateCreated" title="${message(code: 'cashVoucher.dateCreated.label', default: 'Date Created')}" />

                            <g:sortableColumn property="party" title="${message(code: 'cashVoucher.prepared.label', default: 'Date Created')}" />

                            <g:sortableColumn property="party" title="${message(code: 'cashVoucher.requested.label', default: 'Date Created')}" />

                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${cashVoucherInstanceList}" status="i" var="cashVoucherInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${cashVoucherInstance.id}">${fieldValue(bean: cashVoucherInstance, field: "cashVoucherNumber")}</g:link></td>
                        
                            <td>${fieldValue(bean: cashVoucherInstance, field: "status")}</td>
                        
                            <td>${fieldValue(bean: cashVoucherInstance, field: "approvalStatus")}</td>
                        
                            <td><g:formatDate date="${cashVoucherInstance.dateCreated}" /></td>

                            <td>${fieldValue(bean: cashVoucherInstance, field: "preparedBy?.name")}</td>

                            <td>${fieldValue(bean: cashVoucherInstance, field: "requestedBy?.name")}</td>
                        
                            <td>
                                <g:link action="edit" id="${cashVoucherInstance.id}">
                                    Edit
                                </g:link>
                            </td>
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
