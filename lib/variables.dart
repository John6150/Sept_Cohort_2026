import 'package:flutter_riverpod/legacy.dart';

/// Providers are declared globally and specify how to create a state
// final counterProvider = StateProvider((ref) => 0);

StateProvider<int> counterProvider = StateProvider((ref) {
  return 0;
});
