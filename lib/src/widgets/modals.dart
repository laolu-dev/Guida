import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../util/helpers.dart';
import '../controllers/providers.dart';
import 'button.dart';


class CarModal extends ConsumerWidget {
  const CarModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userLocation = ref.watch(userLocationController);
    return Column(
      children: [
        Text(userLocation.value!.distance),
        GuidaButton(
          name: "Ok",
          action: () => Helpers.navigateBack(ref),
        )
      ],
    );
  }
}
