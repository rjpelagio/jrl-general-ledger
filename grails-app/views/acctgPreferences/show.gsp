
<%@ page import="com.gl.AcctgPreferences" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'acctgPreferences.label', default: 'AcctgPreferences')}" />
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
                            <td valign="top" class="name"><g:message code="acctgPreferences.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: acctgPreferencesInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="acctgPreferences.jvPrefix.label" default="Jv Prefix" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: acctgPreferencesInstance, field: "jvPrefix")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="acctgPreferences.amtRounding.label" default="Amt Rounding" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: acctgPreferencesInstance, field: "amtRounding")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="acctgPreferences.priceRounding.label" default="Price Rounding" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: acctgPreferencesInstance, field: "priceRounding")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="acctgPreferences.docLineLimit.label" default="Doc Line Limit" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: acctgPreferencesInstance, field: "docLineLimit")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="acctgPreferences.docFormat.label" default="Doc Format" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: acctgPreferencesInstance, field: "docFormat")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="acctgPreferences.organizationCode.label" default="Organization Code" /></td>
                            
                            <td valign="top" class="value"><g:link controller="appOrganization" action="show" id="${acctgPreferencesInstance?.organizationCode?.id}">${acctgPreferencesInstance?.organizationCode?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${acctgPreferencesInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
