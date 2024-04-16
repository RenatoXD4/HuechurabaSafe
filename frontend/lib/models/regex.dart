

class Regex {
  final RegExp name = RegExp(r'^[A-ZÁÉÍÓÚÜÑ][a-zA-ZáéíóúüñÑ]*(?:\s[A-ZÁÉÍÓÚÜÑ][a-zA-ZáéíóúüñÑ]*)*$');
  final RegExp email = RegExp(r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$');
  final RegExp phone = RegExp(r'^[1-9]\d{8}$');
  final RegExp password = RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()\-_.]).+$');

  String? formValidate(RegExp regex, input, String errorMessage){
    final isValid = regex.hasMatch(input ?? '');

    if (!isValid) {
      return errorMessage;
    }
    return null;
  }
}