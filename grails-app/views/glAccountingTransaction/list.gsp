

<%@ page import="com.gl.GlAccountingTransaction" %>
<%@ page import="com.gl.AcctgTransType" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'glAccountingTransaction.label', default: 'GlAccountingTransaction')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
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
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
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
                
                <div class="search">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="middle" class="sub">
                                    <g:message code="glAccountingTransaction.voucherNo.label" default="Voucher No." />
                                </td>
                                <td >
                                    <g:textField name="voucherNo" value="" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="sub">
                                    <label for="acctgTransType"><g:message code="glAccountingTransaction.acctgTransType.label" default="Voucher Type" /></label>
                                </td>
                                <td >
                                    <g:select name="transType" from="${com.gl.AcctgTransType.list()}" optionKey="id" value="${glAccountingTransactionInstance?.acctgTransType?.id}"  />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td class="sub">
                                    <label for="description"><g:message code="glAccountingTransaction.status.label" default="Status" /></label>
                                </td>
                                <td >
                                    <g:select name="status" from="${glAccountingTransactionInstance.constraints.status.inList}" value="${params?.status}" valueMessagePrefix="glAccountingTransactionInstance.status" noSelection="['null': '']" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td  class="sub">
                                    <label for="approvalStatus"><g:message code="glAccountingTransactionInstance.approvalStatus.label" default="Approval Status" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: glAccountingTransactionInstance, field: 'approvalStatus', 'errors')}">

                                    <g:select name="approvalStatus" from="${glAccountingTransactionInstance.constraints.approvalStatus.inList}" value="${glAccountingTransactionInstance?.approvalStatus}" valueMessagePrefix="glAccountingTransactionInstance.approvalStatus" noSelection="['':'']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="sub">
                                    <label for="dateCreated"><g:message code="dateCreated.label" default="Approval Status" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: glAccountingTransactionInstance, field: 'dateCreated', 'errors')}">
                                    <calendar:datePicker name="dateCreated" precision="day" value="${params?.dateCreated}" onChange="javascript:passDate(this.value)" />
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
                        
                            <g:sortableColumn property="voucherNo" title="${message(code: 'glAccountingTransaction.voucherNo.label', default: 'Voucher No.')}" />
                        
                            <th>Voucher Type</th>
                        
                            <th>Status</th>

                            <th>Approval Status</th>

                            <th>Date Created</th>
                            
                            <th>Transaction Date</th>
                        
                            <th>Posted Date</th>
                        
                            <th>Entry Date</th>
                            
                        </tr>
                    </thead>
                    <tbody>
                    <g:if test="${glAccountingTransactionInstanceTotal==0}">
                      <tr>
                          <td colspan="8"> <g:message code="default.nomatch.message"/></td>
                      </tr>
                    </g:if>
                    <g:else>
                        <g:each in="${glAccountingTransactionInstanceList}" status="i" var="trans">
                            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                                <td><g:link action="show" id="${trans.id}">${trans.voucherNo}</g:link></td>

                                <td>${trans.voucherType}</td>

                                <td>${trans.status}</td>

                                <td>${trans.approvalStatus}</td>

                                <td><g:formatDate format="yyyy-MM-dd hh:mm:ss a" date="${trans.dateCreated}"/></td>
                                
                                <td><g:formatDate format="yyyy-MM-dd" date="${trans.transactionDate}" /></td>

                                <td><g:formatDate format="yyyy-MM-dd" date="${trans.postedDate}" /></td>

                                <td><g:formatDate format="yyyy-MM-dd" date="${trans.entryDate}" /></td>
                                

                                
                            </tr>
                        </g:each>
                    </g:else>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${glAccountingTransactionInstanceTotal}" />Record ${glAccountingTransactionInstanceList.size()} of ${glAccountingTransactionInstanceTotal}
            </div>
        </div>
    </body>
</html>
