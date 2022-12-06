import 'package:get/get.dart';
import 'package:istchrat/screens/wallet/controller/wallet_controller.dart';

class WalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WalletController()..getWalletData());
  }

}