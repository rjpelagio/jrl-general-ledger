<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<select name="acctgPeriodNum">
    <g:set var="period" value="${1}"/>
    <g:while test="${period <= 12}">
      <g:if test="${period==bean}">
          <option value="${period}" selected="selected">${period}</option>
      </g:if>
      <g:else>
          <option value="${period}">${period}</option>
      </g:else>
          <%period++%>
    </g:while>
    
</select>
