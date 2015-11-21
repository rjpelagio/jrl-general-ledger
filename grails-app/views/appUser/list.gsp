

<%@ page import="com.app.AppUser" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'appUser.label', default: 'AppUser')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body" style="width:65%">
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
                                    <label for="party"><g:message code="appUser.party.label" default="Employee" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: appUserInstance, field: 'party', 'errors')}">
                                    <g:select name="party.id" from="${employeeDropDown}" optionKey="party_id" optionValue="name" value="${appUserInstance?.party?.id}" noSelection="['null':'']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="name">
                                    <label for="role">Access Type</label>
                                </td>
                                <td  class="value ${hasErrors(bean: appUserInstance, field: 'role', 'errors')}">
                                    <g:select name="role.id" from="${roleList}" optionKey="id" optionValue="roleName" value="${appUserInstance?.role?.id}"  />
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
                            <g:sortableColumn property="name" title="${message(code: 'employeeData.firstName.label', default: 'Name')}" />

                            <th>Last Name</th>
                        
                            <th>User Name</th>
                        
                            <th>Access Type</th>
                        
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${appUserInstanceList}" status="i" var="appUserInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${appUserInstance.id}">${fieldValue(bean: appUserInstance, field: "username")}</g:link></td>
                    
                            <td>${appUserInstance?.party?.firstName}</td>
                        
                            <td>${appUserInstance?.party?.lastName}</td>
                        
                            <td>${fieldValue(bean: appUserInstance, field: "role")}</td>
                        
                            <td>
                                <g:link action="edit" id="${appUserInstance.id}">
                                    Edit
                                </g:link>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${appUserInstanceTotal}" /> Record ${recordCount} of ${appUserInstanceTotal}
            </div>
        </div>
    </body>
</html>
