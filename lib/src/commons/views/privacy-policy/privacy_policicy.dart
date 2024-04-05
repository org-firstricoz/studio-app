// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod_base/src/commons/widgets/simple_app_bar.dart';

import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:go_router/go_router.dart';

class PrivacyPolicyView extends StatefulWidget {
  static String routePath = '/privacy-policy';
  const PrivacyPolicyView({super.key});

  @override
  State<PrivacyPolicyView> createState() => _PrivacyPolicyViewState();
}

class _PrivacyPolicyViewState extends State<PrivacyPolicyView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorAssets.white,
        appBar: 
        SimpleAppBar(
  title: "Privacy Policy",
  leadingCallback: () => Navigator.pop(context),
),

         body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  policy.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  policy.subtitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final data = policy.privacyPolicyKeys[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 15),
                        Text(
                          data.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        for (final i in data.keyPoints)
                          RichText(
                            text: TextSpan(
                              text: '',
                              style: TextStyle(
                                color: ColorAssets.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                TextSpan(
                                  text: '${i.keys.first}: ',
                                  style: const TextStyle(
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      height: 1.25),
                                ),
                                TextSpan(
                                    text: i.values.first,
                                    style: const TextStyle(
                                        letterSpacing: 0.4,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        height: 1.25)),
                              ],
                            ),
                          )
                      ],
                    );
                  },
                  itemCount: policy.privacyPolicyKeys.length,
                )
                //
              ],
            ),
          ),
        ));
  }

  PrivacyPolicy policy = PrivacyPolicy(
      title: 'Last Updated: [08-09-2023]',
      subtitle:
          'Welcome to the "Studio on Rent" app, created to help users find and book studio spaces.Your privacy is important to us, and we are committed to protecting your personal information. This Privacy Policy explains how we collect, use, and safeguard your data.',
      privacyPolicyKeys: [
        PrivacyPolicyKey(title: 'Information We Collect:', keyPoints: [
          {
            'Personal Information':
                'We collect the information you provide during registration, such as your name, email address, and phone number.'
          },
          {
            'Booking Data':
                'We collect data related to your studio bookings, including dates, times, and payment information.'
          },
          {
            'Device Information':
                'We may collect information about your device, such as the type of device, operating system, and  unique device identifiers.'
          }
        ]),
        PrivacyPolicyKey(title: 'How We Use Your Information:', keyPoints: [
          {
            'Booking Services':
                'We use your information to facilitate studio bookings, including communicating with studio owners and processing payments.'
          },
          {
            'Improving Services':
                'We analyze data to enhance our app\'s functionality, user experience, and customer support.'
          },
          {
            'Communication':
                'We may send you updates,notifications, and promotional content  related to studio bookings.'
          }
        ])
      ]);
}

class PrivacyPolicy {
  final String title;
  final String subtitle;
  final List<PrivacyPolicyKey> privacyPolicyKeys;
  PrivacyPolicy({
    required this.title,
    required this.subtitle,
    required this.privacyPolicyKeys,
  });
}

class PrivacyPolicyKey {
  final String title;
  List<Map<String, String>> keyPoints;
  PrivacyPolicyKey({
    required this.title,
    required this.keyPoints,
  });
}
