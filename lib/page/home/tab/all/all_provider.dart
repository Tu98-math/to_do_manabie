import 'package:riverpod/riverpod.dart';

import 'all_vm.dart';

final viewModelProvider = StateProvider.autoDispose<AllViewModel>(
  (ref) {
    var vm = AllViewModel(ref);
    ref.onDispose(() {
      vm.dispose();
    });
    return vm;
  },
);
