import 'package:myexpenses/modules/app/domain/usecases/form_validation/form_validation_usecase.dart';

String? validateForm(String? value, ValidationMethod method) {
  FormValidationUsecase validator = FormValidationUsecase();

  return validator.validate(value, method);
}
