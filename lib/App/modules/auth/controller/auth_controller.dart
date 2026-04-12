import 'package:get/get.dart';

class AuthController extends GetxController {
  var isSignIn = false.obs; // Set to false to show Sign Up by default if needed
  var obscurePassword = true.obs;
  var obscureConfirmPassword = true.obs;

  void toggleAuthMode() => isSignIn.value = !isSignIn.value;
  void togglePasswordVisibility() => obscurePassword.value = !obscurePassword.value;
  void toggleConfirmPasswordVisibility() => obscureConfirmPassword.value = !obscureConfirmPassword.value;
}
