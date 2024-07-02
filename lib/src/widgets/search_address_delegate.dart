import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'loading_widget.dart';
import 'package:ionicons/ionicons.dart';

import '../../constants/color.dart';
import '../models/place/place_model/places_model.dart';
import '../controllers/providers.dart';

class AddressSearch extends SearchDelegate<String> {
  @override
  String? get searchFieldLabel => "Enter Location";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: const Icon(Ionicons.arrow_back),
      onPressed: () => close(context, ''),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return MapError(btnAction: () => close(context, ''));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        AsyncValue<PlacesModel?> places;
        places = ref.watch(placesController(query));
        return places.isLoading
            ? const Center(child: Loading())
            : ListView.builder(
                itemCount: places.value?.predictions.length,
                itemBuilder: (context, index) {
                  if (places.value != null &&
                      places.value!.predictions.isEmpty) {
                    showResults(context);
                  }
                  return ListTile(
                    leading: places.value != null
                        ? Icon(Ionicons.location_outline,
                            color: GuidaColors.red)
                        : null,
                    title: Text(
                      places.value?.predictions[index].description ?? "",
                    ),
                    onTap: () {
                      close(context,
                          places.value!.predictions[index].description);
                    },
                  );
                },
              );
      },
    );
  }
}

class MapError extends StatelessWidget {
  final void Function()? btnAction;
  const MapError({super.key, this.btnAction});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/map_error.png",
            width: .4.sw,
          ),
          Text(
            "Could not find address.",
            style: TextStyle(fontSize: 22.sp, color: GuidaColors.black),
          ),
          const RSizedBox(height: 16),
          OutlinedButton(
            onPressed: btnAction,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: GuidaColors.red),
            ),
            child: Text(
              "Retry",
              style: TextStyle(fontSize: 16.sp, color: GuidaColors.black),
            ),
          )
        ],
      ),
    );
  }
}
