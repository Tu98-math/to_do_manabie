import 'package:riverpod/riverpod.dart';

import 'complete_vm.dart';

final viewModelProvider = StateProvider.autoDispose<CompleteViewModel>(
  (ref) {
    var vm = CompleteViewModel(ref);
    ref.onDispose(() {
      vm.dispose();
    });
    return vm;
  },
);
