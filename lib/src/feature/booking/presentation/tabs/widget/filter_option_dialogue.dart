import 'package:flutter/material.dart';

class FilterOptionsDialog extends StatelessWidget {
  final Function(ReviewFilterEnum) onOptionSelected;

  const FilterOptionsDialog({Key? key, required this.onOptionSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter Options'),
      content: Wrap(
        alignment: WrapAlignment.spaceBetween,
        children: [
          _buildOptionButton(context, ReviewFilterEnum.highRating),
          _buildOptionButton(context, ReviewFilterEnum.oldReviews),
          _buildOptionButton(context, ReviewFilterEnum.lowRating),
          _buildOptionButton(context, ReviewFilterEnum.newReviews),
        ],
      ),
    );
  }

  Widget _buildOptionButton(BuildContext context, ReviewFilterEnum option) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
        onOptionSelected(option);
      },
      child: Text(reviewFilterEnumToString(option)),
    );
  }
}

enum ReviewFilterEnum { lowRating, highRating, newReviews, oldReviews, all }

String reviewFilterEnumToString(ReviewFilterEnum filter) {
  switch (filter) {
    case ReviewFilterEnum.lowRating:
      return 'Low Rating';
    case ReviewFilterEnum.highRating:
      return 'High Rating';
    case ReviewFilterEnum.newReviews:
      return 'New Reviews';
    case ReviewFilterEnum.oldReviews:
      return 'Old Reviews';
    case ReviewFilterEnum.all:
      return 'All';
  }
}
