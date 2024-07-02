import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/department.dart';
import '../widgets/logo.dart';
import '../widgets/tile.dart';
import '../widgets/view_widget.dart';

class LocationsView extends ConsumerStatefulWidget {
  final Department department;
  const LocationsView({super.key, required this.department});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LocationsViewState();
}

class _LocationsViewState extends ConsumerState<LocationsView> {
  @override
  Widget build(BuildContext context) {
    return ViewWidget(
      viewBody: SafeArea(
        child: SingleChildScrollView(
          padding: REdgeInsets.symmetric(vertical: 20, horizontal: 24),
          child: Column(
            children: [
              Row(
                children: [
                  const BackButton(),
                  const GuidaLogo(),
                  SizedBox(width: 16.h),
                  Text(
                    "Locations",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
             
              ListView.builder(
                shrinkWrap: true,
                itemCount: widget.department.destinations.length,
                padding: REdgeInsets.symmetric(vertical: 20),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => LocationTile(
                    location: widget.department.destinations[index]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
