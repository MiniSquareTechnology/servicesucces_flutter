import 'package:employee_clock_in/data/repository/auth_repository.dart';
import 'package:employee_clock_in/models/login_response_model.dart';
import 'package:employee_clock_in/res/custom_widgets/custom_dialogs.dart';
import 'package:employee_clock_in/res/utils/constants/app_string_constants.dart';
import 'package:employee_clock_in/res/utils/error/app_error.dart';
import 'package:employee_clock_in/res/utils/local_storage/app_preference_storage.dart';
import 'package:employee_clock_in/res/utils/logger/app_logger.dart';
import 'package:get/get.dart';

class AuthViewModel extends GetxController {
  AuthRepository authRepository = AuthRepository();

  /// login
  var passwordObscure = true.obs;

  bool get getPasswordObscureValue => passwordObscure.value;

  void updatePasswordObscureValue() {
    passwordObscure.value = !passwordObscure.value;
  }

  /// update password
  var oldPasswordObscureValue = true.obs;

  bool get getOldPasswordObscureValue => oldPasswordObscureValue.value;

  var newPasswordObscure = true.obs;

  bool get getNewPasswordObscureValue => newPasswordObscure.value;

  var confirmPasswordObscure = true.obs;

  bool get getConfirmPasswordObscureValue => confirmPasswordObscure.value;

  void updateOldPasswordObscureValue() {
    oldPasswordObscureValue.value = !oldPasswordObscureValue.value;
  }

  void updateNewPasswordObscureValue() {
    newPasswordObscure.value = !newPasswordObscure.value;
  }

  void updateConfirmPasswordObscureValue() {
    confirmPasswordObscure.value = !confirmPasswordObscure.value;
  }

  void resetValues() {
    passwordObscure.value = true;
    oldPasswordObscureValue.value = true;
    newPasswordObscure.value = true;
    newPasswordObscure.value = true;
    confirmPasswordObscure.value = true;
  }

  Future<bool> emailLogin(String email, String password) async {
    try {
      CustomDialogs.showLoadingDialog(Get.context!, "${AppStringConstants.loading}...");
      Map<String, String> params = {"email": email, "password": password};
      LoginResponseModel model = await authRepository.loginWithEmail(params);
      Get.back();
      if (model.statusCode! == 200) {
        saveLoginUserData(model);
        return true;
      } else {
        return false;
      }
    } on AppError catch (exception) {
      Get.back();
      AppLogger.logMessage("------>>>> ${exception.code}");
      showErrorDialog(exception.message);
      return false;
    }
  }

  Future<bool> changePassword(
      String oldPass, String newPass, String conformPass) async {
    try {
      CustomDialogs.showLoadingDialog(Get.context!, "${AppStringConstants.loading}...");
      Map<String, String> params = {
        "old_password": oldPass,
        "new_password": newPass,
        "confirm_new_password": conformPass
      };
      LoginResponseModel model = await authRepository.changePassword(params);
      Get.back();
      if (model.statusCode! == 200) {
        return true;
      } else {
        return false;
      }
    } on AppError catch (exception) {
      Get.back();
      AppLogger.logMessage("------>>>>");
      showErrorDialog(exception.message);
      return false;
    }
  }

  Future<bool> logOutClick() async {
    try {
      CustomDialogs.showLoadingDialog(Get.context!, "${AppStringConstants.loading}...");
      LoginResponseModel model = await authRepository.logOut();
      Get.back();
      if (model.statusCode! == 200) {
        return true;
      } else {
        return false;
      }
    } on AppError catch (exception) {
      Get.back();
      showErrorDialog(exception.message);
      return false;
    }
  }

  void showErrorDialog(String msg) {
    CustomDialogs.showErrorDialog(Get.context!, msg, onTap: () {
      Get.back();
    });
  }

  void saveLoginUserData(LoginResponseModel model) {
    AppPreferenceStorage.setStringValuesSF(
        AppPreferenceStorage.userId, model.data!.id!.toString());
    AppPreferenceStorage.setStringValuesSF(
        AppPreferenceStorage.userName, model.data!.fullName ?? '');
    AppPreferenceStorage.setStringValuesSF(
        AppPreferenceStorage.userEmail, model.data!.email!);
    AppPreferenceStorage.setStringValuesSF(
        AppPreferenceStorage.userImage, model.data!.profileImage ?? '');
    AppPreferenceStorage.setStringValuesSF(
        AppPreferenceStorage.authToken, model.data!.authToken!);
    AppPreferenceStorage.setIntValuesSF(
        AppPreferenceStorage.userRole, model.data!.role!.toInt());
  }
}
