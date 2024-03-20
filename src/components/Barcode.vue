<script lang="ts">
import { h } from 'vue';
import JsBarcode from 'jsbarcode';

interface Setting {
  format?: string;
  width?: string | number;
  height?: string | number;
  displayValue?: string | boolean;
  text?: string | number;
  fontOptions?: string;
  font?: string;
  textAlign?: string;
  textPosition?: string;
  textMargin?: string | number;
  fontSize?: string | number;
  background?: string;
  lineColor?: string;
  margin?: string | number;
  marginTop?: string | number;
  marginBottom?: string | number;
  marginLeft?: string | number;
  marginRight?: string | number;
  flat?: boolean;
  ean128?: string | boolean;
  valid?: Function | null;
  elementTag?: string | HTMLElement | null;
}

export default {
  name: 'Barcode',
  props: {
    value: [String, Number],
    format: [String],
    width: [String, Number],
    height: [String, Number],
    displayValue: {
      type: [String, Boolean],
      default: true,
    },
    text: [String, Number],
    fontOptions: [String],
    font: [String],
    textAlign: [String],
    textPosition: [String],
    textMargin: [String, Number],
    fontSize: [String, Number],
    background: [String],
    lineColor: [String],
    margin: [String, Number],
    marginTop: [String, Number],
    marginBottom: [String, Number],
    marginLeft: [String, Number],
    marginRight: [String, Number],
    flat: [Boolean],
    ean128: [String, Boolean],
    elementTag: {
      type: String,
      default: 'svg',
      validator: function (value: string) {
        return ['canvas', 'svg', 'img'].indexOf(value) !== -1;
      },
    },
  },

  methods: {
    removeUndefinedProps(obj: any) {
      Object.keys(obj).forEach(key => obj[key] === undefined ? delete obj[key]: {});
    },
    generateBarcode() {
      const that = this;

      const settings: Setting = {
        format: this.format,
        width: this.width,
        height: this.height,
        displayValue: this.displayValue,
        text: this.text,
        fontOptions: this.fontOptions,
        font: this.font,
        textAlign: this.textAlign,
        textPosition: this.textPosition,
        textMargin: this.textMargin,
        fontSize: this.fontSize,
        background: this.background,
        lineColor: this.lineColor,
        margin: this.margin,
        marginTop: this.marginTop,
        marginBottom: this.marginBottom,
        marginLeft: this.marginLeft,
        marginRight: this.marginRight,
        flat: this.flat,
        ean128: this.ean128,
        valid: function (valid: any) {
          // @ts-ignore
          that.valid = valid;
        },
        elementTag: this.elementTag,
      };

      this.removeUndefinedProps(settings);

      JsBarcode(this.$el, this.value as string, settings as any);
    },
  },

  render () {
    return h(this.elementTag, { id: ['barcodegen'] });
  },

  mounted() {
    this.generateBarcode();
  },
}
</script>
