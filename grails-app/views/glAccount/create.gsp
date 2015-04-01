

<%@ page import="com.gl.GlAccount" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'glAccount.label', default: 'GlAccount')}" />
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
            <g:hasErrors bean="${glAccountInstance}">
            <div class="errors">
                <g:renderErrors bean="${glAccountInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="parentGlAccount"><g:message code="glAccount.parentGlAccount.label" default="Main GL Account" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: glAccountInstance, field: 'parentGlAccount', 'errors')}">
                                    <g:select name="parentGlAccount.id" from="${com.gl.GlAccount.list()}" optionKey="id" value="${glAccountInstance?.parentGlAccount?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="glAccount"><g:message code="glAccount.glAccount.label" default="GL Account" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: glAccountInstance, field: 'glAccount', 'errors')}">
                                    <g:textField name="glAccount" value="${glAccountInstance?.glAccount}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="glAccount.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: glAccountInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${glAccountInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="glAccountType"><g:message code="glAccount.glAccountType.label" default="Account Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: glAccountInstance, field: 'glAccountType', 'errors')}">
                                    <g:select name="glAccountType.id" from="${com.gl.GlAccountType.list()}" optionKey="id" value="${glAccountInstance?.glAccountType?.id}"  />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="organization"><g:message code="glAccount.organization.label" default="Organization" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: Organization, field: 'organization', 'errors')}">
                                    <g:each in="${organizationInstance}" var="o">
                                      <g:if test="${o.id == session.organization.id}">
                                        <g:checkBox name="organizationCheck" value="${o?.id}" checked="true"/> ${o?.organizationName}
                                        <input type="hidden" name="organizationVal" value="${o.id}"/>
                                        <br/>
                                      </g:if>
                                      <g:else>
                                        <g:checkBox name="organizationCheck" value="${o?.id}" checked="false"/> ${o?.organizationName}
                                        <input type="hidden" name="organizationVal" value="${o.id}"/>
                                        <br/>
                                      </g:else>
                                    </g:each>
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
