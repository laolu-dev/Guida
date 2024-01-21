import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guida/src/widgets/view_widget.dart';

class RoutesView extends ConsumerStatefulWidget {
  const RoutesView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RoutesViewState();
}

class _RoutesViewState extends ConsumerState<RoutesView> {
  @override
  Widget build(BuildContext context) {
    return ViewWidget();
  }
}
