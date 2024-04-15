import 'package:flutter/material.dart';

class FaqTab extends StatefulWidget {
  const FaqTab({super.key});

  @override
  State<FaqTab> createState() => _FaqTabState();
}

class _FaqTabState extends State<FaqTab> {
  List<String> categories = ["All", "Services", "General", "Account", "hello"];
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    int isActive = 0;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsetsDirectional.symmetric(vertical: 15),
            height: 29.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Container(
                  
                  height: 29,
                  margin: EdgeInsets.only(
                      left: index == 0 ? 20 : 15,
                      right: index == categories.length - 1 ? 25 : 0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 17, vertical: 6),
                  decoration: BoxDecoration(
                      color: isActive == index
                          ? color.primary
                          : color.secondary,
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    categories[index],
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: isActive == index
                            ? color.surface
                            : color.onSurface),
                  ),
                );
              },
            ),
          ),
          const CustomExpadedTile(
              title: "How do i schedule a Tour?",
              description:
                  "Welcome to the \"Studio on Rent\" app, created to help users find and book studio spaces. Your privacy is important to us, and we are committed "),
          const CustomExpadedTile(
              title: "How do i schedule a Tour?",
              description:
                  "Welcome to the \"Studio on Rent\" app, created to help users find and book studio spaces. Your privacy is important to us, and we are committed "),
          const CustomExpadedTile(
              title: "How do i schedule a Tour?",
              description:
                  "Welcome to the \"Studio on Rent\" app, created to help users find and book studio spaces. Your privacy is important to us, and we are committed "),
          const CustomExpadedTile(
              title: "How do i schedule a Tour?",
              description:
                  "Welcome to the \"Studio on Rent\" app, created to help users find and book studio spaces. Your privacy is important to us, and we are committed "),
          const CustomExpadedTile(
              title: "How do i schedule a Tour?",
              description:
                  "Welcome to the \"Studio on Rent\" app, created to help users find and book studio spaces. Your privacy is important to us, and we are committed "),
          const CustomExpadedTile(
              title: "How do i schedule a Tour?",
              description:
                  "Welcome to the \"Studio on Rent\" app, created to help users find and book studio spaces. Your privacy is important to us, and we are committed ")
        ],
      ),
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
            BoxShadow(
                color:  color.secondary.withOpacity(0.5),
                spreadRadius: 3)
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
