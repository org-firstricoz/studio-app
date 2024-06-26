import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/commons/views/help-center/presentation/bloc/help_bloc.dart';
import 'package:flutter_riverpod_base/src/feature/home/presentation/view/home.dart';
import 'package:flutter_riverpod_base/src/res/data.dart';
import 'package:flutter_super_html_viewer/flutter_super_html_viewer.dart';
import 'package:go_router/go_router.dart';
import 'package:html_viewer_elite/html_viewer_elite.dart';

class FaqTab extends StatefulWidget {
  const FaqTab({super.key});

  @override
  State<FaqTab> createState() => _FaqTabState();
}

class _FaqTabState extends State<FaqTab> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<HelpBloc>().add(GetHelpDataEvent(noParams: '_'));
    super.initState();
  }

  // List<String> categories = ["All", "Services", "General", "Account", "hello"];
  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return BlocConsumer<HelpBloc, HelpState>(
      listener: (context, state) {
        if (state is HelpFailureState) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text('Error'),
                    content: Html(data: state.message),
                    actions: [
                      TextButton(
                          onPressed: () {
                            context.pushReplacement(HomeView.routePath);
                          },
                          child: const Text('ok'))
                    ],
                  ));
        }
      },
      builder: (context, state) {
        if (state is HelpFailureState) {
          return const Center(
            child: Text("No Data to Show"),
          );
        }
        if (state is HelpSuccessState) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: AppData.helpScetion.isEmpty
                ? const Center(
                    child: Text('No Data'),
                  )
                : ListView.builder(
                    itemCount: AppData.helpScetion.length,
                    itemBuilder: (context, index) {
                      return AppData.helpScetion[index];
                    },
                  ),
          );
        } else if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class CustomExpadedTile extends StatelessWidget {
  final String title;
  final String description;

  const CustomExpadedTile(
      {super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
          color: color.surface,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(color: color.secondary.withOpacity(0.5), spreadRadius: 3)
          ]),
      child: ExpansionTile(
        shape: Border.all(color: Colors.transparent, width: 0),
        collapsedShape: Border.all(color: Colors.transparent, width: 0),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        childrenPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        children: [
          const Divider(thickness: 0.5),
          Text(
            description,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}
