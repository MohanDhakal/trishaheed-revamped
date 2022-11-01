import 'dart:html';

import 'package:flutter/material.dart';
import 'package:trishaheed/utilities/textstyles.dart';

class ComplaintForm extends StatelessWidget {
  const ComplaintForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController complaintController = TextEditingController();

    return SizedBox(
      width: 500,
      child: Material(
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: TextFormField(
                  controller: nameController,
                  validator: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Your Name Here",
                    contentPadding: EdgeInsets.symmetric(horizontal: 5),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: TextFormField(
                  controller: phoneController,
                  validator: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Your Phone Number Here",
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Your Email Here",
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: TextFormField(
                  controller: complaintController,
                  validator: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Your Message Here",
                  ),
                  maxLines: 10,
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "SUBMIT YOUR QUERY",
                      style: CustomTextStyle.button(context),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
