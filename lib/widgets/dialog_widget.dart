import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String message;
  final Widget textFields;

  const CustomDialog({Key? key, required this.message , required this.textFields}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.blueGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),

            textFields ,

            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xFF6AD4CA),
                backgroundColor: Colors.white,
              ),
              child: const Text('close', style: TextStyle(color: Colors.black)),
            )
          ],
        ),
      ),
    );
  }
}

void showCustomDialog(BuildContext context, String message , Widget textField) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog(message: message , textFields: textField,);
    },
  );
}
