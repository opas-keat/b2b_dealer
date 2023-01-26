import 'package:b2b_dealer/app/data/graphql/graphql_dealer.dart';
import 'package:b2b_dealer/app/data/graphql/graphql_shipping.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql/client.dart';
import 'package:nhost_graphql_adapter/nhost_graphql_adapter.dart';

import '../../../data/models/cart_order.dart';
import '../../../data/models/dealer_service_model.dart';
import '../../../data/models/shipping_response_model/shipping_model.dart';
import '../../../shared/constant.dart';
import '../../../shared/utils/log_util.dart';

class CartController extends GetxController {
  final logTitle = "CartController";
  RxBool isLoading = true.obs;
  RxList<CartOrder> cartOrders = <CartOrder>[].obs;
  final RxInt cashDiscount = 1.obs;
  final RxString currentPaymentChannel = '1'.obs;

  final addressList = <DealerModel>[].obs;
  final selectedAddress = DealerModel().obs;
  final addressText = TextEditingController().obs;

  final shippingList = <ShippingModel>[].obs;
  final selectedShipping = ShippingModel().obs;
  final shippingText = TextEditingController().obs;

  final shippingDateText = TextEditingController().obs;

  final preSaleOrderNo = ''.obs;

  final RxInt cartTotalItem = 0.obs;
  final RxDouble cartTotal = 0.0.obs;
  final RxDouble discount = 0.0.obs;
  final RxDouble grandTotal = 0.0.obs;

  final graphqlClient = createNhostGraphQLClient(nhostClient);

  @override
  void onInit() {
    listCartOrder();
    listAddressForCart();
    listShippingForCart();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    addressText.value.dispose();
    shippingText.value.dispose();
    shippingDateText.value.dispose();
    super.onClose();
  }

// reserve PreSalOrderNo
  getPreSaleOrderNo() {}

  listAddressForCart() async {
    Log.loga(logTitle, 'listAddressForCart:: start');
    try {
      addressList.clear();
      var result = await graphqlClient.query(
        QueryOptions(
          document: listDealersQuery,
          variables: {
            'offset': 0,
            "limit": 20,
            "created_by": nhostClient.auth.currentUser!.id
          },
        ),
      );
      if (result.hasException) {
        Log.loga(logTitle, 'listAddressForCart:: ${result.exception}');
      }
      final response = (result.data!['dealers'] as List)
          .map((e) => DealerModel.fromJson(e))
          .toList();
      if (response.isNotEmpty) {
        for (var element in response) {
          addressList.value.add(DealerModel(
            address: element.address,
            name: element.name,
            linkId: element.linkId,
            id: element.id,
          ));
        }
      }
      update();
    } catch (e) {
      Log.loga(logTitle, 'Error:: $e');
      return false;
    } finally {
      Log.loga(logTitle, 'listShippingForCart:: end');
    }
  }

  listShippingForCart() async {
    Log.loga(logTitle, 'listShippingForCart:: start');
    try {
      shippingList.clear();
      var result = await graphqlClient.query(
        QueryOptions(
          document: listShippingByCreatedByQuery,
          variables: {
            'offset': 0,
            "limit": 20,
            "created_by": nhostClient.auth.currentUser!.id
          },
        ),
      );
      if (result.hasException) {
        Log.loga(logTitle, 'listProduct:: ${result.exception}');
      }
      final response = (result.data!['shippings'] as List)
          .map((e) => ShippingModel.fromJson(e))
          .toList();
      if (response.isNotEmpty) {
        for (var element in response) {
          shippingList.value.add(ShippingModel(
            id: element.id,
            name: element.name,
            linkedId: element.linkedId,
          ));
        }
      }
      // Log.loga(logTitle, 'listShippingForCart:: ${shippingList.toJson()}');
      update();
    } catch (e) {
      Log.loga(logTitle, 'Error:: $e');
      return false;
    } finally {
      Log.loga(logTitle, 'listShippingForCart:: end');
    }
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
    Log.loga(logTitle, 'listCartOrder:: start');
    cartOrders.value.forEach((element) {
      Log.loga(logTitle, 'element:: id:' + element.fNMSysProdId);
    });
    // sampleCartOrders.forEach((element) {
    //   cartOrders.value.add(CartOrder(
    //     fNMSysProdId: element.fNMSysProdId,
    //     fTProdCode: element.fTProdCode,
    //     fTProdNameTH: element.fTProdNameTH,
    //     fNDealerPrice1: element.fNDealerPrice1,
    //     priceCredit: element.priceCredit,
    //     fNPrice: element.fNPrice,
    //     fNQuantityBal: element.fNQuantityBal,
    //     quantity: element.quantity,
    //   ));
    // });
    update();
    Log.loga(logTitle, 'listCartOrder:: end');
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
    Log.loga(logTitle, 'confirmOrder:: start');
    try {
      Log.loga(logTitle, 'confirmOrder:: ${selectedAddress.toJson()}');
      Log.loga(logTitle, 'confirmOrder:: ${selectedShipping.toJson()}');
      update();
    } catch (e) {
      Log.loga(logTitle, 'Error:: $e');
      return false;
    } finally {
      Log.loga(logTitle, 'confirmOrder:: end');
    }
    // sampleCartOrders.removeWhere((item) => item.fNMSysProdId == '777777');
    // cartOrders.value = sampleCartOrders;
    // updateCartTotalItem();
    // updateTotal();
    // updateDiscount();
    // updateGrandTotal();
  }
}
