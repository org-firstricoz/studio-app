import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/models/location_model.dart';
import 'package:flutter_riverpod_base/src/core/user.dart';
import 'package:flutter_riverpod_base/src/feature/auth/domain/usecase/use_cases.dart';
import 'package:flutter_riverpod_base/src/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_riverpod_base/src/feature/profile/views/complete_profile_info.dart';
import 'package:flutter_riverpod_base/src/utils/custom_extension_methods.dart';
import 'package:flutter_riverpod_base/src/utils/form_text_field.dart';
import 'package:go_router/go_router.dart';

showLoactionAccessingBottomModelSheet(BuildContext context) {
  final color = Theme.of(context).colorScheme;

  showModalBottomSheet(
    showDragHandle: true,
    backgroundColor: color.surface,
    enableDrag: true,
    context: context,
    builder: (context) {
      Size size = MediaQuery.of(context).size;
      return Builder(builder: (context) {
        return LoactionSearchingWidget(size: size);
      });
    },
  );
}

class LoactionSearchingWidget extends StatefulWidget {
  final Size size;

  const LoactionSearchingWidget({Key? key, required this.size})
      : super(key: key);

  @override
  _LoactionSearchingWidgetState createState() =>
      _LoactionSearchingWidgetState();
}

class _LoactionSearchingWidgetState extends State<LoactionSearchingWidget> {
  List<LocationModel> allLocations = [];
  List<LocationModel> filteredLocations = [];

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(ManualLocationEvent(params: NoParams()));
    filteredLocations = List.from(allLocations);
  }

  void filterLocations(String query) {
    // Filter the locations based on the search query
    setState(() {
      filteredLocations = allLocations
          .where((location) =>
              location.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Container(
        height: widget.size.height / 2,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is ManualLocationFailureState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
            if (state is ManualLocationSuccessState) {
              filteredLocations = state.models;
            }
          },
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                FormTextField(
                  prefixWidget: Icon(
                    Icons.search,
                    color: color.primary,
                  ),
                  hintText: "search location",
                  onChanged: filterLocations,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredLocations.length,
                    itemBuilder: (context, index) => ListTile(
                      title: GestureDetector(
                          onTap: () {
                            userDetails.addAll({
                              'location': filteredLocations[index].name
                            });
                            context.go(CompleteYourProfileInfoView.routePath);
                          },
                          child: Text(filteredLocations[index].name)),
                    ),
                  ),
                ),
              ],
            ).addSpacingBetweenElements(15);
          },
        ));
  }
}
