import 'package:daylio_clone/src/core/presentation/assets/colors/app_colors.dart';
import 'package:daylio_clone/src/core/presentation/assets/text/app_text_style.dart';
import 'package:flutter/material.dart';

class StatisticWidget extends StatelessWidget {
  const StatisticWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(flex: 1,child: _NotesCountCard()),
          SizedBox(width: 35),
          Flexible(flex: 1,child: _AverageMoodCard()),
        ],
      ),
    );
  }
}

class _NotesCountCard extends StatelessWidget {
  const _NotesCountCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Card(
      color: AppColors.listBackground,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '12',
              style: AppTextStyle.statisticText,
            ),
            ListTile(
              leading: Icon(Icons.sticky_note_2_rounded, color: Colors.blueAccent,),
              title: Text('Записи', style: TextStyle(color: Colors.white),),
              dense: true,
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 7,
            )
          ],
        ),
      ),
    );
  }
}

class _AverageMoodCard extends StatelessWidget {
  const _AverageMoodCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Card(
      color: AppColors.listBackground,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '3,1',
              style: AppTextStyle.statisticText,
            ),
            ListTile(
              leading: Icon(Icons.emoji_emotions, color: Colors.amberAccent,),
              title: Text('Настроение', style: TextStyle(color: Colors.white),),
              dense: true,
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 7,
            )
          ],
        ),
      ),
    );
  }
}
