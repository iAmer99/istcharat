import 'package:get/get.dart';
import 'package:istchrat/screens/wallet/repository/model/WalletResponse.dart';
import 'package:istchrat/screens/wallet/repository/wallet_repository.dart';

class WalletController extends GetxController with StateMixin<WalletResponse>{
  final WalletRepository _repository = WalletRepository();

  Future getWalletData() async{
    change(null, status: RxStatus.loading());
    final response = await _repository.getWalletData();
    response.fold((error){
      change(null, status: RxStatus.error(error));
    }, (data){
      change(data, status: RxStatus.success());
    });
  }
}