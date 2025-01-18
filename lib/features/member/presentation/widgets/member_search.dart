import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/member/presentation/bloc/member_bloc/member_bloc.dart';

class MemberSearch extends StatefulWidget {
  const MemberSearch({super.key});

  @override
  State<MemberSearch> createState() => _MemberSearchState();
}

class _MemberSearchState extends State<MemberSearch> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      context.read<MemberBloc>().add(MemberSearchEvent(_searchController.text));
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppPadding.doublePadding.r,
        bottom: 0,
        right: AppPadding.defaultPadding.r,
        left: AppPadding.defaultPadding.r,
      ),
      child: TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(),
          ),
          hintText: 'Search ...',
          hintStyle: TextStyle(),
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
          filled: true,
        ),
      ),
    );
  }
}
