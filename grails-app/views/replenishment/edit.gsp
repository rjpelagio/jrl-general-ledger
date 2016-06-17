

<%@ page import="com.cash.Replenishment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'replenishment.label', default: 'Replenishment')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
        <g:javascript library="cash/create_replenishment"/>
        <g:javascript library="cash/cash_denominations"/>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:if test="${flash.errors}">
                <div class="errors"><ul><li>${flash.errors}</li></ul></div>
            </g:if>
            <g:hasErrors bean="${trans}">
            <div class="errors">
                <g:renderErrors bean="${trans}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${trans?.id}" />
                <input type="hidden" name="formAction" value="edit"/>
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td  class="sub"><g:message code="replenishment.number.label" default="Replenishment Number" /></td>
                            
                                <td  class="value" style="width:25%">${trans?.replenishmentNumber}</td>
                            </tr>
                            <tr class="prop">
                                <td class="sub" style="width:20%">
                                    <label for="amount">
                                        <g:message code="amount.label"/>
                                    </label>
                                </td>
                                <td class="value ${hasErrors(bean: trans, field: 'amount', 'errors')}" style="width:15%">
                                    <g:textField id="amount" name="amount"  readonly="readonly"
                                        onchange="this.value=validateInteger(this.value)" 
                                            style="text-align:right" value="${trans?.amount}"/>
                                </td>
                                <td class="sub" style="width:20%">
                                    <label for="change">
                                        <g:message code="change.label"/>
                                    </label>
                                </td>
                                
                                <td class="value ${hasErrors(bean: trans, field: 'change', 'errors')}">
                                    <g:textField id="change" name="change"  readonly="readonly"
                                        onchange="this.value=validateInteger(this.value)" 
                                            style="text-align:right" value="${trans?.change}"/>
                                </td>
                            </tr>
                            <tr class="prop">
                                <td  class="sub">
                                    <label for="party"><g:message code="cashVoucher.glAccount.label" default="Account" /></label>
                                </td>
                                 <td  class="value ${hasErrors(bean: cashVoucherInstance, field: 'glAccount', 'errors')}">
                                    <g:textField id="glAccount" name="glAccount" 
                                        size="40" value="${trans?.glAccount ? trans?.glAccount : ''}"/>
                                    <input type="hidden" id="glAccountId" name="glAccountId"
                                        value="${trans?.glAccountId ? trans?.glAccountId : ''}"/>
                                </td>
                            </tr> 
                            <tr class="prop">
                                <td  class="sub" style="width:18%">
                                    <label for="preparedBy">
                                        <g:message code="preparedBy.label"/>
                                    </label>
                                </td>
                                <td  class="value">
                                    ${trans?.preparedBy}  
                                </td>
                            </tr>
                            <tr class="prop">
                                <td  class="sub">
                                    <label for="description"><g:message code="description.label" default="Description" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: trans, field: 'description', 'errors')}">
                                    <input type="text" id="description" name="description"
                                        size="50" value="${trans?.description ? trans?.description : ''}"/>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div id="accordion" style="padding-top:5px">   
                    <h3>Transaction List</h3>
                    <div class="list" >
                        <table>
                            <thead>
                                <tr>
                                    <!--<th></th> -->

                                    <th><g:message code="replenishment.transNo.label"/></th>

                                    <th><g:message code="dateCreated.label"/></th>

                                    <th><g:message code="transactionType.label"/></th>

                                    <th style="text-align:right"><g:message code="amount.label"/></th>

                                    <th style="text-align:right"><g:message code="change.label"/></th>

                                </tr>
                            </thead>
                            <tbody>
                            <g:each in="${list}" status="i" var="item">
                                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                                    
                                    <!--<td style="width:3%">
                                        <input type="checkbox" class="checkbox" name="checks" id="check_${i}" 
                                                onclick="setFlags(${i})"/>
                                        <input type="hidden" name="flags" id="flag_${i}" value="0"/>
                                    </td>-->

                                    <td>${item?.transactionNo}</td>
                                
                                    <td><g:formatDate format="yyyy-MM-dd" date="${item?.dateCreated}" /></td>
                                
                                    <td>${item?.type}</td>

                                    <td style="text-align:right">
                                        ${item?.amount} 
                                        <input type="hidden" name="amounts" id="amount_${i}" value="${item?.amount}"/>
                                    </td>

                                    <td style="text-align:right">
                                        ${item?.change} 
                                        <input type="hidden" name="changes" id="change_${i}" value="${item?.change}"/>
                                    </td>

                                </tr>
                            </g:each>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="total" style="padding-top: 5px">
                    <table>
                        <tbody>
                            <tr style="background: #fff;">
                                <td style="width:8%" class="sub">Current Cash on hand :</td>
                                <td style="width:3%">
                                    <span id="cashOnHandText">0.00</span>
                                    <input type="hidden" name="cashOnHand" 
                                        id="cashOnHand" value="${params.cashOnHand ? params.cashOnHand : ''}"/>
                                </td>
                                <td style="text-align:left;width:4%">
                                    <input type="button" id="denominationButton" value="Denomination"></input>
                                </td>
                                <td style="width:8%" class="sub">
                                    Recorded Cash on Hand : 
                                </td>
                                <td style="width:3%">
                                    <input type="hidden" name="recordedCoh" id="recordedCoh" 
                                        value="${params.recordedCoh ? params.recordedCoh : cashItem?.recordedCoh}"/>
                                    <span id="totalText">${cashItem?.recordedCoh}</span>
                                </td>
                                <td style="width:1%" class="sub">
                                    Variance : 
                                </td>
                                <td style="text-align:right;width:3%">
                                    <input type="hidden" name="variance" id="variance" 
                                        value="${params.variance ? params.variance : cashItem?.variance}"/>

                                    <span id="varianceText">
                                            ${params.variance ? params.variance : cashItem?.variance}</span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <input type="hidden" id="thousandDem" name="thousandDem" 
                        value="${params.thousandDem ? params.thousandDem : cashItem?.thousandDem}"/>
                <input type="hidden" id="fiveHundredDem" name="fiveHundredDem" 
                    value="${params.fiveHundredDem ? params.fiveHundredDem : cashItem?.fiveHundredDem}"/>
                <input type="hidden" id="twoHundredDem" name="twoHundredDem" 
                    value="${params.twoHundredDem ? params.twoHundredDem : cashItem?.twoHundredDem}"/>
                <input type="hidden" id="hundredDem" name="hundredDem" 
                    value="${params.hundredDem ? params.hundredDem : cashItem?.hundredDem}"/>
                <input type="hidden" id="fiftyDem" name="fiftyDem" 
                    value="${params.fiftyDem ? params.fiftyDem : cashItem?.fiftyDem}"/>
                <input type="hidden" id="twentyDem" name="twentyDem" 
                    value="${params.twentyDem ? params.twentyDem : cashItem?.twentyDem}"/>
                <input type="hidden" id="tenDem" name="tenDem" 
                    value="${params.tenDem ? params.tenDem : cashItem?.tenDem}"/>
                <input type="hidden" id="fiveDem" name="fiveDem" 
                    value="${params.fiveDem ? params.fiveDem : cashItem?.fiveDem}"/>
                <input type="hidden" id="pesoDem" name="pesoDem" 
                    value="${params.pesoDem ? params.pesoDem : cashItem?.pesoDem}"/>
                <input type="hidden" id="fiftyCentDem" name="fiftyCentDem" 
                    value="${params.fiftyCentDem ? params.fiftyCentDem : cashItem?.fiftyCentDem}"/>
                <input type="hidden" id="twentyFiveCentDem" name="twentyFiveCentDem" 
                    value="${params.twentyFiveCentDem ? params.twentyFiveCentDem : cashItem?.twentyFiveCentDem}"/>

                <div id="dialog-message" title="">
           
                </div>
                <g:render template="/replenishment/cashDenominations"/>
                
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
