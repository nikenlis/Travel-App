import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TextFailure extends StatelessWidget {
  final String message;
  const TextFailure({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
      ),
    );
  }
}