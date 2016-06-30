

<%@ page import="com.cash.CashVoucher" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Liquidation Summary</title>
        <script type="text/javascript">
            //This function ensures the passing of date parameters during pagination.
            function fPassDate (date) {
                $("#from_date").val(date)
            }

            function tPassDate (date) {
                $("#thru_date").val(date)
            }

            function validateFields(link) {
                    var fromDate = $("#from_date").val();
                    var thruDate = $("#thru_date").val();
                    var fromDateInvalid = 0
                    var thruDateInvalid = 0
                    var msg = '';

                    if (fromDate == '') {
                        fromDateInvalid = 1
                        $("#fromDate_value").css("border", "1px solid red");
                    }

                    if (thruDate == '') {
                        thruDateInvalid = 1
                        $("#thruDate_value").css("border", "1px solid red");
                    }

                    if (fromDateInvalid == 1 || thruDateInvalid == 1) {
                        $("#dialog-message").append("<p>Please fill up the From and Thru Date fields.</p>")
                        $("#dialog-message").dialog( "open" );
                        return false;
                    } else {
                        //Determine if fromDate is before than thruDate
                        var d1 = new Date(fromDate)
                        var d2 = new Date(thruDate)
                        if (d1.getTime() == d2.getTime()) {
                            $("#dialog-message").append("<p>From Date and Thru Date must not be equal.</p>")
                            $("#dialog-message").dialog( "open" );
                            return false;
                        } else if (d1.getTime() > d2.getTime()) {
                            $("#dialog-message").append("<p>From Date must be before than Thru Date</p>")
                            $("#dialog-message").dialog( "open" );
                        } else {
                            return submit_CashVoucher(link)
                        }

                    }
            }

            function submit_CashVoucher(link) {
                link.parentNode._format.value = link.title;
                link.parentNode.submit();

                return false;
            }

            $(document).ready(function () {
                    
                    $( "#dialog-message" ).dialog({
                        modal: true,
                        autoOpen : false,
                        draggable: false,
                        resizable: false,
                        closeOnEscape: false,
                        buttons: {
                            OK: function() {
                                $("#dialog-message").html("");
                                $( this ).dialog( "close" );
                            }
                        }
                    });
            });
        </script>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/dashBoard/list')}"><g:message code="default.home.label"/></a></span>
        </div>
        <div class="body">
            <h1><g:message code="liquidationSummary.label" /></h1>
            <g:if test="${flash.errors}">
                <div class="errors"><ul><li>${flash.errors}</li></ul></div>
            </g:if>
            <div class="table-header">
              <g:message code="default.button.search.label" args="[entityName]" />
            </div>
            
                <div class="dialog">
                    
                    <table>
                        <tbody>
                            <g:form>
                                <tr class="prop">
                                    <td  class="sub">
                                        <label for="fromDate"><g:message code="fromDate.label"/>
                                    </td>
                                    <td  class="value">
                                        <calendar:datePicker name="fromDate" precision="day" value="${params?.fromDate}"
                                            onChange="javascript:fPassDate(this.value)"/>
                                    </td>
                                </tr>

                                <tr class="prop">
                                    <td  class="sub">
                                        <label for="thruDate"><g:message code="thruDate.label"/>
                                    </td>
                                    <td  class="value">
                                        <calendar:datePicker name="thruDate" precision="day" value="${params?.thruDate}"
                                            onChange="javascript:tPassDate(this.value)"/>
                                    </td>
                                </tr>
                            </g:form>
                            <tr>
                                
                                <td style="padding-left:150px" colspan="2">
                                    <script type="text/javascript">
                                    
                                    </script>
                                    <form class="jasperReport" name="LIquidation Summary" action="/jrl/jasper/">
                                        <input type="hidden" name="_format" value="PDF">
                                        <input type="hidden" name="_name" value="Liquidation Summary ${new Date()}">
                                        <input type="hidden" name="_file" value="LiquidationSummary">
                                        <input type="hidden" name="logged_user" value="1">
                                        <input type="hidden" name="orgcode" value="1">
                                        <input type="hidden" id="from_date" name="from_date" value="">
                                        <input type="hidden" id="thru_date" name="thru_date" value="">

                                        <a href="#" class="pdfButton" title="PDF" onclick="javascript:validateFields(this);" id="pdfButton">PDF</a>

                                        &nbsp;
                                        <a href="#" class="pdfButton" title="XLS" onclick="javascript:validateFields(this)" id="xlsButton">XLS</a>
                                    </form>
                                </td>
                                <td>
                                    
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div id="dialog-message" title="Incomplete Parameters">
           
                </div>
            <br/>
        </div>
    </body>
</html>
