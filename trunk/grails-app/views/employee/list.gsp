

<%@ page import="com.app.Employee" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'employee.label', default: 'Employee')}" />
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
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="party.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: partyInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${partyInstance?.name}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="firstName"><g:message code="party.firstName.label" default="First Name" /></label>
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
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="department"><g:message code="employee.department.label" default="Department" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeInstance, field: 'department', 'errors')}">
                                    <g:select name="department" from="${employeeInstance.constraints.department.inList}" value="${employeeInstance?.department}" valueMessagePrefix="employee.department" noSelection="['null':'']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="position"><g:message code="employee.position.label" default="Position" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: employeeInstance, field: 'position', 'errors')}">
                                    <g:select name="position" from="${employeeInstance.constraints.position.inList}" value="${employeeInstance?.position}" valueMessagePrefix="employee.position" noSelection="['null':'']" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'employee.party.label', default: 'Name')}" />

                            <th>Last Name</th>

                            <th>First Name</th>

                            <th>Middle Name</th>
                            
                            <th>TIN</th>

                            <g:sortableColumn property="department" title="${message(code: 'employee.department.label', default: 'Department')}" />
                        
                            <g:sortableColumn property="position" title="${message(code: 'employee.position.label', default: 'Position')}" />
                        
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${employeeInstanceList}" status="i" var="employeeInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${employeeInstance.id}">${employeeInstance.name}</g:link></td>

                            <td>${employeeInstance?.last_name}</td>
                            <td>${employeeInstance?.first_name}</td>
                            <td>${employeeInstance?.middle_name}</td>
                            <td>${employeeInstance?.tin}</td>

                            <td>${employeeInstance?.department}</td>
                        
                            <td>${employeeInstance?.position}</td>
                        
                            <td>
                                <g:link action="edit" id="${employeeInstance.id}">
                                    Edit
                                </g:link>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${employeeInstanceTotal}" /> Record ${recordCount} of ${employeeInstanceTotal}
            </div>
        </div>
    </body>
</html>
