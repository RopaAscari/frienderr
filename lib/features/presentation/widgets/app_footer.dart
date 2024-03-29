import 'package:flutter/material.dart';

class AppFooter extends StatelessWidget {
  final Widget child;
  const AppFooter({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 120),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50,
              // margin: const EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(2.0, 2.0), // shadow direction: bottom right
                  )
                ],
                border: Border(
                  top: BorderSide(width: 0.5, color: Colors.grey[900]!),
                ),
              ),
              child: child,
            )));
  }
}
