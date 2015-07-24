

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
        <div class="body" style="width:60%">
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
                                <td  class="name">
                                    <label for="name"><g:message code="party.name.label" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: partyInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${partyInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="name">
                                    <label for="status"><g:message code="employeeData.role.label" default="role" /></label>
                                </td>
                                <td >
                                    <g:select from="${roleList}" name="role" optionValue="roleName" optionKey="id"/>             
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
                        
                            <g:sortableColumn property="name" title="${message(code: 'party.name.label', default: 'Name')}" />
                        
                            <th><g:message code="employeeData.tin.label" default="TIN" /></th>

                            <th><g:message code="employeeData.role.label" default="Role" /></th>

                            <th><g:message code="employeeData.city.label" default="City" /></th>

                            <th><g:message code="employeeData.contactNumber.label" default="Contact Number" /></th>

                            <th><g:message code="employeeData.mobileNumber.label" default="Mobile Number" /></th>

                            <th><g:message code="employeeData.status.label" default="Status" /></th>
                        
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${partyInstanceList}" status="i" var="partyInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${partyInstance.id}">${partyInstance?.name}</g:link></td>
                        
                            <td>${partyInstance?.tin}</td>

                            <td>${partyInstance?.role}</td>

                            <td>${partyInstance?.city}</td>

                            <td>${partyInstance?.contactNumber}</td>

                            <td>+63${partyInstance?.mobileNumber}</td>

                            <td>${partyInstance?.status}</td>
                        
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
        </div>
    </body>
</html>
