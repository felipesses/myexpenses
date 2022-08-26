import 'simple_field_validator_usecase.dart';
import 'validator_usecase.dart';

enum ValidationMethod {
  // ignore: constant_identifier_names
  SIMPLE_FIELD,
}

class FormValidationUsecase {
  Map<ValidationMethod, ValidatorUsecase> map = {
    ValidationMethod.SIMPLE_FIELD: SimpleFieldValidatorUsecase(),
  };

  String? validate(String? value, ValidationMethod method) {
    return map[method]?.validate(value);
  }
}
