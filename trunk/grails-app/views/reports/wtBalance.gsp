<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Working Trial Balance Report</title>
        <script>
          $(document).ready(function () {
            $("#acctgPeriod").change(function(){
              showDuration($(this).val());
            })
            $("#transFromDate").change(function(){
              alert($(this).val());
            })
          });
          function showDuration(periodId){
            $.ajax({
              url: "../reports/showjson/"+periodId,
              dataType:"json",
              success: function(json) {
                  $("#trans_from_date").val(dateFormat(json.fromDate, "yyyy-mm-dd"))
                  $("#trans_thru_date").val(dateFormat(json.thruDate, "yyyy-mm-dd"))
                  //$("#transFromDate").val(dateFormat(json.fromDate, "yyyy-mm-dd"))
                  //$("#transThruDate").val(dateFormat(json.thruDate, "yyyy-mm-dd"))
                  $("#bal_from_date").val(dateFormat(json.fromDate, "yyyy-mm-dd"))
                  $("#bal_thru_date").val(dateFormat(json.fromDate, "yyyy-mm-dd"))
              }
            });
          }

          //function setThruDate(){
            //$("#trans_thru_date").value = $("transThruDate").value;
          //}
        </script>
    </head>
    <body>
      <div class="body">
        <h1>Working Trial Balance</h1>
        <g:form action="list">
          <div class="dialog">
            <table>
              <tbody>
                <tr class="prop">
                  <td valign="top" class="name">
                    <label for="acctgPeriod"><g:message code="acctgPeriod.acctgPeriod.label" default="Accounting Period"/></label>
                  </td>
                  <td valign="top" class="value ${hasErrors(bean: acctgPeriodInstance, field: 'acctgPeriod', 'errors')}">
                    <g:select id="acctgPeriod" name="acctgPeriod" from="${com.gl.AcctgPeriod.list()}" optionKey="id" value="${acctgPeriodInstance?.acctgPeriod?.acctgPeriodNum}" onchange="(document.getElementById('period').value = this.value)" />
                  </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="transFromDate"><g:message code="period.fromDate.label" default="From Date" /></label>
                    </td>
                    <td valign="top" class="value">
                        <calendar:datePicker name="transFromDate" precision="day" value="" onChange="(document.getElementById('trans_from_date').value = dateFormat(this.value, 'yyyy-mm-dd')); (document.getElementById('bal_thru_date').value = dateFormat(this.value, 'yyyy-mm-dd'))"/>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="transThruDate"><g:message code="period.thruDate.label" default="Thru Date" /></label>
                    </td>
                    <td valign="top" class="value">
                        <calendar:datePicker name="transThruDate" precision="day" onChange="(document.getElementById('trans_thru_date').value = dateFormat(this.value, 'yyyy-mm-dd'));" />
                    </td>
                </tr>
              </tbody>
            </table>
          </div>
        </g:form>
        <g:jasperReport jasper="WTBalance" format="PDF" name="Working Trial Balance">
          <input type="hidden" name="logged_user" value="${session.user.id}"/>
          <input type="hidden" name="orgcode" value="${session.organization.id}"/>
          <input type="hidden" id="period" name="period" value="${com.gl.AcctgPeriod.get(1).id}"/>
          <input type="hidden" id="bal_from_date" name="bal_from_date"/>
          <input type="hidden" id="bal_thru_date" name="bal_thru_date"/>
          <input type="hidden" id="trans_from_date" name="trans_from_date"/>
          <input type="hidden" id="trans_thru_date" name="trans_thru_date"/>
        </g:jasperReport>
      </div>
    </body>
</html>