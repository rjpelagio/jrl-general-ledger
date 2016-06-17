

<%@ page import="com.cash.Replenishment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'replenishment.label', default: 'Replenishment')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <g:if test="${disableCreate == 'no'}">
                <span class="menuButton">
                    <g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>
                </span>
            </g:if>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
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
                                    <label for="replenishmentNumber"><g:message code="replenishment.replenishmentNumber.label" default="Replenishment #" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: trans, field: 'replenishmentNumber', 'errors')}">
                                    <g:textField name="replenishmentNumber" value="${trans?.replenishmentNumber}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="sub">
                                    <label for="status"><g:message code="replenishment.status.label" default="Status" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: trans, field: 'status', 'errors')}">
                                    <g:select name="status" from="${trans.constraints.status.inList}" value="${trans?.status}" valueMessagePrefix="replenishment.status"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="sub">
                                    <label for="approvalStatus"><g:message code="replenishment.approvalStatus.label" default="Approval Status" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: trans, field: 'approvalStatus', 'errors')}">
                                    <g:select name="approvalStatus" from="${trans.constraints.approvalStatus.inList}" value="${trans?.approvalStatus}" valueMessagePrefix="replenishment.approvalStatus"  />
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
                    
                            <th><g:message code="replenishment.number.label"/></th>
                            <th><g:message code="status.label"/></th>
                            <th><g:message code="approvalStatus.label"/></th>
                            <th><g:message code="dateCreated.label"/></th>
                            <th><g:message code="preparedBy.label" default="Prepared By" /></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${transList}" status="i" var="trans">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${trans.id}">${trans?.replenishmentNumber}</g:link></td>
                        
                            <td>${trans?.status}</td>
                        
                            <td>${trans?.approvalStatus}</td>
                        
                            <td><g:formatDate format="yyyy-MM-dd" date="${trans.dateCreated}" /></td>
                        
                            <td>${trans?.preparedBy}</td>
                    
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${transTotal}" 
                    params="${[date : params.date,
                        dateCreated_value : params.date,
                        dateCreated_year : params.dateCreated_year,
                        dateCreated_month : params.dateCreated_month,
                        dateCreated_day : params.dateCreated_day, 
                        liquidationNumber : params.liquidationNumber,
                        status : params.status,
                        approvalStatus : params.approvalStatus,
                        offset : params.offset,
                        max : params.max]}"/>
            </div>
        </div>
    </body>
</html>
