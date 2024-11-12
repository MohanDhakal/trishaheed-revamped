// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:trishaheed/features/auth/viewmodel/auth/school_registration_cubit.dart';
import 'package:trishaheed/features/auth/views/widgets/customformfeild.dart';
import 'package:trishaheed/features/routes.dart';

class SchoolRegistrationScreen extends StatefulWidget {
  SchoolRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<SchoolRegistrationScreen> createState() =>
      _SchoolRegistrationScreenState();
}

class _SchoolRegistrationScreenState extends State<SchoolRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  late SchoolRegistrationCubit registrationCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    registrationCubit = BlocProvider.of<SchoolRegistrationCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SchoolRegistrationCubit, SchoolRegistrationState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 8.h),
                  Text(
                    "School Registration Form",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  SizedBox(height: 4.h),
                  CustomFormField(
                    controller: nameController,
                    hintText: "Tri-Shaheed Model School",
                    labelText: "School Name",
                    symmetricPadding:
                        EdgeInsets.symmetric(vertical: 8.sp, horizontal: 8.sp),
                    validator: registrationCubit.validateName,
                  ),
                  CustomFormField(
                    controller: codeController,
                    hintText: "34002",
                    labelText: "School Code",
                    symmetricPadding:
                        EdgeInsets.symmetric(vertical: 8.sp, horizontal: 8.sp),
                    validator: registrationCubit.validateCode,
                  ),
                  SizedBox(height: 8),
                  BlocListener<SchoolRegistrationCubit,
                      SchoolRegistrationState>(
                    listener: (context, state) {
                      if (state is SchoolRegistrationComplete) {
                        Navigator.pushNamedAndRemoveUntil(context, Routes.home,
                            (Route<dynamic> route) => false);
                      } else if (state is SchoolRegistrationLoading) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => Material(
                            color: Colors.white,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        );
                      } else if (state is SchoolRegistrationFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(state.authfailure?.message ??
                                  " Unexpected Error Occured")),
                        );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.sp),
                            child: ElevatedButton(
                              onPressed: () {
                                var validated =
                                    _formKey.currentState?.validate();
                                if (validated ?? false) {
                                  registrationCubit.submitRegistrationForm(
                                      nameController.text, codeController.text);
                                }
                              },
                              child: Text("Submit"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
