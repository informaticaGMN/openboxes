<table id="requisition-items">
    <thead>
        <tr class="theader">
            <th></th>
            <th><warehouse:message code="report.number.label"/></th>
            <th class="center">${warehouse.message(code: 'product.productCode.label')}</th>
            <th>${warehouse.message(code: 'product.label')}</th>
            <th>${warehouse.message(code: 'inventoryItem.lotNumber.label')}</th>
            <th>${warehouse.message(code: 'inventoryItem.expirationDate.label')}</th>
            <th class="center">${warehouse.message(code: 'requisitionItem.quantityPicked.label')}</th>
            <th>${warehouse.message(code: 'requisitionItem.cancelReasonCode.label')}</th>
        </tr>
    </thead>
    <tbody>
        <g:unless test="${requisitionItems}">
            <tr>
                <td colspan="8" class="middle center">
                    <span class="fade">
                        <warehouse:message code="default.none.label"/>
                    </span>
                </td>
            </tr>
        </g:unless>
        <g:each in="${requisitionItems}" status="i" var="requisitionItem">
            <g:if test="${picklist}">
                <g:set var="picklistItems" value="${requisitionItem?.retrievePicklistItems()}"/>
                <g:set var="numInventoryItem" value="${picklistItems?.size() ?: 1}"/>
            </g:if>
            <g:else>
                <g:set var="numInventoryItem" value="${1}"/>
            </g:else>
            <g:set var="j" value="${0}"/>
            <g:while test="${j < numInventoryItem}">
                <tr class="prop">
                    <td class="center middle">
                        <g:if test="${j==0}">
                            <g:if test="${requisitionItem?.product?.coldChain}">
                                <img src="${resource(dir: 'images/icons/', file: 'coldchain.gif')}"/>
                            </g:if>
                            <g:if test="${requisitionItem?.product?.controlledSubstance}">
                                <img src="${resource(dir: 'images/icons/silk', file: 'error.png')}" title="Controlled substance"/>
                            </g:if>
                            <g:if test="${requisitionItem?.product?.hazardousMaterial}">
                                <img src="${resource(dir: 'images/icons/silk', file: 'exclamation.png')}" title="Hazardous material"/>
                            </g:if>
                        </g:if>
                    </td>
                    <td class="center middle">
                        <g:if test="${j==0}">
                            ${i + 1}
                        </g:if>
                    </td>
                    <td class="center middle">
                        <g:if test="${j==0}">
                            <b>${requisitionItem?.product?.productCode}</b>
                            <g:if test="${requisitionItem?.parentRequisitionItem}">
                                <div class="canceled">
                                    ${requisitionItem?.parentRequisitionItem?.product?.productCode}
                                </div>
                            </g:if>
                        </g:if>
                    </td>
                    <td class="middle">
                        <g:if test="${j==0}">
                            ${requisitionItem?.product?.name}
                            <g:if test="${requisitionItem?.parentRequisitionItem}">
                                <div class="canceled">
                                    ${requisitionItem?.parentRequisitionItem?.product?.name}
                                </div>
                            </g:if>
                        </g:if>
                    </td>
                    <td class="middle center">
                        ${picklistItems[j]?.inventoryItem?.lotNumber}
                    </td>
                    <td class="middle center">
                        <g:formatDate date="${picklistItems[j]?.inventoryItem?.expirationDate}" format="MMM yyyy"/>
                    </td>
                    <td class="center middle">
                        ${picklistItems[j]?.quantity ?: 0} ${requisitionItem?.product?.unitOfMeasure ?: "EA"}

                        <g:if test="${requisitionItem?.parentRequisitionItem}">
                            <div class="canceled">
                                ${requisitionItem?.parentRequisitionItem?.quantity}
                                ${requisitionItem?.parentRequisitionItem?.product?.unitOfMeasure ?: "EA"}
                            </div>
                        </g:if>
                    </td>
                    <td class="center middle">
                        ${requisitionItem?.parentRequisitionItem?.cancelReasonCode}
                        <span class="fade">${requisitionItem?.parentRequisitionItem?.cancelComments}</span>
                    </td>
                    <% j++ %>
                </tr>
            </g:while>
        </g:each>
    </tbody>
</table>