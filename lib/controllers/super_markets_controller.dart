import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:kokzaki_admin_panel/models/market_model.dart';

class SuperMarketsController extends GetxController {
  RxList<MarketModel> superMarkets = RxList<MarketModel>([]);
  Rx<MarketModel?> seller = Rx<MarketModel?>(null);

  setReceiverUser(MarketModel receiverMarket) {
    seller.value = receiverMarket;
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   getSuperMarkets();
  // }

  getSuperMarkets() async {
    await FirebaseFirestore.instance.collection('sellers').get().then((value) =>
        superMarkets.value =
            value.docs.map((e) => MarketModel.fromMap(e.data())).toList());
  }
}
