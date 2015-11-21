

<%@ page import="com.cash.CashVoucher" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'cashVoucher.label', default: 'CashVoucher')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <script type="text/javascript">
        $(document).ready(function () {
            $("#payeeText").autocomplete({
                    source: function(request, response){
                        $.ajax({
                            url: "/jrl/lookup/payeeWithTin", // remote datasource
                            data: request,
                            success: function(data){
                                response(data); // set the response
                            },
                        });
                    },
                    minLength: 2, // triggered only after minimum 2 characters have been entered.
                    select: function(event, ui) { // event handler when user selects a company from the list.
                        $("#requestedBy").val(ui.item.id); // update the hidden field.
                        $("#tinText").val(ui.item.tin);
                        $("#tin").html(ui.item.tin);
                    }
                });
        })
        </script>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="cashVoucher.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${cashVoucherInstance}">
            <div class="errors">
                <g:renderErrors bean="${cashVoucherInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form>
                <div class="table-header">
                    <g:message code="default.button.details.label" args="[entityName]" />
                </div>
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td  class="name">
                                    <label for="party"><g:message code="default.amount.label" default="Amount" /></label>
                                </td>
                                 <td style="text-align:left" ><g:textField id="total" name="total" onchange="this.value=validateInteger(this.value)" style="text-align:right" value="0.00"/></td>
                            </tr> 

                            <tr class="prop">
                                <td  class="name">
                                    <label for="party"><g:message code="cashVoucher.requestedBy.label" default="Party" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: cashVoucherInstance, field: 'requestedBy', 'errors')}" style="width:20%">
                                    <g:textField name="payeeText" id="payeeText" value="${params.payeeText}"/>
                                    <input type="hidden" id="requestedBy" name="requestedBy" 
                                        value="${cashVoucherInstance?.requestedBy?.id}"/>
                                </td>
                                <td  class="name">
                                    <label for="tin">Tin</label>
                                    
                                </td>
                                <td  class="value">
                                    <span name="tin" id="tin">${params.tinText}</span>
                                    <input type="hidden" name="tinText" id="tinText" value="${params.tinText}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="name">
                                    <label for="party"><g:message code="cashVoucher.preparedBy.label" default="Party" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: cashVoucherInstance, field: 'preparedBy', 'errors')}">
                                    ${session.user.party.name}
                                </td>
                            </tr>

                            <tr class="prop">
                                <td  class="name">
                                    <label for="description"><g:message code="cashVoucher.description.label" default="Description" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: cashVoucherInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" value="${fieldValue(bean:cashVoucherInstance, field:'description')}"/>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <input type="hidden" name="formAction" value="create"/>
                    <g:actionSubmit id="save" name="create" class="save" action="save" value="${message(code: 'default.button.save.label', default: 'Save')}" />
                    <g:actionSubmit id="submit" name="submit" class="save" action="submit" value="Submit"  onclick="return confirm('Are you sure you want to submit?')"/>
                </div>
            </g:form>
        </div>
    </body>
</html>
