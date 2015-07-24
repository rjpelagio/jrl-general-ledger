<script>
    function showLookup() {
      $("#lookup").dialog("open")
    }

    function closeLookup() {
      $("#lookup").dialog("close")
    }
    
    function results (json){
        var list = ' ';
        var i = 0;
        $.each (json, function() {
          list += '<tr>\n\
                        <td>' + json[i].id + '</td>\n\
                        <td>' + json[i].glAccount + '</td>\n\
                        <td>' + json[i].description + '</td>\n\
                        <td>' + json[i].glAccountType.description + '</td>'
          if (json[i].parentGlAccount == null) {
            list += '<td></td>'
          } else {
            list += '<td>' + json[i].parentGlAccount.description + '</td>'
          }
          list += '</tr>';
          i++;
        });
        
        $('#searchResultTable').append(list);
      }

    $(document).ready(function () {
      $("#lookup").dialog({ autoOpen: false, minHeight : 600, minWidth : 800, resizable : false, modal : true })
      
      $("#search").click(function() {
        var description = $('#lookupDescription').val();
        $.post("${createLinkTo(dir:'/glAccountingTransaction/lookupSearchAction')}", description,
        function(json) {
            results(json);
        }, "json");
      })
    })
</script>
<div id="lookup" title="Lookup GL Account">
            ${glAccountInstanceLists}
            <h1>Lookup GL Account</h1>
<!--            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>-->
            <div class="table-header">
              <g:message code="default.button.search.label"/>
            </div>
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td  class="name">
                                    <label for="glAccount"><g:message code="glAccount.glAccount.label" default="Gl Account" /></label>
                                </td>
                                <td >
                                    <g:textField name="glAccount" value="" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="name">
                                    <label for="description"><g:message code="glAccount.description.label" default="Description" /></label>
                                </td>
                                <td >
                                    <g:textField name="description" value="" id="lookupDescription"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="name">
                                    <label for="glAccountType"><g:message code="glAccount.glAccountType.label" default="Gl Account Type" /></label>
                                </td>
                                <td >
                                    <g:select name="glAccountType.id" from="${com.gl.GlAccountType.list()}" optionKey="id" value=""  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td  class="name">
                                    <label for="parentGlAccount"><g:message code="glAccount.parentGlAccount.label" default="Parent Gl Account" /></label>
                                </td>
                                <td >
                                    <g:select name="parentGlAccount.id" from="${com.gl.GlAccount.list()}" optionKey="id" value="" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr>
                                <td></td>
                                <td>
                                    <g:submitButton name="search" id="search" class="save" value="Search" /></span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            
                <div class="list">
                    <table>
                        <thead>
                            <tr>

                                <g:sortableColumn property="id" title="${message(code: 'glAccount.id.label', default: 'Id')}" />

                                <g:sortableColumn property="glAccount" title="${message(code: 'glAccount.glAccount.label', default: 'Gl Account')}" />

                                <g:sortableColumn property="description" title="${message(code: 'glAccount.description.label', default: 'Description')}" />

                                <th><g:message code="glAccount.glAccountType.label" default="Gl Account Type" /></th>

                                <th><g:message code="glAccount.parentGlAccount.label" default="Parent Gl Account" /></th>

                            </tr>
                        </thead>
                        <tbody id="searchResultTable">
                            
                        </tbody>
                  </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="100" />
            </div>
</div>