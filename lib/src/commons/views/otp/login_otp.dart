import 'dart:async';

import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod_base/src/commons/views/location_access/location_access_page.dart';
import 'package:flutter_riverpod_base/src/commons/widgets/simple_app_bar.dart';
import 'package:flutter_riverpod_base/src/core/user.dart';
import 'package:flutter_riverpod_base/src/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_riverpod_base/src/feature/auth/presentation/pages/login_page.dart';
import 'package:flutter_riverpod_base/src/feature/auth/presentation/pages/sign_up_page.dart';
import 'package:flutter_riverpod_base/src/feature/home/presentation/view/home.dart';
import 'package:flutter_riverpod_base/src/feature/profile/views/complete_profile_info.dart';
import 'package:flutter_riverpod_base/src/res/assets.dart';
import 'package:flutter_riverpod_base/src/utils/custom_extension_methods.dart';
import 'package:flutter_riverpod_base/src/utils/form_text_field.dart';
import 'package:go_router/go_router.dart';
import 'package:otp_fields/otp_fields.dart';
import 'package:otp_timer/otp_timer.dart';
import 'package:timer_button/timer_button.dart';

class LoginOtp extends StatefulWidget {
  static const routePath = '/login-otp';
  const LoginOtp({super.key});

  @override
  State<LoginOtp> createState() => _LoginOtpState();
}

class _LoginOtpState extends State<LoginOtp> {
  TextEditingController _controller = TextEditingController();
  String? smsOtp;
  bool requestedOtp = false;
  bool editable = false;
  Future<void> initSmsListener() async {
    String? commingSms;
    try {
      commingSms = await AltSmsAutofill().listenForSms;
    } on PlatformException {
      commingSms = 'Failed to get Sms.';
    }
    if (!mounted) return;

    setState(() {
      smsOtp = commingSms;
    });
  }

  @override
  void dispose() {
    AltSmsAutofill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(
        title: 'OTP',
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is AuthSuccess) {
            user = state.user;  
            context.go(HomeView.routePath);
          }
        },
        builder: (context, state) {
          return Form(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Icon(
                        Icons.home_filled,
                        size: 200,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 216, 216, 216),
                      ),
                      child: TextFormField(
                        controller: _controller,
                       maxLength: 10,
                        readOnly: editable,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                            hintText: 'phone number',
                            border: InputBorder.none,
                            disabledBorder: InputBorder.none),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        child: const Icon(Icons.edit),
                        onTap: () {
                          setState(() {
                            editable = false;
                            requestedOtp = false;
                          });
                        },
                      ),
                    ),
                    !requestedOtp
                        ? Container(
                            margin: const EdgeInsets.only(top: 30),
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [
                                  Color.fromARGB(255, 70, 155, 225),
                                  Color.fromARGB(255, 38, 127, 201),
                                  Colors.blue
                                ]),
                                borderRadius: BorderRadius.circular(20)),
                            child: TextButton(
                                onPressed: () async {
                                  final value = _controller.text.trim();
                                  if (value.isNotEmpty) {
                                    print(value);
                                    requestedOtp = !requestedOtp;
                                    editable = true;
                                    context
                                        .read<AuthBloc>()
                                        .add(SendOtpEvent(emailOrPhone: value));

                                    setState(() {});
                                    await initSmsListener();
                                  }
                                },
                                child: const Text(
                                  'Send Otp',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                )),
                          )
                        : const SizedBox(
                            height: 30,
                          ),
                    requestedOtp
                        ? OtpFieldsCustom(
                            autofillOtp: smsOtp,
                            filledBorderColor:
                                const Color.fromARGB(255, 132, 145, 219),
                            context: context,
                            numberOfFields: 6,
                            onCodeChanged: (otp) {
                              if (state is OtpSuccessState) {
                                if (otp == state.otp) {
                                  userDetails.addAll(
                                      {'phoneNumber': _controller.text.trim()});
                                  newUser
                                      ? context
                                          .push(LocationAccessPage.routePath)
                                      : context.read<AuthBloc>().add(
                                          LoginWithOtpEvent(
                                              emailOrPhone:
                                                  _controller.text.trim()));
                                }
                              }
                            })
                        : const SizedBox(),
                    requestedOtp
                        ? Container(
                            margin: const EdgeInsets.only(top: 30),
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: TimerButton(
                                buttonType: ButtonType.textButton,
                                label: 'Resend Otp',
                                onPressed: () {
                                  final value = _controller.text.trim();
                                  context
                                      .read<AuthBloc>()
                                      .add(SendOtpEvent(emailOrPhone: value));

                                  setState(() {});
                                },
                                timeOutInSeconds: 25))
                        : const SizedBox.shrink(),
                    Image.asset(
                      ImageAssets.page3,
                      width: 290,
                      height: 477,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
