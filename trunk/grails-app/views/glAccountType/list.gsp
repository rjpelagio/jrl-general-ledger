

<%@ page import="com.gl.GlAccountType" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'glAccountType.label', default: 'GlAccountType')}" />
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
                        
                            <g:sortableColumn property="glAccountType" title="${message(code: 'glAccountType.glAccountType.label', default: 'Account Type')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'glAccountType.description.label', default: 'Description')}" />
                        
                            <g:sortableColumn property="glAccountClass" title="${message(code: 'glAccountType.glAccountClass.label', default: 'GL Account Class')}" />
                        
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:if test="${glAccountTypeInstanceTotal==0}">
                        <tr>
                          <td colspan="4"> No Data Available</td>
                        </tr>
                    </g:if>
                    <g:else>
                        <g:each in="${glAccountTypeInstanceList}" status="i" var="glAccountTypeInstance">
                            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                                <td><g:link action="show" id="${glAccountTypeInstance.id}">${fieldValue(bean: glAccountTypeInstance, field: "glAccountType")}</g:link></td>

                                <td>${fieldValue(bean: glAccountTypeInstance, field: "description")}</td>

                                <td>${fieldValue(bean: glAccountTypeInstance, field: "glAccountClass")}</td>

                                <td>
                                    <g:link action="edit" id="${glAccountTypeInstance.id}">
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
                <g:paginate total="${glAccountTypeInstanceTotal}" />
                <g:if test="${glAccountTypeInstanceTotal!=0}">
                    [Record ${recordCount} out of ${glAccountTypeInstanceTotal}]
                </g:if>
            </div>
        </div>
    </body>
</html>
