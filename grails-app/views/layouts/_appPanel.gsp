<!-- 
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<div id="navMenu">
  <ul>
    <!-- ADM only -->
    <g:if test="${session?.employee?.position == 'Manager'}">
    <li><a href="/jrl/">Setup</a>
       <ul>
          <li><g:link controller="party" action="list">Payee</g:link></li>
          <li><g:link controller="employee" action="list">Employee</g:link></li>
          <li><g:link controller="appUser" action="list">Users</g:link></li>
          <li><g:link controller="approval" action="list">Approval Setup</g:link></li>
          <li>
            <a href="#">Customer</a>
            <ul>
              <li><g:link controller="customerArea" action="list">Customer Area</g:link></li>
              <li><g:link controller="customer" action="list">Customer Info</g:link></li>
            </ul>
          </li>
          <li> 
            <a href="#">Salesman</a>
            <ul>
              <li><g:link controller="salesmanArea" action="list">Salesman Area</g:link></li>
              <li><g:link controller="salesman" action="list">Salesman Info</g:link></li>
            </ul>
          </li>
          <li><g:link controller="area" action="list">Area</g:link></li>
        </ul>
    </li>
    </g:if>
    
    <li><a href="#">GL</a>
      <ul>
        <!-- ADM  -->
        <g:if test="${session?.employee?.position == 'Manager'}">
        <li><g:link controller="glAccount" action="list">GL Setup</g:link>
            <ul>
              <li><g:link controller="glAccount" action="list">GL Account</g:link></li>
              <li><g:link controller="glAccountType" action="list">GL Account Type</g:link></li>
              <li><g:link controller="periodType" action="list">Period Type</g:link></li>
              <li><g:link controller="acctgPeriod" action="list">Accounting Period</g:link></li>
              <li><g:link controller="acctgPreferences" action="list">Company Preferences</g:link></li>
            </ul>
        </li>
        </g:if>

        <li><g:link controller="glAccountingTransaction" action="list">GL Transaction</g:link>
            <ul>
              <li><g:link controller="glAccountingTransaction" action="list">Accounting Transaction</g:link></li>
              <li><g:link controller="glAccountingTransaction" action="consol">Account Consolidation</g:link></li>
            </ul>
        </li>

      <g:if test="${session?.employee?.position == 'Manager' || session?.employee?.position == 'Supervisor'}">
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

    <li><a href="#">Cash</a>
      <ul>
        <li><a href="#">Petty Cash</a>
          <ul>
            <li><g:link controller="cashVoucher" action="list">Cash Advance</g:link></li>
            <li><a href="#">Reimbursement</a></li>
          </ul>
        </li>
        <li><a href="#">Disbursement</a></li>
        <li><a href="#">Replenishment</a></li>
      </ul>
    </li>

    <li><a href="#">AR</a>
      <ul>
        <li><g:link controller="receivables" action="receivable">Receivables</g:link></li>
        <li><g:link controller="receivables" action="collection">Sales and Collection History</g:link></li>
        <li><g:link controller="receivables" action="remittance">Salemen's Remittance</g:link></li>
        <li><g:link controller="receivables" action="violation">Receivables Violation</g:link></li>  
        <li>
          <a href="#">Summary of Sales and Invoices</a>
          <ul>
            <li><g:link controller="receivables" action="summary">SCIDE</g:link></li>
            <li><g:link controller="receivables" action="sid">SID</g:link></li>
          </ul>
        </li>  
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

