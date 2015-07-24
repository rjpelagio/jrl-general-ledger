<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Income Sheet Report</title>
        <script>
          $(document).ready(function () {
            $("#acctgPeriod").change(function(){
              showDuration($(this).val());
            })
          });
          function showDuration(periodId){
            $.ajax({
              url: "../reports/showjson/"+periodId,
              dataType:"json",
              success: function(json) {
                  $("#from_date").val(dateFormat(json.fromDate, "yyyy-mm-dd"))
                  $("#thru_date").val(dateFormat(json.thruDate, "yyyy-mm-dd"))
              }
            });
          }
        </script>
    </head>
    <body>
      <div class="body">
        <h1>Income Sheet Report</h1>
        <g:form action="list">
          <div class="dialog">
            <table>
              <tbody>
                <tr class="prop">
                  <td  class="name">
                    <label for="acctgPeriod"><g:message code="acctgPeriod.acctgPeriod.label" default="Acctg Period"/></label>
                  </td>
                  <td  class="value ${hasErrors(bean: acctgPeriodInstance, field: 'acctgPeriod', 'errors')}">
                    <g:select id="acctgPeriod" name="acctgPeriod" from="${com.gl.AcctgPeriod.list()}" optionKey="id" value="${acctgPeriodInstance?.acctgPeriod?.acctgPeriodNum}" onchange="(document.getElementById('period').value = this.value)" />
                  </td>
                </tr>
                <tr class="prop">
                  <td  class="name">
                    <label for="glAccount"><g:message code="glAccountOrganization.glAccount.label" default="Gl Account" /></label>
                  </td>
                  <td  class="value ${hasErrors(bean: glAccountOrganizationInstance, field: 'glAccount', 'errors')}">
                    <g:select name="glAccount.id" from="${com.gl.GlAccountOrganization.list()}" optionKey="id" value="${glAccountOrganizationInstance?.glAccount?.id}" onchange="(document.getElementById('gl_account').value = this.value)" />
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </g:form>
        <g:jasperReport jasper="GLHistory" format="PDF" name="General Ledger History">
          <input type="hidden" name="logged_user" value="${session.user.id}"/>
          <input type="hidden" name="orgcode" value="${session.organization.id}"/>
          <input type="hidden" id="period" name="period" value="${com.gl.AcctgPeriod.get(1).id}"/>
          <input type="hidden" id="gl_account" name="gl_account" value="${com.gl.GlAccount.get(1).id}"/>
          <input type="text" id="from_date" name="from_date" value="${com.gl.AcctgPeriod.get(1).fromDate}"/>
          <input type="text" id="thru_date" name="thru_date" value="${com.gl.AcctgPeriod.get(1).thruDate}"/>
        </g:jasperReport>
      </div>
    </body>
</html>