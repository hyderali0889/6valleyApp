import 'package:geniouscart/Theme/Themes.dart';
import 'package:geniouscart/main.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';

class OfflineStatus extends StatefulWidget {
  Widget child;

  OfflineStatus({this.child});

  @override
  _OfflineStatusState createState() => _OfflineStatusState();
}

class _OfflineStatusState extends State<OfflineStatus> {
  @override
  Widget build(BuildContext context) {
    return ConnectivityWidgetWrapper(
        disableInteraction: false,
        alignment: Alignment.bottomCenter,
        offlineWidget: Container(
          color: Themes.TextField_Error_Color,
          width: mainWidth,
          padding: EdgeInsets.all(5),
          child: Text(language.Offline,textAlign: TextAlign.center,),
        ),
        child: widget.child
    );
  }
}
