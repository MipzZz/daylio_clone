enum GradeLabel{
  excellent('Отлично'),
  good('Хорошо'),
  normal('Нормально'),
  bad('Плохо'),
  terrible('Ужасно');

  const GradeLabel(this.title);
  final String title;
}