import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/features/main/presentation/widgets/main_appbar.dart';
import 'package:project_nineties/features/settings/presentation/cubit/theme_cubit.dart';
import 'package:project_nineties/features/settings/presentation/widgets/setting_color_picker_dialog.dart';

//analyze this code below
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBarNoAvatar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        children: [
          const Text(
            'Appearance',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 2),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.dark_mode),
                  title: const Text('Dark Mode'),
                  trailing: Radio<ThemeMode>(
                    value: ThemeMode.dark,
                    groupValue: context.watch<ThemeCubit>().state.themeMode,
                    onChanged: (value) {
                      context.read<ThemeCubit>().setThemeMode(value!);
                    },
                  ),
                  onTap: () =>
                      context.read<ThemeCubit>().setThemeMode(ThemeMode.dark),
                ),
                const Divider(height: 1, thickness: 1),
                ListTile(
                  leading: const Icon(Icons.light_mode),
                  title: const Text('Light Mode'),
                  trailing: Radio<ThemeMode>(
                    value: ThemeMode.light,
                    groupValue: context.watch<ThemeCubit>().state.themeMode,
                    onChanged: (value) {
                      context.read<ThemeCubit>().setThemeMode(value!);
                    },
                  ),
                  onTap: () =>
                      context.read<ThemeCubit>().setThemeMode(ThemeMode.light),
                ),
                const Divider(height: 1, thickness: 1),
                ListTile(
                  leading: const Icon(Icons.phone_android),
                  title: const Text('System Default'),
                  trailing: Radio<ThemeMode>(
                    value: ThemeMode.system,
                    groupValue: context.watch<ThemeCubit>().state.themeMode,
                    onChanged: (value) {
                      context.read<ThemeCubit>().setThemeMode(value!);
                    },
                  ),
                  onTap: () =>
                      context.read<ThemeCubit>().setThemeMode(ThemeMode.system),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 2),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: ListTile(
              leading: const Icon(Icons.color_lens),
              title: const Text('Pick a Color'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.watch<ThemeCubit>().state.colorSeed.color,
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios,
                      size: 16, color: Colors.grey),
                ],
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const SettingColorPickerDialog();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
