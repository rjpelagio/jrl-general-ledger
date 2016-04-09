
<%@ page import="com.cash.Disbursement" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'disbursement.label', default: 'Disbursement')}" />
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
                            <td  class="name"><g:message code="disbursement.id.label" default="Id" /></td>
                            
                            <td  class="value">${fieldValue(bean: disbursementInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  class="name"><g:message code="disbursement.status.label" default="Status" /></td>
                            
                            <td  class="value">${fieldValue(bean: disbursementInstance, field: "status")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  class="name"><g:message code="disbursement.description.label" default="Description" /></td>
                            
                            <td  class="value">${fieldValue(bean: disbursementInstance, field: "description")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  class="name"><g:message code="disbursement.dateCreated.label" default="Date Created" /></td>
                            
                            <td  class="value"><g:formatDate date="${disbursementInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  class="name"><g:message code="disbursement.disbursementNumber.label" default="Disbursement Number" /></td>
                            
                            <td  class="value">${fieldValue(bean: disbursementInstance, field: "disbursementNumber")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  class="name"><g:message code="disbursement.preparedBy.label" default="Prepared By" /></td>
                            
                            <td  class="value"><g:link controller="party" action="show" id="${disbursementInstance?.preparedBy?.id}">${disbursementInstance?.preparedBy?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  class="name"><g:message code="disbursement.total.label" default="Total" /></td>
                            
                            <td  class="value">${fieldValue(bean: disbursementInstance, field: "total")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${disbursementInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
