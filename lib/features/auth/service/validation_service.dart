class ValidationService {
  static String? validateEmail(String email) {
    if (email.isEmpty) return 'Email cannot be empty';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) return 'Password cannot be empty';
    if (password.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  static String? validateName(String name) {
    if (name.isEmpty) return 'name cannot be empty';
    if (name.length < 6) return 'School name must be at least 6 characters';

    return null;
  }

  static String? validateCode(String code) {
    if (code.isEmpty) return 'code cannot be empty';
    if (code.length < 4) return 'Code must be at least 4 characters or digits';

    return null;
  }
}
