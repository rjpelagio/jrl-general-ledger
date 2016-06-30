

<%@ page import="com.cash.CashSetup" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'cashSetup.label', default: 'CashSetup')}" />
        <title>Cash Setup</title>
        <g:javascript library="cash/cash_setup"/>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/dashBoard/list')}"><g:message code="default.home.label"/></a></span>
            </span>
        </div>
        <div class="body">
            <h1>Cash Setup</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${cashSetupInstance}">
            <div class="errors">
                <g:renderErrors bean="${cashSetupInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>   
                        <tbody>
                            <tr class="prop">
                                <td class="name" colspan="2" style="padding-left:10px">
                                Cash Advance and Liquidation Default Accounts
                                </td>   
                            </tr>
                            <tr class="prop">
                                <td  class="sub" style="width:25%;text-align:right;padding-right:25px">
                                    <label for="cashVoucherAcctTitle">Cash Advance</label>
                                </td>
                                <td  class="value ${hasErrors(bean: setup, field: 'cashVoucherAcctTitle', 'errors')}">
                                    <g:textField id="cashVoucherAcctTitle" name="cashVoucherAcctTitle" size="50"
                                        value="${setup?.cashVoucherAcctTitle}"/>
                                    <input type="hidden" id="cashVoucherAcctTitleId" name="cashVoucherAcctTitleId"
                                        value="${setup?.cashVoucherAcctTitle?.id}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="sub" style="width:25%;text-align:right;padding-right:25px">
                                    <label for="liquidationAcctTitle">Liquidation</label>
                                </td>
                                <td  class="value ${hasErrors(bean: cashSetupInstance, field: 'liquidationAcctTitle', 'errors')}">
                                    <g:textField id="liquidationAcctTitle" name="liquidationAcctTitle" size="50"
                                        value="${setup?.liquidationAcctTitle}"/>
                                    <input type="hidden" id="liquidationAcctTitleId" name="liquidationAcctTitleId"
                                        value="${setup?.liquidationAcctTitle?.id}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td class="name" colspan="2" style="padding-left:10px">
                                Reimbursement Default Accounts
                                </td>   
                            </tr>
                        
                            <tr class="prop">
                                <td  class="sub" style="width:25%;text-align:right;padding-right:25px">
                                    <label for="reimbursementAcctTitle">Reimbursement</label>
                                </td>
                                <td  class="value ${hasErrors(bean: cashSetupInstance, field: 'reimbursementAcctTitle', 'errors')}">
                                    <g:textField id="reimbursementAcctTitle" name="reimbursementAcctTitle" size="50"
                                        value="${setup?.reimbursementAcctTitle}"/>
                                    <input type="hidden" id="reimbursementAcctTitleId" name="reimbursementAcctTitleId"
                                        value="${setup?.reimbursementAcctTitle?.id}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="sub" style="width:25%;text-align:right;padding-right:25px">
                                    <label for="reimbursementCreditAccount"><g:message code="cashSetup.reimbursementCreditAccount.label" default="Reimbursement Credit Account" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: cashSetupInstance, field: 'reimbursementCreditAccount', 'errors')}">
                                    <g:textField id="reimbursementCreditAccount" name="reimbursementCreditAccount" size="50"
                                        value="${setup?.reimbursementCreditAccount}"/>
                                    <input type="hidden" id="reimbursementCreditAccountId" name="reimbursementCreditAccountId"
                                        value="${setup?.reimbursementCreditAccount?.id}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="sub" style="width:25%;text-align:right;padding-right:25px">
                                    <label for="reimbursementDebitAccount"><g:message code="cashSetup.reimbursementDebitAccount.label" default="Reimbursement Debit Account" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: cashSetupInstance, field: 'reimbursementDebitAccount', 'errors')}">
                                    <g:textField id="reimbursementDebitAccount" name="reimbursementDebitAccount" size="50"
                                        value="${setup?.reimbursementDebitAccount}"/>
                                    <input type="hidden" id="reimbursementDebitAccountId" name="reimbursementDebitAccountId"
                                        value="${setup?.reimbursementDebitAccount?.id}"/>
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td class="name" colspan="2" style="padding-left:10px">
                                Replenishment Default Accounts
                                </td>   
                            </tr>
                            <!--
                            <tr class="prop">
                                <td  class="sub" style="width:25%;text-align:right;padding-right:25px">
                                    <label for="replenishmentAcctTitle">Replenishment</label>
                                </td>
                                <td  class="value ${hasErrors(bean: cashSetupInstance, field: 'replenishmentAcctTitle', 'errors')}">
                                    <g:textField id="replenishmentAcctTitle" name="replenishmentAcctTitle" size="50"
                                        value="${setup?.replenishmentAcctTitle}"/>
                                    <input type="hidden" id="replenishmentAcctTitleId" name="replenishmentAcctTitleId"
                                        value="${setup?.replenishmentAcctTitle?.id}"/>
                                </td>
                            </tr>
                            -->
                            <tr class="prop">
                                <td  class="sub" style="width:25%;text-align:right;padding-right:25px">
                                    <label for="replenishmentAcctTitle">Replenishment Negative Variance (Debit)</label>
                                </td>
                                <td  class="value ${hasErrors(bean: cashSetupInstance, field: 'replenishmentNegVariance', 'errors')}">
                                    <g:textField id="replenishmentNegVariance" name="replenishmentNegVariance" size="50"
                                        value="${setup?.replenishmentNegVariance}"/>
                                    <input type="hidden" id="replenishmentNegVarianceId" name="replenishmentNegVarianceId"
                                        value="${setup?.replenishmentNegVariance?.id}"/>
                                </td>
                            </tr>
                            <tr class="prop">
                                <td  class="sub" style="width:25%;text-align:right;padding-right:25px">
                                    <label for="replenishmentPosVariance">Replenishment Positive Variance (Credit)</label>
                                </td>
                                <td  class="value ${hasErrors(bean: cashSetupInstance, field: 'replenishmentPosVariance', 'errors')}">
                                    <g:textField id="replenishmentPosVariance" name="replenishmentPosVariance" size="50"
                                        value="${setup?.replenishmentPosVariance}"/>
                                    <input type="hidden" id="replenishmentPosVarianceId" name="replenishmentPosVarianceId"
                                        value="${setup?.replenishmentPosVariance?.id}"/>
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="Save" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
