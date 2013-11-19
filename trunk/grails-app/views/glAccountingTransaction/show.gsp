
<%@ page import="com.gl.GlAccountingTransaction" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'glAccountingTransaction.label', default: 'GlAccountingTransaction')}" />
        <g:set var="debit" value="${0}" scope="page"/>
        <g:set var="credit" value="${0}" scope="page"/>
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="glAccountingTransaction.voucherNo.label" default="Voucher No." /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: glAccountingTransactionInstance, field: "voucherNo")}</td>

                            <td valign="top" class="name"><g:message code="glAccountingTransaction.transactionDate.label" default="Transaction Date" /></td>

                            <td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${glAccountingTransactionInstance?.transactionDate}" /></td>
                        </tr>

                        <tr class="prop">
                            
                            <td valign="top" class="name"><g:message code="glAccountingTransaction.postedDate.label" default="Posted Date" /></td>

                            <td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${glAccountingTransactionInstance?.postedDate}" /></td>

                            <td valign="top" class="name"><g:message code="glAccountingTransaction.entryDate.label" default="Entry Date" /></td>

                            <td valign="top" class="value"><g:formatDate format="yyyy-MM-dd" date="${glAccountingTransactionInstance?.entryDate}" /></td>

                        </tr>
                        
                        <tr class="prop">
                            
                            <td valign="top" class="name"><g:message code="glAccountingTransaction.status.label" default="Status" /></td>

                            <td valign="top" class="value">${fieldValue(bean: glAccountingTransactionInstance, field: "status")}</td>
                            
                            <td valign="top" class="name"><g:message code="glAccountingTransaction.voucherType.label" default="Voucher Type" /></td>

                            <td valign="top" class="value">${fieldValue(bean: glAccountingTransactionInstance, field: "acctgTransType")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="glAccountingTransaction.cdoKg.label" default="CDO Kg" /></td>

                            <td valign="top" class="value">${fieldValue(bean: glAccountingTransactionInstance, field: "cdoKg")}</td>

                            <td valign="top" class="name"><g:message code="glAccountingTransaction.terms.label" default="Terms" /></td>

                            <td valign="top" class="value">${fieldValue(bean: glAccountingTransactionInstance, field: "terms")}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="glAccountingTransaction.checkNo.label" default="Check No." /></td>

                            <td valign="top" class="value">${fieldValue(bean: glAccountingTransactionInstance, field: "checkNo")}</td>

                            <td valign="top" class="name"><g:message code="glAccountingTransaction.ckSiDate.label" default="Check/SI Date" /></td>

                            <td valign="top" class="value">${fieldValue(bean: glAccountingTransactionInstance, field: "ckSiDate")}</td>

                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="glAccountingTransaction.party.label" default="Payee" /></td>

                            <td valign="top" class="value">${fieldValue(bean: glAccountingTransactionInstance, field: "party")}</td>

                            <td valign="top" class="name"><g:message code="party.tin.label" default="TIN" /></td>

                            <td valign="top" class="value">${glAccountingTransactionInstance?.party?.tin?:'N/A'}</td>

                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="glAccountingTransaction.description.label" default="Description" /></td>

                            <td valign="top" class="value">${fieldValue(bean: glAccountingTransactionInstance, field: "description")}</td>

                            <td valign="top" class="name"><g:message code="glAccountingTransaction.refDoc.label" default="Reference Doc" /></td>

                            <td valign="top" class="value">${fieldValue(bean: glAccountingTransactionInstance, field: "refDoc")}</td>
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            </br>
            <div class="list">
              <table>
                  <thead>
                      <tr>
                        <th>GL Account</th>
                        <th>Description</th>
                        <th>Debit</th>
                        <th>Credit</th>
                      </tr>
                  </thead>
                  <tbody id="dataTable"><tbody id="dataTable">
                      <g:each status="i" in="${transItems}" var="acct">
                          <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <td>${acct.glAccount.glAccount}</td>
                            <td>${acct.glAccount.description}</td>
                            <g:if test="${acct.debitCreditFlag == 'Credit'}">
                                <td class="amount"><g:formatNumber number="0" format="###,##0.00"/></td>
                                <td class="amount"><g:formatNumber number="${acct.amount}" format="###,##0.00"/></td>
                            </g:if>
                            <g:else>
                                <td class="amount"><g:formatNumber number="${acct.amount}" format="###,##0.00"/></td>
                                <td class="amount"><g:formatNumber number="0" format="###,##0.00"/></td>
                            </g:else>
                          </tr>
                          <g:if test="${acct.debitCreditFlag.equals('Debit')}"><span style="display:none">${debit = debit + acct.amount}</span></g:if>
                          <g:if test="${acct.debitCreditFlag.equals('Credit')}"><span style="display:none">${credit = credit + acct.amount}</span></g:if>
                      </g:each>
                      <tr class="lastRow">
                          <td colspan="2">Total Amount</td>
                          <td class="amount">
                            <input type="hidden" id="debit" name="debit" value="0.0"/>
                            <span id="debitDisplay" style="font-size:120%;"><g:formatNumber number="${debit}" format="###,##0.00"/></span>
                          </td>
                          <td class="amount">
                            <input type="hidden" id="credit" name="credit" value="0.0"/>
                            <span id="creditDisplay" style="font-size:120%;"><g:formatNumber number="${credit}" format="###,##0.00"/></span>
                          </td>
                      </tr>
                  </tbody>
              </table>
              <table>
                <tbody>
                  <g:each status="j" in ="${transApproval}" var="app">
                    <tr>
                      <td valign="top" class="name">${app?.approvalSeq?.remarks}</td>
                      <td valign="top" class="value">${app?.user?.party}</td>
                    </tr>
                  </g:each>
                </tbody>
              </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${glAccountingTransactionInstance?.id}" />
                      <g:if test="${glAccountingTransactionInstance.status=='Approved'}"></g:if>
                      <g:elseif test="${glAccountingTransactionInstance.status=='Cancelled'}"></g:elseif>
                      <g:elseif test="${glAccountingTransactionInstance.status=='For Approval'}"></g:elseif>
                      <g:else>
                        <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                        <span class="button"><g:actionSubmit class="submit" action="submit" value="${message(code: 'default.button.submit.label', default: 'Submit')}" /></span>
                      </g:else>
                      <g:if test="${glAccountingTransactionInstance.status=='Approved'}"></g:if>
                      <g:elseif test="${glAccountingTransactionInstance.status=='Cancelled'}"></g:elseif>
                      <g:else>
                        <span class="button"><g:actionSubmit class="cancel" action="cancel" value="${message(code: 'default.button.cancel.label', default: 'Cancel')}" /></span>
                      </g:else>
                      <g:if test="${glAccountingTransactionInstance.status=='Active'}"></g:if>
                      <g:elseif test="${glAccountingTransactionInstance.status=='Cancelled'}"></g:elseif>
                      <g:elseif test="${glAccountingTransactionInstance.status=='Approved'}"></g:elseif>
                      <g:elseif test="${approverChecker.role==session.user.role.id}">
                      <span class="button"><g:actionSubmit class="approve" action="approve" value="${message(code: 'default.button.approve.label', default: 'Approve')}" /></span>
                      </g:elseif>
                </g:form>
            </div>
        </div>
        <div class="dialog">
          
        </div>
    </body>
</html>
