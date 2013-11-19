<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
    <meta http-equiv="Content-Type"
          content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main" />
    <g:if test="${session.user == null && request.getSession(false)}">
      <title>Login</title>
    </g:if>
    <g:else>
      <title>Main</title>
    </g:else>
  </head>
  <body>
  <g:if test="${session.user == null && request.getSession(false)}">
    <div id="rightdiv">
      <div id="rightdivframe">
        <div id="rightdivcontent">
          <h2>Sign In</h2>
          <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
          </g:if>
          <g:form action="authenticate" method="post" controller="appUser" >
            <label for="login">Username</label>
            <input type="text" id="username" name="username"/>
            <label for="password">Password</label>
            <input type="password"
                   id="password" name="password"/>
            <label for="organization">Company</label>
            <g:select name="organization.id" from="${com.app.AppOrganization.list()}" optionKey="id" value="${glAccountingTransactionInstance?.organization?.id}"  />
            <div class="clearer"></div>
            <div class="buttons">
              <span class="button">
                <input type="submit" value="Login" />
              </span>
            </div>
          </g:form>
        </div>
      </div>
    </div>
    <div id="leftdiv">
      <div id="contentdiv">
        <h4>VISION STATEMENT</h4>
        <p>Our vision is to be the leading distribution company committed to continuously harness the full market potentials in close partnership and cooperation of our principals and valued customers thus ensuring the success of our collective performance.<br>
        </p>
        <h4>MISSION STATEMENT</h4>
        <p>
        Our mission is to achieve dominance of the market through our unwavering commitment in providing our customers with continuous improvement and innovation in the delivery of our services.
        </p>
        
        <h4>CORE VALUES</h4>
        <ul>
          <li>Integrity and honesty</li>
          <li>Dependability</li>
          <li>Passionately committed to improve and to excel</li>
        </ul>
      </div>
    </div>
    </g:if>
  <!--
    
    
  -->
  <g:if test="${session.user != null}">
    <g:if test="${flash.message}">
      <div class="message">${flash.message}</div>
    </g:if>
    
    <g:if test="${session.user.role}"> 
        <g:render template="/layouts/dashBoard" />
    </g:if>
  </g:if>
</body>
</html>
