

<%@ page import="com.gl.GlAccountType" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'glAccountType.label', default: 'GlAccountType')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${glAccountTypeInstance}">
            <div class="errors">
                <g:renderErrors bean="${glAccountTypeInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="glAccountType"><g:message code="glAccountType.glAccountType.label" default="Account Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: glAccountTypeInstance, field: 'glAccountType', 'errors')}">
                                    <g:textField name="glAccountType" value="${glAccountTypeInstance?.glAccountType}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="glAccountType.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: glAccountTypeInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${glAccountTypeInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="glAccountClass"><g:message code="glAccountType.glAccountClass.label" default="Account Class" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: glAccountTypeInstance, field: 'glAccountClass', 'errors')}">
                                    <g:select name="glAccountClass" from="${glAccountTypeInstance.constraints.glAccountClass.inList}" value="${glAccountTypeInstance?.glAccountClass}" valueMessagePrefix="glAccountType.glAccountClass" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
