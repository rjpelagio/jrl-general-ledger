

<%@ page import="com.cash.CashVoucher" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'cashVoucher.label', default: 'CashVoucher')}" />
        <title>Disbursement</title>
        <script type="text/javascript">

            function setFlags(rowIndex){
            if ($("#check_"+rowIndex).is(':checked')) {
                    
                    var cashOnHand = parseFloat($("#cashOnHand").val());
                    var total = 0.00;
                    total = parseFloat($("#total").val());
                    total = total + parseFloat($("#amount_"+rowIndex).val());

                    if (total < cashOnHand) {
                        $("#total").val(total.toFixed(2));
                        $("#totalText").html(total.toFixed(2));
                        $("#flag_"+rowIndex).val('1');
                    } else {
                        alert ('Insufficient cash on hand.')
                        $("#check_"+rowIndex).attr('checked', false); 
                        $("#flag_"+rowIndex).val('0');
                    }
                    

                } else {
                    $("#flag_"+rowIndex).val('0');
                    var total = 0.00;
                    total = parseFloat($("#total").val());
                    total = total - parseFloat($("#amount_"+rowIndex).val());

                    if (total < 0) { 
                        total = 0.00; 
                    }
                    $("#total").val(total.toFixed(2))
                    $("#totalText").html(total.toFixed(2))
                }
            }

            function validate() {

                var flags = document.getElementsByName("flags");
                var valid = 0
                    
                for (i = 0; i < flags.length; i++) {
                    if ($("#check_"+i).is(':checked')) {
                        valid = 1;
                    }
                }

                if (valid == 0) {
                    alert ('Atleast 1 transaction must be selected.');
                    return false;
                }

            }

        </script>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/dashBoard/list')}">
                <g:message code="default.home.label"/></a>
            </span>
        </div>
        <div class="body">
            <h1><g:message code="disbursement.label" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:if test="${flash.errors}">
                <div class="errors"><ul><li>${flash.errors}</li></ul></div>
            </g:if>

            
            <div class="table-header">
              <g:message code="cashVoucher.transactionList.label" args="[entityName]" />
            </div>

            <g:form action="disburse">
                <input type="hidden" name="cashOnHand" value="${cashHistory?.amount}"/>
                <input type="hidden" name="preparedBy" value="${session.user.party.id}"/>
                <g:if test="${list.size() >= 1}">
                    <div class="list">
                        <table>
                            <thead>
                                <tr>
                                    <th></th>

                                    <th><g:message code="cashVoucher.cashVoucherNo.label"/></th>

                                    <th><g:message code="cashVoucher.dateCreated.label"/></th>

                                    <th><g:message code="cashVoucher.requestedBy.label"/></th>

                                    <th><g:message code="cashVoucher.payee.label"/></th>

                                    <th><g:message code="cashVoucher.transtype.label"/></th>

                                    <th style="text-align:right"><g:message code="cashVoucher.total.label"/></th>

                                </tr>
                            </thead>
                            <tbody>
                            <g:each in="${list}" status="i" var="trans">
                                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                                    
                                    <td style="width:3%">
                                        <input type="checkbox" class="checkbox" name="checks" id="check_${i}" 
                                                onclick="setFlags(${i})"/>
                                        <input type="hidden" name="flags" id="flag_${i}" value="0"/>
                                    </td>

                                    <td>${trans?.cashVoucherNumber}</td>
                                
                                    <td><g:formatDate format="yyyy-MM-dd" date="${trans?.dateCreated}" /></td>
                                
                                    <td>${trans?.requestedBy}</td>
                                
                                    <td>${trans?.payee}</td>

                                    <td style="width:10%">
                                        <g:if test="${trans?.transType == 'CASH_ADVANCE'}">Cash Advance</g:if>
                                        <g:if test="${trans?.transType == 'REIMBURSEMENT'}">Reimbursement</g:if>
                                    </td>

                                    <td style="text-align:right">
                                        ${trans?.total} 
                                        <input type="hidden" name="amounts" id="amount_${i}" value="${trans?.total}"/>
                                    </td>

                                </tr>
                            </g:each>
                            </tbody>
                        </table>
                    </div>
                    <br/>
                    <div class="total">
                        <table>
                            <tbody>
                                <tr style="background: #fff;">
                                    <td style="width:50%"></td>
                                    <td style="text-align:right;width:10%" class="sub">
                                        Cash on hand : 
                                    </td>
                                    <td style="text-align:right;width:10%">
                                        ${cashHistory?.amount}
                                        <input type="hidden" name="cashOnHand" 
                                            id="cashOnHand" value="${cashHistory?.amount}"/>
                                    </td>
                                    <td style="text-align:right; width:20%" class="sub">Disbursable Amount : </td>
                                    <td style="text-align:right; width:10%">
                                        <input type="hidden" name="total" id="total" value="0.00"/>
                                        <span id="totalText">0.00</span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <g:if test="${disableCreate == 'no'}">
                    <div class="buttons">   
                        <g:actionSubmit id="disburse" name="disburse" class="save" action="disburse" value="Disburse"
                            onclick="validate()"/>
                    </div>
                    </g:if>
                    

                </g:if>
                <g:if test="${list.size() < 1}" >
                    <div class="dialog">
                        <table>
                            <tbody>
                                <tr class="prop">
                                    <td  class="sub">
                                        <g:message code="cashVoucher.noDisbursement.label"/>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </g:if>
            </g:form>
        </div>
    </body>
</html>
