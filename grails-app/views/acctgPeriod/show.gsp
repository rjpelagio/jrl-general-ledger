
<%@ page import="com.gl.AcctgPeriod" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'acctgPeriod.label', default: 'AcctgPeriod')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td  class="name"><g:message code="acctgPeriod.id.label" default="Id" /></td>
                            
                            <td  class="value">${fieldValue(bean: acctgPeriodInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  class="name"><g:message code="acctgPeriod.acctgPeriodNum.label" default="Acctg Period Num" /></td>
                            
                            <td  class="value">${fieldValue(bean: acctgPeriodInstance, field: "acctgPeriodNum")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  class="name"><g:message code="acctgPeriod.month.label" default="Month" /></td>
                            
                            <td  class="value">${fieldValue(bean: acctgPeriodInstance, field: "month")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  class="name"><g:message code="acctgPeriod.status.label" default="Status" /></td>
                            
                            <td  class="value">${fieldValue(bean: acctgPeriodInstance, field: "status")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  class="name"><g:message code="acctgPeriod.fromDate.label" default="From Date" /></td>
                            
                            <td  class="value"><g:formatDate date="${acctgPeriodInstance?.fromDate}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  class="name"><g:message code="acctgPeriod.thruDate.label" default="Thru Date" /></td>
                            
                            <td  class="value"><g:formatDate date="${acctgPeriodInstance?.thruDate}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  class="name"><g:message code="acctgPeriod.year.label" default="Year" /></td>
                            
                            <td  class="value">${fieldValue(bean: acctgPeriodInstance, field: "year")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  class="name"><g:message code="acctgPeriod.dateCreated.label" default="Date Created" /></td>
                            
                            <td  class="value"><g:formatDate date="${acctgPeriodInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  class="name"><g:message code="acctgPeriod.organization.label" default="Organization" /></td>
                            
                            <td  class="value"><g:link controller="appOrganization" action="show" id="${acctgPeriodInstance?.organization?.id}">${acctgPeriodInstance?.organization?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  class="name"><g:message code="acctgPeriod.periodTypeId.label" default="Period Type Id" /></td>
                            
                            <td  class="value"><g:link controller="periodType" action="show" id="${acctgPeriodInstance?.periodTypeId?.id}">${acctgPeriodInstance?.periodTypeId?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${acctgPeriodInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
