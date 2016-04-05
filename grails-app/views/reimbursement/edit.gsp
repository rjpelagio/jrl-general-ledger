

<%@ page import="com.cash.CashVoucher" %>
<%@ page import="com.app.Party" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'cashVoucher.label', default: 'CashVoucher')}" />
        <title><g:message code="reimburse.edit.label" args="[entityName]" /></title>
        <g:javascript library="cash/create_reimburse"/>
        <script type="text/javascript">
        $(document).ready(function () {
            $("#addRow").click(
                    function() {
                        var index = $("#rowNumber").val();
                        index++;
                        $("input[name='rowNumber']").val(index);
                        var rowIndex = $("#rowIndex").val();
                        rowIndex++;
                        $("input[name='rowIndex']").val(rowIndex);
                        $("tbody#dataTable tr#totals").before(<g:render template="/reimbursement/createLineItem"/>);
            

                        if ( $(document).height() > $(".leftnav").height() ) {
                            $(".leftnav").height($(document).height() - 50)
                        } else {
                            $(".leftnav").height($(".leftnav").height() - 50)
                        }
                        $(".rightnav").height($(".leftnav").height());
                        
                        return false;
                    }
                );
        })
        </script>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/dashBoard/list')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="reimburse.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="reimburse.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="reimburse.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${cashVoucherInstance}">
            <div class="errors">
                <g:renderErrors bean="${cashVoucherInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:if test="${flash.batchMsgs}" >
                <div class="errors">
                    <ul>
                        <g:each in="${flash.batchMsgs}" var="msg">
                            <li>${msg}</li>
                        </g:each>
                    </ul>
                </div>
            </g:if>
            <g:form method="post" >
                <input type="hidden" name="formAction" value="edit"/>
                <input type="hidden" name="department" value="${session.employee.department}"/>
                <div class="table-header">
                    <g:message code="default.button.details.label" args="[entityName]" />
                </div>
                <g:hiddenField name="id" value="${cashVoucherInstance?.id}" />
                <g:hiddenField name="version" value="${cashVoucherInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>

                            <tr class="prop">
                                <td class="sub">
                                  <label for="cashVoucherNumber"><g:message code="cashVoucher.cashVoucherNumber.label" default="Cash Voucher Number" /></label>
                                </td>
                                <td style="width:20%">
                                    ${cashVoucherInstance?.cashVoucherNumber}
                                    <input type="hidden" name="cashVoucherNumber" value="${cashVoucherInstance?.cashVoucherNumber}"/>
                                </td>

                                <td class="sub">
                                  <label for="status"><g:message code="cashVoucher.dateCreated.label" default="Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: cashVoucherInstance, field: 'dateCreated', 'errors')}">
                                    <g:formatDate g:formatDate format="yyyy-MM-dd" 
                                    date="${cashVoucherInstance?.dateCreated}" />
                                </td>

                            </tr>

                            <tr class="prop">
                                <td  class="sub">
                                    <label for="party">
                                        <g:message code="cashVoucher.requestedBy.label" default="Party" />
                                    </label>
                                </td>
                                <td class="value">
                                    <g:textField name="payeeText" id="payeeText" 
                                        value="${cashVoucherInstance?.requestedBy?.name}"/>
                                    <input type="hidden" id="requestedBy" name="requestedBy" 
                                        value="${cashVoucherInstance?.requestedBy?.id}"/>
                                </td>
                                <td  class="sub">
                                    <label for="tin">Tin</label>
                                </td>
                                <td class="value"> 
                                    <span name="tin" id="tin">
                                    ${cashVoucherInstance?.requestedBy?.tin}
                                    </span>
                                </td>
                            </tr>

                        
                            <tr class="prop">
                                <td  class="sub">
                                    <label for="party">
                                        <g:message code="cashVoucher.payee.label" default="Party" />
                                    </label>
                                </td>
                                <td class="value">
                                    <g:textField name="payeeText" id="payeeText2" 
                                        value="${cashVoucherInstance?.payee?.name}"/>
                                    <input type="hidden" id="payee" name="payee" 
                                        value="${cashVoucherInstance?.payee?.id}"/>
                                </td>
                                <td  class="sub">
                                    <label for="tin">Tin</label>
                                </td>
                                <td class="value">
                                    <span name="tin2" id="tin2">
                                    ${cashVoucherInstance?.payee?.tin}
                                    </span>
                                </td>
                                
                            </tr>

                            <tr class="prop">
                                <td class="sub">
                                     <label for="account"><g:message code="cashVoucher.glAccount.label" default="Account Title"/>
                                </td>
                                <td class="value ${hasErrors(bean: cashVoucherInstance, field: 'glAccount', 'errors')}">
                                    <g:textField name="glAccount" id="glAccount" size="40" 
                                        value="${cashVoucherInstance?.glAccount}"/>
                                    <input type="hidden" name="glAccountId" id="glAccountId" 
                                        value="${cashVoucherInstance?.glAccount?.id}"/>
                                </td>
                                <td  class="sub">
                                    <label for="party"><g:message code="cashVoucher.preparedBy.label" default="Party" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: cashVoucherInstance, field: 'preparedBy', 'errors')}">
                                    ${cashVoucherInstance?.preparedBy?.name}
                                </td>
                            </tr>

                            <tr class="prop">
                                <td  class="sub">
                                  <label for="approvalStatus"><g:message code="cashVoucher.status.label" default="Status" /></label>
                                </td>
                                <td class="value ${hasErrors(bean: cashVoucherInstance, field: 'status', 'errors')}">
                                    ${cashVoucherInstance?.status}
                                </td>
                                <td  class="sub">
                                  <label for="approvalStatus"><g:message code="cashVoucher.approvalStatus.label" default="Approval Status" /></label>
                                </td>
                                <td class="value ${hasErrors(bean: cashVoucherInstance, field: 'approvalStatus', 'errors')}">
                                    ${cashVoucherInstance?.approvalStatus}
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="sub" >
                                    <label for="description"><g:message code="cashVoucher.description.label" default="Description" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: cashVoucherInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" value="${fieldValue(bean:cashVoucherInstance, field:'description')}"/>
                                </td>
                                
                            </tr>

                        
                        </tbody>
                    </table>
                </div>
                <div class="list">
                    <table>
                        <thead>
                            <tr>
                                <g:if test="${session.employee.department == 'Finance'}">
                                    <th>GL Account</th>  
                                    <th>Description</th>
                                    <th>Payee</th>
                                    <th>Tin</th>
                                    <th>Ref Doc</th>
                                    <th>Amount</th>
                                    <th></th>          
                                </g:if>
                                <g:else>
                                    <th>Description</th>
                                    <th>Payee</th>
                                    <th>Tin</th>
                                    <th>Ref Doc</th>
                                    <th >Amount</th>
                                    <th></th>
                                </g:else>
                            </tr>
                        </thead>
                        <tbody id="dataTable">
                            <g:if test="${transItems.size() > 0}">
                    
                                    <input type="hidden" id="rowIndex" name="rowIndex" value="${rowIndex}"/>
                                    <input type="hidden" id="rowNumber" name="rowNumber" value="${rowNumber}"/>
                                    <g:each status="i" in="${transItems}" var="item">
                                            <tr id="row_${i}">



                                                <g:if test="${session.employee.department == 'Finance'}">
                                                    <td style="width:20%">
                                                        <g:textField id="glAccount_${i}"
                                                            name="glAccounts"
                                                            size="30"
                                                            value="${item.glAccount}"
                                                            onkeypress="getAccounts(${i})"/>
                                                        <input type="hidden" id="glAccountId_${i}" name="glAccountIds"
                                                            value="${item.glAccount.id}"/>
                                                    </td>
                                                    <td style="width:20%"><g:textField id="description_${i}"
                                                                 name="descriptions" size="35"
                                                                 value="${item.description}"/>
                                                    </td>
                                                    <td style="width:15%">
                                                        <g:textField id="payee_${i}"
                                                                     name="payees"
                                                                     value="${item.payee}"
                                                                     onkeypress="getPayees(${i})"/>
                                                        <input type="hidden" id="payeeId_${i}" 
                                                                     name="payeeIds"
                                                                     value="${item.payee.id}"
                                                                     />
                                                    </td>
                                                    <td style="width:10%">
                                                        <span id="tinText_${i}">${item.payee.tin}</span>
                                                    </td>
                                                    <td style="width:15%"><g:textField id="refDoc_${i}"
                                                                     name="refDocs"
                                                                     value="${item.referenceDoc}" size="20"/>
                                                    </td>
                                                    <td style="text-align:right;width:5%">
                                                        <g:textField id="amount_${i}"
                                                             name="amounts"
                                                             value="${item.amount}"
                                                             onchange="this.value=validateInteger(this.value);recomputeCredit(${i})"
                                                             style="text-align:right" size="10"/>
                                                    </td>
                                                    <td>
                                                      <input type="button" id="delete_${i}" value="Delete" onClick="deleteRow(${i});"/>
                                                    </td>
                                                </g:if>



                                                <g:else>
                                                    <td style="width:25%"><g:textField id="description_${i}"
                                                                     name="descriptions" size="55"
                                                                     value="${item.description}"/></td>
                                                    <td style="width:15%">
                                                        <g:textField id="payee_${i}"
                                                                     name="payees"
                                                                     value="${item.payee}"
                                                                     onkeypress="getPayees(${i})"/>
                                                        <input type="hidden" id="payeeId_${i}" 
                                                                     name="payeeIds"
                                                                     value="${item.payee.id}"
                                                                     />
                                                    </td>
                                                    <td style="width:15%">
                                                        <span id="tinText_${i}">${item.payee.tin}</span>
                                                    </td>
                                                    
                                                    <td style="width:25%"><g:textField id="refDoc_${i}"
                                                                     name="refDocs"
                                                                     value="${item.referenceDoc}" size="35"/></td>
                                                    <td style="text-align:right;width:5%"><g:textField id="amount_${i}"
                                                                     name="amounts"
                                                                     value="${item.amount}"
                                                                     onchange="this.value=validateInteger(this.value);recomputeCredit(${i})"
                                                                     style="text-align:right" size="10"/></td>
                                                    <td>
                                                      <input type="button" id="delete_${i}" value="Delete" onClick="deleteRow(${i});"/>
                                                    </td>
                                                </g:else>


                                            </tr>
                                        </g:each>

                            </g:if>
                            <tr id="totals">
                                <g:if test="${session.employee.department == 'Finance'}">
                                        <td></td>
                                </g:if>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td style="text-align:right">Total : </td>
                                <td style="text-align:right">
                                    <span id="totalDisplay">${cashVoucherInstance.total}</span> 
                                    <input type="hidden" name="total" id="total"/>
                                </td>
                                <td></td>
                            </tr>
                            <tr class="button-bar">
                                <g:if test="${session.employee.department == 'Finance'}">
                                   <td colspan="7">                        
                                        <input type="button" id="addRow" class="add" value="Add Item"></input>
                                    </td>
                                </g:if>
                                <g:else>
                                    <td colspan="6">                        
                                        <input type="button" id="addRow" class="add" value="Add Item"></input>
                                    </td>
                                </g:else>
                                
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
                                      <td style="width:65%">
                                            <g:if test="${appr.status  == 'Active'}">
                                                <g:if test="${appr.position  == session.employee.position}">
                                                    <g:textField name="remarks" value="${appr.remarks}" size="100"/>
                                                </g:if>
                                                <g:else>
                                                    Pending approval from ${appr.position} 
                                                </g:else>
                                            </g:if>
                                            <g:else>
                                                ${appr.remarks}
                                            </g:else>
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
                <div class="buttons">
                    <span class="button">
                        <g:actionSubmit class="save" action="update" value="${message(code: 'default.button.save.label', default: 'Save')}" />
                        <g:actionSubmit id="submit" name="submit" class="save" value="Submit" action="submit" />
                    
                    <g:if test="${approvalItems}">
                        <g:actionSubmit class="delete" action="cancel" value="${message(code: 'default.button.cancel.label', default: 'Cancel')}" onclick="return confirm('${message(code: 'default.button.cancel.confirm.message', default: 'Are you sure?')}');" />
                    </g:if>
                    </span>
                </div>
            </g:form>
        </div>
    </body>
</html>
