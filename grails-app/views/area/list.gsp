

<%@ page import="com.ar.Area" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'area.label', default: 'Area')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/dashBoard/list')}"><g:message code="default.home.label"/></a></span>
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
                                    <label for="code"><g:message code="area.code.label" default="Code" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: areaInstance, field: 'code', 'errors')}">
                                    <g:textField name="code" value="${areaInstance?.code}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="name">
                                    <label for="description"><g:message code="area.description.label" default="Description" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: areaInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${areaInstance?.description}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'area.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="code" title="${message(code: 'area.code.label', default: 'Code')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'area.description.label', default: 'Description')}" />
                        
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${areaInstanceList}" status="i" var="areaInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${areaInstance.id}">${fieldValue(bean: areaInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: areaInstance, field: "code")}</td>
                        
                            <td>${fieldValue(bean: areaInstance, field: "description")}</td>
                        
                            <td>
                                <g:link action="edit" id="${areaInstance.id}">
                                    Edit
                                </g:link>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${areaInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
