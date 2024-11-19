class AppString{
  static const welcomeBack = "Welcome Back !";
  static const pleaseEnterYour = "Please enter your email and password";
  static const email = "E-mail";
  static const String enterValidEmail = "Enter a valid email";
  static RegExp emailRegexp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static const enterYourEmail = "Enter Your Email";
  static const password = "Password";
  static const String passWordMustBeAtLeast =
      "Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character";
  static RegExp passRegexp =
  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.{8,}$)');
  static const String passwordLengthAndContain =
      "Password must be at least 8 characters long and at least one uppercase letter, one lowercase letter, one number";
  static const enterYourPassword = "Enter Your Password";
  static const signUp = "Sign Up";
  static const logIn = "Log In";
  static const dontHaveAnyAccount = "Don’t have any account?";
  static const createAccount = "Create Account";
  static const fullName = "Full name";
  static const String fieldCantBeEmpty = "Field can't be empty";
  static const String enterAValidName = "Enter a valid name";
  static const phoneNumber = "Phone Number";
  static const confirmPassword = "Confirm Password";
  static const alreadyHaveAnAccount = "already have an account?";
  static const checkYourEmail = "Check your email";
  static const wehaveSendAnOTP = "We have send an OTP to your email address";
  static const verifyCode = "Verify code";
}