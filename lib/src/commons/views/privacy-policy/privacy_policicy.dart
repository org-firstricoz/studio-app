// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod_base/src/commons/widgets/simple_app_bar.dart';

import 'package:flutter_riverpod_base/src/res/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:html_viewer_elite/html_viewer_elite.dart';

class PrivacyPolicyView extends StatefulWidget {
  static String routePath = '/privacy-policy';
  const PrivacyPolicyView({super.key});

  @override
  State<PrivacyPolicyView> createState() => _PrivacyPolicyViewState();
}

class _PrivacyPolicyViewState extends State<PrivacyPolicyView> {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
        backgroundColor: color.surface,
        appBar: SimpleAppBar(
          title: "Privacy Policy",
          leadingCallback: () => Navigator.pop(context),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Html(data: """
LAST UPDATED AT- 31-05-2024
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Privacy Policy</title>
</head>

<body>
    <h1>Privacy Policy for Book My Studio- Studio Rentals</h1>

    <p>At Book My Studio- Studio Rentals, one of our main priorities is the privacy of our visitors. This Privacy Policy
        document contains types of information that is collected and recorded by Book My Studio- Studio Rentals and how
        we use it.</p>

    <p>If you have additional questions or require more information about our Privacy Policy, do not hesitate to contact
        us.</p>

    <h2>Log Files</h2>

    <p>Book My Studio- Studio Rentals follows a standard procedure of using log files. These files log visitors when
        they use app. The information collected by log files include internet protocol (IP) addresses, browser type,
        Internet Service Provider (ISP), date and time stamp, referring/exit pages, and possibly the number of clicks.
        These are not linked to any information that is personally identifiable. The purpose of the information is for
        analyzing trends, administering the app, tracking users' movement on the app, and gathering demographic
        information.</p>
    <h2>Privacy Policies</h2>

    <P>You may consult this list to find the Privacy Policy for each of the advertising partners of Book My Studio-
        Studio Rentals.</p>

    <p>Third-party ad servers or ad networks uses technologies like cookies, JavaScript, or Beacons that are used in
        their respective advertisements and links that appear on Book My Studio- Studio Rentals. They automatically
        receive your IP address when this occurs. These technologies are used to measure the effectiveness of their
        advertising campaigns and/or to personalize the advertising content that you see on this app or other apps or
        websites.</p>

    <p>Note that Book My Studio- Studio Rentals has no access to or control over these cookies that are used by
        third-party advertisers.</p>

    <h2>Third Party Privacy Policies</h2>

    <p>Book My Studio- Studio Rentals's Privacy Policy does not apply to other advertisers or websites. Thus, we are
        advising you to consult the respective Privacy Policies of these third-party ad servers for more detailed
        information. It may include their practices and instructions about how to opt-out of certain options.</p>

    <h2>Children's Information</h2>

    <p>Another part of our priority is adding protection for children while using the internet. We encourage parents and
        guardians to observe, participate in, and/or monitor and guide their online activity.</p>

    <p>Book My Studio- Studio Rentals does not knowingly collect any Personal Identifiable Information from children
        under the age of 13. If you think that your child provided this kind of information on our App, we strongly
        encourage you to contact us immediately and we will do our best efforts to promptly remove such information from
        our records.</p>

    <h2>Online Privacy Policy Only</h2>

    <p>This Privacy Policy applies only to our online activities and is valid for visitors to our App with regards to
        the information that they shared and/or collect in Book My Studio- Studio Rentals. This policy is not applicable
        to any information collected offline or via channels other than this app. </p>
    <h2>Permissions</h2>
    <dl>
    
    <dt>Location Permissions</dt>
    <dd>Here, we access users location to suggest them studios near them . We store their location , specifically their
        Districts name in our mongodb database and fetches the studios based on api request from our server </dd>
    </dl>
    <h2>Consent</h2>

    <p>By using our app, you hereby consent to our Privacy Policy and agree to its Terms and Conditions.</p>
</body>

</html>

""")

                // Text(
                //   policy.title,
                //   style: const TextStyle(
                //     fontWeight: FontWeight.w600,
                //     fontSize: 16,
                //   ),
                // ),
                // const SizedBox(height: 10),
                // Text(
                //   policy.subtitle,
                //   style: const TextStyle(
                //     fontWeight: FontWeight.w400,
                //     fontSize: 16,
                //   ),
                // ),

                // const SizedBox(height: 10),
                // ListView.builder(
                //   shrinkWrap: true,
                //   physics: const NeverScrollableScrollPhysics(),
                //   itemBuilder: (context, index) {
                //     final data = policy.privacyPolicyKeys[index];
                //     return Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         SizedBox(height: 15),
                //         Text(
                //           data.title,
                //           style: const TextStyle(
                //             fontWeight: FontWeight.w600,
                //             fontSize: 16,
                //           ),
                //         ),
                //         const SizedBox(height: 10),
                //         for (final i in data.keyPoints)
                //           RichText(
                //             text: TextSpan(
                //               text: '',
                //               style: TextStyle(
                //                 color: ColorAssets.black,
                //                 fontSize: 14,
                //                 fontWeight: FontWeight.w600,
                //               ),
                //               children: [
                //                 TextSpan(
                //                   text: '${i.keys.first}: ',
                //                   style: TextStyle(
                //                       color: color.secondary,
                //                       letterSpacing: 0.4,
                //                       fontWeight: FontWeight.w600,
                //                       fontSize: 16,
                //                       height: 1.25),
                //                 ),
                //                 TextSpan(
                //                     text: i.values.first,
                //                     style: TextStyle(
                //                         color: color.secondary,
                //                         letterSpacing: 0.4,
                //                         fontWeight: FontWeight.w400,
                //                         fontSize: 16,
                //                         height: 1.25)),
                //               ],
                //             ),
                //           )
                //       ],
                //     );
                //   },
                //   itemCount: policy.privacyPolicyKeys.length,
                // )
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
