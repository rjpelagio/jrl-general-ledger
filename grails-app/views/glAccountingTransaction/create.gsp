<%@ page import="com.gl.GlAccountingTransaction" %>
<%@ page import="com.gl.GlAccount" %>
<%@ page import="com.app.Party" %>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'glAccountingTransaction.label', default: 'GlAccountingTransaction')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <g:javascript library="gl/acctgTrans"/>
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
                        $("tbody#dataTable tr#totals").before(<g:render template="/glAccountingTransaction/transItem"/>);
            

                        if ( $(document).height() > $(".leftnav").height() ) {
                            $(".leftnav").height($(document).height() - 50)
                        } else {
                            $(".leftnav").height($(".leftnav").height() - 50)
                        }
                        $(".rightnav").height($(".leftnav").height());
                        
                        return false;
                    }
                );
        });
        </script>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/dashBoard/list')}">${currentOrg}<g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${glAccountingTransactionInstance}">
                <div class="errors">
                    <g:renderErrors bean="${glAccountingTransactionInstance}" as="list" />
                </div>
            </g:hasErrors>
            <g:if test="${flash.errors}">
                <div class="errors">
                <ul><li>${flash.errors}</li></ul>
                </div>
            </g:if>
            <g:if test="${flash.batchMsgs}" >
                <div class="errors">
                    <ul>
                        <g:each in="${flash.batchMsgs}" var="msg">
                            <li>${msg}</li>
                        </g:each>
                    </ul>
                </div>
            </g:if>
            <g:form id="createAcctgTrans">
                <input type="hidden" name="formAction" value="create"/>
                <div class="table-header">
                    <g:message code="default.button.details.label" args="[entityName]" />
                </div>
                <div class="dialog" >
                    <table >
                        <tbody>
                            <tr class="prop">
                                <td  class="sub">
                                    <label for="Voucher No"><g:message code="glAccountingTransaction.voucherNo.label" default="Voucher No."  /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: glAccountingTransactionInstance, field: 'voucherNo', 'errors')}">
                                    <g:textField name="voucherNo" value="${glAccountingTransactionInstance?.voucherNo}"/>
                                </td>
                                <td  class="sub">
                                    <label for="Transaction Date"><g:message code="glAccountingTransaction.transactionDate.label" default="Transaction Date" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: glAccountingTransactionInstance, field: 'transactionDate', 'errors')}">
                                    <calendar:datePicker name="transactionDate" precision="day" value="${glAccountingTransactionInstance?.transactionDate}"  />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td  class="sub">
                                    <label for="Ref Doc"><g:message code="glAccountingTransaction.refDoc.label" default="Reference Doc" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: glAccountingTransactionInstance, field: 'refDoc', 'errors')}">
                                    <g:textField name="refDoc" value="${glAccountingTransactionInstance?.refDoc}"/>
                                </td>
                                <td  class="sub">
                                    <label for="Voucher Type"><g:message code="glAccountingTransaction.acctgTransType.label" default="Voucher Type" /></label>
                                </td>
                                <td >
                                    <g:select name="transType" from="${com.gl.AcctgTransType.list()}" optionKey="id" value="${glAccountingTransactionInstance?.acctgTransType?.id}"  />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td  class="sub">
                                    <label for="CDO Kg"><g:message code="glAccountingTransaction.cdoKg.label" default="CDO Kg" /></label>
                                </td>
                                <td >
                                    <g:textField name="cdoKg" value="${glAccountingTransactionInstance?.cdoKg}" />
                                </td>
                                <td  class="sub">
                                    <label for="Terms"><g:message code="glAccountingTransaction.terms.label" default="Terms" /></label>
                                </td>
                                <td >
                                    <select name="Terms">
                                        <option value="30D">30 Days</option>
                                        <option value="45D">45 Days</option>
                                        <option value="90D">90 Days</option>
                                    </select>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td  class="sub">
                                    <label for="Check No"><g:message code="glAccountingTransaction.checkNo.label" default="Check No." /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: glAccountingTransactionInstance, field: 'checkNo', 'errors')}">
                                    <g:textField name="checkNo" value="${glAccountingTransactionInstance?.checkNo}" />
                                </td>
                                <td  class="sub">
                                    <label for="Check Date"><g:message code="glAccountingTransaction.ckSiDate.label" default="Check/SI Date" /></label>
                                </td>
                                <td >
                                    <calendar:datePicker name="ckSiDate" precision="day" value="${glAccountingTransactionInstance?.ckSiDate}"  />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td  class="sub">
                                    <label for="Payee"><g:message code="glAccountingTransaction.partyId.label" default="Payee" /></label>
                                </td>
                                <td class="value ${hasErrors(bean: glAccountingTransactionInstance, field: 'party', 'errors')}">
                                    <g:textField name="payeeText" value="${payeeText}" id="payeeText"/>
                                    <input type="hidden" name="partyId" id="partyId" value="${glAccountingTransactionInstance?.party?.id}"/>
                                </td>
                                <td  class="sub">
                                    <label for="Tin"><g:message code="party.tin.label" default="TIN" /></label>
                                </td>
                                <td >
                                  <span id="tin">${tinText}</span>
                                  <input type="hidden" id="tinText" name="tinText" value="${tinText}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td  class="sub" style="vertical-align:top">
                                    <label for="Description"><g:message code="glAccountingTransaction.description.label" default="Description" /></label>
                                </td>
                                <td colspan="3"  class="value ${hasErrors(bean: glAccountingTransactionInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" value="${glAccountingTransactionInstance?.description}" rows="3" cols="150" style="resize:none" maxlength="500"/>
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
                                  <th style="width:65%">GL Account</th>
                                  <th style="text-align:right" >Debit</th>
                                  <th style="text-align:right" >Credit</th>
                                  <th></th>
                                </tr>
                            </thead>
                            <tbody id="dataTable">
                                <g:if test="${glAccounts.size() > 0}">
                                <input type="hidden" id="rowIndex" name="rowIndex" value="${rowIndex}"/>
                                <input type="hidden" id="rowNumber" name="rowNumber" value="${rowNumber}"/>
                                <g:each status="i" in="${glAccounts}" var="acct">
                                    <tr id="row_${i}">
                                        <td>
                                            <g:textField name="glAccounts" value="${acct}" id="glAccount_${i}" style="width:500px;background-color:#FFFF71" onkeypress="setSelectedIndex(${i})"/>
                                            <input type="hidden" id="glAccountId_${i}" name="glAccountIds" value="${glAccountIds[i]}"/>
                                        </td>
                                        <td style="text-align:right"><g:textField id="debit_${i}"
                                                         name="debits"
                                                         value="${debits[i]}"
                                                         onchange="this.value=validateInteger(this.value);recomputeDebit(${i})"
                                                         style="text-align:right" /></td>
                                        <td><g:textField id="credit_${i}"
                                                         name="credits"
                                                         value="${credits[i]}"
                                                         onchange="this.value=validateInteger(this.value);recomputeCredit(${i})"
                                                         style="text-align:right" /></td>
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
                                        <td>
                                            <g:textField name="glAccounts" id="glAccount_0"  style="width:500px;background-color:#FFFF71" onkeypress="setSelectedIndex(0)"/>
                                            <input type="hidden" id="glAccountId_0" name="glAccountIds"/>
                                        </td>
                                        <td style="text-align:right" ><g:textField id="debit_0" name="debits" onchange="this.value=validateInteger(this.value);recomputeDebit(0)" style="text-align:right" value="0.00" /></td>
                                        <td style="text-align:right" ><g:textField id="credit_0" name="credits" onchange="this.value=validateInteger(this.value);recomputeCredit(0)" style="text-align:right" value="0.00"/></td>
                                        <td>
                                            <input type="button" id="delete_0" value="Delete" onClick="deleteRow(0);"/>
                                        </td>
                                    </tr>
                                </g:else>
                                <tr id="totals">
                                    <td style="text-align:right">Total : </td>
                                    <td style="text-align:right" width="100%">
                                      <input type="hidden" id="debit" name="debit" value="${debit}"/>
                                      <span id="debitDisplay" style="font-size:16px;">${debit}</span>
                                    </td>
                                    <td style="text-align:right" width="100%">
                                      <input type="hidden" id="credit" name="credit" value="${credit}"/>
                                      <span id="creditDisplay" style="font-size:16px;">${credit}</span>
                                    </td>
                                    <td></td>
                                </tr>
                                <tr class="button-bar">
                                    <td colspan="4">                        
                                        <input type="button" id="addRow" class="add" value="Add Item"></input>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                </div>
                <br/>
                <div class="buttons">
                    <span style="float:right">
                        <g:actionSubmit id="save" name="create" class="save" action="save" value="${message(code: 'default.button.save.label', default: 'Save')}" />
                        <g:actionSubmit id="submit" name="submit" class="save" action="submit" value="Submit" />
                    </span>
                </div>
            </g:form>
        </div>
    </body>
</html>
