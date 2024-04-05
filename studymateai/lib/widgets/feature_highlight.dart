import 'package:flutter/material.dart';

class FeatureHighlight extends StatelessWidget {
  final Widget target;
  final String message;

  const FeatureHighlight({Key? key, required this.target, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      child: target,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(4),
      ),
      textStyle: const TextStyle(color: Colors.white),
      showDuration: const Duration(seconds: 10),
    );
  }
}
