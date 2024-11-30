import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:trishaheed/features/auth/model/Teacher.dart';
import 'package:trishaheed/features/auth/viewmodel/auth/login/login_cubit.dart';
import '../../../routes.dart';
import '../../model/Student.dart';
import '../../model/grade.dart';
import '../widgets/customformfeild.dart';

enum LoginType { student, teacher }

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController studentPasswordController =
      TextEditingController();
  final TextEditingController teacherPasswordController =
      TextEditingController();
  LoginType type = LoginType.teacher;

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    return BlocProvider<LoginCubit>(
      create: (BuildContext context) {
        loginCubit.getTeachers();
        loginCubit.getGrades();
        return loginCubit;
      },
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
   
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Login",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            body: Form(
              key: _formKey,
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(height: 16.sp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              type = LoginType.teacher;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "Teacher",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        color: type == LoginType.teacher
                                            ? Colors.purple
                                            : null),
                              ),
                              Container(
                                  height: 2, width: 16, color: Colors.grey),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              type = LoginType.student;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "Student",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      color: type == LoginType.student
                                          ? Colors.purple
                                          : null,
                                    ),
                              ),
                              Container(
                                height: 2,
                                width: 16,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.sp),
                    type == LoginType.student
                        ? Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              // Rounding the corners
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<Grade>(
                                hint: Text("Select Grade"),
                                value: state.grade,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                isExpanded: true,
                                dropdownColor: Colors.white,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                borderRadius: BorderRadius.circular(25),
                                onChanged: loginCubit.setSelectedGrade,
                                items: loginCubit.grades
                                    .map<DropdownMenuItem<Grade>>(
                                  (Grade value) {
                                    return DropdownMenuItem<Grade>(
                                      value: value,
                                      child: Text(value.name),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          )
                        : SizedBox(),
                    SizedBox(height: 8.sp),
                    type == LoginType.student
                        ? Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              // Rounding the corners
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<Student>(
                                hint: Text("Select Student Name"),
                                value: state.student,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                isExpanded: true,
                                dropdownColor: Colors.white,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                borderRadius: BorderRadius.circular(25),
                                onChanged: loginCubit.setSelectedStudent,
                                items: loginCubit.students
                                    .map<DropdownMenuItem<Student>>(
                                  (Student value) {
                                    return DropdownMenuItem<Student>(
                                      value: value,
                                      child: Text(value.name),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              // Rounding the corners
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<Teacher>(
                                hint: Text("Select Teacher Name"),
                                value: state.teacher,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                isExpanded: true,
                                dropdownColor: Colors.white,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                borderRadius: BorderRadius.circular(25),
                                onChanged: loginCubit.setSelectedTeacher,
                                items: loginCubit.teachers
                                    .map<DropdownMenuItem<Teacher>>(
                                  (Teacher value) {
                                    return DropdownMenuItem<Teacher>(
                                      value: value,
                                      child: Text(value.name),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ),
                    SizedBox(height: 8.sp),
                    type == LoginType.student
                        ? CustomFormField(
                            controller: studentPasswordController,
                            hintText: "Enter Your Secret Code/Password",
                            isPassword: true,
                            labelText: "Secret Code",
                            symmetricPadding: EdgeInsets.symmetric(
                                vertical: 8.sp, horizontal: 8.sp),
                            validator: loginCubit.validatePassword,
                          )
                        : CustomFormField(
                            controller: teacherPasswordController,
                            hintText: "Enter Your Secret Code/Password",
                            isPassword: true,
                            labelText: "Secret Code",
                            symmetricPadding: EdgeInsets.symmetric(
                                vertical: 8.sp, horizontal: 8.sp),
                            validator: loginCubit.validatePassword,
                          ),
                    BlocListener<LoginCubit, LoginState>(
                      listener: (context, state) {
                        if (state is LoginComplete) {
                          Navigator.of(context, rootNavigator: true)
                              .pop(); // Close the dialog explicitly
                          Navigator.pushNamedAndRemoveUntil(context,
                              Routes.home, (Route<dynamic> route) => false);
                        } else if (state is LoginLoading) {
                          // print("logging in");
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
                        } else if (state is LoginFailure) {
                          Navigator.of(context, rootNavigator: true).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                state.authfailure?.message ??
                                    " Unexpected Error Occured ",
                              ),
                            ),
                          );
                        } else {
                          print("Undefined State");
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
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.resolveWith<Color>(
                                    (Set<WidgetState> states) {
                                      // Use the primary color for the default state
                                      if (states
                                          .contains(WidgetState.disabled)) {
                                        // Use a lighter color when the button is disabled
                                        return Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(0.5);
                                      }
                                      return Theme.of(context)
                                          .colorScheme
                                          .primary;
                                    },
                                  ),
                                ),
                                onPressed: () {
                                  if (type == LoginType.teacher) {
                                    loginCubit.submitLoginForm(
                                        teacherPasswordController.text);
                                  } else {
                                    loginCubit.submitLoginForm(
                                        studentPasswordController.text);
                                  }
                                },
                                child: Text(
                                  type == LoginType.student
                                      ? "Login as Student"
                                      : "Login as Teacher",
                                ),
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
      ),
    );
  }
}
