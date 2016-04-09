

<%@ page import="com.cash.Disbursement" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'disbursement.label', default: 'Disbursement')}" />
        <title>Cash Advance</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/dashBoard/list')}"><g:message code="default.home.label"/></a></span>
            <g:if test="${disableCreate == 'no'}">
            <span class="menuButton"><g:link class="create" action="create"><g:message code="disbursement.new.label"/></g:link></span>
            </g:if>
        </div>
        <div class="body">
            <h1><g:message code="disbursement.label" /></h1>
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
                                    <label for="disbursementNumber"><g:message code="disbursement.number.label" default="Disbursement Number" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: trans, field: 'disbursementNumber', 'errors')}">
                                    <g:textField name="disbursementNumber" value="${trans?.disbursementNumber}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="sub">
                                    <label for="status"><g:message code="disbursement.status.label" default="Status" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: trans, field: 'status', 'errors')}">
                                    <g:select name="status" from="${trans.constraints.status.inList}" value="${trans?.status}" valueMessagePrefix="disbursement.status" noSelection="['':'']" />
                                </td>
                            </tr>
                        
                           

                            <tr class="prop">
                                <td  class="sub">
                                    <label for="approvalStatus"><g:message code="disbursement.dateCreated.label" default="Date Created" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: trans, field: 'approvalStatus', 'errors')}">
                                    <calendar:datePicker name="dateCreated" precision="day" value="${trans?.dateCreated}"  />
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
                            <g:sortableColumn property="disbursementNumber" title="${message(code: 'disbursement.number.label', default: 'Disbursement #')}" />
                        
                        
                            <g:sortableColumn property="status" title="${message(code: 'disbursement.status.label', default: 'Status')}" />
        
                        
                            <g:sortableColumn property="dateCreated" title="${message(code: 'cashVoucher.dateCreated.label', default: 'Date Created')}" />

                            <th><g:message code="cashVoucher.preparedBy.label" default="Status" /></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${disbursmentList}" status="i" var="entry">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${entry.id}">
                                ${entry?.disbursmentNumber}</g:link></td>
                        
                            <td>${entry?.status}</td>
                        
                            <td><g:formatDate format="yyyy-MM-dd" date="${entry.dateCreated}" /></td>

                            <td>${entry?.preparedBy}</td>

                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${disbursementTotal}" />
            </div>
        </div>
    </body>
</html>
