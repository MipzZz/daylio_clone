import 'package:daylio_clone/src/features/statistic/data/statistic_repository.dart';
import 'package:flutter/material.dart';

class StatisticProvider extends ChangeNotifier {
  final StatisticRepository _statisticRepository;

  StatisticProvider({required StatisticRepository statisticRepository})
      : _statisticRepository = statisticRepository;
}
