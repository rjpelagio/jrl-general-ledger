

<%@ page import="com.cash.CashVoucher" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'liquidation.label', default: 'Liquidation')}" />
        <title>Liquidation</title>
        <script type="text/javascript">
            //This function ensures the passing of date parameters during pagination.
            function passDate (date) {
                $("#date").val(date)
            }
        </script>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/dashBoard/list')}"><g:message code="default.home.label"/></a></span>
            <g:if test="${disableCreate == 'no'}">
            <span class="menuButton"><g:link class="create" action="create"><g:message code="liquidation.new.label"/></g:link></span>
            </g:if>
        </div>
        <div class="body">
            <h1><g:message code="liquidation.label" /></h1>
            <g:if test="${flash.errors}">
                <div class="errors"><ul><li>${flash.errors}</li></ul></div>
            </g:if>
            <div class="table-header">
              <g:message code="default.button.search.label" args="[entityName]" />
            </div>
            <g:form action="list">
                <input type="hidden" name="date" id="date" value="${params.date}"/>
                <div class="dialog">
                    <table>
                        <tbody>

                            <tr class="prop">
                                <td  class="sub" style="width:18%">
                                    <label for="liquidationNumber">
                                        <g:message code="liquidation.number.label" default="Cash Voucher Number" />
                                    </label>
                                </td>
                                <td  class="value">
                                    <g:textField name="liquidationNumber" 
                                        value="${trans?.liquidationNumber}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="sub">
                                    <label for="status">
                                        <g:message code="liquidation.status.label" default="Status" />
                                    </label>
                                </td>
                                <td  class="value">
                                    <g:select name="status" from="${trans.constraints.status.inList}" 
                                        value="${trans?.status}" 
                                            valueMessagePrefix="liquidation.status" noSelection="['':'']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="sub">
                                    <label for="approvalStatus">
                                        <g:message code="approvalStatus.label" default="Approval Status" />
                                    </label>
                                </td>
                                <td  class="value ${hasErrors(bean: trans, field: 'approvalStatus', 'errors')}">
                                    <g:select name="approvalStatus" from="${trans.constraints.approvalStatus.inList}" value="${trans?.approvalStatus}" valueMessagePrefix="liquidation.approvalStatus" noSelection="['':'']" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td  class="sub">
                                    <label for="approvalStatus"><g:message code="dateCreated.label"/>
                                </td>
                                <td  class="value ${hasErrors(bean: trans, field: 'dateCreated', 'errors')}">
                                    <calendar:datePicker name="dateCreated" precision="day" value="${params?.dateCreated}"  onChange="javascript:passDate(this.value)"/>
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
                            <th><g:message code="liquidation.number.label"/></th>
                            <th><g:message code="cashVoucher.cashVoucherNumber.label"/></th>
                            <th><g:message code="status.label"/></th>
                            <th><g:message code="approvalStatus.label"/></th>
                            <th><g:message code="dateCreated.label"/></th>
                            <th><g:message code="preparedBy.label" default="Prepared By" /></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${liquidationList}" status="i" var="entry">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${entry?.id}">
                                ${entry?.liquidationNumber}</g:link></td>

                            <td>${entry?.cashVoucher}</td>
                        
                            <td>${entry?.status}</td>
                        
                            <td>${entry?.approvalStatus}</td>
                        
                            <td><g:formatDate format="yyyy-MM-dd" date="${entry?.dateCreated}" /></td>

                            <td>${entry?.preparedBy}</td>

                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${liquidationTotal}" 
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
