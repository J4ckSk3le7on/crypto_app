import 'package:flutter/material.dart';

enum SnackBarType {
  success,
  error
}

class _Utils {
  
  showSnackBar(BuildContext context, String text, SnackBarType type) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: type == SnackBarType.error ? Colors.red : Colors.green,
        content: Text(text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white
          ),
        )
      )
    );
  }

}

final utils = _Utils();