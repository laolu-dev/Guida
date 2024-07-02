import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/route_names.dart';
import '../../util/helpers.dart';
import '../controllers/location_data_controller.dart';
import '../widgets/button.dart';
import '../widgets/logo.dart';
import '../widgets/tile.dart';
import '../widgets/view_widget.dart';

class FacultiesView extends ConsumerStatefulWidget {
  const FacultiesView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FacultiesViewState();
}

class _FacultiesViewState extends ConsumerState<FacultiesView> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(locationDataController);

    return ViewWidget(
      viewBody: SafeArea(
        child: RefreshIndicator.adaptive(
          onRefresh: () => ref.read(locationDataController.notifier).build(),
          child: SingleChildScrollView(
            padding: REdgeInsets.symmetric(vertical: 20, horizontal: 24),
            child: Column(
              children: [
                Row(
                  children: [
                    const GuidaLogo(),
                    SizedBox(width: 16.h),
                    Expanded(
                      child: Text(
                        "Faculties",
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const GuidaSearchButton()
                  ],
                ),
                TextButton(
                  onPressed: () => ref.refresh(locationDataController),
                  child: Text("Reload"),
                ),
                data.isLoading
                    ? const CircularProgressIndicator.adaptive()
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.value!.length,
                        padding: REdgeInsets.symmetric(vertical: 20),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>
                            FacultyTile(faculty: data.value![index]),
                      ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Can't find your destination?",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      OutlinedButton.icon(
                        onPressed: () =>
                            Helpers.navigateTo(ref, GuidaRouteString.mapView),
                        icon: const Icon(Icons.map),
                        iconAlignment: IconAlignment.end,
                        label: Text(
                          "Use Map",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
