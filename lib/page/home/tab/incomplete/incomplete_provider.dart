import 'package:riverpod/riverpod.dart';

import 'incomplete_vm.dart';

final viewModelProvider = StateProvider.autoDispose<IncompleteViewModel>(
  (ref) {
    var vm = IncompleteViewModel(ref);
    ref.onDispose(() {
      vm.dispose();
    });
    return vm;
  },
);
