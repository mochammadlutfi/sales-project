class FormValidation {

  String? isEmpty(String value, String message) {
    if (value.isEmpty ) {
      return message;
    }
    return null;
  }

  String? isValidFirstName(String value) {
    if (value.length<=2) {
      return 'enter_your_first_name';
    }
    return null;
  }

  String? isValidNik(String value) {
    RegExp nikRegex = RegExp(r'^(1[1-9]|21|[37][1-6]|5[1-3]|6[1-5]|[89][12])\d{2}\d{2}([04][1-9]|[1256][0-9]|[37][01])(0[1-9]|1[0-2])\d{2}\d{4}$');
    bool result = nikRegex.hasMatch(value);
    if (result == false) {
      return 'NIK Tidak Valid!';
    }
    return null;
  }

  String? phoneValidate(String value){
    // RegExp regExp = RegExp(r'^((0[0-9]{1,2}|\+[0-9]{1,2}|\(\+?[0-9]{1,2}\)) ?)');
    // output = value.replaceFirst(regExp, '');
    String output = value;
    if (value.startsWith("0")) {
      output = value.substring(1);
    }
     else if (value.startsWith("+62")) {
      output = value.substring(3);
    } else if (value.startsWith("62")) {
      output = value.substring(2);
    }
    return output;
  }

  String? isValidLastName(String value) {
    if (value.length<=2) {
      return 'enter_your_last_name';
    }
    return null;
  }

  String? isValidPassword(String value) {
    if (value.length <= 7) {
      return '';
    }
    return null;
  }

}