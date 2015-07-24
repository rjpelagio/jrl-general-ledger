

<%@ page import="com.gl.AcctgPreferences" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'acctgPreferences.label', default: 'AcctgPreferences')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="table-header">
              <g:message code="default.button.search.label" args="[entityName]" />
            </div>
            <g:form action="list">
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
                        
                            <tr>
                                <td></td>
                                <td>
                                    <g:submitButton name="search" class="save" value="Search" /></span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </g:form>
            <br/>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'acctgPreferences.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="jvPrefix" title="${message(code: 'acctgPreferences.jvPrefix.label', default: 'Jv Prefix')}" />
                        
                            <g:sortableColumn property="amtRounding" title="${message(code: 'acctgPreferences.amtRounding.label', default: 'Amt Rounding')}" />
                        
                            <g:sortableColumn property="priceRounding" title="${message(code: 'acctgPreferences.priceRounding.label', default: 'Price Rounding')}" />
                        
                            <g:sortableColumn property="docLineLimit" title="${message(code: 'acctgPreferences.docLineLimit.label', default: 'Doc Line Limit')}" />
                        
                            <g:sortableColumn property="docFormat" title="${message(code: 'acctgPreferences.docFormat.label', default: 'Doc Format')}" />
                        
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${acctgPreferencesInstanceList}" status="i" var="acctgPreferencesInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${acctgPreferencesInstance.id}">${fieldValue(bean: acctgPreferencesInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: acctgPreferencesInstance, field: "jvPrefix")}</td>
                        
                            <td>${fieldValue(bean: acctgPreferencesInstance, field: "amtRounding")}</td>
                        
                            <td>${fieldValue(bean: acctgPreferencesInstance, field: "priceRounding")}</td>
                        
                            <td>${fieldValue(bean: acctgPreferencesInstance, field: "docLineLimit")}</td>
                        
                            <td>${fieldValue(bean: acctgPreferencesInstance, field: "docFormat")}</td>
                        
                            <td>
                                <g:link action="edit" id="${acctgPreferencesInstance.id}">
                                    Edit
                                </g:link>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${acctgPreferencesInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
