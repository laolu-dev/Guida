import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color.dart';
import '../../constants/route_names.dart';
import '../../util/helpers.dart';
import '../models/department.dart';
import '../models/faculty.dart';
import '../models/location_model.dart';

class FacultyTile extends ConsumerWidget {
  final Faculty faculty;
  const FacultyTile({super.key, required this.faculty});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: REdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            offset: const Offset(2, 2),
            color: GuidaColors.black.withOpacity(.1),
          )
        ],
      ),
      child: ExpansionTile(
        title: Text(
          'Faculty of ${faculty.name}',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        backgroundColor: GuidaColors.white,
        collapsedBackgroundColor: GuidaColors.white,
        tilePadding: REdgeInsets.symmetric(horizontal: 14),
        childrenPadding: REdgeInsets.symmetric(horizontal: 12, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        children: <Widget>[
          for (Department i in faculty.departments)
            DepartmentTile(department: i)
        ],
      ),
    );
  }
}

class DepartmentTile extends ConsumerWidget {
  final Department department;
  const DepartmentTile({super.key, required this.department});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () =>
          Helpers.navigateTo(ref, GuidaRouteString.locations, args: department),
      child: Container(
        width: 1.sw,
        padding: REdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: REdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          // color: GuidaColors.grey.withOpacity(.4),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(
          "Department of ${department.name}",
          style: TextStyle(fontSize: 16.sp),
        ),
      ),
    );
  }
}

class LocationTile extends ConsumerWidget {
  final Location location;
  const LocationTile({super.key, required this.location});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => Helpers.navigateTo(ref, GuidaRouteString.directions,
          args: location.directions),
      child: Container(
        width: 1.sw,
        padding: REdgeInsets.symmetric(horizontal: 12, vertical: 8),
        margin: REdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: GuidaColors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              offset: const Offset(2, 2),
              color: GuidaColors.black.withOpacity(.1),
            )
          ],
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            if (location.imageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  location.imageUrl!,
                  fit: BoxFit.fill,
                  width: 45.w,
                  height: 45.w,
                ),
              ),
            SizedBox(width: 12.w),
            Text(
              location.name,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
