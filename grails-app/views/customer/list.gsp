<%@ page import="com.ar.CustomerArea" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'customerArea.label', default: 'CustomerArea')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'customerArea.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="dateCreated" title="${message(code: 'customerArea.dateCreated.label', default: 'Date Created')}" />
                        
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${customerAreaInstanceList}" status="i" var="customerAreaInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${customerAreaInstance.id}">${fieldValue(bean: customerAreaInstance, field: "id")}</g:link></td>
                        
                            <td><g:formatDate date="${customerAreaInstance.dateCreated}" /></td>
                        
                            <td>
                                <g:link action="edit" id="${customerAreaInstance.id}">
                                    Edit
                                </g:link>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${customerAreaInstanceTotal}" />
            </div>
        </div>
    </body>
</html>