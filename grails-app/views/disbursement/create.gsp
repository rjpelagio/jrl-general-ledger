

<%@ page import="com.cash.Disbursement" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'disbursement.label', default: 'Disbursement')}" />
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
            <g:hasErrors bean="${disbursementInstance}">
            <div class="errors">
                <g:renderErrors bean="${disbursementInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <div class="table-header">
                        <g:message code="default.button.details.label" args="[entityName]" />
                    </div>
                    <table>
                        <tbody>

                            <tr class="prop">
                                <td  class="sub">
                                    <label for="preparedBy"><g:message code="disbursement.preparedBy.label" default="Prepared By" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: disbursementInstance, field: 'preparedBy', 'errors')}">
                                    ${session.party.name}
                                </td>
                            </tr>

                            <tr class="prop">
                                <td  class="sub">
                                    Date
                                </td>
                                <td  class="value ${hasErrors(bean: disbursementInstance, field: 'preparedBy', 'errors')}">
                                    <g:formatDate g:formatDate format="yyyy-MM-dd" 
                                            date="${new Date()}" />
                                </td>
                            </tr>

                        
                        </tbody>
                    </table>
                </div>
                <br/>
                <div class="list">
                        <table>
                            <thead>
                                <g:if test="${requestList.size() > 1}">
                                    <tr>
                                        <th></th>
                                        <th>Petty Cash Number</th>  
                                        <th>Transaction Type</th>
                                        <th>Date Created</th>
                                        <th>Prepared By</th>
                                        <th>Requested By</th>
                                        <th style="text-align:right">Amount</th>
                                    </tr>
                                </g:if>
                                <g:else>
                                    <tr>
                                        <th>No available requests</th>
                                    </tr>
                                </g:else>
                            </thead>
                            <tbody>
                                <g:if test="${requestList.size() > 1}">
                                    <g:each status="i" in="${requestList}" var="entry">
                                    <tr id="row_${i}">
                                        <td style="width:3%"><input type="checkbox" class="checkbox" name="flags" id="flag_${i}"/></td>
                                        <td style="wdith:15%">${entry?.cashVoucherNumber}</td>
                                        <td>
                                            <g:if test="${entry.transType == 'CASH_ADVANCE'}">Cash Advance</g:if>
                                            <g:if test="${entry.transType == 'REIMBURSEMENT'}">Reimbursement</g:if>
                                        </td>
                                        <td><g:formatDate g:formatDate format="yyyy-MM-dd" 
                                            date="${entry?.dateCreated}" />
                                        </td>
                                        <td>${entry?.preparedBy}</td>
                                        <td>${entry?.requestedBy}</td>
                                        <td style="text-align:right; width:10%">${entry?.total}</td>
                                    </tr>
                                    </g:each>
                                </g:if>
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
