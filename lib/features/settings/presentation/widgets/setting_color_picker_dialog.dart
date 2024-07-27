import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/settings/presentation/cubit/theme_cubit.dart';

class SettingColorPickerDialog extends StatelessWidget {
  const SettingColorPickerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pick a Color'),
      content: SingleChildScrollView(
        child: Column(
          children: ColorSeed.values.map((colorSeed) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: colorSeed.color,
              ),
              title: Text(colorSeed.label),
              onTap: () {
                context.read<ThemeCubit>().setColorSeed(colorSeed);
                Navigator.of(context).pop();
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
