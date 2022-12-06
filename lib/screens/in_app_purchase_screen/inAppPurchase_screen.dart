import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:intl/intl.dart';
import 'package:istchrat/screens/in_app_purchase_screen/repository/iap_repository.dart';
import 'package:istchrat/shared_components/colors.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../custom_widgets/custom_dialogs/success_dialog/custom_success_dialog.dart';
import '../../shared_components/widgets/custom_app_bar.dart';

class InAppPurchaseScreen extends StatefulWidget {
  final String title;
  final String id;
  final String type;

  const InAppPurchaseScreen({Key? key, required this.title, required this.id, required this.type}) : super(key: key);

  @override
  _InAppPurchaseScreenState createState() => _InAppPurchaseScreenState();
}

class _InAppPurchaseScreenState extends State<InAppPurchaseScreen> {
  bool loading = false;
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  final String _productID = 'istcharat_non';
  final IAPRepository _repository = IAPRepository();

  bool _available = true;
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  @override
  void initState() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;

    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      setState(() {
        _purchases.addAll(purchaseDetailsList);
        _listenToPurchaseUpdated(purchaseDetailsList);
      });
    }, onDone: () {
      _subscription!.cancel();
      Get.defaultDialog(
        title: "",
        content: CustomSuccessDialog(
          message: "",
        ),
      );
    }, onError: (error) {
      _subscription!.cancel();
    });

    _initialize();

    super.initState();
  }

  @override
  void dispose() {
    _subscription!.cancel();
    super.dispose();
  }

  void _initialize() async {
    _available = await _inAppPurchase.isAvailable();

    List<ProductDetails> products = await _getProducts(
      productIds: Set<String>.from(
        [_productID],
      ),
    );

    setState(() {
      _products = products;
    });
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      switch (purchaseDetails.status) {
        case PurchaseStatus.pending:
        setState(() {
          loading = true;
        });
          break;
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          if(widget.type != "consultation"){
            final response = await _repository.buyItem(id: widget.id, type: widget.type);
            response.fold((error){
              setState(() {
                loading = false;
              });
            }, (r){
              setState(() {
                loading = false;
              });
              Get.defaultDialog(
                title: "",
                content: CustomSuccessDialog(
                  message: "",
                ),
              );
            });
          }else{
            setState(() {
              loading = false;
            });
            Get.defaultDialog(
              title: "",
              content: CustomSuccessDialog(
                message: "",
              ),
            );
          }
          break;
        case PurchaseStatus.error:
          print(purchaseDetails.error.toString());
          setState(() {
            loading = false;
          });
          // _handleError(purchaseDetails.error!);
          break;
        default:
          break;
      }

      if (purchaseDetails.pendingCompletePurchase) {
        await _inAppPurchase.completePurchase(purchaseDetails);
      }
    });
  }

  Future<List<ProductDetails>> _getProducts(
      {required Set<String> productIds}) async {
    ProductDetailsResponse response =
    await _inAppPurchase.queryProductDetails(productIds);

    return response.productDetails;
  }

  ListTile _buildProduct({required ProductDetails product}) {
    return ListTile(
      leading: Icon(Icons.attach_money),
      title: Text('${product.title} - ${product.price}'),
      subtitle: Text(product.description),
      trailing: ElevatedButton(
        onPressed: () {
          _subscribe(product: product);
        },
        child: Text(
          'confirm_reservation'.tr,
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(yelloCollor),
        ),
      ),
    );
  }

  ListTile _buildPurchase({required PurchaseDetails purchase}) {
    if (purchase.error != null) {
      return ListTile(
        title: Text("${purchase.error?.details.toString()}"),
        subtitle: Text("${purchase.error?.message}"),
      );
    }

    String? transactionDate;
    if (purchase.status == PurchaseStatus.purchased) {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(
        int.parse(purchase.transactionDate!),
      );
      transactionDate = ' @ ' + DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
    }

    return ListTile(
      title: Text('${purchase.productID} ${transactionDate ?? ''}'),
      subtitle: Text(purchase.status.toString()),
    );
  }

  void _subscribe({required ProductDetails product}) {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
    _inAppPurchase.buyNonConsumable(
      purchaseParam: purchaseParam,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loading,
      child: Scaffold(
        appBar: CustomAppBar.appBar(context, text: widget.title),
        body: _available
            ? Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Current Products ${_products.length}'),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      return _buildProduct(
                        product: _products[index],
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Past Purchases: ${_purchases.length}'),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _purchases.length,
                      itemBuilder: (context, index) {
                        return _buildPurchase(
                          purchase: _purchases[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
            : Center(
          child: Text('The Store Is Not Available'),
        ),
      ),
    );
  }
}