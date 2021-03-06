<%@ page import="org.pih.warehouse.core.RoleType" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="print"/>
    <link rel="stylesheet" href="${createLinkTo(dir: 'css', file: 'print.css')}" type="text/css"
          media="print, screen, projection"/>
    <g:set var="entityName" value="${warehouse.message(code: 'requisition.label', default: 'Requisition')}"/>
    <title><warehouse:message code="default.show.label" args="[entityName]"/></title>
    <script src="${createLinkTo(dir: 'js/jquery.nailthumb', file: 'jquery.nailthumb.1.1.js')}"
            type="text/javascript"></script>
    <link rel="stylesheet" href="${createLinkTo(dir: 'js/jquery.nailthumb', file: 'jquery.nailthumb.1.1.css')}"
          type="text/css" media="all"/>
    <link rel="stylesheet" href="${createLinkTo(dir:'css',file:'buttons.css')}" type="text/css" media="all" />

</head>

<body>
<div id="print-header" style="line-height: 40px;">
    <%--<img id="logo" src="${createLinkTo(dir: 'images/', file: 'hands.jpg')}"/>--%>
    <span class="title"><warehouse:message code="picklist.print.label"/></span>
    <div class="right button-group" style="margin:10px;">
        <a href="javascript:window.print()" type="button" id="print-button" onclick="window.print();"  class="button">
            ${warehouse.message(code: "default.button.print.label", default: 'Print')}
        </a>
        <g:link controller="picklist" action="renderPdf" id="${requisition?.id}" class="button">
            ${warehouse.message(code: "default.button.download.label", default: 'Download')}
        </g:link>
        <a href="javascript:window.close();" class="button">
            ${warehouse.message(code: "default.button.close.label", default: 'Close')}
        </a>
    </div>
    <hr/>
</div>

<div class="clear"></div>



<table border="0">
    <tr>
        <td width="1%">
            <div class="requisition-header cf-header" style="margin-bottom: 20px;">
                <div class="print-logo nailthumb-container-100 center">
                    <img src="${createLinkTo(dir: 'images/', file: 'hands.jpg')}"/>
                </div>
            </div>
        </td>
        <td>
            <div class="header">
                <h1><warehouse:message code="picklist.label"/></h1>
            </div>
            <div class="header">
                ${requisition.requestNumber} - ${requisition?.name }
            </div>
            <%--
            <div class="header">
                <h3>${requisition?.destination?.name}</h3>
            </div>
            --%>
            <div class="header">
            </div>

            <div class="header">
                <g:if test="${requisition.requestNumber}">
                    <img src="${createLink(controller: 'product', action: 'barcode', params: [data: requisition?.requestNumber, width: 100, height: 30, format: 'CODE_128'])}"/>
                </g:if>
            </div>
        </td>
        <td class="top">
            <table border="0">
                <tr class="header">
                    <td class="name right">
                        <label><warehouse:message code="requisition.requisitionNumber.label"/>:</label>
                    </td>
                    <td>
                        ${requisition.requestNumber}
                    </td>
                </tr>
                <tr class="header">
                    <td class="name right">
                        <label><warehouse:message code="requisition.requisitionType.label"/>:</label>
                    </td>
                    <td>
                        <format:metadata obj="${requisition.type}"/>
                    </td>
                </tr>
                <tr class="header">
                    <td class="name right">
                        <label><warehouse:message code="requisition.origin.label"/>:</label>
                    </td>
                    <td>
                        ${requisition.origin?.name}
                    </td>
                </tr>
                <tr class="header">
                    <td class="name right">
                        <label><warehouse:message code="requisition.destination.label"/>:</label>
                    </td>
                    <td>
                        ${requisition.destination?.name}
                    </td>
                </tr>

                <tr class="header">
                    <td class="name right">
                        <label><warehouse:message code="requisition.date.label"/>:</label>
                    </td>
                    <td>
                        <g:formatDate
                                date="${requisition?.dateRequested}" format="MMM d, yyyy  hh:mma"/>
                    </td>
                </tr>
                <tr class="header">
                    <td class="name right">
                        <label><warehouse:message code="picklist.datePrinted.label" default="Date printed"/>:</label>
                    </td>
                    <td>
                        <g:formatDate
                                date="${new Date()}" format="MMM d, yyyy hh:mma"/>
                    </td>
                </tr>

            </table>
        </td>
    </tr>

</table>



<table class="signature-table" border="0">
    <tr class="theader">
        <td width="15%"></td>
        <td width="20%"><warehouse:message code="default.name.label"/></td>
        <td width="40%"><warehouse:message code="default.signature.label"/></td>
        <td width="15%" class="center"><warehouse:message code="default.date.label"/></td>
        <td width="10%" class="center"><warehouse:message code="default.time.label"/></td>
    </tr>
    <tr>
        <td class="right">
            <label><warehouse:message code="requisition.requestedBy.label"/></label>
        </td>
        <td class="middle">
            ${requisition?.requestedBy?.name}
        </td>
        <td>

        </td>
        <td class="middle center">
            <g:formatDate date="${requisition?.dateRequested}" format="MMM d, yyyy"/>
        </td>
        <td class="middle center">
            <g:formatDate date="${requisition?.dateRequested}" format="hh:mma"/>
        </td>
    </tr>
    <tr>
        <td class="right middle">
            <label><warehouse:message code="requisition.createdBy.label"/></label>
        </td>
        <td class="middle">
            ${requisition?.createdBy?.name?:warehouse.message(code:'default.none.label')}
        </td>
        <td>

        </td>
        <td class="middle center">
            <g:formatDate date="${requisition?.dateCreated}" format="MMM d, yyyy"/>
        </td>
        <td class="middle center">
            <g:formatDate date="${requisition?.dateCreated}" format="hh:mma"/>
        </td>
    </tr>
    <tr>
        <td class="right">
            <label><warehouse:message code="requisition.verifiedBy.label"/></label>
        </td>
        <td class="middle">
            ${requisition?.verifiedBy?.name?:warehouse.message(code:'default.none.label')}
        </td>
        <td>

        </td>
        <td class="middle center">
            <g:formatDate date="${requisition?.dateVerified}" format="MMM d, yyyy"/>
        </td>
        <td class="middle center">
            <g:formatDate date="${requisition?.dateVerified}" format="hh:mma"/>
        </td>
    </tr>
    <tr>
        <td class="right">
            <label><warehouse:message code="requisition.pickedBy.label"/></label>
        </td>
        <td class="middle">
            ${picklist?.picker?.name?:warehouse.message(code:'default.none.label')}
        </td>
        <td>

        </td>
        <td class="middle center">
            <g:formatDate date="${picklist?.datePicked}" format="MMM d, yyyy"/>
        </td>
        <td class="middle center">
            <g:formatDate date="${picklist?.datePicked}" format="hh:mma"/>
        </td>
    </tr>
    <tr>
        <td class="middle right">
            <label><warehouse:message code="requisition.reviewedBy.label" default="Checked by"/></label>
        </td>
        <td class="middle">
            ${requisition?.checkedBy?.name?:warehouse.message(code:'default.none.label')}
        </td>
        <td>

        </td>
        <td class="middle center">
            <g:formatDate date="${requisition?.dateChecked}" format="MMM d, yyyy"/>
        </td>
        <td class="middle center">
            <g:formatDate date="${requisition?.dateChecked}" format="hh:mma"/>
        </td>
    </tr>
</table>

<div class="clear"></div>

<g:set var="requisitionItems" value='${requisition.requisitionItems.sort { it.product.name }}'/>
<g:set var="requisitionItemsCanceled" value='${requisitionItems.findAll { it.isCanceled()}}'/>
<g:set var="requisitionItems" value='${requisitionItems.findAll { !it.isCanceled()&&!it.isChanged() }}'/>
<g:set var="requisitionItemsColdChain" value='${requisitionItems.findAll { it?.product?.coldChain }}'/>
<g:set var="requisitionItemsControlled" value='${requisitionItems.findAll {it?.product?.controlledSubstance}}'/>
<g:set var="requisitionItemsHazmat" value='${requisitionItems.findAll {it?.product?.hazardousMaterial}}'/>
<g:set var="requisitionItemsOther" value='${requisitionItems.findAll {!it?.product?.hazardousMaterial && !it?.product?.coldChain && !it?.product?.controlledSubstance}}'/>

<div>
    <g:if test="${requisitionItemsColdChain}">
        <h2>
            <img src="${resource(dir: 'images/icons/', file: 'coldchain.gif')}" title="Cold chain"/>&nbsp;
            ${warehouse.message(code:'product.coldChain.label', default:'Cold chain')}
        </h2>
        <g:render template="printPage" model="[requisitionItems:requisitionItemsColdChain, location:location, pageBreakAfter: (requisitionItemsControlled||requisitionItemsHazmat||requisitionItemsOther)?'always':'avoid']"/>
    </g:if>
    <g:if test="${requisitionItemsControlled}">
        <h2>
            <img src="${resource(dir: 'images/icons/silk', file: 'error.png')}" title="Controlled substance"/>&nbsp;
            ${warehouse.message(code:'product.controlledSubstance.label', default:'Controlled substance')}
        </h2>
        <g:render template="printPage" model="[requisitionItems:requisitionItemsControlled, location:location, pageBreakAfter: (requisitionItemsHazmat||requisitionItemsOther)?'always':'avoid']"/>
    </g:if>
    <g:if test="${requisitionItemsHazmat}">
        <h2>
            <img src="${resource(dir: 'images/icons/silk', file: 'exclamation.png')}" title="Hazardous material"/>&nbsp;
            ${warehouse.message(code:'product.hazardousMaterial.label', default:'Hazardous material')}

        </h2>
        <g:render template="printPage" model="[requisitionItems:requisitionItemsHazmat, location:location, pageBreakAfter: (requisitionItemsOther)?'always':'avoid']"/>
    </g:if>
    <g:if test="${requisitionItemsOther}">
        <h2>
            <img src="${resource(dir: 'images/icons/silk', file: 'pill.png')}" title="Medicines & Consumables"/>&nbsp;
            ${warehouse.message(code:'product.everythingElse.label', default:'Medicines & Consumables')}
        </h2>
        <g:render template="printPage" model="[requisitionItems:requisitionItemsOther, location:location, pageBreakAfter:(requisitionItemsCanceled)?'always':'avoid']"/>
    </g:if>
    <g:if test="${requisitionItemsCanceled}">
        <h2>
            <img src="${resource(dir: 'images/icons/silk', file: 'decline.png')}" title="Canceled"/>&nbsp;
            ${warehouse.message(code:'default.canceled.label', default:'Canceled')}
        </h2>
        <g:render template="printPage" model="[requisitionItems:requisitionItemsCanceled, location:location, pageBreakAfter: 'avoid']"/>
    </g:if>
</div>

<script>
    $(document).ready(function () {
        $('.nailthumb-container').nailthumb({ width: 100, height: 60 });
        $('.nailthumb-container-100').nailthumb({ width: 100, height: 100 });
    });
</script>

</body>
</html>
