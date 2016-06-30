
<%@ page import="com.cash.CashVoucher" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'cashVoucher.label', default: 'CashVoucher')}" />
        <title><g:message code="reimburse.show.label" args="[entityName]" /></title>
        <script type="text/javascript">

            $(document).ready(function () {


                $( "#accordion" ).accordion({
                  collapsible: true
                });



            });


        </script>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/dashBoard/list')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="replenishment.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="replenishment.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="replenishment.show.label" args="[entityName]" /></h1>
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
                            <td  class="sub"><g:message code="replenishment.number.label" default="Replenishment Number" /></td>
                            
                            <td  class="value" style="width:25%">${fieldValue(bean: trans, field: "replenishmentNumber")}</td>
                        </tr>

                        <tr class="prop">

                            <td  class="sub"><g:message code="amount.label" default="Amount" /></td>
                            
                            <td  class="value">
                                <g:formatNumber number="${trans.amount}" format="###,##0.00"  />
                            </td>

                            <td  class="sub"><g:message code="change.label" default="Change" /></td>
                            
                            <td  class="value">
                                <g:formatNumber number="${trans.change}" format="###,##0.00"  />
                            </td>

                      
                        </tr>
                    
                        <tr class="prop">

                            <td  class="sub"><g:message code="glAccount.label" default="" /></td>
                            
                            <td  class="value">${trans?.glAccount}</td>

                            <td  class="sub">
                                <g:message code="dateCreated.label" default="Date Created" />
                            </td>
                            
                            <td  class="value">
                                <g:formatDate g:formatDate format="yyyy-MM-dd" 
                                    date="${trans?.dateCreated}" />
                            </td>

                        </tr>
                    
                        <tr class="prop">
                            <td  class="sub"><g:message code="preparedBy.label" default="Prepared By" /></td>
                            
                            <td  class="value">${trans?.preparedBy}</td>

                            
                        </tr>

                        <tr class="prop">
                            

                            <td  class="sub"><g:message code="cashVoucher.status.label" default="Status" /></td>
                            
                            <td  class="value">${trans?.status}</td>

                            <td  class="sub">
                                <g:message code="cashVoucher.approvalStatus.label" default="Approval Status" />
                            </td>
                            
                            <td  class="value">
                                ${trans?.approvalStatus}
                            </td>
                               
                        </tr>
                        <tr class="prop">
                            <td  class="sub"><g:message code="description.label" default="Description" /></td>

                            <td  class="value">${trans?.description}</td>

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

                                <g:if test="${item?.liquidation}">
                                    <td>
                                        ${item?.liquidation?.liquidationNumber}
                                    </td>
                                    <td>
                                        <g:formatDate format="yyyy-MM-dd" date="${item?.liquidation?.dateCreated}" />
                                    </td>
                                    <td>
                                        Liquidation
                                    </td>
                                    <td style="text-align:right">
                                        <g:formatNumber number="${item?.liquidation?.total}" format="###,##0.00"  />
                                    </td>
                                    <td style="text-align:right">
                                        <g:formatNumber number="${item?.liquidation?.change}" format="###,##0.00"  />
                                    </td>
                                </g:if>        
                                <g:elseif test="${item?.cashVoucher}">  
                                    <td>
                                        ${item?.cashVoucher?.cashVoucherNumber}
                                    </td>  
                                    <td>
                                        <g:formatDate format="yyyy-MM-dd" date="${item?.cashVoucher?.dateCreated}" />
                                    </td>  
                                    <td>
                                        Reimbursement
                                    </td>
                                    <td style="text-align:right">
                                        <g:formatNumber number="${item?.cashVoucher?.total}" format="###,##0.00"  />
                                    </td>
                                    <td style="text-align:right">
                                        <g:formatNumber number="${item?.cashVoucher?.change}" format="###,##0.00"  />
                                    </td>
                                </g:elseif>



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
                                        <span id="cashOnHandText">
                                            <g:formatNumber number="${cashItem?.cashOnHand}" format="###,##0.00"  />
                                        </span>
                                    </td>
                                    <td style="text-align:left;width:4%">
                                        &nbsp;
                                    </td>
                                    <td style="width:8%" class="sub">
                                        Recorded Cash on Hand : 
                                    </td>
                                    <td style="width:3%">
                                        <span id="totalText">
                                            <g:formatNumber number="${cashItem?.recordedCoh}" format="###,##0.00"  />
                                        </span>
                                    </td>
                                    <td style="width:1%" class="sub">
                                        Variance : 
                                    </td>
                                    <td style="text-align:right;width:3%">
                                        <g:if test="${params.variance > 0}">
                                            <span id="varianceText" style="color : #3C5326">
                                                <g:formatNumber number="${cashItem.variance}" format="###,##0.00"  />
                                            </span>
                                        </g:if>
                                        <g:else test="${params.variance < 0}">
                                            <span id="varianceText" style="color : red">
                                                <g:formatNumber number="${cashItem.variance}" format="###,##0.00"  />
                                            </span>
                                        </g:else>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
            <!--
            <g:if test="${transItems}">
                <br/>
                <div>
                    <div class="list">
                        <table border="1">
                            <thead>
                                <tr>
                                    <th>GL Account</th>
                                    <th>Description</th>
                                    <th>Payee</th>
                                    <th>Tin</th>
                                    <th>Ref Doc</th>
                                    <th>Amount</th>
                                </tr>
                            </thead>
                            <tbody id="dataTable">
                                <g:each status="i" in="${transItems}" var="item">
                                    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                                        <td>${item.glAccount}</td>
                                        <td>${item.description}</td>
                                        <td>${item.payee}</td>
                                        <td>${item.payee?.tin}</td>
                                        <td>${item.referenceDoc}</td>
                                        <td>${item.amount}</td>
                                    </tr>
                                </g:each>
                            </tbody>
                        </table>
                    </div>
                </div>
            </g:if>
            -->
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
                      <tbody id="dataTable">
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
                    <g:hiddenField name="id" value="${trans?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="cancel" value="${message(code: 'default.button.cancel.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.cancel.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
            </g:if>
        </div>
    </body>
</html>
