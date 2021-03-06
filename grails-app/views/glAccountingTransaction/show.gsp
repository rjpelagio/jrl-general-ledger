
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
            <div class="table-header">
                    <g:message code="default.button.details.label" args="[entityName]" />
                </div>
            <div class="dialog">

                <table>
                    <tbody>
                        
                        <tr class="prop">
                            <td  class="name"><g:message code="glAccountingTransaction.voucherNo.label" default="Voucher No." /></td>
                            
                            <td  class="value">${fieldValue(bean: glAccountingTransactionInstance, field: "voucherNo")}</td>

                            <td  class="name"><g:message code="glAccountingTransaction.transactionDate.label" default="Transaction Date" /></td>

                            <td  class="value"><g:formatDate format="yyyy-MM-dd" date="${glAccountingTransactionInstance?.transactionDate}" /></td>
                        </tr>

                        <tr class="prop">
                            
                            <td  class="name"><g:message code="glAccountingTransaction.postedDate.label" default="Posted Date" /></td>

                            <td  class="value"><g:formatDate format="yyyy-MM-dd" date="${glAccountingTransactionInstance?.postedDate}" /></td>

                            <td  class="name"><g:message code="glAccountingTransaction.entryDate.label" default="Entry Date" /></td>

                            <td  class="value"><g:formatDate format="yyyy-MM-dd" date="${glAccountingTransactionInstance?.entryDate}" /></td>

                        </tr>
                        
                        <tr class="prop">
                            

                            <td  class="name"><g:message code="glAccountingTransaction.voucherType.label" default="Voucher Type" /></td>

                            <td  class="value">${fieldValue(bean: glAccountingTransactionInstance, field: "acctgTransType")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  class="name"><g:message code="glAccountingTransaction.cdoKg.label" default="CDO Kg" /></td>

                            <td  class="value">${fieldValue(bean: glAccountingTransactionInstance, field: "cdoKg")}</td>

                            <td  class="name"><g:message code="glAccountingTransaction.terms.label" default="Terms" /></td>

                            <td  class="value">${fieldValue(bean: glAccountingTransactionInstance, field: "terms")}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td  class="name"><g:message code="glAccountingTransaction.checkNo.label" default="Check No." /></td>

                            <td  class="value">${fieldValue(bean: glAccountingTransactionInstance, field: "checkNo")}</td>

                            <td  class="name"><g:message code="glAccountingTransaction.ckSiDate.label" default="Check/SI Date" /></td>

                            <td  class="value">${fieldValue(bean: glAccountingTransactionInstance, field: "ckSiDate")}</td>

                        </tr>

                        <tr class="prop">
                            <td  class="name"><g:message code="glAccountingTransaction.party.label" default="Payee" /></td>

                            <td  class="value">${fieldValue(bean: glAccountingTransactionInstance, field: "party")}</td>

                            <td  class="name"><g:message code="party.tin.label" default="TIN" /></td>

                            <td  class="value">${glAccountingTransactionInstance?.party?.tin?:'N/A'}</td>

                        </tr>
                        
                        <tr class="prop">

                            <td  class="name"><g:message code="glAccountingTransaction.preparedBy.label" default="Prepared By" /></td>

                            <td  class="value">${fieldValue(bean: glAccountingTransactionInstance, field: "preparedBy.name")}</td>

                          
                            <td  class="name"><g:message code="glAccountingTransaction.refDoc.label" default="Reference Doc" /></td>

                            <td  class="value">${fieldValue(bean: glAccountingTransactionInstance, field: "refDoc")}</td>
                        </tr>

                        <tr class="prop">
                            <td  class="name"><g:message code="glAccountingTransaction.status.label" default="Status"/></td>
                            <td  class="value">${fieldValue(bean: glAccountingTransactionInstance, field: "status")}</td>
                            <td class="name">Approval Status</td>
                            <td class="value">
                              ${fieldValue(bean: glAccountingTransactionInstance, field : "approvalStatus")}
                            </td>

                        </tr>

                        <tr class="prop">
                            <td  class="name"><g:message code="glAccountingTransaction.description.label" default="Description" /></td>

                            <td  class="value" style="width:50%">${fieldValue(bean: glAccountingTransactionInstance, field: "description")}</td>

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
            </div>
          
            <g:if test="${approvalItems}">
              <br/>
                <div class="list">
                  <table border="1">
                      <thead>
                          <tr>
                            <th>Approval Remarks</th>
                            <th>Position</th>
                            <th>Updated By</th>
                            <th>Last Updated</th>
                          </tr>
                      </thead>
                      <tbody id="dataTable"><tbody id="dataTable">
                          <g:each status="i" in="${approvalItems}" var="appr">
                              <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                                  <td>
                                      <g:if test="${appr.remarks  == ''}">
                                          Pending approval from ${appr.position}
                                      </g:if>
                                      <g:else>${appr.remarks}</g:else>
                                  </td>
                                  <td>${appr.position}</td>
                                  <td>${appr.updatedBy?.name}</td>
                                  <td>${appr.lastUpdated}</td>
                                </tr>
                          </g:each>
                      </tbody>
                  </table>
                </div>
            </g:if>
            <g:if test="${showButtons == true}">
              <div class="buttons">
                  <g:form>
                      <g:hiddenField name="transId" value="${glAccountingTransactionInstance?.id}" />
                      <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" />
                      <span class="button"><g:actionSubmit class="delete" action="cancel" value="${message(code: 'default.button.cancel.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.cancel.confirm.message', default: 'Are you sure?')}');" /></span>
                  </g:form>
              </div>
            </g:if>
        </div>
        
    </body>
</html>
