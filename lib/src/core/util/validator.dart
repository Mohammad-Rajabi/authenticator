import 'package:authenticator/src/core/constant/general_constants.dart';

class Validators {

  static String? accountNameValidator(String? value) {
    return emptyValidator(value);
  }

  static String? secretKeyValidator(String? value) {
    String? result;
    result = emptyValidator(value!);

    result =  result ??= lengthValidator(value, 16);
    return result ??= alphaNumericValidator(value);

  }

  static String? lengthValidator(String value, int minLength){
    if(value.length < minLength){
      return "Cannot be less than 16 letters";
    }
  }

  static String? emptyValidator(String? value){
    if(value == null || value.isEmpty){
      return "required";
    }
  }

  static String? alphaNumericValidator(String value){
    if(!AlphaNumericRegex.hasMatch(value)){
      return "Must contain letters and numbers";
    }
  }

}