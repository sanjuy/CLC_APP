import 'dart:async';
import 'dart:io';

import 'package:clc_app/custom_widget/custom_appbar.dart';
import 'package:clc_app/home/redeem/web_view_screen.dart';
import 'package:clc_app/loading_indicator.dart';
import 'package:clc_app/resources/alert_view.dart';
import 'package:clc_app/resources/default_color.dart';
import 'package:clc_app/resources/router.dart';
import 'package:clc_app/resources/utils.dart';
import 'package:clc_app/subscription_plans/in_app_purchase.dart';
import 'package:clc_app/subscription_plans/subscription_card_view.dart';
import 'package:clc_app/subscription_plans/subscription_controller.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

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
  // bool _isSubscribed = false;
  final String _productID1 = "chowlucky_plus_1_weekly_1";
  final String _productID2 = "chowlucky_plus_1_special_1";
  final String _productID3 = "chowlucky_plus_1_annual_1";

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      _initialize();
    }
  }

  Future<void> _initialize() async {
    final bool available = await _iap.isAvailable();
    if (!available) return;
    final productIds = <String>{_productID1, _productID2, _productID3};
    LoadingIndicator.show();
    _subscription = _iap.purchaseStream.listen(_handlePurchaseUpdates);

    final response = await _iap.queryProductDetails(productIds);
    if ((response.error == null) && response.productDetails.isNotEmpty) {
      setState(() {
        _products = response.productDetails;
      });
    }
    LoadingIndicator.hide();
  }

  Future<void> _handlePurchaseUpdates(List<PurchaseDetails> purchases) async {
    for (final purchase in purchases) {
      if (purchase.status == PurchaseStatus.pending) {
        _pendingPurchase = purchase;
      } else if (purchase.status == PurchaseStatus.purchased) {
        _pendingPurchase = null;
        await _iap.completePurchase(purchase);

        if (purchase.productID == _productID1) {
          await SubscriptionController.instance.grantAccess(56);
        }
        if (purchase.productID == _productID2) {
          await SubscriptionController.instance.grantAccess(180);
        }
        if (purchase.productID == _productID3) {
          await SubscriptionController.instance.grantAccess(365);
        }
        // await _grantAccess(7);
        if (!mounted) return;
        showInSnackBar(
            context: context, message: "Purchase ${purchase.productID}");
        showSuccessPopup(context, () {
          widget.onSuccess!();
          Navigation.pop(context: context);
        });
      } else if (purchase.status == PurchaseStatus.restored) {
        _pendingPurchase = null;
        await _iap.completePurchase(purchase);
        if (!mounted) return;
        // showInSnackBar(
        //     context: context, message: "Purchase ${purchase.productID}");
        showSuccessPopup(context, message: "Purchases Restore Successful!", () {
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
    if (Platform.isIOS) {
      _subscription.cancel();
    }
    super.dispose();
  }

  Future<void> _restorePurchases() async {
    try {
      LoadingIndicator.show(); // optional: show loading
      await _iap.restorePurchases();
      if (!mounted) return;
      showInSnackBar(context: context, message: "Restoring purchases...");
    } catch (e) {
      showInSnackBar(context: context, message: "Failed to restore purchases");
    } finally {
      LoadingIndicator.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    final weekly = _products.firstWhereOrNull((p) => p.id == _productID1);
    final special = _products.firstWhereOrNull((p) => p.id == _productID2);
    final annual = _products.firstWhereOrNull((p) => p.id == _productID3);

    return Scaffold(
      appBar: CustomAppBar(title: "Subscription Plans"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: Platform.isIOS
                ? [
                    if (weekly != null)
                      SubscriptionCard(
                        title: weekly.title,
                        price: weekly.price,
                        // price: "\$7.09",
                        duration: weekly.description,
                        renews: "",
                        onClicked: () => _buy(weekly),
                      ),
                    if (special != null)
                      SubscriptionCard(
                        title: special.title,
                        price: special.price,
                        // price: "\$38.90",
                        duration: special.description,
                        renews: "",
                        // oldPrice: "\$48.89",
                        onClicked: () => _buy(special),
                      ),
                    if (annual != null)
                      SubscriptionCard(
                        title: annual.title,
                        price: annual.price,
                        // price: "\$58.90",
                        duration: annual.description,
                        renews: "",
                        // oldPrice: "\$97.76",
                        isTopChoice: true,
                        onClicked: () => _buy(annual),
                      ),
                    const SizedBox(height: 10),
                    customText(
                      title:
                          "By purchasing a premium pass, you gain access to exclusive features for the selected duration:",
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 3),
                    customText(
                      title:
                          "1-Week Pass: Enjoy premium access for 8 weeks (56 days).",
                    ),
                    SizedBox(height: 2),
                    customText(
                      title:
                          "6-Month Pass: Enjoy premium access for 6 months (180 days).",
                    ),
                    SizedBox(height: 2),
                    customText(
                      title:
                          "1-Year Pass: Enjoy premium access for 12 months (365 days).",
                    ),
                    SizedBox(height: 5),
                    customText(
                      title:
                          "These are non-renewing subscriptions and will not automatically renew. You may repurchase a plan once the current one expires.",
                    ),
                    SizedBox(height: 3),
                    customText(
                      title: "We do not collect or share any personal data.",
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 5),
                    customText(
                      title:
                          "For support or inquiries, please contact our support team.",
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () => _restorePurchases(),
                          child: customText(
                            title: "Restore Purchases",
                            color: primeColor,
                            fontSize: 13,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigation.push(
                              context: context,
                              moveTo: WebViewScreen(
                                title: "Terms of Use",
                                url:
                                    "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/",
                              ),
                            );
                          },
                          child: customText(
                            title: "Terms of Use",
                            color: primeColor,
                            fontSize: 13,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigation.push(
                              context: context,
                              moveTo: WebViewScreen(
                                title: "Contact Us",
                                url: "https://chowluckclub.com/contact",
                              ),
                            );
                          },
                          child: customText(
                            title: "Contact Us",
                            color: primeColor,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ]
                : [
                    SubscriptionCard(
                      title: "ChowLucky Plus Weekly",
                      price: "\$0.89",
                      duration: "For the first 8 weeks, pay just",
                      renews: "Renews \$1.88 per week",
                      onClicked: () {
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
                      },
                    ),
                    SubscriptionCard(
                      title: "ChowLucky Plus Special",
                      price: "\$38.90",
                      duration: "Pay just",
                      renews: "Renews at \$48.89 every 6 months",
                      oldPrice: "\$48.89",
                      onClicked: () {
                        SubscriptionController.instance.makePayment(38.90,
                            (vl) {
                          if (vl) {
                            showSuccessPopup(context, () {
                              widget.onSuccess!();
                              Navigation.pop(context: context);
                            });
                          } else {
                            showFailurePopup(context);
                          }
                        });
                      },
                    ),
                    SubscriptionCard(
                      title: "ChowLucky Plus Annual",
                      price: "\$58.90",
                      duration: "Pay just",
                      renews: "Renews \$78 per year",
                      oldPrice: "\$97.76",
                      isTopChoice: true,
                      onClicked: () {
                        SubscriptionController.instance.makePayment(58.90,
                            (vl) {
                          if (vl) {
                            showSuccessPopup(context, () {
                              widget.onSuccess!();
                              Navigation.pop(context: context);
                            });
                          } else {
                            showFailurePopup(context);
                          }
                        });
                      },
                    ),
                  ],
          ),
        ),
      ),
      // persistentFooterAlignment: AlignmentDirectional.center,
      // persistentFooterButtons: Platform.isIOS
      //     ? [
      //         TextButton(
      //           onPressed: () => _restorePurchases(),
      //           child:
      //               customText(title: "Restore Purchases", color: primeColor),
      //         ),
      //         TextButton(
      //           onPressed: () {
      //             Navigation.push(
      //               context: context,
      //               moveTo: WebViewScreen(
      //                 title: "Terms of Use",
      //                 url:
      //                     "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/",
      //               ),
      //             );
      //           },
      //           child: customText(title: "Terms of Use", color: primeColor),
      //         ),
      //         // TextButton(
      //         //   onPressed: () {
      //         //     Navigation.push(
      //         //       context: context,
      //         //       moveTo: WebViewScreen(
      //         //         title: "Privacy Policy",
      //         //         url:
      //         //             "https://drive.google.com/file/d/1ZABD_MptkFiZrJd3UJJkVrlBsA3WD6w9/view",
      //         //       ),
      //         //     );
      //         //   },
      //         //   child: customText(title: "Privacy Policy", color: primeColor),
      //         // ),
      //       ]
      //     : null,
    );
  }
}
