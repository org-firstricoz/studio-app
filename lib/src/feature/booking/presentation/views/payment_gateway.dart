// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod_base/secrets/secrets.dart';
// import 'package:flutter_riverpod_base/src/core/user.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

// class PaymentGateway extends StatefulWidget {
//   const PaymentGateway({super.key, required this.amount});
//   static const String routePath = '/payment-gateway';
//   final num amount;
//   @override
//   State<PaymentGateway> createState() => _PaymentGatewayState();
// }

// class _PaymentGatewayState extends State<PaymentGateway> {
//   final TextEditingController keyController = TextEditingController();
//   final TextEditingController amountController = TextEditingController();
//   final TextEditingController orderIdController = TextEditingController();
//   final TextEditingController mobileNumberController = TextEditingController();

//   // TPV Key - rzp_test_5sHeuuremkiApj
//   //Non-TPV key - rzp_test_0wFRWIZnH65uny
//   //Checkout key - rzp_live_ILgsfZCZoFIKMb
//   String merchantKeyValue = "rzp_live_ILgsfZCZoFIKMb";
//   String amountValue = "100";
//   String orderIdValue = "";
//   String mobileNumberValue = "8888888888";

//   late Razorpay razorpay;

//   @override
//   void initState() {
//     razorpay = Razorpay();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('title'),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           child: Column(
//             children: [
//               RZPEditText(
//                 controller: keyController,
//                 textInputType: TextInputType.text,
//                 hintText: 'Enter Key',
//                 labelText: 'Merchant Key',
//               ),
//               RZPEditText(
//                 controller: amountController,
//                 textInputType: TextInputType.number,
//                 hintText: 'Enter Amount',
//                 labelText: 'Amount',
//               ),
//               RZPEditText(
//                 controller: orderIdController,
//                 textInputType: TextInputType.text,
//                 hintText: 'Enter Order Id',
//                 labelText: 'Order Id',
//               ),
//               RZPEditText(
//                 controller: mobileNumberController,
//                 textInputType: TextInputType.number,
//                 hintText: 'Enter Mobile Number',
//                 labelText: 'Mobile Number',
//               ),
//               Container(
//                 margin: EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
//                 child: Text(
//                   '* Note - In case of TPV the orderId is mandatory.',
//                   style: TextStyle(
//                     fontStyle: FontStyle.italic,
//                   ),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Expanded(
//                     child: RZPButton(
//                       widthSize: 200.0,
//                       onPressed: () {
//                         try {
//                           merchantKeyValue = keyController.text;
//                           amountValue = amountController.text;

//                           razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
//                               handlePaymentErrorResponse);
//                           razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
//                               handlePaymentSuccessResponse);
//                           razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
//                               handleExternalWalletSelected);
//                           razorpay.open(getPaymentOptions());
//                         } catch (e) {
//                           print(e);
//                         }
//                       },
//                       labelText: 'Standard Checkout Pay',
//                     ),
//                   ),
//                 ],
//               ),
//               RZPEditText(
//                 controller: mobileNumberController,
//                 textInputType: TextInputType.number,
//                 hintText: 'Enter Mobile Number',
//                 labelText: 'Mobile Number',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Map<String, Object> getPaymentOptions() {
//     return {
//       'key': merchantKeyValue,
//       'amount': 200,
//       'name': 'Booking Studio',
//       'description': 'Fine T-Shirt',
//       'retry': {'enabled': true, 'max_count': 1},
//       'send_sms_hash': true,
//       'order_id': 'order_DaZlswtdcn9UNV',
//       'prefill': {'contact': user.phoneNumber, 'email': user.email},
//       'external': {
//         'wallets': ['paytm']
//       }
//     };
//   }

//   //Handle Payment Responses

//   void handlePaymentErrorResponse(PaymentFailureResponse response) {
//     /** PaymentFailureResponse contains three values:
//     * 1. Error Code
//     * 2. Error Description
//     * 3. Metadata
//     **/
//     showAlertDialog(context, "Payment Failed",
//         "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
//   }

//   void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
//     /** Payment Success Response contains three values:
//     * 1. Order ID
//     * 2. Payment ID
//     * 3. Signature
//     **/
//     showAlertDialog(
//         context, "Payment Successful", "Payment ID: ${response.paymentId}");
//   }

//   void handleExternalWalletSelected(ExternalWalletResponse response) {
//     showAlertDialog(
//         context, "External Wallet Selected", "${response.walletName}");
//   }

//   void showAlertDialog(BuildContext context, String title, String message) {
//     // set up the buttons
//     Widget continueButton = ElevatedButton(
//       child: const Text("Continue"),
//       onPressed: () {},
//     );
//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       title: Text(title),
//       content: Text(message),
//     );
//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
// }

// class RZPButton extends StatelessWidget {
//   String labelText;
//   VoidCallback onPressed;
//   double widthSize = 100.0;

//   RZPButton(
//       {required this.widthSize,
//       required this.labelText,
//       required this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: widthSize,
//       height: 50.0,
//       margin: EdgeInsets.fromLTRB(12.0, 8.0, 8.0, 12.0),
//       child: ElevatedButton(
//         onPressed: onPressed,
//         child: Text(
//           labelText,
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//         style: ButtonStyle(
//           backgroundColor: MaterialStatePropertyAll(Colors.indigoAccent),
//         ),
//       ),
//     );
//   }
// }

// class RZPEditText extends StatelessWidget {
//   String hintText;
//   String labelText;
//   TextInputType textInputType;
//   TextEditingController controller;

//   RZPEditText(
//       {required this.textInputType,
//       required this.hintText,
//       required this.labelText,
//       required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(12.0),
//       padding: EdgeInsets.fromLTRB(16.0, 0, 0, 0),
//       decoration: BoxDecoration(
//         border: Border.all(),
//       ),
//       child: TextField(
//         controller: controller,
//         keyboardType: textInputType,
//         style: TextStyle(
//           color: Colors.black,
//         ),
//         decoration: InputDecoration(
//           border: InputBorder.none,
//           hintText: hintText,
//           labelText: labelText,
//         ),
//       ),
//     );
//   }
// }
