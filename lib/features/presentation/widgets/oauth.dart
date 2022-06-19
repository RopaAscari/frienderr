import 'package:flutter/material.dart';
import 'package:frienderr/core/services/services.dart';
import 'package:frienderr/core/constants/constants.dart';

enum OAuthType { google, apple, facebook }

class OAuthItems {
  String icon;
  OAuthType type;
  OAuthItems({
    required this.icon,
    required this.type,
  });
}

final oAuthItems = [
  OAuthItems(icon: Constants.googleIcon, type: OAuthType.google),
  OAuthItems(icon: Constants.appleIconWhite, type: OAuthType.apple),
  OAuthItems(icon: Constants.facebookIcon, type: OAuthType.facebook),
];

class OAuthHandler extends StatelessWidget {
  final Function(OAuthType) onSelected;
  const OAuthHandler({Key? key, required this.onSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: oAuthItems
            .map<Widget>(
              (oAuth) => MaterialButton(
                height: 60,
                minWidth: 60,
                onPressed: () {
                  onSelected(oAuth.type);
                },
                color: HexColor('#9C9C9C').withOpacity(0.1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: Colors.grey[900]!)),
                child: Image.asset(oAuth.icon, height: 25, width: 25),
              ),
            )
            .toList(),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      width: MediaQuery.of(context).size.width * .45,
    );
  }
}