
<%@ page import="com.gl.GlAccountType" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'glAccountType.label', default: 'GlAccountType')}" />
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
                            <td  class="name"><g:message code="glAccountType.glAccountType.label" default="Gl Account Type" /></td>
                            
                            <td  class="value">${fieldValue(bean: glAccountTypeInstance, field: "glAccountType")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  class="name"><g:message code="glAccountType.description.label" default="Description" /></td>
                            
                            <td  class="value">${fieldValue(bean: glAccountTypeInstance, field: "description")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  class="name"><g:message code="glAccountType.glAccountClass.label" default="Gl Account Class" /></td>
                            
                            <td  class="value">${fieldValue(bean: glAccountTypeInstance, field: "glAccountClass")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  class="name"><g:message code="glAccountType.dateCreated.label" default="Date Created" /></td>
                            
                            <td  class="value"><g:formatDate date="${glAccountTypeInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td  class="name"><g:message code="glAccountType.lastUpdated.label" default="Last Updated" /></td>
                            
                            <td  class="value"><g:formatDate date="${glAccountTypeInstance?.lastUpdated}" /></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${glAccountTypeInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
