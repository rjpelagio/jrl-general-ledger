

<%@ page import="com.app.Party" %>
<%@ page import="com.gl.GlAccount" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'cashVoucher.label', default: 'CashVoucher')}" />
        <title><g:message code="reimburse.create.label" /></title>
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
            <span class="menuButton"><g:link class="list" action="list"><g:message code="reimburse.list.label"/></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="reimburse.create.label" args="[entityName]" /></h1>
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

            <g:form>
                <input type="hidden" name="formAction" value="create"/>
                <input type="hidden" name="department" id="department" value="${session.employee.department}"/>
                <div class="table-header">
                    <g:message code="default.button.details.label" args="[entityName]" />
                </div>
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td class="sub">
                                    <label for="party"><g:message code="cashVoucher.requestedBy.label" default="Party" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: cashVoucherInstance, field: 'requestedBy', 'errors')}" style="width:20%">
                                    <g:textField name="payeeText" id="payeeText" value="${params.payeeText}"/>
                                    <input type="hidden" id="requestedBy" name="requestedBy" 
                                        value="${params.requestedBy}"/>
                                </td>
                                <td  class="sub">
                                    <label for="tin">Tin</label>
                                </td>
                                <td  class="value">
                                    <span name="tin" id="tin">${params.tinText}</span>
                                    <input type="hidden" name="tinText" id="tinText" value="${params.tinText}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td  class="sub">
                                    <label for="party"><g:message code="cashVoucher.payee.label" default="Party" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: cashVoucherInstance, field: 'payee', 'errors')}" style="width:20%">
                                    <g:textField name="payeeText2" id="payeeText2" value="${params.payeeText2}"/>
                                    <input type="hidden" id="payee" name="payee" 
                                        value="${params.payee}"/>
                                </td>
                                <td  class="sub">
                                    <label for="tin">Tin</label>
                                    
                                </td>
                                <td  class="value">
                                    <span name="tin2" id="tin2">${params.tinText2}</span>
                                    <input type="hidden" name="tinText2" id="tinText2" value="${params.tinText2}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td  class="sub">
                                    <label for="party"><g:message code="cashVoucher.glAccount.label" default="Account" /></label>
                                </td>
                                 <td  class="value ${hasErrors(bean: cashVoucherInstance, field: 'glAccount', 'errors')}">
                                    <g:textField id="glAccount" name="glAccount" size="40" value="${params?.glAccount ? params?.glAccount : setup?.reimbursementAcctTitle}"/>
                                    <input type="hidden" id="glAccountId" name="glAccountId"
                                        value="${params?.glAccountId ? params?.glAccountId : setup?.reimbursementAcctTitle?.id}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="sub">
                                    <label for="party"><g:message code="cashVoucher.preparedBy.label" default="Party" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: cashVoucherInstance, field: 'preparedBy', 'errors')}">
                                    ${session.user.party.name}
                                </td>
                            </tr>

                            <tr class="prop">
                                <td  class="sub">
                                    <label for="description"><g:message code="cashVoucher.description.label" default="Description" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: cashVoucherInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" value="${params.description}"/>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <br/>

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
                               
                                <g:if test="${payeeIds.size() > 0}">
                                    <input type="hidden" id="rowIndex" name="rowIndex" value="${rowIndex}"/>
                                    <input type="hidden" id="rowNumber" name="rowNumber" value="${rowNumber}"/>
                                    <g:each status="i" in="${payeeIds}" var="acct">
                                        <tr id="row_${i}">
                                            <g:if test="${session.employee.department == 'Finance'}">
                                                <td style="width:20%">
                                                    <g:textField id="glAccounts_${i}"
                                                        name="glAccounts"
                                                        size="30"
                                                        value="${GlAccount.get(glAccountIds[i])}"
                                                        onkeypress="getAccounts(${i})"/> 
                                                    <input type="hidden" id="glAccountId_${i}" name="glAccountIds"
                                                        value="${glAccountIds[i]}"/>
                                                </td>
                                                <td style="width:20%"><g:textField id="description_${i}"
                                                             name="descriptions" size="35"
                                                             value="${descriptions[i]}"/>
                                                </td>
                                                <td style="width:15%">
                                                    <g:textField id="payee_${i}"
                                                                 name="payees"
                                                                 value="${payees[i]}"
                                                                 onkeypress="getPayees(${i})"/>
                                                    <input type="hidden" id="payeeId_${i}" 
                                                                 name="payeeIds"
                                                                 value="${payeeIds[i]}"
                                                                 />
                                                </td>
                                                <td style="width:10%">
                                                    <span id="tinText_${i}">${Party.get(payeeIds[i])?.tin}</span>
                                                </td>
                                                <td style="width:15%"><g:textField id="refDoc_${i}"
                                                                 name="refDocs"
                                                                 value="${refDocs[i]}" size="20"/>
                                                </td>
                                                <td style="text-align:right;width:5%">
                                                    <g:textField id="amount_${i}"
                                                         name="amounts"
                                                         value="${amounts[i]}"
                                                         onchange="this.value=validateInteger(this.value);recomputeAmount(${i})"
                                                         style="text-align:right" size="10"/>
                                                </td>
                                                <td>
                                                  <input type="button" id="delete_${i}" value="Delete" onClick="deleteRow(${i});"/>
                                                </td>
                                            </g:if>
                                            <g:else>
                                               
                                                <td style="width:25%"><g:textField id="description_${i}"
                                                                 name="descriptions" size="55"
                                                                 value="${descriptions[i]}"/></td>
                                                <td style="width:15%">
                                                    <g:textField id="payee_${i}"
                                                                 name="payees"
                                                                 value="${payees[i]}"
                                                                 onkeypress="getPayees(${i})"/>
                                                    <input type="hidden" id="payeeId_${i}" 
                                                                 name="payeeIds"
                                                                 value="${payeeIds[i]}"
                                                                 />
                                                </td>
                                                <td style="width:15%">
                                                    <span id="tinText_${i}">${Party.get(payeeIds[i])?.tin}</span>
                                                </td>
                                                
                                                <td style="width:25%"><g:textField id="refDoc_${i}"
                                                                 name="refDocs"
                                                                 value="${refDocs[i]}"/></td>
                                                <td style="text-align:right;width:5%"><g:textField id="amount_${i}"
                                                                 name="amounts"
                                                                 value="${amounts[i]}"
                                                                 onchange="this.value=validateInteger(this.value);recomputeAmount(${i})"
                                                                 style="text-align:right" size="10"/></td>
                                                <td>
                                                  <input type="button" id="delete_${i}" value="Delete" onClick="deleteRow(${i});"/>
                                                </td>
                                            </g:else>
                                        </tr>
                                    </g:each>
                                </g:if>
                                <g:else>
                                    <input type="hidden" id="rowIndex" name="rowIndex" value="1"/>
                                    <input type="hidden" id="rowNumber" name="rowNumber" value="0"/> 
                                    <tr id="row_0">
                                        <g:if test="${session.employee.department == 'Finance'}">
                                            <td style="width:20%">
                                                <g:textField id="glAccounts_0"
                                                    name="glAccounts"
                                                    size="30"
                                                    onkeypress="getAccounts(0)"
                                                    value="${glAccounts}"/>
                                                <input type="hidden" id="glAccountIds_0" name="glAccountIds" value="${glAccountIds}"/>    
                                            </td>
                                            <td style="width:20%">
                                                <g:textField id="description_0" name="descriptions" size="35"
                                                    value="${descriptions}"/>
                                            </td>
                                            <td style="width:15%">
                                                <g:textField id="payee_0" name="payees" onkeypress="getPayees(0)" value="${payees}" />
                                                <input type="hidden" id="payeeId_0" name="payeeIds" value="${payeeIds}"/>
                                            </td>
                                            <td style="width:10%">
                                                <span id="tinText_0">
                                                    <g:if test="${payeeIds != [:]}">
                                                        ${Party?.get(payeeIds)?.tin}
                                                    </g:if>        
                                                </span>
                                            </td>
                                            <td style="width:15%">
                                                <g:textField id="refDoc_0" name="refDocs" size="20" value="${refDocs}"/>
                                            </td>
                                            <td style="text-align:right;width:5%">
                                                <g:if test="${amounts != null}">
                                                     <g:textField id="amount_0" name="amounts" 
                                                        onchange="this.value=validateInteger(this.value);recomputeAmount(0)" 
                                                            style="text-align:right" value="${amounts}" size="10"/>
                                                </g:if>
                                                <g:else>
                                                    <g:textField id="amount_0" name="amounts" 
                                                        onchange="this.value=validateInteger(this.value);recomputeAmount(0)" 
                                                            style="text-align:right" value="0.00" size="10"/>
                                                </g:else>
                                               
                                            </td>
                                            <td>
                                                <input type="button" id="delete_0" value="Delete" onClick="deleteRow(0);"/>
                                            </td>
                                        </g:if>
                                        <g:else>
                                            <td style="width:25%">
                                                <g:textField id="description_0" name="descriptions" size="55" 
                                                    value="${descriptions}"/>
                                            </td>
                                            <td style="width:15%">
                                                <g:textField id="payee_0" name="payees" onkeypress="getPayees(0)" 
                                                    value="${payees}"/>
                                                <input type="hidden" id="payeeId_0" name="payeeIds" value="${payeeIds}" />
                                            </td>
                                            <td style="width:15%"><span id="tinText_0">${Party?.get(payeeIds)?.tin}</span></td>
                                            <td style="width:25%">
                                                <g:textField id="refDoc_0" name="refDocs" size="35"
                                                    value="${refDocs}"/>
                                            </td>
                                            <td style="text-align:right;width:5%">
                                                <g:if test="${amounts != null}">
                                                     <g:textField id="amount_0" name="amounts" 
                                                        onchange="this.value=validateInteger(this.value);recomputeAmount(0)" 
                                                            style="text-align:right" value="${amounts}" size="10"/>
                                                </g:if>
                                                <g:else>
                                                    <g:textField id="amount_0" name="amounts" 
                                                        onchange="this.value=validateInteger(this.value);recomputeAmount(0)" 
                                                            style="text-align:right" value="0.00" size="10"/>
                                                </g:else>
                                            <td>
                                                <input type="button" id="delete_0" value="Delete" onClick="deleteRow(0);"/>
                                            </td>
                                        </g:else>
                                    </tr>
                                </g:else>

                                
                                <tr id="totals">
                                    <g:if test="${session.employee.department == 'Finance'}">
                                        <td></td>
                                    </g:if>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td style="text-align:right">Total : </td>
                                    <td style="text-align:right">
                                        <span id="totalDisplay">${params?.total}</span> 
                                        <input type="hidden" name="total" id="total" value="${params?.total}"/>
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
                <br/>

                <div class="buttons">
                    <g:actionSubmit id="save" name="create" class="save" action="save" value="${message(code: 'default.button.save.label', default: 'Save')}" />
                    <g:actionSubmit id="submit" name="submit" class="save" action="submit" value="Submit"/>
                </div>
            </g:form>
        </div>
        <div id="dialog-message" title="Incomplete List">
           
        </div>
    </body>
</html>
