<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

  <div class="fullDiv">
    <div class="box1">
      <div class="bi">
        <div class="imgcntr">
          <img src="${resource(dir:'images',file:'modules.png')}">
        </div>
        <div class="mncntr">
          <h4>Voucher Summary </h4>
          <% <g:dashboardSummary /> %>
        </div>
        <div class="clearer"></div>
      </div>
    </div>
    <div class="box2">
      <div class="bi">
        <div class="imgcntr">
          <img src="${resource(dir:'images',file:'users.png')}">
        </div>
        <div class="mncntr">
          <h4>Profile Management</h4>
          <ul>
            <li><g:link controller="appUser" action="changePassword" id="${session.user.id}">Change Password</g:link></li>
          </ul>
        </div>
        <div class="clearer"></div>
      </div>
    </div>
    <div class="box1">
      <div class="bi">
        <div class="imgcntr">
          <img src="${resource(dir:'images',file:'modules.png')}">
        </div>
        <div class="mncntr">
          <h4>Voucher for Approval</h4>
          
             <% <g:approvalSummary />%>
          
        </div>
        <div class="clearer"></div>
      </div>
    </div>
  </div>