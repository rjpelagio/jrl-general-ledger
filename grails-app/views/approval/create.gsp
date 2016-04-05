

<%@ page import="com.app.Approval" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'approval.label', default: 'Approval')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <g:javascript library="app/approval"/>
        <script>
        $(document).ready(function () {
               $("#addRow").click(
                    function() {
                        var index = $("#rowCount").val();
                        index++;
                        $("input[name='rowCount']").val(index);
                        var rowIndex = $("#rowIndex").val();
                        rowIndex++;
                        $("input[name='rowIndex']").val(rowIndex);
                        $("tbody#dataTable").append(<g:render template="/approval/approvalItem"/>);
                        
                        
                        var $content = $('#leftnav');
                        $content.height($(document).height() - 155);

                        //checkDuplicate();
                        
                        return false;
                    }
                );
        });
        </script>

    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/dashBoard/list')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body" style="width:55%">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${approvalInstance}">
            <div class="errors">
                <g:renderErrors bean="${approvalInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td  class="name">
                                    <label for="description"><g:message code="approval.description.label" default="Description" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: approvalInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${approvalInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="name">
                                    <label for="department"><g:message code="approval.department.label" default="Department" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: approvalInstance, field: 'department', 'errors')}">
                                    <g:select name="department" from="${approvalInstance.constraints.department.inList}" value="${approvalInstance?.department}" valueMessagePrefix="approval.department"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="name">
                                    <label for="approvalFeature"><g:message code="approval.approvalFeature.label" default="Approval Feature" /></label>
                                </td>
                                <td  class="value ${hasErrors(bean: approvalInstance, field: 'approvalFeature', 'errors')}">
                                    <g:select name="approvalFeature" from="${approvalInstance.constraints.approvalFeature.inList}" value="${approvalInstance?.approvalFeature}" valueMessagePrefix="approval.approvalFeature"  />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <br/>
                <div class="table-header">
                    <g:message code="default.button.details.label" args="[entityName]" />
                    <input type="hidden" id="rowIndex" name="rowIndex" value="1"/>
                    <input type="hidden" id="rowCount" name="rowCount" value="0"/>
                </div>

                <div class="list">
                    
                    <table>
                        <thead>
                            <tr>
                              <th style="width:50%">Position</th>
                              <th  >Remarks</th>
                              <th></th>
                            </tr>
                        </thead>
                        <tbody id="dataTable">
                            <tr id="row_0">
                                <td>
                                    <select id="position_0" name="positions" style="width:300px;background-color:#FFFF71">
                                        <option value="Clerk">Clerk</option>
                                        <option value="Supervisor">Supervisor</option>
                                        <option value="Manager">Manager</option>
                                    </select>
                                </td>
                                <td >
                                    <select id="remark_0" name="remarks" style="width:300px;background-color:#FFFF71">
                                        <option value="Noted By">Noted By</option>
                                        <option value="Approved By">Approved By</option>
                                        <option value="Reviewed By">Reviewed By</option>
                                    </select>
                                </td> 
                                <td>
                                    <input type="button" id="delete_0" value="Delete" onClick="deleteRow(0);"/>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div class="buttons">
                        <span >
                            <input type="button" id="addRow" class="add" value="Add Item"></input>
                        </span>
                        <span style="float:right">
                            <g:submitButton name="create" class="save" value="${message(code: 'default.button.save.label', default: 'Save')}" />
                        </span>
                        <span style="float:right">
                            <g:submitButton name="create" class="submit" value="${message(code: 'default.button.submit.label', default: 'Submit')}" />
                        </span>
                </div>
            </g:form>
        </div>
    </body>
</html>
