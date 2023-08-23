String? validateConfirmPassword(String? value1, String myCPass) {
  if (value1 != null) {
    if (value1.isNotEmpty && myCPass.isNotEmpty) {
      if (value1 != myCPass) {
        return "please type in the same password in both field";
      }
      return null;
    }
    return "Password cannot be empty";
  } else {
    return "Password not valid";
  }
}

String? validateEmail(String? value) {
  if (value != null) {
    if (value.isNotEmpty) {
      final bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value);
      if (emailValid) {
        return null;
      } else
        return "Email is not valid";
    } else {
      return "Email Cannot be empty";
    }
  } else {
    return "Email Can't be Empty";
  }
}

String? validatePhone(String? value) {
  if (value != null) {
    if (value.isNotEmpty) {
      String pattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
      RegExp regExp = RegExp(pattern);
      if (regExp.hasMatch(value)) {
        return null;
      } else {
        return "Not a valid phone number";
      }
    } else {
      return "Phone number feild cannot be empty";
    }
  } else {
    return "Phone Feild is required";
  }
}

String? validateName(String? value) {
  if (value != null) {
    if (value.isNotEmpty) {
      if (value.length <= 2) {
        return "name must contain 3 letters";
      } else {
        return null;
      }
    } else {
      return "Name Feild Cannot be empty";
    }
  } else {
    return "Name feild is required";
  }
}

String? validateDescription(String? value) {
  if (value == null)
    return "Nothing found";
  else {
    if (value.isEmpty)
      return "Please write something";
    else
      return null;
  }
}

String? validatePassword(String? value) {
  if (value != null) {
    if (value.isNotEmpty) {
      if (value.length < 5) {
        return "The length of the password must be greater than 5";
      }
      return null;
    }
    return "Password cannot be empty";
  } else {
    return "Password not valid";
  }
}
