
<%@ page import="com.cash.CashVoucher" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'cashVoucher.label', default: 'CashVoucher')}" />
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
                            <td  class="name"><g:message code="cashVoucher.cashVoucherNumber.label" default="Cash Voucher Number" /></td>
                            
                            <td  class="value" style="width:25%">${fieldValue(bean: cashVoucherInstance, field: "cashVoucherNumber")}</td>
                            
                            <td  class="name"><g:message code="cashVoucher.status.label" default="Status" /></td>
                            
                            <td  class="value">${fieldValue(bean: cashVoucherInstance, field: "status")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td  class="name">
                                <g:message code="cashVoucher.dateCreated.label" default="Date Created" />
                            </td>
                            
                            <td  class="value">
                                <g:formatDate g:formatDate format="yyyy-MM-dd" 
                                    date="${cashVoucherInstance?.dateCreated}" />
                            </td>

                            <td  class="name">
                                <g:message code="cashVoucher.approvalStatus.label" default="Approval Status" />
                            </td>
                            
                            <td  class="value">
                                ${fieldValue(bean: cashVoucherInstance, field: "approvalStatus")}
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  class="name"><g:message code="cashVoucher.party.label" default="Requested By" /></td>
                            
                            <td  class="value">${cashVoucherInstance?.requestedBy}</td>

                            <td  class="name"><g:message code="cashVoucher.party.label" default="Prepared By" /></td>
                            
                            <td  class="value">${cashVoucherInstance?.preparedBy}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td  class="name"><g:message code="cashVoucher.total.label" default="Amount" /></td>
                            
                            <td  class="value">
                                <g:formatNumber number="${cashVoucherInstance.total}" format="###,##0.00"  />
                            </td>
                            <g:if test="${cashVoucherInstance.transType == 'REIMBURSEMENT'}">
                                <td  class="name"><g:message code="cashVoucher.change.label" default="Change" /></td>
                                
                                <td  class="value">${fieldValue(bean: cashVoucherInstance, field: "change")}</td>
                            </g:if>
                               
                        </tr>
                        <tr class="prop">
                            <td  class="name"><g:message code="cashVoucher.description.label" default="Description" /></td>

                            <td  class="value">${fieldValue(bean: cashVoucherInstance, field: "description")}</td>

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
                    <g:hiddenField name="id" value="${cashVoucherInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="cancel" value="${message(code: 'default.button.cancel.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.cancel.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
            </g:if>
        </div>
    </body>
</html>
