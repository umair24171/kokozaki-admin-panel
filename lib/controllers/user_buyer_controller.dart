import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
// import 'package:kokozaki_seller_panel/helper/firebase_features.dart';

import 'package:kokzaki_admin_panel/models/orders.dart';
import 'package:kokzaki_admin_panel/models/product_model.dart';

class UserBuyerController extends GetxController {
  RxList<OrderModel> orders = RxList<OrderModel>([]);
  RxList<Product> products = RxList<Product>([]);
  // late Rx<User?> _user;
  @override
  void onInit() {
    super.onInit();
    getOrders();
  }
  // @override
  // void onReady() {
  //   super.onReady();
  //   _user = Rx<User?>(FirebaseAuth.instance.currentUser);
  //   _user.bindStream(FirebaseAuth.instance.authStateChanges());
  //   // ever(_user, _setInitialScreen);
  // }

  // _setInitialScreen(User? user) {
  //   if (user == null) {
  //     Get.offAll(() => const LoginScreen());
  //   } else {
  //     Get.offAll(() => Dashboard());
  //   }
  // }

  getOrders() async {
    await FirebaseFirestore.instance.collection('orders').get().then((value) {
      if (value.docs.isNotEmpty) {
        orders.value =
            value.docs.map((e) => OrderModel.fromMap(e.data())).toList();
        update(); // Notify listeners
      } else {
        orders.value = [];
      }
    });
  }

  getProductBasedOnIds(List<String> productIds) async {
    await FirebaseFirestore.instance
        .collection('products')
        .where('id', whereIn: productIds)
        .where('sellerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        products.value =
            value.docs.map((e) => Product.fromMap(e.data())).toList();
      } else {
        products.value = [];
      }
    });
  }
}
