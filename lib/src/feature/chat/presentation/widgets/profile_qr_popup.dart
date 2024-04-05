part of '../pages/user_chat_profile.dart';

class ProfileQRPopup extends StatelessWidget {
  const ProfileQRPopup({super.key,required this.qrData});
  final String qrData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GlassMophicEffect(
          child: Container(
            
            padding: const EdgeInsets.all(8),
            child: QrImageView(
              
              data: qrData,
              version: QrVersions.auto,
              size: 200.0,
            ),
          ),
        ),
      ],
    );
  }
}
