import 'package:mobx/mobx.dart';
part 'loading_controller.g.dart';

class LoadingController = _LoadingControllerBase with _$LoadingController;

abstract class _LoadingControllerBase with Store {
  @observable
  Observable<bool> status = Observable(false);

  @action
  on() {
    status.value = true;
  }

  @action
  out() {
    status.value = false;
  }
}
