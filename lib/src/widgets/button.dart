import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guida/src/controllers/location_data_controller.dart';
import 'package:guida/src/models/faculty.dart';

import '../../constants/color.dart';

class GuidaButton extends StatelessWidget {
  final String name;
  final void Function()? action;

  const GuidaButton({super.key, required this.name, this.action});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: action,
      style: ElevatedButton.styleFrom(
        backgroundColor: GuidaColors.red,
        disabledBackgroundColor: GuidaColors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
        ),
        fixedSize: Size(double.maxFinite, .055.sh),
        padding: const EdgeInsets.symmetric(vertical: 4),
      ),
      child: Text(
        name,
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: GuidaColors.white,
        ),
      ),
    );
  }
}

class MapViewButton extends StatelessWidget {
  final IconData icon;
  final void Function()? onTap;
  const MapViewButton({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: GuidaColors.red.withAlpha(120),
        child: InkWell(
          splashColor: GuidaColors.redAccent,
          onTap: onTap,
          child: SizedBox(
            width: 50.w,
            height: 50.h,
            child: Icon(icon),
          ),
        ),
      ),
    );
  }
}

class GuidaSearchButton extends ConsumerStatefulWidget {
  const GuidaSearchButton({super.key});

  @override
  ConsumerState<GuidaSearchButton> createState() => _GuidaSearchButtonState();
}

class _GuidaSearchButtonState extends ConsumerState<GuidaSearchButton> {
  // bool _isLoading = false;
  String? _searchingWithQuery;

  // The most recent options received from the API.
  late Iterable<Widget> _lastOptions = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      isFullScreen: false,
      dividerColor: GuidaColors.white,
      viewHintText: "Search for a faculty",
      textInputAction: TextInputAction.search,
      builder: (context, controller) => const Icon(Icons.search),
      suggestionsBuilder: (context, controller) async {
        _searchingWithQuery = controller.text;
        final List<Faculty> options =
            (await _search(_searchingWithQuery!)).toList();

        // If another search happened after this one, throw away these options.
        // Use the previous options instead and wait for the newer request to
        // finish.
        if (_searchingWithQuery != controller.text) {
          return _lastOptions;
        }

        _lastOptions = List<Widget>.generate(options.length, (int index) {
          final Faculty item = options[index];
          return GestureDetector(
            onTap: () {
              controller.closeView(controller.text);
            },
            child: Container(
              padding: REdgeInsets.symmetric(horizontal: 16, vertical: 14),
              margin: REdgeInsets.fromLTRB(12, 16, 24, 16),
              decoration: BoxDecoration(
                color: GuidaColors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1,
                    offset: const Offset(2, 2),
                    color: GuidaColors.black.withOpacity(.1),
                  )
                ],
              ),
              child: Text(
                "Faculty of ${item.name}",
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
          );
        });

        return _lastOptions;
      },
    );
  }

  Future<Iterable<Faculty>> _search(String query) async {
    final data = ref.read(locationDataController).value!;
    if (query == '') {
      return const Iterable<Faculty>.empty();
    }
    return data.where((Faculty option) {
      return option.name.contains(query.toLowerCase());
    });
  }
}
