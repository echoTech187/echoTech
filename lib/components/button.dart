import 'package:echo_tech/utils/extention/text.dart';
import 'package:flutter/material.dart';

import '../utils/style/button.dart';

enum PlatformType { login, register }

class PrimaryButton extends StatelessWidget {
  final BuildContext context;
  final String label;
  final Function() onPress;

  const PrimaryButton(
      {super.key,
      required this.context,
      required this.label,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      elevation: 6,
      shadowColor: Colors.black45,
      child: FilledButton(
        onPressed: onPress,
        style: loginButtonStyle(context),
        child: Text(label),
      ),
    );
  }
}

class SocialMediaButton extends StatelessWidget {
  final PlatformType platformType;
  final String platform;
  final Function() onTap;

  const SocialMediaButton({
    super.key,
    required this.platformType,
    required this.platform,
    required this.onTap,
  });

  Widget getLabel(PlatformType platformType, String platform) {
    String status = "";
    switch (platformType) {
      case PlatformType.login:
        status = "Masuk";
      case PlatformType.register:
        status = "Daftar";
      default:
        status = "";
    }
    platform = platform.capitalize();
    return Text(
      "$status dengan $platform",
      style: const TextStyle(fontSize: 14),
    );
  }

  Widget imagePlatform(String platform) {
    platform = platform.toLowerCase();
    return SizedBox(
        width: 24,
        height: 24,
        child: Image(
          image: AssetImage("public/assets/icons/$platform.png"),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SocialMediaLayout(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            imagePlatform(platform),
            const SizedBox(
              width: 12,
            ),
            getLabel(platformType, platform),
          ],
        ),
      ),
    );
  }
}

class SocialMediaLayout extends StatelessWidget {
  final Widget child;

  const SocialMediaLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black12,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: 24,
        child: child,
      ),
    );
  }
}
