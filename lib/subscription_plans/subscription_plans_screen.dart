import 'dart:async';
import 'dart:io';

import 'package:clc_app/custom_widget/custom_appbar.dart';
import 'package:clc_app/loading_indicator.dart';
import 'package:clc_app/resources/alert_view.dart';
import 'package:clc_app/resources/router.dart';
import 'package:clc_app/subscription_plans/in_app_purchase.dart';
import 'package:clc_app/subscription_plans/subscription_card_view.dart';
import 'package:clc_app/subscription_plans/subscription_controller.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubscriptionPlansScreen extends StatefulWidget {
  final Function? onSuccess;
  const SubscriptionPlansScreen({super.key, this.onSuccess});

  @override
  State<SubscriptionPlansScreen> createState() =>
      _SubscriptionPlansScreenState();
}

class _SubscriptionPlansScreenState extends State<SubscriptionPlansScreen> {
  final InAppPurchase _iap = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> _products = [];
  // bool _hasPendingPurchase = false;
  PurchaseDetails? _pendingPurchase;
  bool _isSubscribed = false;

  final _productIds = <String>{
    'chowlucky_plus_weekly',
    'chowlucky_plus_special',
    'chowlucky_plus_annual',
  };

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    LoadingIndicator.show();
    _subscription = _iap.purchaseStream.listen(_handlePurchaseUpdates);

    final response = await _iap.queryProductDetails(_productIds);
    if ((response.error == null) && response.productDetails.isNotEmpty) {
      setState(() {
        _products = response.productDetails;
      });
    }

    // Restore any past purchases (important for returning users)
    // await _iap.restorePurchases();

    // Load local subscription status
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isSubscribed = prefs.getBool('isSubscribed') ?? false;
    });
    LoadingIndicator.hide();
  }

  Future<void> _handlePurchaseUpdates(List<PurchaseDetails> purchases) async {
    final prefs = await SharedPreferences.getInstance();

    for (final purchase in purchases) {
      if (purchase.status == PurchaseStatus.pending) {
        _pendingPurchase = purchase;
      } else if (purchase.status == PurchaseStatus.purchased ||
          purchase.status == PurchaseStatus.restored) {
        _pendingPurchase = null;
        if (_productIds.contains(purchase.productID)) {
          await prefs.setBool('isSubscribed', true);
          setState(() => _isSubscribed = true);
        }
        await _iap.completePurchase(purchase);
        if (!mounted) return;
        showInSnackBar(
            context: context, message: "Purchase ${purchase.productID}");
        showSuccessPopup(context, () {
          Navigation.pop(context: context);
          widget.onSuccess!();
        });
      } else if (purchase.status == PurchaseStatus.canceled) {
        await _iap.completePurchase(_pendingPurchase!);
        if (!mounted) return;
        showInSnackBar(context: context, message: "Purchase Cancelled!");
      } else if (purchase.status == PurchaseStatus.error) {
        // _pendingPurchase = null;
        await _iap.completePurchase(_pendingPurchase!);
        if (!mounted) return;
        showInSnackBar(context: context, message: "Purchase Error!");
        showFailurePopup(context);
      }
    }
  }

  void _buy(ProductDetails product) async {
    // await _iap.completePurchase(_pendingPurchase!);
    final param = PurchaseParam(productDetails: product);
    _iap.buyNonConsumable(purchaseParam: param);
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weekly =
        _products.firstWhereOrNull((p) => p.id == 'chowlucky_plus_weekly');
    final special =
        _products.firstWhereOrNull((p) => p.id == 'chowlucky_plus_special');
    final annual =
        _products.firstWhereOrNull((p) => p.id == 'chowlucky_plus_annual');

    return Scaffold(
      appBar: CustomAppBar(title: "Subscription Plans"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 1,
          childAspectRatio: 1.5,
          children: [
            if (weekly != null)
              SubscriptionCard(
                title: "ChowLucky Plus Weekly",
                price: weekly.price,
                duration: "For the first 8 weeks, pay just",
                renews: "Renews \$1.88 per week",
                onClicked: () {
                  if (Platform.isIOS) {
                    _buy(weekly);
                  } else {
                    SubscriptionController.instance.makePayment(0.89, (vl) {
                      if (vl) {
                        showSuccessPopup(context, () {
                          Navigation.pop(context: context);
                          widget.onSuccess!();
                        });
                      } else {
                        showFailurePopup(context);
                      }
                    });
                  }
                },
              ),
            if (special != null)
              SubscriptionCard(
                title: "ChowLucky Plus Special",
                price: special.price,
                duration: "Pay just",
                renews: "Renews at \$48.89 every 6 months",
                oldPrice: "\$48.89",
                onClicked: () {
                  if (Platform.isIOS) {
                    _buy(special);
                  } else {
                    SubscriptionController.instance.makePayment(38.90, (vl) {
                      if (vl) {
                        showSuccessPopup(context, () {
                          widget.onSuccess!();
                          Navigation.pop(context: context);
                        });
                      } else {
                        showFailurePopup(context);
                      }
                    });
                  }
                },
              ),
            if (annual != null)
              SubscriptionCard(
                title: "ChowLucky Plus Annual",
                price: annual.price,
                duration: "Pay just",
                renews: "Renews \$78 per year",
                oldPrice: "\$97.76",
                isTopChoice: true,
                onClicked: () {
                  if (Platform.isIOS) {
                    _buy(annual);
                  } else {
                    SubscriptionController.instance.makePayment(58.90, (vl) {
                      if (vl) {
                        showSuccessPopup(context, () {
                          widget.onSuccess!();
                          Navigation.pop(context: context);
                        });
                      } else {
                        showFailurePopup(context);
                      }
                    });
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
