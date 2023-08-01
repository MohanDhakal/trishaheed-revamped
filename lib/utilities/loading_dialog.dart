import 'package:flutter/material.dart';

void showLoadingDialog(context) {
  showDialog(
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Loading..."),
        content: SizedBox(
          height: 50,
          width: 50,
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          ),
        ),
      );
    },
    context: context,
  );
}

void showErrorDialog(context, String? message) {
  showDialog(
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Error Occured!!!"),
        content: SizedBox(
          height: 80,
          width: 100,
          child: Column(
            children: [
              message != null ? Text(message) : SizedBox(),
              SizedBox(height: 8),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.blue,
                child: Text("Okay"),
              ),
            ],
          ),
        ),
      );
    },
    context: context,
  );
}

void showSuccessDialog(context, String? successMsg) {
  showDialog(
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Request Sucessfull!"),
        content: SizedBox(
          height: 80,
          width: 100,
          child: Column(
            children: [
              successMsg != null ? Text(successMsg) : SizedBox(),
              SizedBox(height: 8),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.blue,
                child: Text("Okay"),
              ),
            ],
          ),
        ),
      );
    },
    context: context,
  );
}
