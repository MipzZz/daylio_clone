import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';
import 'package:daylio_clone/src/features/notes/domain/entity/grade_label.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Поиск'),
          backgroundColor: AppColors.appBarSearch,
        ),
        body: SafeArea(
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: AppColors.appBarSearch,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(

                      prefixIcon: Icon(Icons.search_rounded),
                      hintText: 'Поиск',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
                      fillColor: AppColors.background,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const _DropdownMenuRow(),
                ],
              ),
            ),
          ),
        ),
      );
}

class _DropdownMenuRow extends StatelessWidget {
  const _DropdownMenuRow();

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: DropdownMenu(
              hintText: 'Настроение',
              dropdownMenuEntries: GradeLabel.values
                  .map<DropdownMenuEntry<GradeLabel>>(
                    (GradeLabel grade) => DropdownMenuEntry<GradeLabel>(
                      value: grade,
                      label: grade.title,
                    ),
                  )
                  .toList(),
            ),
          ),
          Flexible(
            child: DropdownMenu(
              hintText: 'Занятия',
              dropdownMenuEntries: GradeLabel.values
                  .map<DropdownMenuEntry<GradeLabel>>(
                    (GradeLabel grade) => DropdownMenuEntry<GradeLabel>(
                      value: grade,
                      label: grade.title,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      );
}
