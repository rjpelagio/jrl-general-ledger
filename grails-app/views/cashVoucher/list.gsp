

<%@ page import="com.cash.CashVoucher" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'cashVoucher.label', default: 'CashVoucher')}" />
        <title>Cash Advance</title>
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
            <span class="menuButton"><g:link class="create" action="create"><g:message code="cashVoucher.new.label"/></g:link></span>
            </g:if>
        </div>
        <div class="body">
            <h1><g:message code="cashVoucher.label" /></h1>
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
                <input type="hidden" name="date" id="date" value="${params.date}"/>
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
                                    <label for="status"><g:message code="cashVoucher.status.label" default="Status" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: cashVoucherInstance, field: 'status', 'errors')}">
                                    <g:select name="status" from="${cashVoucherInstance.constraints.status.inList}" value="${cashVoucherInstance?.status}" valueMessagePrefix="cashVoucher.status" noSelection="['':'']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="sub">
                                    <label for="approvalStatus"><g:message code="cashVoucher.approvalStatus.label" default="Approval Status" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: cashVoucherInstance, field: 'approvalStatus', 'errors')}">

                                    <g:select name="approvalStatus" from="${cashVoucherInstance.constraints.approvalStatus.inList}" value="${cashVoucherInstance?.approvalStatus}" valueMessagePrefix="cashVoucher.approvalStatus" noSelection="['':'']" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td  class="sub">
                                    <label for="approvalStatus"><g:message code="cashVoucher.dateCreated.label" default="Approval Status" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: cashVoucherInstance, field: 'approvalStatus', 'errors')}">
                                    <calendar:datePicker name="dateCreated" precision="day" value="${params?.dateCreated}" onChange="javascript:passDate(this.value)" />
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
                            <th><g:message code="cashVoucher.cashVoucherNumber.label"/></th>
                            <th><g:message code="status.label"/></th>
                            <th><g:message code="approvalStatus.label"/></th>
                            <th><g:message code="cashVoucher.dateCreated.label"/></th>
                            <th><g:message code="cashVoucher.preparedBy.label"/></th>
                            <th><g:message code="cashVoucher.requestedBy.label"/></th>

                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${cashVoucherInstanceList}" status="i" var="cashVoucherInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${cashVoucherInstance?.id}">
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
                <g:paginate total="${cashVoucherInstanceTotal}" 
                    params="${[date : params.date,
                        dateCreated_value : params.date,
                        dateCreated_year : params.dateCreated_year,
                        dateCreated_month : params.dateCreated_month,
                        dateCreated_day : params.dateCreated_day, 
                        cashVoucherNumber : params.cashVoucherNumber,
                        status : params.status,
                        approvalStatus : params.approvalStatus,
                        offset : params.offset,
                        max : params.max]}"/>
            </div>
        </div>
    </body>
</html>
