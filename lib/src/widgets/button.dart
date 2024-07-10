import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guida/src/controllers/search_controller.dart';
import 'package:guida/src/models/location/location_model.dart';

import '../../constants/color.dart';
import '../../constants/route_names.dart';
import '../../util/helpers.dart';

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

class GuidaSearchButton extends ConsumerStatefulWidget {
  final List<LocationModel> data;

  const GuidaSearchButton({super.key, required this.data});

  @override
  ConsumerState<GuidaSearchButton> createState() => _GuidaSearchButtonState();
}

class _GuidaSearchButtonState extends ConsumerState<GuidaSearchButton> {
  String? _searchingWithQuery;

  // The most recent options received from the API.
  late Iterable<Widget> _lastOptions = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return SearchAnchor.bar(
      isFullScreen: false,
      dividerColor: GuidaColors.white,
      textInputAction: TextInputAction.search,
      viewHintText: "Search for a location",
      suggestionsBuilder: (context, controller) async {
        _searchingWithQuery = controller.text;
        final List<LocationModel> options =
            (await _search(_searchingWithQuery!)).toList();

        // If another search happened after this one, throw away these options.
        // Use the previous options instead and wait for the newer request to
        // finish.
        if (_searchingWithQuery != controller.text) {
          return _lastOptions;
        }

        _lastOptions = List<Widget>.generate(options.length, (int index) {
          final LocationModel item = options[index];
          return GestureDetector(
            onTap: () {
              ref.read(searchController.notifier).addSearch(item);
              controller.closeView(item.name);
              Helpers.navigateTo(ref, GuidaRouteString.directions, args: item);
            },
            child: Container(
              padding: REdgeInsets.symmetric(horizontal: 16, vertical: 14),
              margin: REdgeInsets.fromLTRB(12, 16, 24, 0),
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
                item.name,
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
          );
        });

        return _lastOptions;
      },
    );
  }

  Future<Iterable<LocationModel>> _search(String query) async {
    if (query == '') {
      return const Iterable<LocationModel>.empty();
    }

    return widget.data.where((LocationModel option) {
      return option.name.toLowerCase().contains(query.toLowerCase());
    });
  }
}
