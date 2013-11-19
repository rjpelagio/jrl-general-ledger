<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<div id="navMenu">
  <ul>
    <li><a href="/jrl/">Setup</a>
       <ul>
          <li><g:link controller="party" action="list">Payee</g:link></li>
           <g:if test="${session.user.role.roleCode!='EMP'}">
            <li><g:link controller="employee" action="list">Employee</g:link></li>
            <li><g:link controller="appUser" action="list">Users</g:link></li>
          </g:if>
          <g:if test="${session.user.role.roleCode=='ADM'}">
            <li><g:link controller="appRole" action="list">Roles</g:link></li>
            <li><g:link controller="appOrganization" action="list">Organization</g:link></li>
          </g:if>
      </ul>
    </li>
    
    <li><a href="#">GL</a>
      <ul>
        <g:if test="${session.user.role.roleCode=='EMP'}">
        </g:if>
        <g:else>
        <li><g:link controller="glAccount" action="list">GL Setup</g:link>
            <ul>
              <li><g:link controller="glAccount" action="list">GL Account</g:link></li>
              <li><g:link controller="glAccountType" action="list">GL Account Type</g:link></li>
              <li><g:link controller="periodType" action="list">Period Type</g:link></li>
              <li><g:link controller="acctgPeriod" action="list">Accounting Period</g:link></li>
              <li><g:link controller="acctgPreferences" action="list">Company Preferences</g:link></li>
            </ul>
        </li>
        </g:else>
        <li><g:link controller="glAccountingTransaction" action="list">GL Transaction</g:link>
            <ul>
              <li><g:link controller="glAccountingTransaction" action="list">Accounting Transaction</g:link></li>
              <g:if test="${session.user.role.roleCode!='EMP'}">
                <li><g:link controller="glAccountingTransaction" action="consol">Account Consolidation</g:link></li>
              </g:if>
            </ul>
        </li>
        <g:if test="${session.user.role.roleCode!='EMP'}">
        <li>
          <g:link controller="reports" action="list">Reports</g:link>
          <ul>
            <li><g:link controller="reports" action="wtBalance">Working Trial Balance</g:link></li>
            <li><g:link controller="reports" action="glHistory">General Ledger History</g:link></li>
            <li><g:link controller="reports" action="balSheet">Balance Sheet</g:link></li>
            <li><g:link controller="reports" action="incomeSheet">Income Sheet</g:link></li>
          </ul>
        </li>
        </g:if>
      </ul>
    </li>
    <!--<li><a href="#" class="header-menu">Payables</a></li>
    <li><a href="#" class="header-menu">Receivables</a></li>-->
    <!--<li><a href="#" class="header-menu">HR</a></li>
    <li><a href="#" class="header-menu">Payroll</a></li>
    <li><a href="#" class="header-menu">Products</a></li>
    <li><a href="#" class="header-menu">Sales</a></li>
    <li><a href="#" class="header-menu">Warehouse</a></li>-->
  </ul>
</div>
<div style="clear:both"></div>

