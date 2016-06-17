

<%@ page import="com.app.Party" %>
<%@ page import="com.gl.GlAccount" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'liquidation.label', default: 'Liquidation')}" />
        <title><g:message code="liquidation.edit.label" /></title>
        <g:javascript library="cash/create_liquidation"/>
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
                        $("tbody#dataTable tr#totals").before(<g:render template="/liquidation/createLineItem"/>);
            

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
            <span class="menuButton"><g:link class="list" action="list"><g:message code="liquidation.list.label"/></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="liquidation.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${trans}">
            <div class="errors">
                <g:renderErrors bean="${trans}" as="list" />
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
                <g:form>
                    <input type="hidden" name="formAction" value="edit"/>
                    <g:if test="${cashVoucherInstance != null}">
                        <br/>
                        <input type="hidden" name="cashVoucherNo" value="${cashVoucherInstance?.cashVoucherNumber}"/>
                        <input type="hidden" name="id" value="${trans.id}"/>
                        <div class="dialog">
                            <table>
                                <tbody>

                                    <tr class="prop">
                                        <td  class="sub"><g:message code="liquidation.number.label"/></td>
                                        
                                        <td  class="value" style="width:25%">${trans?.liquidationNumber}</td>
                                    </tr>

                                    <tr class="prop">
                                        <td  class="sub"><g:message code="cashVoucher.cashVoucherNumber.label" default="Cash Voucher Number" /></td>
                                        
                                        <td  class="value" style="width:25%">${cashVoucherInstance?.cashVoucherNumber}</td>

                                        <td  class="sub">CA Amount</td>
                                        
                                        <td  class="value">
                                            <g:formatNumber number="${cashVoucherInstance.total}" format="###,##0.00"  />
                                        </td>   
                                    </tr>
                                
                                    <tr class="prop">

                                        <td  class="sub"><g:message code="cashVoucher.glAccount.label" default="" /></td>
                                        
                                        <td  class="value">${cashVoucherInstance?.glAccount}</td>

                                        <td  class="sub">
                                            <g:message code="cashVoucher.dateCreated.label" default="Date Created" />
                                        </td>
                                        
                                        <td  class="value">
                                            <g:formatDate g:formatDate format="yyyy-MM-dd" 
                                                date="${cashVoucherInstance?.dateCreated}" />
                                        </td>

                                    </tr>
                                
                                    <tr class="prop">
                                        <td  class="sub"><g:message code="cashVoucher.party.label" default="Requested By" /></td>
                                        
                                        <td  class="value">${cashVoucherInstance?.requestedBy}</td>

                                        <td  class="sub"><g:message code="cashVoucher.payee.label" default="Payee" /></td>
                                        
                                        <td  class="value">${cashVoucherInstance?.payee}</td>
                                        
                                    </tr>

                                    <tr class="prop">
                                        <td  class="sub"><g:message code="cashVoucher.party.label" default="Prepared By" /></td>
                                        
                                        <td  class="value">${cashVoucherInstance?.preparedBy}</td>

                                        
                                    </tr>

                                    <tr class="prop">
                                        

                                        <td  class="sub"><g:message code="cashVoucher.status.label" default="Status" /></td>
                                        
                                        <td  class="value">${fieldValue(bean: cashVoucherInstance, field: "status")}</td>

                                        <td  class="sub">
                                            <g:message code="cashVoucher.approvalStatus.label" default="Approval Status" />
                                        </td>
                                        
                                        <td  class="value">
                                            ${fieldValue(bean: cashVoucherInstance, field: "approvalStatus")}
                                        </td>
                                           
                                    </tr>
                                    <tr class="prop">
                                        <td  class="sub"><g:message code="cashVoucher.description.label" default="Description" /></td>

                                        <td  class="value">${fieldValue(bean: cashVoucherInstance, field: "description")}</td>

                                    </tr>
                                    
                                </tbody>
                            </table>
                        </div>
                        <br/>
                        <div class="list">
                            <input type="hidden" id="voucherAmount" 
                                name="voucherAmount" value="${cashVoucherInstance?.total}"/>

                            <table>
                                <thead>
                                    <tr>
                                        <th>GL Account</th>  
                                        <th>Description</th>
                                        <th>Payee</th>
                                        <th>Tin</th>
                                        <th>Ref Doc</th>
                                        <th>Amount</th>
                                        <th></th>          
                                    </tr>
                                </thead>
                                <tbody id="dataTable">
                                    <g:if test="${transItems.size() >= 1}">
                                        <input type="hidden" id="rowIndex" name="rowIndex" value="${rowIndex}"/>
                                        <input type="hidden" id="rowNumber" name="rowNumber" value="${rowNumber}"/>
                                        <g:each status="i" in="${transItems}" var="item">
                                            <tr id="row_${i}">
                                                <td style="width:20%">
                                                    <g:textField id="glAccounts_${i}"
                                                        name="glAccounts"
                                                        size="30"
                                                        value="${GlAccount.get(item.glAccount?.id)}"
                                                        onkeypress="getAccounts(${i})"/> 
                                                    <input type="hidden" id="glAccountId_${i}" name="glAccountIds"
                                                        value="${item?.glAccount?.id}"/>
                                                </td>
                                                <td style="width:20%"><g:textField id="description_${i}"
                                                             name="descriptions" size="35"
                                                             value="${item?.description}"/>
                                                </td>
                                                <td style="width:15%">
                                                    <g:textField id="payee_${i}"
                                                                 name="payees"
                                                                 value="${item?.payee}"
                                                                 onkeypress="getPayees(${i})"/>
                                                    <input type="hidden" id="payeeId_${i}" 
                                                                 name="payeeIds"
                                                                 value="${item?.payee?.id}"/>
                                                </td>
                                                <td style="width:10%">
                                                    <span id="tinText_${i}">${item?.payee?.tin}</span>
                                                </td>
                                                <td style="width:15%"><g:textField id="refDoc_${i}"
                                                                 name="refDocs"
                                                                 value="${item?.refDoc}" size="20"/>
                                                </td>
                                                <td style="text-align:right;width:5%">
                                                    <g:textField id="amount_${i}"
                                                         name="amounts"
                                                         value="${item?.amount}"
                                                         onchange="this.value=validateInteger(this.value);recomputeAmount(${i})"
                                                         style="text-align:right" size="10"/>
                                                </td>
                                                <td>
                                                  <input type="button" id="delete_${i}" value="Delete" onClick="deleteRow(${i});"/>
                                                </td>
                                            </tr>
                                        </g:each>
                                    </g:if>
                                    <tr id="totals">
                                        <td></td><td></td><td></td><td></td>
                                        <td style="text-align:right">Total : </td>
                                        <td style="text-align:right">
                                            <span id="totalDisplay">${trans.total}</span> 
                                            <input type="hidden" name="total" id="total" value="${trans.total}"/>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr class="button-bar">
                                        <td colspan="7">                        
                                            <input type="button" id="addRow" class="add" value="Add Item"></input>
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
                            <g:actionSubmit id="save" name="create" class="save" action="update" value="${message(code: 'default.button.save.label', default: 'Save')}" />
                            <g:actionSubmit id="submit" name="submit" class="save" action="submit" value="Submit"/>
                        </div>
                    </g:if>
                </g:form>
        </div>
        <div id="dialog-message" title="Incomplete List">
           
            </div>
    </body>
</html>
