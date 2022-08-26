import 'validator_usecase.dart';

class SimpleFieldValidatorUsecase implements ValidatorUsecase {
  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo não pode ser vazio';
    } else {
      return null;
    }
  }
}
