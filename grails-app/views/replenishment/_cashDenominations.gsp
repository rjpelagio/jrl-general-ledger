<div id="dialog-denomination" title="Cash Denomination">
    <div class="dialog">
        <table >
            <thead>
                <tr>

                    <th>Denominations</th>

                    <th style="text-align:right">QTY</th>

                    <th style="text-align:right">Total</th>

                </tr>
            </thead>
            <tbody>
                <tr class="prop">
                    <td class="sub" style="width:30%">1000</td>
                    <td class="value" style="text-align:right;width:30%;vertical-align:middle">
                        <input type="text" style="text-align:right" id="diathousandDem" name="diathousandDem" 
                            value="${params.thousandDem ? params.thousandDem : ''}" size="8"
                            onchange="this.value=validateInteger(this.value);computeThousandDem(this.value); " />
                    </td>
                    <td style="text-align:right;width:30%;vertical-align:middle">
                        <span id="diathousandTextSpan">${params.thousandText ? params.thousandText : 0.00}</span>
                        <input type="hidden" id="diathousandText" name="diathousandText" 
                            value="${params.thousandText ? params.thousandText : 0.00}"/>
                    </td> 
                </tr>
                <tr class="prop">
                    <td class="sub" style="width:30%">500</td>
                    <td class="value" style="text-align:right;width:30%;vertical-align:middle">
                        <input type="text" style="text-align:right" id="diafiveHundredDem" name="diafiveHundredDem" 
                            value="${params.fiveHundredDem ? params.fiveHundredDem : ''}" size="8"
                            onchange="this.value=validateInteger(this.value);computeFiveHundredDem(this.value)" />
                    </td>
                    <td style="text-align:right;width:30%;vertical-align:middle">
                        <span id="diafiveHundredTextSpan">${params.fiveHundredText ? params.fiveHundredText : 0.00}</span>
                        <input type="hidden" id="diafiveHundredText" name="diafiveHundredText" 
                            value="${params.fiveHundredText ? params.fiveHundredText : 0.00}"/>
                    </td>
                </tr>
                <tr class="prop">
                    <td class="sub" style="width:30%">200</td>
                    <td class="value" style="text-align:right;width:30%;vertical-align:middle">
                        <input type="text" style="text-align:right" id="diatwoHundredDem" name="diatwoHundredDem" 
                            value="${params.twoHundredDem ? params.twoHundredDem : ''}" size="8"
                            onchange="this.value=validateInteger(this.value);computeTwoHundredDem(this.value)" />
                    </td>
                    <td style="text-align:right;width:30%;vertical-align:middle">
                        <span id="diatwoHundredTextSpan">${params.twoHundredText ? params.twoHundredText : 0.00}</span>
                        <input type="hidden" id="diatwoHundredText" name="diatwoHundredText" 
                            value="${params.twoHundredText ? params.twoHundredText : 0.00}"/>
                    </td>
                </tr>
                <tr class="prop">
                    <td class="sub" style="width:30%">100</td>
                    <td class="value" style="text-align:right;width:30%;vertical-align:middle">
                        <input type="text" style="text-align:right" id="diahundredDem" name="diahundredDem" 
                            value="${params.hundredDem ? params.hundredDem : ''}" size="8"
                            onchange="this.value=validateInteger(this.value);computeHundredDem(this.value)" />
                    </td>
                    <td style="text-align:right;width:30%;vertical-align:middle">
                        <input type="hidden" id="diahundredText" name="diahundredText" 
                            value="${params.hundredText ? params.hundredText : 0.00}"/>
                        <span id="diahundredTextSpan">${params.hundredText ? params.hundredText : 0.00}</span>
                    </td>
                </tr>
                <tr class="prop">
                    <td class="sub" style="width:30%">50</td>
                    <td class="value" style="text-align:right;width:30%;vertical-align:middle">
                        <input type="text" style="text-align:right" id="diafiftyDem" name="diafiftyDem" 
                            value="${params.fiftyDem ? params.fiftyDem : ''}" size="8"
                            onchange="this.value=validateInteger(this.value);computeFiftyDem(this.value)" />
                    </td>
                    <td style="text-align:right;width:30%;vertical-align:middle">
                        <input type="hidden" id="diafiftyText" name="diafiftyText" 
                            value="${params.fiftyText ? params.fiftyText : 0.00}"/>
                        <span id="diafiftyTextSpan">${params.fiftyText ? params.fiftyText : 0.00}</span>
                    </td>
                </tr>
                <tr class="prop">
                    <td class="sub" style="width:30%">20</td>
                    <td class="value" style="text-align:right;width:30%;vertical-align:middle">
                        <input type="text" style="text-align:right" id="diatwentyDem" name="diatwentyDem" 
                            value="${params.twentyDem ? params.twentyDem : ''}" size="8"
                            onchange="this.value=validateInteger(this.value);computeTwentyDem(this.value)" />
                    </td>
                    <td style="text-align:right;width:30%;vertical-align:middle">
                        <input type="hidden" id="diatwentyText" name="diatwentyText" 
                            value="${params.twentyText ? params.twentyText : 0.00}"/>
                        <span id="diatwentyTextSpan">${params.twentyText ? params.twentyText : 0.00}</span>
                    </td>
                </tr>
                <tr class="prop">
                    <td class="sub" style="width:30%">10</td>
                    <td class="value" style="text-align:right;width:30%;vertical-align:middle">
                        <input type="text" style="text-align:right" id="diatenDem" name="diatenDem" 
                            value="${params.tenDem ? params.tenDem : ''}" size="8"
                            onchange="this.value=validateInteger(this.value);computeTenPesoDem(this.value)" />
                    </td>
                    <td style="text-align:right;width:30%;vertical-align:middle">
                        <input type="hidden" id="diatenText" name="diatenText" 
                            value="${params.tenText ? params.tenText : 0.00}"/>
                        <span id="diatenTextSpan">${params.tenText ? params.tenText : 0.00}</span>
                    </td>
                </tr>
                <tr class="prop">
                    <td class="sub" style="width:30%">5</td>
                    <td class="value" style="text-align:right;width:30%;vertical-align:middle">
                        <input type="text" style="text-align:right" id="diafiveDem" name="diafiveDem" 
                            value="${params.fiveDem ? params.fiveDem : ''}" size="8"
                            onchange="this.value=validateInteger(this.value);computeFivePesoDem(this.value)" />
                    </td>
                    <td style="text-align:right;width:30%;vertical-align:middle">
                        <input type="hidden" id="diafiveText" name="diafiveText" 
                            value="${params.fiveText ? params.fiveText : 0.00}"/>
                        <span id="diafiveTextSpan">${params.fiveText ? params.fiveText : 0.00}</span>
                    </td>
                </tr>
                <tr class="prop">
                    <td class="sub" style="width:30%">1</td>
                    <td class="value" style="text-align:right;width:30%;vertical-align:middle">
                        <input type="text" style="text-align:right" id="diapesoDem" name="diapesoDem" 
                            value="${params.pesoDem ? params.pesoDem : ''}" size="8"
                            onchange="this.value=validateInteger(this.value);computePesoDem(this.value)" />
                    </td>
                    <td style="text-align:right;width:30%;vertical-align:middle">
                        <input type="hidden" id="diapesoText" name="diapesoText" 
                            value="${params.pesoText ? params.pesoText : 0.00}"/>
                        <span id="diapesoTextSpan">${params.pesoText ? params.pesoText : 0.00}</span>
                    </td>
                </tr>
                <tr class="prop">
                    <td class="sub" style="width:30%">.50</td>
                    <td class="value" style="text-align:right;width:30%;vertical-align:middle">
                        <input type="text" style="text-align:right" id="diafiftyCentDem" name="diafiftyCentDem" 
                            value="${params.fiftyCentDem ? params.fiftyCentDem : ''}" size="8"
                            onchange="this.value=validateInteger(this.value);computeFiftyCentDem(this.value)" />
                    </td>
                    <td style="text-align:right;width:30%;vertical-align:middle">
                        <span id="diafiftyCentTextSpan">${params.fiftyCentText ? params.fiftyCentText : 0.00}</span>
                        <input type="hidden" id="diafiftyCentText" name="diafiftyCentText" 
                            value="${params.fiftyCentText ? params.fiftyCentText : 0.00}"/>
                    </td>
                </tr>
                <tr class="prop">
                    <td class="sub" style="width:30%">.25</td>
                    <td class="value" style="text-align:right;width:30%;vertical-align:middle">
                        <input type="text" style="text-align:right" id="diatwentyFiveCentDem" name="diatwentyFiveCentDem" 
                            value="${params.twentyFiveCentDem ? params.twentyFiveCentDem : ''}" size="8"
                            onchange="this.value=validateInteger(this.value);computeTwentyFiveCentDem(this.value)" />
                    </td>
                    <td style="text-align:right;width:30%;vertical-align:middle">
                        <span id="diatwentyFiveCentTextSpan">${params.twentyFiveCentText ? params.twentyFiveCentText : 0.00}</span>
                        <input type="hidden" id="diatwentyFiveCentText" name="diatwentyFiveCentText"
                            value="${params.twentyFiveCentText ? params.twentyFiveCentText : 0.00}"/>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td class="sub" style="text-align:right">Total : </td>
                    <td style="border-top:1px solid #3C5326;text-align:right;vertical-align:middle">
                        <span id="totalTextSpan">0.00</span>
                        <input type="hidden" name="diatotalCashDenom" value="${params.totalCashDenom ? params.totalCashDenom : ''}"/>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>