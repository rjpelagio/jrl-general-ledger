

<%@ page import="com.gl.PeriodType" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'periodType.label', default: 'Period Type')}" />
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
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="periodTypeId" title="${message(code: 'periodType.periodTypeId.label', default: 'Period Type Id')}" />
                        
                            <th>Period Name</th>

                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:if test = "${glAccountInstanceTotal==0}">
                        <tr>
                          <td colspan="2">No data available.</td>
                        </tr>
                    </g:if>
                    <g:else>
                        <g:each in="${periodTypeInstanceList}" status="i" var="periodTypeInstance">
                            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                                <td><g:link action="show" id="${periodTypeInstance.id}">${fieldValue(bean: periodTypeInstance, field: "periodTypeId")}</g:link></td>

                                <td>${fieldValue(bean: periodTypeInstance, field: "periodName")}</td>

                                <td>
                                    <g:link action="edit" id="${periodTypeInstance.id}">
                                        Edit
                                    </g:link>
                                </td>
                            </tr>
                        </g:each>
                    </g:else>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${periodTypeInstanceTotal}" />
                <g:if test = "${glAccountInstanceTotal!=0}">
                    Record ${recordCount} of ${periodTypeInstanceTotal}
                </g:if>
                  
            </div>
        </div>
    </body>
</html>
