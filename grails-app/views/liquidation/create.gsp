

<%@ page import="com.app.Party" %>
<%@ page import="com.gl.GlAccount" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'liquidation.label', default: 'Liquidation')}" />
        <title><g:message code="liquidation.create.label" /></title>
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
            <h1><g:message code="liquidation.create.label" args="[entityName]" /></h1>
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
            <g:hasErrors bean="${trans}">
            <div class="errors">
                <g:renderErrors bean="${trans}" as="list" />
            </div>
            </g:hasErrors>
            <g:if test="${cashVoucherList.size() >= 1}" >
                <g:form>
                    <input type="hidden" name="formAction" value="create"/>
                    <div class="dialog">
                        <table>
                            <tbody>

                                <tr class="prop">
                                    <td  class="sub" style="width:18%">
                                        <label for="cashVoucher">
                                            <g:message code="cashVoucher.cashVoucherNumber.label"/>
                                        </label>
                                    </td>
                                    <td  class="value">
                                        <g:select optionKey="id" optionValue="cashVoucherNumber" value="${params.cashVoucher}"
                                            name="cashVoucher" from="${cashVoucherList}" noSelection="['':'']" />
                                        &nbsp;&nbsp;
                                        <g:actionSubmit id="load" name="load" class="load" action="load" value="Load" />

                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <g:if test="${cashVoucherInstance != null}">
                        <br/>
                        <input type="hidden" name="cashVoucherNo" value="${cashVoucherInstance?.cashVoucherNumber}"/>
                        <div class="dialog">
                            <table>
                                <tbody>

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
                                    <g:if test="${payeeIds.size() > 0}">
                                        <input type="hidden" id="rowIndex" name="rowIndex" value="${rowIndex}"/>
                                        <input type="hidden" id="rowNumber" name="rowNumber" value="${rowNumber}"/>
                                        <g:each status="i" in="${payeeIds}" var="acct">
                                            <tr id="row_${i}">

                                                
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
                                                
                                            </tr>
                                        </g:each>
                                    </g:if>
                                    <g:else>
                                        <input type="hidden" id="rowIndex" name="rowIndex" value="1"/>
                                        <input type="hidden" id="rowNumber" name="rowNumber" value="0"/> 

                                        <tr id="row_0">
                                            
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
                                            <td style="width:10%"><span id="tinText_0">
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
                                            
                                        </tr>
                                    </g:else>
                                    
                                    <tr id="totals">
                                        <td></td><td></td><td></td><td></td>
                                        <td style="text-align:right">Total : </td>
                                        <td style="text-align:right">
                                            <span id="totalDisplay"></span> 
                                            <input type="hidden" name="total" id="total" value="${params.total}"/>
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
                        <div class="buttons">
                            <g:actionSubmit id="save" name="create" class="save" action="save" value="${message(code: 'default.button.save.label', default: 'Save')}" />
                            <g:actionSubmit id="submit" name="submit" class="save" action="submit" value="Submit"/>
                        </div>
                    </g:if>
                </g:form>
            </g:if>
            <g:if test="${cashVoucherList.size() < 1}" >
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td  class="sub">
                                    <g:message code="cashVoucher.noLiquidation.label"/>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </g:if>
            <div id="dialog-message" title="Incomplete List">
           
            </div>
        </div>
    </body>
</html>
