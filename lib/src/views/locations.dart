import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:guida/src/controllers/location_data_controller.dart';
import 'package:guida/src/controllers/search_controller.dart';
import 'package:guida/src/widgets/button.dart';

import '../models/department/department_model.dart';
import '../widgets/tile.dart';
import '../widgets/view_widget.dart';

class LocationsView extends ConsumerStatefulWidget {
  final DepartmentModel department;
  const LocationsView({super.key, required this.department});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LocationsViewState();
}

class _LocationsViewState extends ConsumerState<LocationsView> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final recent = ref.watch(searchController);
    return ViewWidget(
      viewBody: SafeArea(
        child: SingleChildScrollView(
          padding: REdgeInsets.symmetric(vertical: 20, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const BackButton(),
                  SizedBox(width: 16.h),
                  Expanded(
                    child: Text(
                      widget.department.department,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: REdgeInsets.symmetric(vertical: 16),
                child: GuidaSearchButton(data: widget.department.locations),
              ),
              ListView.builder(
                shrinkWrap: true,
                controller: _controller,
                itemCount: widget.department.locations.length,
                padding: REdgeInsets.symmetric(vertical: 20),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) =>
                    LocationTile(location: widget.department.locations[index]),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       "Recent Searches:",
              //       style: TextStyle(fontSize: 16.sp),
              //     ),
              //     TextButton(
              //       onPressed: () {
              //         ref.read(searchController.notifier).clearAll();
              //         ref.invalidate(searchController);
              //       },
              //       child: const Text("Clear all"),
              //     )
              //   ],
              // ),
              // ListView.builder(
              //   shrinkWrap: true,
              //   controller: _controller,
              //   itemCount: recent.length,
              //   padding: REdgeInsets.symmetric(vertical: 20),
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemBuilder: (context, index) =>
              //       LocationTile(location: recent[index]),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
