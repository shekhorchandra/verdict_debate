import 'package:get/get.dart';

class AuthController extends GetxController {
  var isSignIn = false.obs;
  var obscurePassword = true.obs;
  var obscureConfirmPassword = true.obs;

  // NEW: State for terms and conditions
  var isAgreed = false.obs;

  void toggleAuthMode() => isSignIn.value = !isSignIn.value;
  void togglePasswordVisibility() => obscurePassword.value = !obscurePassword.value;
  void toggleConfirmPasswordVisibility() => obscureConfirmPassword.value = !obscureConfirmPassword.value;

  void toggleAgreed(bool? value) => isAgreed.value = value ?? false;
}