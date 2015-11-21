

<%@ page import="com.app.AppOrganization" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'appOrganization.label', default: 'AppOrganization')}" />
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
            <g:hasErrors bean="${appOrganizationInstance}">
            <div class="errors">
                <g:renderErrors bean="${appOrganizationInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td  class="name">
                                    <label for="organizationCode"><g:message code="appOrganization.organizationCode.label" default="Organization Code" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: appOrganizationInstance, field: 'organizationCode', 'errors')}">
                                    <g:textField name="organizationCode" value="${appOrganizationInstance?.organizationCode}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="name">
                                    <label for="organizationName"><g:message code="appOrganization.organizationName.label" default="Organization Name" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: appOrganizationInstance, field: 'organizationName', 'errors')}">
                                    <g:textField name="organizationName" value="${appOrganizationInstance?.organizationName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="name">
                                    <label for="organizationType"><g:message code="appOrganization.organizationType.label" default="Organization Type" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: appOrganizationInstance, field: 'organizationType', 'errors')}">
                                    <g:select name="organizationType" from="${appOrganizationInstance.constraints.organizationType.inList}" value="${appOrganizationInstance?.organizationType}" valueMessagePrefix="appOrganization.organizationType"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="name">
                                    <label for="party"><g:message code="appOrganization.party.label" default="Party" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: appOrganizationInstance, field: 'party', 'errors')}">
                                    <g:select name="party.id" from="${com.app.Party.list()}" optionKey="id" value="${appOrganizationInstance?.party?.id}"  />
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
