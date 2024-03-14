import { ComputedRef, Ref } from "vue";
import { ref, watch, onMounted, toRaw } from "vue";
import { supabase } from '@/supabase';
import { notify } from '@kyvg/vue3-notification';
import { Price, PriceData } from "@/types/product";

export function useProductPrice(
  productPricesRef: ComputedRef<PriceData | undefined>,
  productType: string = 'product'
) {
  const columnName = (prodType: string) => ({
    'product': 'product_id' as keyof Price,
    'variation': 'variation_id' as keyof Price,
  })[prodType] || 'product_id' as keyof Price;

  const pricesLoading = ref(false);
  const yearList: Ref<number[]> = ref<number[]>([]);
  const prices: Ref<PriceData> = ref<PriceData>({
    map: [],
    dealer: [],
    distributor: [],
    group: [],
    internet: [],
    landscape: [],
    master_distributor: [],
    msrp: [],
  });

  const generateYearList = (currentYear: number): number[] => {
    const startYear = currentYear - 2;
    const endYear = currentYear + 1;
    const yearArray: number[] = [];

    for (let year = startYear; year <= endYear; year++) {
      yearArray.push(year);
    }

    return yearArray;
  }

  const yearToShowList = (priceType: keyof PriceData) => {
    const yearsToExclude = new Set(prices.value[priceType].map(item => item.year));
    return yearList.value.filter((year: number) => !yearsToExclude.has(year));
  }

  const removeYearFromList = (priceType: keyof PriceData, item: Price) => {
    prices.value[priceType] = prices.value[priceType].filter((priceItem) => priceItem.year !== item.year);
  }

  const addPrice = (priceType: keyof PriceData) => {
    const lastElement = yearToShowList(priceType)?.slice(-1)?.[0] || new Date().getFullYear();
    const newPrice = { year: lastElement, price: 0 };
    prices.value[priceType].push(newPrice);
  }

  const savePrice = async (type: string, priceForm: {
    year: number,
    price: number,
    variation_id?: number
    product_id?: number
  }) => {
    try {
      pricesLoading.value = true;
      const { data, error } = await supabase
        .from(`${type}_price`)
        .upsert(priceForm)
        .select();
      if (error) throw error;
      return data;
    } catch (e: any) {
      console.error(e);
      notify({
        title: `Error saving ${type} price.`,
        text: e?.message || `An error ocurred trying to save ${type} price. Please contact TOP support.`,
        type: 'error',
        duration: 6000,
      });
    } finally {
      pricesLoading.value = false;
    }
  }

  const setPrices = async (productId: number) => {
    try {
      pricesLoading.value = true;
      const availablePrices = Object.fromEntries(
        Object.entries(prices.value).filter(([key, value]) => value.length > 0)
      );
      const savePrices: Promise<any>[] = [];

      Object.entries(availablePrices).forEach(([key, value]) => {
        value.forEach(({ year, price, id }: any) => {
          const priceForm = {
            id: (id && id !== 0) ? id : undefined,
            year,
            price: +price,
            [columnName(productType)]: productId,
          };
          savePrices.push(savePrice(key, priceForm));
        });
      });
      const promiseResult = await Promise.allSettled(savePrices);
    } catch (e: any) {
      notify({
        title: `Error saving  prices.`,
        text: e?.message || `An error ocurred trying to save prices. Please contact TOP support.`,
        type: 'error',
        duration: 6000,
      });
    } finally {
      pricesLoading.value = false;
    }
  }

  watch(
    () => productPricesRef.value,
    (productPrices) => {
      if (productPrices) {
        prices.value = productPrices;
      }
    },
    { deep: true },
  );

  onMounted(() => {
    if (productPricesRef.value)
      prices.value = productPricesRef.value;
  })

  return {
    yearList,
    generateYearList,
    yearToShowList,
    removeYearFromList,
    pricesLoading,
    prices,
    addPrice,
    savePrice,
    setPrices
  }
}

