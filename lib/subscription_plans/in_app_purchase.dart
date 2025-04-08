// import 'dart:async';

// import 'package:clc_app/resources/alert_view.dart';
// import 'package:flutter/material.dart';
// import 'package:in_app_purchase/in_app_purchase.dart';

// InAppPurchase _inAppPurchase = InAppPurchase.instance;
// late StreamSubscription<dynamic> _streamSubscription;
// List<ProductDetails> _products = [];
// const variants = {"ChowLuckyPlusWeekly"};

// class InAppPurchases extends StatefulWidget {
//   const InAppPurchases({super.key});

//   @override
//   State<InAppPurchases> createState() => __InAppPurchasesState();
// }

// class __InAppPurchasesState extends State<InAppPurchases> {
//   @override
//   void initState() {
//     super.initState();
//     Stream inappPurchasedUpdate = InAppPurchase.instance.purchaseStream;
//     _streamSubscription = inappPurchasedUpdate.listen((purchaseList) {
//       _listenToPurchase(purchaseList);
//     }, onDone: () {
//       _streamSubscription.cancel();
//     }, onError: (e) {
//       showInSnackBar(context: context, message: e);
//     });
//     initStore();
//   }

//   _listenToPurchase(List<PurchaseDetails> list) async {
//     list.forEach((PurchaseDetails purchaseDetails) async {
//       if (purchaseDetails.status == PurchaseStatus.pending) {
//         showInSnackBar(context: context, message: "pending");
//       } else if (purchaseDetails.status == PurchaseStatus.error) {
//         showInSnackBar(context: context, message: "error");
//       } else if (purchaseDetails.status == PurchaseStatus.purchased) {
//         await _inAppPurchase.completePurchase(purchaseDetails);
//         showInSnackBar(context: context, message: "success");
//       }
//     });
//   }

//   initStore() async {
//     ProductDetailsResponse response =
//         await _inAppPurchase.queryProductDetails(variants);
//     if (response.error == null) {
//       _products = response.productDetails;
//       setState(() {});
//     }
//   }

//   _buy() {
//     final PurchaseParam param = PurchaseParam(productDetails: _products[0]);
//     _inAppPurchase.buyConsumable(purchaseParam: param);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("In-app Purchase"),
//       ),
//       body: Center(
//         child: TextButton(
//             onPressed: () {
//               _buy();
//             },
//             child: Text("Pay")),
//       ),
//     );
//   }
// }

// import 'dart:async';

// import 'package:clc_app/resources/alert_view.dart';
// import 'package:flutter/material.dart';
// import 'package:in_app_purchase/in_app_purchase.dart';

// InAppPurchase _inAppPurchase = InAppPurchase.instance;
// late StreamSubscription<dynamic> _streamSubscription;
// List<ProductDetails> _products = [];
// const variants = {"ChowLuckyPlusWeekly"};

// class InAppPurchases extends StatefulWidget {
//   const InAppPurchases({super.key});

//   @override
//   State<InAppPurchases> createState() => __InAppPurchasesState();
// }

// class __InAppPurchasesState extends State<InAppPurchases> {
//   bool _hasPendingPurchase = false;

//   @override
//   void initState() {
//     super.initState();
//     Stream inappPurchasedUpdate = InAppPurchase.instance.purchaseStream;
//     _streamSubscription = inappPurchasedUpdate.listen((purchaseList) {
//       _listenToPurchase(purchaseList);
//     }, onDone: () {
//       _streamSubscription.cancel();
//     }, onError: (e) {
//       showInSnackBar(context: context, message: e);
//     });
//     initStore();
//   }

//   _listenToPurchase(List<PurchaseDetails> list) async {
//     for (PurchaseDetails purchaseDetails in list) {
//       if (purchaseDetails.status == PurchaseStatus.pending) {
//         _hasPendingPurchase = true;
//         showInSnackBar(context: context, message: "pending");
//       } else if (purchaseDetails.status == PurchaseStatus.error) {
//         _hasPendingPurchase = false;
//         showInSnackBar(context: context, message: "error");
//       } else if (purchaseDetails.status == PurchaseStatus.purchased) {
//         _hasPendingPurchase = false;
//         // ✅ Deliver content here if needed
//         await _inAppPurchase.completePurchase(purchaseDetails);
//         showInSnackBar(context: context, message: "success");
//       }
//     }
//   }

//   initStore() async {
//     ProductDetailsResponse response =
//         await _inAppPurchase.queryProductDetails(variants);
//     if (response.error == null) {
//       _products = response.productDetails;
//       setState(() {});
//     }
//   }

//   _buy() async {
//     if (_products.isEmpty) return;

//     if (_hasPendingPurchase) {
//       showInSnackBar(
//           context: context,
//           message: "Transaction already in progress. Please wait...");
//       return;
//     }

//     final PurchaseParam param = PurchaseParam(productDetails: _products[0]);
//     try {
//       _inAppPurchase.buyConsumable(purchaseParam: param);
//       _hasPendingPurchase = true;
//     } catch (e) {
//       showInSnackBar(context: context, message: "Purchase failed: $e");
//     }
//   }

//   @override
//   void dispose() {
//     _streamSubscription.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("In-app Purchase"),
//       ),
//       body: Center(
//         child: TextButton(
//             onPressed: () {
//               _buy();
//             },
//             child: Text("Pay")),
//       ),
//     );
//   }
// }

// import 'dart:async';

// import 'package:clc_app/resources/alert_view.dart';
// import 'package:flutter/material.dart';
// import 'package:in_app_purchase/in_app_purchase.dart';

// InAppPurchase _inAppPurchase = InAppPurchase.instance;

// late StreamSubscription<dynamic> _streamSubscription;

// List<ProductDetails> _products = [];

// const variants = {"ChowLuckyPlusWeekly"};

// class InAppPurchases extends StatefulWidget {
//   const InAppPurchases({super.key});

//   @override
//   State<InAppPurchases> createState() => __InAppPurchasesState();
// }

// class __InAppPurchasesState extends State<InAppPurchases> {
//   bool _hasPendingPurchase = false;

//   PurchaseDetails? _pendingPurchaseDetails;

//   @override
//   void initState() {
//     super.initState();

//     Stream inappPurchasedUpdate = InAppPurchase.instance.purchaseStream;

//     _streamSubscription = inappPurchasedUpdate.listen((purchaseList) {
//       _listenToPurchase(purchaseList);
//     }, onDone: () {
//       _streamSubscription.cancel();
//     }, onError: (e) {
//       showInSnackBar(context: context, message: e.toString());
//     });

//     // Restore pending purchases from Apple on app launch (recommended)

//     InAppPurchase.instance.restorePurchases();

//     initStore();
//   }

//   _listenToPurchase(List<PurchaseDetails> list) async {
//     for (PurchaseDetails purchaseDetails in list) {
//       if (purchaseDetails.status == PurchaseStatus.pending) {
//         _hasPendingPurchase = true;

//         _pendingPurchaseDetails = purchaseDetails;

//         showInSnackBar(context: context, message: "Transaction pending...");
//       } else if (purchaseDetails.status == PurchaseStatus.error) {
//         _hasPendingPurchase = false;

//         _pendingPurchaseDetails = null;

//         showInSnackBar(context: context, message: "Transaction error");
//       } else if (purchaseDetails.status == PurchaseStatus.purchased) {
//         _hasPendingPurchase = false;

//         _pendingPurchaseDetails = null;

//         // ✅ Deliver content here if needed

//         await _inAppPurchase.completePurchase(purchaseDetails);

//         showInSnackBar(context: context, message: "Transaction successful");
//       }
//     }
//   }

//   initStore() async {
//     ProductDetailsResponse response =
//         await _inAppPurchase.queryProductDetails(variants);

//     if (response.error == null) {
//       _products = response.productDetails;

//       setState(() {});
//     }
//   }

//   _buy() async {
//     if (_products.isEmpty) return;

//     if (_hasPendingPurchase) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content:
//               Text("Transaction already in progress. Please wait or retry."),
//           action: SnackBarAction(
//             label: "Retry Now",
//             onPressed: () async {
//               if (_pendingPurchaseDetails != null) {
//                 await _inAppPurchase.completePurchase(_pendingPurchaseDetails!);
//                 _hasPendingPurchase = false;
//               }
//             },
//           ),
//         ),
//       );

//       return;
//     }

//     final PurchaseParam param = PurchaseParam(productDetails: _products[0]);

//     try {
//       _inAppPurchase.buyConsumable(purchaseParam: param);

//       _hasPendingPurchase = true;
//     } catch (e) {
//       showInSnackBar(context: context, message: "Purchase failed: $e");
//     }
//   }

//   @override
//   void dispose() {
//     _streamSubscription.cancel();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("In-app Purchase"),
//       ),
//       body: Center(
//         child: TextButton(
//           onPressed: () {
//             _buy();
//           },
//           child: Text("Pay"),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:clc_app/resources/alert_view.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});
  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  final InAppPurchase _iap = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> _products = [];
  bool _hasPendingPurchase = false;
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
  }

  Future<void> _handlePurchaseUpdates(List<PurchaseDetails> purchases) async {
    final prefs = await SharedPreferences.getInstance();

    for (final purchase in purchases) {
      if (purchase.status == PurchaseStatus.pending) {
        _hasPendingPurchase = true;
        _pendingPurchase = purchase;
      } else if (purchase.status == PurchaseStatus.purchased ||
          purchase.status == PurchaseStatus.restored) {
        _hasPendingPurchase = false;
        _pendingPurchase = null;

        if (_productIds.contains(purchase.productID)) {
          await prefs.setBool('isSubscribed', true);
          setState(() => _isSubscribed = true);
        }
        await _iap.completePurchase(purchase);
        if (!mounted) return;
        showInSnackBar(
            context: context, message: "Purchase ${purchase.productID}");
      } else if (purchase.status == PurchaseStatus.canceled) {
        _hasPendingPurchase = false;
        // _pendingPurchase = null;
        await _iap.completePurchase(_pendingPurchase!);
        if (!mounted) return;
        showInSnackBar(context: context, message: "Purchase Cancelled!");
      } else if (purchase.status == PurchaseStatus.error) {
        _hasPendingPurchase = false;
        _pendingPurchase = null;
        if (!mounted) return;
        showInSnackBar(context: context, message: "Purchase Error!");
      }
    }
  }

  void _buy(ProductDetails product) {
    // if (_hasPendingPurchase) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text("Transaction in progress."),
    //       action: SnackBarAction(
    //         label: "Retry Now",
    //         onPressed: () async {
    //           if (_pendingPurchase != null) {
    //             _hasPendingPurchase = false;
    //             await _iap.completePurchase(_pendingPurchase!);
    //           }
    //         },
    //       ),
    //     ),
    //   );
    //   return;
    // }

    final param = PurchaseParam(productDetails: product);
    _iap.buyNonConsumable(purchaseParam: param);
    _hasPendingPurchase = true;
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  Widget buildCard({
    required String title,
    required String price,
    required String renewalText,
    required VoidCallback onTap,
    String? originalPrice,
    bool highlight = false,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (highlight)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(20)),
                child: const Text("TOP CHOICE",
                    style: TextStyle(color: Colors.white)),
              ),
            const SizedBox(height: 8),
            Text(title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 4),
            if (originalPrice != null)
              Text(originalPrice,
                  style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.red,
                      fontSize: 14)),
            Text(price, style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text("Subscribe now"),
            ),
            const SizedBox(height: 4),
            Text(renewalText,
                style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
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
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title:
            Text(_isSubscribed ? "You're Subscribed!" : "Subscription Plans"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isSubscribed)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Thank you for subscribing!",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              )
            else ...[
              if (weekly != null)
                buildCard(
                  title: "ChowLucky Plus Weekly",
                  price: "\$0.88",
                  renewalText: "Renews \$1.88 per week",
                  onTap: () => _buy(weekly),
                ),
              if (special != null)
                buildCard(
                  title: "ChowLucky Plus Special",
                  price: "\$38.88",
                  originalPrice: "\$48.88",
                  renewalText: "Renews at \$48.88 every 6 months",
                  onTap: () => _buy(special),
                ),
              if (annual != null)
                buildCard(
                  title: "ChowLucky Plus Annual",
                  price: "\$58.88",
                  originalPrice: "\$97.76",
                  renewalText: "Renews \$78 per year",
                  onTap: () => _buy(annual),
                  highlight: true,
                ),
            ]
          ],
        ),
      ),
    );
  }
}

// helper extension for null-safe lookup
extension FirstWhereOrNull on List<ProductDetails> {
  ProductDetails? firstWhereOrNull(bool Function(ProductDetails) test) {
    for (var item in this) {
      if (test(item)) return item;
    }
    return null;
  }
}
