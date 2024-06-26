import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod_base/src/commons/widgets/custom_list_tile.dart';
import 'package:flutter_riverpod_base/src/utils/custom_extension_methods.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:latlong2/latlong.dart';

class ContactUsTab extends StatefulWidget {
  const ContactUsTab({super.key});

  @override
  State<ContactUsTab> createState() => _ContactUsTabState();
}

class _ContactUsTabState extends State<ContactUsTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Container(
              height: 300,
              margin: const EdgeInsetsDirectional.symmetric(
                  horizontal: 15, vertical: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FlutterMap(
                  options: const MapOptions(
                    initialCenter: LatLng(18.4038, 83.3395),
                    initialZoom: 9.2,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    RichAttributionWidget(
                      attributions: [
                        TextSourceAttribution(
                          'OpenStreetMap contributors',
                          onTap: () => launchUrl(
                              Uri.parse('https://openstreetmap.org/copyright')),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          CustomListTile(
            onTap: () {},
            leadingIcon: const Icon(Icons.location_on),
            title: const Text("Company Name"),
            subtitle: const Text("123 Main Street, City, State, Zip Code"),
          ),
          CustomListTile(
            onTap: () {
              launchUrl(Uri.parse("tel:+1234567890"));
            },
            leadingIcon: const Icon(Icons.phone),
            title: const Text("Phone Number"),
            subtitle: const Text("+1 (234) 567-890"),
          ),
          CustomListTile(
            enableBottom: false,
            onTap: () async {
              const String subject = "Subject:";
              const String stringText = "Same Message:";
              String uri = 'mailto:administrator@gmail.com';
              // if (await canLaunchUrl(Uri.parse(uri))) {
              launchUrl(Uri.parse(uri));
              // } else {
              //   print("No email client found");
              // }
            },
            leadingIcon: const Icon(Icons.email),
            title: const Text("Email Address"),
            subtitle: const Text("info@example.com"),
          ),
          const Divider(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSocialMediaTile(
                imageUrl:
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/Facebook_Logo_2023.png/900px-Facebook_Logo_2023.png",
                title: "Facebook",
                url: "https://www.facebook.com/yourcompany",
              ),
              _buildSocialMediaTile(
                imageUrl:
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Instagram_logo_2022.svg/225px-Instagram_logo_2022.svg.png",
                title: "Instagram",
                url: "https://www.instagram.com/yourcompany",
              ),
              _buildSocialMediaTile(
                imageUrl:
                    "https://upload.wikimedia.org/wikipedia/commons/c/ce/Twitter_Logo.png",
                title: "Twitter",
                url: "https://twitter.com/yourcompany",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMediaTile(
      {required String imageUrl, required String title, required String url}) {
    return InkWell(
      onTap: () {
        launchUrl(Uri.parse(url));
      },
      child: Column(
        children: [
          Image.network(
            imageUrl,
            width: 50,
            height: 50,errorBuilder: (context, error, stackTrace) {
                        return SizedBox.expand();
                      },
          ),
          Text(title)
        ],
      ).addSpacingBetweenElements(10),
    );
  }

  void launchUrl(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      launchUrl(uri);
    } else {
      // Handle error
      if (kDebugMode) {
        print('Could not launch $uri');
      }
    }
  }
}
