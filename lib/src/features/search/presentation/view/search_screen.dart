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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.appBarSearch,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        decoration: InputDecoration(
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
                      SizedBox(height: 15),
                      _DropdownMenuRow(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainGreen,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_rounded,
                        color: Colors.black,
                      ),
                      SizedBox(width: 7),
                      Text(
                        'Поиск',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
          // Flexible(
          //   child: DropdownMenu(
          //     hintText: 'Занятия',
          //     dropdownMenuEntries: GradeLabel.values
          //         .map<DropdownMenuEntry<GradeLabel>>(
          //           (GradeLabel grade) => DropdownMenuEntry<GradeLabel>(
          //             value: grade,
          //             label: grade.title,
          //           ),
          //         )
          //         .toList(),
          //   ),
          // ),
        ],
      );
}
