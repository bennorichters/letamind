import 'package:flutter/material.dart';
import 'package:letamind/keys.dart';

class TappableFlag extends StatelessWidget {
  const TappableFlag({
    @required this.languageCode,
    @required this.enabled,
    @required this.onTap,
  });
  final String languageCode;
  final bool enabled;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
      child: GestureDetector(
        key: Key(settings_language_prefix + languageCode),
        onTap: onTap,
        child: Opacity(
          opacity: enabled ? 1.0 : 0.3,
          child: Image.asset(
            'assets/lang/' + languageCode + '/flag40.png',
            width: 40.0,
            height: 40.0,
          ),
        ),
      ),
    );
  }
}

