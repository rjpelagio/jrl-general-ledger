

<%@ page import="com.gl.GlAccountingTransaction" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Account Consolidation</title>
        <script>
          $(document).ready(function () {
            $("#acctgPeriod").change(function(){
              $("#period").val($(this).val());
              //showDuration($(this).val());
            })
          });
        </script>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        <div class="body">
            <h1>Account Consolidation</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="table-header">
              <g:message code="default.button.search.label" args="[entityName]" />
            </div>
            <g:form action="consol">
                <div class="search">
                    <table>
                        <tbody>
                            <tr class="prop">
                              <td  class="name">
                                <label for="acctgPeriod"><g:message code="acctgPeriod.acctgPeriod.label" default="Acctg Period"/></label>
                              </td>
                              <td  class="value ${hasErrors(bean: acctgPeriodInstance, field: 'acctgPeriod', 'errors')}">
                                <g:select id="acctgPeriod" name="acctgPeriod" from="${dropDown}" optionKey="id"
                                 value="${acctgPeriodInstance?.acctgPeriod?.id ?: currentPeriodInstance}" />
                              </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td>
                                    <g:submitButton name="search" class="save" value="Show Consol" /></span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <g:link action="process" id="${currentPeriodInstance}">Consolidate Now</g:link>
                                </td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </g:form>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                            <th>Main Account</th>
                            <th>Main Account Name</th>
                            <th>Sub Account</th>
                            <th>Sub Account Name</th>
                            <th>Beginning Balance</th>
                            <th>Debit Amount</th>
                            <th>Credit Amount</th>
                            <th>Ending Balance</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:if test = "${glAcctConsolInstanceTotal==0}">
                        <tr>
                          <td colspan="6">No data available.</td>
                        </tr>
                    </g:if>
                    <g:else>
                      <g:each in="${glAcctConsolInstanceList}" status="i" var="glAcctConsolInstance">
                          <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                              <td>${glAcctConsolInstance.main_acct}</td>

                              <td>${glAcctConsolInstance.main_desc}</td>

                              <td>${glAcctConsolInstance.gl_account}</td>

                              <td>${glAcctConsolInstance.description}</td>

                              <td><g:formatNumber number="${glAcctConsolInstance.beg_bal}" type="currency" currencyCode="PHP"/></td>

                              <td><g:formatNumber number="${glAcctConsolInstance.debit_amount}" type="currency" currencyCode="PHP"/></td>

                              <td><g:formatNumber number="${glAcctConsolInstance.credit_amount}" type="currency" currencyCode="PHP"/></td>

                              <td><g:formatNumber number="${glAcctConsolInstance.end_bal}" type="currency" currencyCode="PHP"/></td>
                          </tr>
                      </g:each>
                    </g:else>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
              <g:paginate total="${glAcctConsolInstanceTotal}" /> out of ${glAcctConsolInstanceTotal} record(s)
            </div>
        </div>
    </body>
</html>
