<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<select name="year">
    <g:set var="year" value="${2010}"/>
    <g:set var="yearEnd" value="${year + 10}"/>
    <g:set var="selectedYear" value="${bean}"/>
    <g:while test="${year <= yearEnd}">
      <g:if test="${year==bean}">
          <option value="${year}" selected="selected">${year}</option>
      </g:if>
      <g:else>
          <option value="${year}">${year}</option>
      </g:else>
          <%year++%>
    </g:while>
    
</select>
