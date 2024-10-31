import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'utilities/validators.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final TextEditingController nameController = TextEditingController();

  String? value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(value ?? "Hello this is for testing"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              controller: nameController,
              validator: validateName,
              key: ValueKey("nameField"),
              onChanged: (value) {
                this.value = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Your Name Here",
                contentPadding: EdgeInsets.symmetric(horizontal: 4),
              ),
            ),
          ),
          MaterialButton(
            key: const ValueKey("btn"),
            onPressed: () {
              if (kDebugMode) {
                setState(() {
                  value = "Button is Pressed";
                });
              }
            },
            child: const Text("Submit Query"),
          )
        ],
      ),
    );
  }
}
