<table id="investment-details" class="investment-details-table">
    <thead>
    <tr>
        <th>Investment</th>
        <th>Market (Fieldwork)</th>
        <th>Market (Funding)</th>
        <th>Project Owner / Project Contact</th>
        <th>SP&I Contact</th>
        <th>Estimated Cost</th>
        <th>Currency</th>
        <th>Approved</th>
        <th>Edit</th>
        <th>Delete</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td class="no-items" colspan="10">
            Investments not available
        </td>
    </tr>
    </tbody>
</table>

<!-- Add Investment Popup Starts -->
<div id="add-investment-popup" style="display:none">

    <div>
        <a href="javascript:void(0);" class="close" onclick="closePopUp();"></a>
        <label>Investment Type</label>
        <div class="investment-popup-field">
            <input type="radio" name="investmentType" class="investmentType" id="global-investment-opt" value="1">
            <span class="input-text">Global</span>
        </div>
        <div class="investment-popup-field">
            <input type="radio" name="investmentType" class="investmentType" id="region-investment-opt" value="2">
            <span class="input-text">Regional</span>
        <@renderRegionSelect name='region' readonly=true class="investment-popup-select"/>
            <div>
                <span id="error-region" class="jive-error-message" style="display:none">Please select region</span>
            </div>
        </div>
        <div class="investment-popup-field">
            <input type="radio" name="investmentType" class="investmentType" id="area-investment-opt" value="3">
            <span class="input-text">Area</span>
        <@renderAreaSelect name='area' readonly=true class="investment-popup-select"/>
            <div>
                <span id="error-area" class="jive-error-message" style="display:none">Please select area</span>
            </div>
        </div>
        <div class="investment-popup-field investment-field">
            <input type="radio" name="investmentType" class="investmentType" id="country-investment-opt" value="4">
            <span class="input-text">Country</span>
            <div class="investment-popup-subfield">
                <span class="input-text">Fieldwork:</span>
            <@renderEndMarketSingleSelectFld name='fieldwork' disabled=false class="investment-popup-select"/>
                <span id="error-fieldwork" class="jive-error-message" style="display:none">Please select fieldwork</span>
            </div>
            <div class="investment-popup-subfield">
                <span class="input-text">Funding:</span>
            <@renderEndMarketSingleSelectFld name='funding' disabled=false class="investment-popup-select"/>
                <span id="error-funding" class="jive-error-message" style="display:none">Please select funding</span>
            </div>
            <span id="error-investmentType" class="jive-error-message" style="display:none">Please select investment type</span>
        </div>
        <div id="project-contact" class="investment-popup-field">
            <span class="add-investment-sp">Project Owner / Project Contact</span>
            <div id="popup-contact-container">
                <input type="text" tabindex="1" name="projectContact" id="projectContact" value="" class="j-user-autocomplete j-ui-elem" autocomplete="off" />
            </div>
            <span id="error-contact" class="jive-error-message" style="display:none">Please select Project Contact</span>
        </div>
        <div class="investment-popup-field" id="spi-contact-container" style="display:none;">
            <span class="add-investment-sp"><@s.text name="project.initiate.project.spi"/></span>
            <div id="popup-spi-container">
                <input type="text" tabindex="1" name="spiContact" id="spiContact" value="" class="j-user-autocomplete j-ui-elem" srole="1" autocomplete="off" />
            </div>
        </div>
        <div class="investment-popup-field investment-estimate">

            <div class="spi-estimate-cost">
                <span>Initial Cost</span>
                <input type="text" name="initialCost" class="text_field numericfield-pit numericformat longField" value=""/>
                <span id="numeric-error-initialCost" class="jive-error-message numeric-error" style="display:none">Please enter numeric value</span>
            </div>
            <div class="pit-currency">
                <span class="input-text">Currency</span>
            <@renderCurrenciesField name='initialCostCurrency' value=-1 disabled=false/>
                <span id="error-currency" class="jive-error-message" style="display:none">Please select currency</span>
            </div>

        </div>
        <div class="investment-popup-buttons">
            <input type="button" id="investment-popup-save" value="Save" onClick="saveInvestment();"/>
            <input type="button" id="investment-popup-cancel" value="Cancel" onClick="closePopUp();" />
        </div>
        <input type="hidden" name="investmentID" id="investmentID" value="0" />
        <input type="hidden" name="approved" id="approved" value="false" />
        <input type="hidden" name="editMode" id="editMode" value="false" />
        <input type="hidden" name="editRowID" id="editRowID" value="" />
        <input type="hidden" name="pageType" id="pageType" value="pit" />
        <input type="hidden" name="canViewRow" id="canViewRow" value="" />
    </div>
</div>
<!-- Add Investment Popup Ends -->

<!-- Form dynamic-->
<div class="style:hidden" id="append-investment-div">
</div>