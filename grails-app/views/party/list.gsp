

<%@ page import="com.app.Party" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'party.label', default: 'Party')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="party.newButton.label"/></g:link></span>
        </div>
        <div class="body">
            <h1>Payee List</h1>
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
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="party.name.label" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: partyInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${partyInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="firstName"><g:message code="party.firstName.label" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: partyInstance, field: 'firstName', 'errors')}">
                                    <g:textField name="firstName" value="${partyInstance?.firstName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="middleName"><g:message code="party.middleName.label" default="Middle Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: partyInstance, field: 'middleName', 'errors')}">
                                    <g:textField name="middleName" value="${partyInstance?.middleName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastName"><g:message code="party.lastName.label" default="Last Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: partyInstance, field: 'lastName', 'errors')}">
                                    <g:textField name="lastName" value="${partyInstance?.lastName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tin"><g:message code="party.tin.label" default="TIN" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: partyInstance, field: 'tin', 'errors')}">
                                    <g:textField name="tin" value="${partyInstance?.tin}" />
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
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="name" title="${message(code: 'party.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="firstName" title="${message(code: 'party.firstName.label', default: 'First Name')}" />
                        
                            <g:sortableColumn property="middleName" title="${message(code: 'party.middleName.label', default: 'Middle Name')}" />
                        
                            <g:sortableColumn property="lastName" title="${message(code: 'party.lastName.label', default: 'Last Name')}" />
                        
                            <g:sortableColumn property="tin" title="${message(code: 'party.tin.label', default: 'TIN')}" />
                        
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${partyInstanceList}" status="i" var="partyInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${partyInstance.id}">${fieldValue(bean: partyInstance, field: "name")}</g:link></td>
                        
                            <td>${fieldValue(bean: partyInstance, field: "firstName")}</td>
                        
                            <td>${fieldValue(bean: partyInstance, field: "middleName")}</td>
                        
                            <td>${fieldValue(bean: partyInstance, field: "lastName")}</td>
                        
                            <td>${fieldValue(bean: partyInstance, field: "tin")}</td>
                        
                            <td>
                                <g:link action="edit" id="${partyInstance.id}">
                                    Edit
                                </g:link>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
              <g:paginate total="${partyInstanceTotal}" /> Record ${recordCount} of ${partyInstanceTotal}
            </div>
            <g:jasperReport jasper="ChartOfAccounts" format="PDF, XLS" name="List of Payee"></g:jasperReport>
        </div>
    </body>
</html>
