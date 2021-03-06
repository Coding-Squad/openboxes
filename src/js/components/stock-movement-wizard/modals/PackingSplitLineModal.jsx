import _ from 'lodash';
import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';

import ModalWrapper from '../../form-elements/ModalWrapper';
import TextField from '../../form-elements/TextField';
import ArrayField from '../../form-elements/ArrayField';
import LabelField from '../../form-elements/LabelField';
import SelectField from '../../form-elements/SelectField';
import { showSpinner, hideSpinner } from '../../../actions';
import { debouncedUsersFetch } from '../../../utils/option-utils';

const FIELDS = {
  splitLineItems: {
    // eslint-disable-next-line react/prop-types
    addButton: ({ addRow, lineItem }) => (
      <button
        type="button"
        className="btn btn-outline-success margin-bottom-lg"
        onClick={() => addRow({
          productName: lineItem.productName,
          lotNumber: lineItem.lotNumber,
          expirationDate: lineItem.expirationDate,
          binLocationName: lineItem.binLocationName,
        })}
      >Add line
      </button>
    ),
    type: ArrayField,
    disableVirtualization: true,
    fields: {
      productName: {
        type: LabelField,
        label: 'Product Name',
      },
      lotNumber: {
        type: LabelField,
        label: 'Lot #',
      },
      expirationDate: {
        type: LabelField,
        label: 'Expiry Date',
      },
      binLocationName: {
        type: LabelField,
        label: 'Bin',
      },
      quantityShipped: {
        type: TextField,
        label: 'QTY',
        fixedWidth: '150px',
        attributes: {
          type: 'number',
        },
      },
      recipient: {
        type: SelectField,
        label: 'Recipient',
        fieldKey: '',
        attributes: {
          async: true,
          required: true,
          showValueTooltip: true,
          openOnClick: false,
          autoload: false,
          loadOptions: debouncedUsersFetch,
          cache: false,
          options: [],
          labelKey: 'name',
        },
      },
      palletName: {
        type: TextField,
        label: 'Pallet',
        fixedWidth: '150px',
      },
      boxName: {
        type: TextField,
        label: 'Box',
        fixedWidth: '150px',
      },
    },
  },
};

/** Modal window where user can split line for Packing Page item */
class PackingSplitLineModal extends Component {
  /**
   * Sums up quantity packed from all available lines.
   * @param {object} values
   * @public
   */
  static calculatePacked(values) {
    return (_.reduce(values, (sum, val) =>
      (sum + (val.quantityShipped ? _.toInteger(val.quantityShipped) : 0)), 0));
  }

  /**
   * Display sum of quantity packed from all available lines.
   * @param {object} values
   * @public
   */
  static displayPackedSum(values) {
    return (
      <div>
        <div className="font-weight-bold pb-2">
          Quantity Packed: {PackingSplitLineModal.calculatePacked(values.splitLineItems)}
        </div>
        <hr />
      </div>
    );
  }

  constructor(props) {
    super(props);

    const {
      fieldConfig: { attributes, getDynamicAttr },
    } = props;
    const dynamicAttr = getDynamicAttr ? getDynamicAttr(props) : {};
    const attr = { ...attributes, ...dynamicAttr };

    this.state = {
      attr,
      formValues: {},
    };
    this.onOpen = this.onOpen.bind(this);
    this.validate = this.validate.bind(this);
  }

  /**
   * Loads current packing lines for specified item
   * @public
   */
  onOpen() {
    this.setState({
      formValues: {
        splitLineItems: [
          {
            productName: this.state.attr.lineItem.productName,
            lotNumber: this.state.attr.lineItem.lotNumber,
            expirationDate: this.state.attr.lineItem.expirationDate,
            binLocationName: this.state.attr.lineItem.binLocationName,
            quantityShipped: this.state.attr.lineItem.quantityShipped,
            recipient: this.state.attr.lineItem.recipient,
            palletName: this.state.attr.lineItem.palletName,
            boxName: this.state.attr.lineItem.boxName,
          },
        ],
      },
    });
  }

  validate(values) {
    const shippedQty = _.toInteger(this.state.attr.lineItem.quantityShipped);
    const splitItemsQty = PackingSplitLineModal.calculatePacked(values.splitLineItems);
    const errors = { splitLineItems: [] };

    _.forEach(values.splitLineItems, (item, key) => {
      if (shippedQty !== splitItemsQty) {
        errors.splitLineItems[key] = { quantityShipped: 'Sum of all quantities must equal the original quantity' };
      }
    });

    return errors;
  }

  render() {
    return (
      <ModalWrapper
        {...this.state.attr}
        onOpen={this.onOpen}
        onSave={values =>
          this.state.attr.onSave(_.filter(values.splitLineItems, item => item.quantityShipped))}
        fields={FIELDS}
        initialValues={this.state.formValues}
        formProps={{ lineItem: this.state.attr.lineItem }}
        validate={this.validate}
        renderBodyWithValues={PackingSplitLineModal.displayPackedSum}
      >
        <div>
          <div className="font-weight-bold">Total Quantity: {this.state.attr.lineItem.quantityShipped} </div>
        </div>
      </ModalWrapper>
    );
  }
}

export default connect(null, { showSpinner, hideSpinner })(PackingSplitLineModal);

PackingSplitLineModal.propTypes = {
  /** Name of the field */
  fieldName: PropTypes.string.isRequired,
  /** Configuration of the field */
  fieldConfig: PropTypes.shape({
    getDynamicAttr: PropTypes.func,
  }).isRequired,
  /** Function called when data is loading */
  showSpinner: PropTypes.func.isRequired,
  /** Function called when data has loaded */
  hideSpinner: PropTypes.func.isRequired,
};
