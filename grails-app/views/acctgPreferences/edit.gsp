

<%@ page import="com.gl.AcctgPreferences" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'acctgPreferences.label', default: 'AcctgPreferences')}" />
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
            <g:hasErrors bean="${acctgPreferencesInstance}">
            <div class="errors">
                <g:renderErrors bean="${acctgPreferencesInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${acctgPreferencesInstance?.id}" />
                <g:hiddenField name="version" value="${acctgPreferencesInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td  class="name">
                                  <label for="jvPrefix"><g:message code="acctgPreferences.jvPrefix.label" default="Jv Prefix" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: acctgPreferencesInstance, field: 'jvPrefix', 'errors')}">
                                    <g:textField name="jvPrefix" value="${acctgPreferencesInstance?.jvPrefix}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="name">
                                  <label for="amtRounding"><g:message code="acctgPreferences.amtRounding.label" default="Amt Rounding" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: acctgPreferencesInstance, field: 'amtRounding', 'errors')}">
                                    <g:textField name="amtRounding" value="${fieldValue(bean: acctgPreferencesInstance, field: 'amtRounding')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="name">
                                  <label for="priceRounding"><g:message code="acctgPreferences.priceRounding.label" default="Price Rounding" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: acctgPreferencesInstance, field: 'priceRounding', 'errors')}">
                                    <g:textField name="priceRounding" value="${fieldValue(bean: acctgPreferencesInstance, field: 'priceRounding')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="name">
                                  <label for="docLineLimit"><g:message code="acctgPreferences.docLineLimit.label" default="Doc Line Limit" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: acctgPreferencesInstance, field: 'docLineLimit', 'errors')}">
                                    <g:textField name="docLineLimit" value="${fieldValue(bean: acctgPreferencesInstance, field: 'docLineLimit')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="name">
                                  <label for="docFormat"><g:message code="acctgPreferences.docFormat.label" default="Doc Format" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: acctgPreferencesInstance, field: 'docFormat', 'errors')}">
                                    <g:textField name="docFormat" value="${acctgPreferencesInstance?.docFormat}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="name">
                                  <label for="organizationCode"><g:message code="acctgPreferences.organizationCode.label" default="Organization Code" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: acctgPreferencesInstance, field: 'organizationCode', 'errors')}">
                                    <g:select name="organizationCode.id" from="${com.app.AppOrganization.list()}" optionKey="id" value="${acctgPreferencesInstance?.organizationCode?.id}"  />
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
