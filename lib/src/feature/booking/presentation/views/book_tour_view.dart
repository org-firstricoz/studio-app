import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/commons/widgets/simple_app_bar.dart';
import 'package:flutter_riverpod_base/src/core/models/studio_details.dart';
import 'package:flutter_riverpod_base/src/core/user.dart';
import 'package:flutter_riverpod_base/src/feature/booking/domain/usecase/requesting_schedule.dart';
import 'package:flutter_riverpod_base/src/feature/booking/presentation/bloc/booking_bloc.dart';
import 'package:flutter_riverpod_base/src/feature/booking/presentation/views/tour_request_view.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:flutter_riverpod_base/src/utils/custom_extension_methods.dart';

import 'package:flutter_riverpod_base/src/utils/custom_text_button.dart';
import 'package:flutter_riverpod_base/src/utils/form_text_field.dart';
import 'package:flutter_riverpod_base/src/utils/widgets/customElevatedContainer.dart';
import 'package:go_router/go_router.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../home/presentation/view/home.dart';

class BookingTourView extends StatefulWidget {
  static String routePath = '/booking-tour';
  final StudioDetails studioDetails;
  final TimeOfDay time;
  final DateTime date;

  const BookingTourView(
      {super.key,
      required this.studioDetails,
      required this.time,
      required this.date});

  @override
  State<BookingTourView> createState() => _BookingTourViewState();
}

class _BookingTourViewState extends State<BookingTourView> {
  final Razorpay _razorpay = Razorpay();

  @override
  void initState() {
    super.initState();
    print('object');
  }

 
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: color.surface,
      appBar: SimpleAppBar(
        title: "Book Tour",
        leadingCallback: () => context.pushReplacement(HomeView.routePath),
      ),
      body: BlocListener<BookingBloc, BookingState>(
        listener: (context, state) {
         
          if (state is OrderSuccessState) {
             _handlePaymentSuccess(PaymentSuccessResponse response) {
    context.read<BookingBloc>().add(PaymentEvent(data: {
          'userId': user.uuid,
          'studioId': widget.studioDetails.id,
          'orderId': state.options['id'],
          'paymentId': response.paymentId,
          'time': '${widget.time.hour}:${widget.time.minute}',
          'date': widget.date.toIso8601String(),
          
        }));
    context.push(TourRequestView.routePath, extra: {'date': widget.date});
  }

  _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(response.message.toString()),
      duration: const Duration(seconds: 5),
    ));
  }

  _handleExternalWallet(ExternalWalletResponse response) {}
            _razorpay.open(state.options);
            _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
            _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
            _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
          } else if (state is BookingFailure) {
            print(state.message);
            context.pushReplacement(HomeView.routePath);
          } else if (state is LoadingState) {
            showDialog(
                context: context,
                builder: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ));
          }
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Your Information Details',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              color: ColorAssets.blackFaded),
                        ),
                      ),
                      _buildFormFields(context),
                    ],
                  ),
                ),
              ),
            ),

            CustomElevatedContainer(
              buttonText: "Continue",
              onTap: () {
                context.read<BookingBloc>().add(RequestScheduleEvent(
                    requestParams: RequestParams(
                        description: widget.studioDetails.description,
                        name: widget.studioDetails.name,
                        amount: widget.studioDetails.rent,
                        time: widget.time,
                        date: widget.date,
                        userId: user.uuid,
                        studioId: widget.studioDetails.id)));
              },
            )
            // button
          ],
        ),
      ),
    );
  }

  // Map<String, Object> getPaymentOptions() {
  //   return {
  //     // 'key': AppSecrets.secretKey,
  //     // 'amount': widget.studioDetails.rent.toString(),
  //     // 'name': 'Booking Studio',
  //     // 'description': 'Fine T-Shirt',
  //     // 'retry': {'enabled': true, 'max_count': 1},
  //     // 'send_sms_hash': true,
  //     // 'prefill': {'contact': user.phoneNumber, 'email': user.email},
  //     // 'external': {
  //     //   'wallets': ['paytm']
  //     // }
  //     'key': AppSecrets.secretKey,
  //     'amount': 200,
  //     'name': 'Booking Studio',
  //     'description': 'Fine T-Shirt',
  //     'retry': {'enabled': true, 'max_count': 1},
  //     'send_sms_hash': true,
  //     'prefill': {
  //       'contact': user.phoneNumber,
  //       'email': user.email
  //     },
  //     'external': {
  //       'wallets': ['paytm']
  //     }
  //   };
}

_buildFormFields(BuildContext context) {
  final color = Theme.of(context).colorScheme;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 30),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FormTextField(
          labelText: "Name",
          hintText: "Enter your name",
          initialValue: user.name,
        ),
        FormTextField(
          labelText: "Email",
          hintText: "Enter mail here",
          initialValue: user.email,
        ),
        FormTextField(
            labelText: "Gender",
            child: DropdownButton(
              value: user.gender[0],
              underline: const SizedBox(),
              isExpanded: true,
              items: const [
                DropdownMenuItem(
                  value: 'f',
                  child: Text(
                    "Female",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: ColorAssets.blackFaded,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: "m",
                  child: Text(
                    "Male",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: ColorAssets.blackFaded,
                    ),
                  ),
                ),
              ],
              onChanged: (data) {},
            )),
        FormTextField(
          labelText: "Phone Number",
          hintText: '1235468790',
          initialValue: user.phoneNumber,
          prefixWidget: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton(
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: ColorAssets.blackFaded),
                  underline: const SizedBox(),
                  items: const [DropdownMenuItem(child: Text("+91"))],
                  onChanged: (val) {}),
              Container(
                margin: const EdgeInsets.only(left: 0, right: 4),
                height: 20,
                width: 2,
                color: ColorAssets.black,
              ),
            ],
          ),
        ),
        FormTextField(
          labelText: "Country",
          child: Container(
            height: 54,
            width: double.maxFinite,
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.only(left: 14, right: 14, top: 3),
            decoration: BoxDecoration(
              color: color.secondary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButton(
              value: 'I',
              underline: const SizedBox(),
              isExpanded: true,
              items: const [
                DropdownMenuItem(
                  value: 'I',
                  child: Text(
                    "India",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: ColorAssets.blackFaded,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: "U",
                  child: Text(
                    "US",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: ColorAssets.blackFaded,
                    ),
                  ),
                ),
              ],
              onChanged: (data) {},
            ),
          ),
        ),
      ],
    ).addSpacingBetweenElements(25),
  );
}

  //Handle Payment Responses

  // void handlePaymentErrorResponse(PaymentFailureResponse response) {
  //   /** PaymentFailureResponse contains three values:
  //   * 1. Error Code
  //   * 2. Error Description
  //   * 3. Metadata
  //   **/
  //   showAlertDialog(context, "Payment Failed",
  //       "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  // }

  // void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
  //   /** Payment Success Response contains three values:
  //   * 1. Order ID
  //   * 2. Payment ID
  //   * 3. Signature
  //   **/
  //   showAlertDialog(
  //       context, "Payment Successful", "Payment ID: ${response.paymentId}");
  // }

  // void handleExternalWalletSelected(ExternalWalletResponse response) {
  //   showAlertDialog(
  //       context, "External Wallet Selected", "${response.walletName}");
  // }

  // void showAlertDialog(BuildContext context, String title, String message) {
  //   // set up the buttons
  //   Widget continueButton = ElevatedButton(
  //     child: const Text("Continue"),
  //     onPressed: () {},
  //   );
  //   // set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     title: Text(title),
  //     content: Text(message),
  //   );
  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }

