<g:form controller="productAssociation" method="post">

    <g:hiddenField name="id" value="${productAssociation?.id}"></g:hiddenField>
    <g:hiddenField name="product.id" value="${productAssociation?.product?.id}"></g:hiddenField>
    <g:hiddenField name="dialog" value="true"></g:hiddenField>

    <table>
        <tr class="prop">
            <td class="name">
                <label for="code"><g:message code="default.code.label"/></label>
            </td>
            <td class="value ">
                <g:selectProductAssociationTypeCode name="code" value="${productAssociation.code}" class="chzn-select-deselect"/>
            </td>
        </tr>
        <tr class="prop">
            <td class="name">
                <label for="product"><g:message code="productAssociation.substitutionRule.label"/></label>
            </td>
            <td class="value ">
                <div id="product">
                    <g:textField name="readonly-quantity" size="4" class="medium text" value="1" readonly="readonly" /> x
                    ${productAssociation?.product?.productCode}
                    <format:product product="${productAssociation?.product}"/>
                </div>
                <div id="associatedProduct">
                    <g:textField name="quantity" size="4" class="medium text" value="${productAssociation?.quantity}" /> x
                    <g:autoSuggest id="associatedProduct" name="associatedProduct"
                                   valueId="${productAssociation?.associatedProduct?.id}"
                                   valueName="${productAssociation?.associatedProduct?.name}"
                                   jsonUrl="${request.contextPath }/json/findProductByName" styleClass="text" />
                </div>



            </td>
        </tr>

        <tr class="prop">
            <td class="name">
                <label for="comments"><g:message code="default.comments.label"/></label>
            </td>
            <td class="value ">
                <g:textArea name="comments" size="80" class="text medium" value="${productAssociation?.comments}" />
            </td>
        </tr>
    </table>


    <div class="buttons">
        <g:if test="${productAssociation.id}">
            <g:actionSubmit action="update" class="button icon accept" value="Save" id="update">${warehouse.message(code: 'default.button.save.label', default: 'Save')}</g:actionSubmit>
            <g:actionSubmit action="delete" class="button icon trash" value="Delete" id="delete">${warehouse.message(code: 'default.button.save.label', default: 'Save')}</g:actionSubmit>
        </g:if>
        <g:else>
            <g:actionSubmit action="save" class="button icon approve" value="Save" id="save">${warehouse.message(code: 'default.button.save.label', default: 'Save')}</g:actionSubmit>
        </g:else>
        &nbsp;
        <a href="#" class="close-dialog" dialog-id="product-association-dialog">${warehouse.message(code: 'default.button.cancel.label', default: 'Cancel')}</a>


    </div>


</g:form>