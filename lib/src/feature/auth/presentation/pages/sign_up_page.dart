import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod_base/src/core/user.dart';
import 'package:flutter_riverpod_base/src/feature/auth/domain/usecase/use_cases.dart';
import 'package:flutter_riverpod_base/src/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_riverpod_base/src/feature/auth/presentation/pages/login_page.dart';
import 'package:flutter_riverpod_base/src/feature/auth/presentation/widgets/header_builder.dart';
import 'package:flutter_riverpod_base/src/feature/auth/presentation/widgets/social_login_buttons.dart';
import 'package:flutter_riverpod_base/src/res/assets.dart';
import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:flutter_riverpod_base/src/utils/custom_extension_methods.dart';

import 'package:flutter_riverpod_base/src/utils/custom_text_button.dart';
import 'package:flutter_riverpod_base/src/utils/form_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../commons/views/location_access/location_access_page.dart';

class SignUpPage extends StatelessWidget {
  static String routePath = '/signup-page';

  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailEditingController = TextEditingController();
    TextEditingController passwordEditingController = TextEditingController();
    TextEditingController nameEditingController = TextEditingController();
    TextEditingController confirmPasswordEditingController =
        TextEditingController();
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      // backgroundColor: ColorAssets.white,
      body: SafeArea(
        child: Center(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
              // TODO: implement listener
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AuthenticationPageHeaderBuilder(
                            title: "Sign Up", subtitle: "Create Your Account"),
                        _formFields(
                            nameTextEditingController: nameEditingController,
                            passwordEditingController:
                                passwordEditingController,
                            confirmPasswordTextEditingController:
                                confirmPasswordEditingController,
                            emailTextEditingController: emailEditingController),
                        CustomTextButton(
                            text: "Sign Up",
                            ontap: () {
                              if (_formKey.currentState!.validate()) {
                                userDetails.addAll({
                                  'name': nameEditingController.text.trim(),
                                  'email': emailEditingController.text.trim(),
                                  'password':
                                      passwordEditingController.text.trim()
                                });
                                
                                context.push(
                                  LocationAccessPage.routePath,
                                );
                              }
                            }),
                        SocialAuthenticationButtons(
                          widget: RichText(
                            text: TextSpan(
                                text: "Alredy have an account?",
                                style: textTheme.titleLarge!.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                children: [
                                  TextSpan(
                                    text: " Sign In",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        context.push(LoginPage.routePath);
                                      },
                                    style: textTheme.titleLarge!.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  )
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _formFields(
      {required TextEditingController passwordEditingController,
      required TextEditingController nameTextEditingController,
      required TextEditingController emailTextEditingController,
      required TextEditingController confirmPasswordTextEditingController}) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FormTextField(
            labelText: "Name",
            hintText: "Tara Choudhary",
            controller: nameTextEditingController,
          ),
          FormTextField(
            labelText: "Email",
            hintText: "example@gmail.com",
            controller: emailTextEditingController,
          ),
          FormTextField(
            labelText: "Password",
            enableObsecure: true,
            hintText: "* * * * * * * ",
            controller: passwordEditingController,
          ),
          FormTextField(
            labelText: "Confirm Password",
            enableObsecure: true,
            hintText: "* * * * * * * ",
            controller: confirmPasswordTextEditingController,
          ),
        ],
      ).addSpacingBetweenElements(15),
    );
  }
}
