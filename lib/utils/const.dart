class AppString{
  static const email = "E-mail";
  static const String enterValidEmail = "Enter a valid email";
  static RegExp emailRegexp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static const password = "Password";
  static const String passWordMustBeAtLeast =
      "Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character";
static RegExp passRegexp =
  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.{8,}$)');
  static const createAccount = "Create Account";
  static const fullName = "Full name";
  static const String fieldCantBeEmpty = "Field can't be empty";
  static const String enterAValidName = "Enter a valid name";

}