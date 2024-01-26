import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';
import 'package:daylio_clone/src/core/presentation/assets/text/app_text_style.dart';
import 'package:daylio_clone/src/core/presentation/assets/text/app_text_style_abstract_class.dart';
import 'package:flutter/material.dart';

class StatisticWidget extends StatelessWidget {
  const StatisticWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10.0),
      child: Card(
        color: AppColors.listBackground,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: Text('Статистика настроения', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),),
              ),
              SizedBox(height: 10),
              Text('Отлично: 5', style: AppTextStyle.statisticText,),
              Text('Хорошо: 6', style: AppTextStyle.statisticText,),
              Text('Нормально: 1', style: AppTextStyle.statisticText,),
              Text('Плохо: 2', style: AppTextStyle.statisticText,),
            ],
          ),
        ),
      ),
    );
  }
}
