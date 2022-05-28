import '/base/base_view_model.dart';

class CompleteViewModel extends BaseViewModel {
  BehaviorSubject<InitialStatus> bsInitSate =
      BehaviorSubject.seeded(InitialStatus.loading);

  CompleteViewModel(ref) : super(ref);

  @override
  void dispose() {
    bsInitSate.close();
    super.dispose();
  }
}

enum InitialStatus { onBoarding, home, loading, error }
