import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:trishaheed/repository/contacts_repo.dart';
import 'package:trishaheed/utilities/textstyles.dart';
import 'package:trishaheed/utilities/validators.dart';
import '../utilities/loading_dialog.dart';

class ComplaintForm extends StatefulWidget {
  ComplaintForm({Key? key}) : super(key: key);

  @override
  State<ComplaintForm> createState() => _ComplaintFormState();
}

class _ComplaintFormState extends State<ComplaintForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController complaintController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)
          ? width
          : width * 0.5,
      child: Material(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: TextFormField(
                  controller: nameController,
                  validator: validateName,
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
                  validator: validatePhone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Your Phone Number Here",
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: TextFormField(
                  controller: emailController,
                  validator: validateEmail,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Your Email Here",
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: TextFormField(
                  controller: complaintController,
                  validator: validateDescription,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Your Message Here",
                  ),
                  maxLines: 10,
                ),
              ),
              SizedBox(height: 10),
              MaterialButton(
                onPressed: () async {
                  final validated = _formKey.currentState?.validate() ?? false;
                  if (validated) {
                    showLoadingDialog(context);
                    final response = await ContactRepo().addFeedback({
                      "name": nameController.text,
                      "email": emailController.text,
                      "message": complaintController.text,
                      "phone_number": phoneController.text,
                    });
                    if (response == null) {
                      Navigator.pop(context);
                      showErrorDialog(context, "Error Occured");
                    } else {
                      print("came here");
                      _formKey.currentState?.reset();
                      Navigator.pop(context);
                      showSuccessDialog(context, response);
                    }
                  }
                },
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
