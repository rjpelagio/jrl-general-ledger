

<%@ page import="com.gl.AcctgPeriod" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'acctgPeriod.label', default: 'AcctgPeriod')}" />
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
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="acctgPeriodNum"><g:message code="acctgPeriod.acctgPeriodNum.label" default="Acctg Period Num" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: acctgPeriodInstance, field: 'acctgPeriodNum', 'errors')}">
                                    <g:textField name="acctgPeriodNum" value="${fieldValue(bean: acctgPeriodInstance, field: 'acctgPeriodNum')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="month"><g:message code="acctgPeriod.month.label" default="Month" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: acctgPeriodInstance, field: 'month', 'errors')}">
                                    <g:select name="month" from="${acctgPeriodInstance.constraints.month.inList}" value="${acctgPeriodInstance?.month}" valueMessagePrefix="acctgPeriod.month"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="acctgPeriod.status.label" default="Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: acctgPeriodInstance, field: 'status', 'errors')}">
                                    <g:select name="status" from="${acctgPeriodInstance.constraints.status.inList}" value="${acctgPeriodInstance?.status}" valueMessagePrefix="acctgPeriod.status"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fromDate"><g:message code="acctgPeriod.fromDate.label" default="From Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: acctgPeriodInstance, field: 'fromDate', 'errors')}">
                                    <g:datePicker name="fromDate" precision="day" value="${acctgPeriodInstance?.fromDate}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="thruDate"><g:message code="acctgPeriod.thruDate.label" default="Thru Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: acctgPeriodInstance, field: 'thruDate', 'errors')}">
                                    <g:datePicker name="thruDate" precision="day" value="${acctgPeriodInstance?.thruDate}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="year"><g:message code="acctgPeriod.year.label" default="Year" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: acctgPeriodInstance, field: 'year', 'errors')}">
                                    <g:textField name="year" value="${acctgPeriodInstance?.year}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="organization"><g:message code="acctgPeriod.organization.label" default="Organization" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: acctgPeriodInstance, field: 'organization', 'errors')}">
                                    <g:select name="organization.id" from="${com.app.AppOrganization.list()}" optionKey="id" value="${acctgPeriodInstance?.organization?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="periodTypeId"><g:message code="acctgPeriod.periodTypeId.label" default="Period Type Id" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: acctgPeriodInstance, field: 'periodTypeId', 'errors')}">
                                    <g:select name="periodTypeId.id" from="${com.gl.PeriodType.list()}" optionKey="id" value="${acctgPeriodInstance?.periodTypeId?.id}"  />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'acctgPeriod.id.label', default: 'Id')}" />
                        
                            <th>Period Number</th>
                        
                            <th>Month</th>
                        
                            <th>Status</th>
                        
                            <th>From Date</th>
                        
                            <th>Thru Date</th>
                            
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${acctgPeriodInstanceList}" status="i" var="acctgPeriodInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${acctgPeriodInstance.id}">${fieldValue(bean: acctgPeriodInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: acctgPeriodInstance, field: "acctgPeriodNum")}</td>
                        
                            <td>${fieldValue(bean: acctgPeriodInstance, field: "month")}</td>
                        
                            <td>${fieldValue(bean: acctgPeriodInstance, field: "status")}</td>
                        
                            <td><g:formatDate date="${acctgPeriodInstance.fromDate}" /></td>
                        
                            <td><g:formatDate date="${acctgPeriodInstance.thruDate}" /></td>
                        
                            <td>
                                <g:link action="edit" id="${acctgPeriodInstance.id}">
                                    Edit
                                </g:link>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${acctgPeriodInstanceTotal}" /> Record ${acctgPeriodInstanceList.size()} of ${acctgPeriodInstanceTotal}
            </div>
        </div>
    </body>
</html>
