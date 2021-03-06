
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'glAccount.label', default: 'GlAccount')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <script type="text/javascript">
            function enableDisable()
            {
                if (document.getElementById('selectBox').checked) {
                    document.getElementById('invoiceno').disabled = true
                    document.getElementById('invoiceno').style.background = "#ADADAD"
                    document.getElementById('invoiceno').value = ""
                } else {    
                    document.getElementById('invoiceno').disabled = false
                    document.getElementById('invoiceno').style.background = "#FFFFFF"
                }
            }
        </script>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        <div class="body" style="width:45%">
            <h1>Sales and Collections History</h1>
            <g:form action="#" >
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td>Payment Date</td>
                                <td>
                                    <calendar:datePicker name="paymentdate" precision="day" value="" years="1950, 2050"  />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td></td>
                                <td>
                                    <input id="select" type="checkbox" name="date" onclick="enableDisable()">Select All</input>  
                                </td>
                            </tr>
                            <tr class="prop">
                                <td>Area Code</td>
                                <td>
                                    <select>
                                        <option value="Selectall">Select All</option>
                                        <option value="01BIN">O1BIN</option>
                                        <option value="02CAB">02CAB</option>
                                        <option value="02SR">02SR</option>
                                        <option value="03CAL">03CAL</option>
                                        <option value="04MP">04MP</option>
                                        <option value="05SP">05SP</option>
                                        <option value="06UL1">06UL1</option>
                                        <option value="07UL2">07UL2</option>
                                        <option value="08UL3">08UL3</option>
                                        <option value="09CFS">09CFS</option>
                                        <option value="10SSS">10SSS</option>
                                        <option value="11SSS2">11SS2</option>
                                        <option value="HA">HA</option>
                                        <option value="HSE">HSE</option>
                                        <option value="LP">LP</option>
                                        <option value="LPWH">LPWH</option>
                                        <option value="OFF">OFF</option>
                                        <option value="WHS">WHS</option>
                                    </select>
                                </td>
                            </tr>
                            <tr class="prop">
                                <td>Agent Code</td>
                                <td>
                                    <select>
                                        <option value="Selectall">Select All</option>
                                        <option value="MAA">MAA</option>
                                        <option value="JPP">JPP</option>
                                        <option value="NMM">NMM</option>
                                        <option value="AAA">AAA</option>
                                        <option value="WMM">WMM</option>
                                        <option value="HPR">HPR</option>
                                        <option value="EAI">EAI</option>
                                        <option value="RNM">RNM</option>
                                        <option value="MLB">MLB</option>
                                        <option value="BAM">BAM</option>
                                        <option value="ISA">ISA</option>
                                        <option value="RAA">RAA</option>
                                        <option value="MCB">MCB</option>
                                        <option value="PPA">PPA</option>
                                        <option value="RCM">RCM</option>
                                    </select>
                                </td>
                            </tr>
                            <tr class="prop">
                                <td>Customer Code</td>
                                <td>
                                    <select>
                                        <option value="Selectall">Select All</option>
                                        <option value="AMORFM">AMORF-M</option>
                                    </select>
                                </td>
                            </tr>
                            <tr class="prop">
                                <td>Invoice Number</td>
                                <td>
                                    <input type="text" name="invoiceno" id="invoiceno">
                                </td>
                            </tr>
                            <tr class="prop">
                                <td></td>
                                <td>
                                    <input id="selectBox" type="checkbox" name="invoice" onclick="enableDisable()">Select All</input>  
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>