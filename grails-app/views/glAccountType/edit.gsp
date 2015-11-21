

<%@ page import="com.gl.GlAccountType" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'glAccountType.label', default: 'GlAccountType')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${glAccountTypeInstance}">
            <div class="errors">
                <g:renderErrors bean="${glAccountTypeInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${glAccountTypeInstance?.id}" />
                <g:hiddenField name="version" value="${glAccountTypeInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td  class="name">
                                  <label for="glAccountType"><g:message code="glAccountType.glAccountType.label" default="Gl Account Type" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: glAccountTypeInstance, field: 'glAccountType', 'errors')}">
                                    <g:textField name="glAccountType" value="${glAccountTypeInstance?.glAccountType}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="name">
                                  <label for="description"><g:message code="glAccountType.description.label" default="Description" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: glAccountTypeInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${glAccountTypeInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="name">
                                  <label for="glAccountClass"><g:message code="glAccountType.glAccountClass.label" default="Account Class" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: glAccountTypeInstance, field: 'glAccountClass', 'errors')}">
                                    <g:select name="glAccountClass" from="${glAccountTypeInstance.constraints.glAccountClass.inList}" value="${glAccountTypeInstance?.glAccountClass}" valueMessagePrefix="glAccountType.glAccountClass" noSelection="['': '']" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
