import 'package:get/get.dart';

import '../../../data/models/cart_order.dart';
import '../../../shared/utils/log_util.dart';

class CartController extends GetxController {
  final logTitle = "CartController";
  RxBool isLoading = true.obs;
  RxList<CartOrder> cartOrders = <CartOrder>[].obs;
  final RxInt cashDiscount = 1.obs;
  final RxString currentPaymentChannel = '1'.obs;

  final RxInt cartTotalItem = 0.obs;
  final RxDouble cartTotal = 0.0.obs;
  final RxDouble discount = 0.0.obs;
  final RxDouble grandTotal = 0.0.obs;

  @override
  void onInit() {
    listCartOrder();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  minusItem(int index) {
    Log.loga(logTitle, 'minusItem:: start');
    Log.loga(logTitle, 'minusItem:: index: $index');
    if (cartOrders[index].quantity < 1) {
      cartOrders[index].quantity = 0;
    } else {
      cartOrders[index].quantity--;
    }
    update();
    cartOrders.refresh();
    Log.loga(logTitle, 'minusItem:: end');
  }

  plusItem(int index) {
    Log.loga(logTitle, 'plusItem:: start');
    Log.loga(logTitle, 'plusItem:: index: $index');
    cartOrders[index].quantity++;
    Log.loga(logTitle,
        'plusItem:: total: ${cartOrders[index].fNPrice * cartOrders[index].quantity}');
    update();
    cartOrders.refresh();
    Log.loga(logTitle, 'plusItem:: end');
  }

  listCartOrder() {
    sampleCartOrders.forEach((element) {
      cartOrders.value.add(CartOrder(
        fNMSysProdId: element.fNMSysProdId,
        fTProdCode: element.fTProdCode,
        fTProdNameTH: element.fTProdNameTH,
        fNDealerPrice1: element.fNDealerPrice1,
        priceCredit: element.priceCredit,
        fNPrice: element.fNPrice,
        fNQuantityBal: element.fNQuantityBal,
        quantity: element.quantity,
      ));
    });
    update();
  }

  updatePaymentChannel(String value) {
    currentPaymentChannel.value = value;
    // updateDiscount();
    // updateGrandTotal();
  }

  updateCartOrder() {
    updateCartTotalItem();
    updateTotal();
    updateDiscount();
    updateGrandTotal();
  }

  updateCartTotalItem() {
    int tempItem = 0;
    for (var order in cartOrders) {
      tempItem += order.quantity;
    }
    cartTotalItem.value = tempItem;
  }

  updateTotal() {
    int tempPrice = 0;
    for (var order in cartOrders) {
      tempPrice += (order.fNPrice * order.quantity);
    }
    cartTotal.value = tempPrice / 1;
  }

  updateDiscount() {
    if (currentPaymentChannel.value == '1') {
      discount.value = (cartTotal.value * cashDiscount.value) / 100;
    } else {
      discount.value = 0;
    }
  }

  updateGrandTotal() {
    grandTotal.value = cartTotal.value - discount.value;
  }

  confirmOrder() {
    // sampleCartOrders.removeWhere((item) => item.fNMSysProdId == '777777');
    // cartOrders.value = sampleCartOrders;
    // updateCartTotalItem();
    // updateTotal();
    // updateDiscount();
    // updateGrandTotal();
  }
}
