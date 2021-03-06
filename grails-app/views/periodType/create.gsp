

<%@ page import="com.gl.PeriodType" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'periodType.label', default: 'PeriodType')}" />
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
            <g:hasErrors bean="${periodTypeInstance}">
            <div class="errors">
                <g:renderErrors bean="${periodTypeInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td  class="name">
                                    <label for="periodTypeId"><g:message code="periodType.periodTypeId.label" default="Period Type Id" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: periodTypeInstance, field: 'periodTypeId', 'errors')}">
                                    <g:textField name="periodTypeId" value="${periodTypeInstance?.periodTypeId}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="name">
                                    <label for="periodName"><g:message code="periodType.periodName.label" default="Period Name" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: periodTypeInstance, field: 'periodName', 'errors')}">
                                    <g:textField name="periodName" value="${periodTypeInstance?.periodName}" />
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
