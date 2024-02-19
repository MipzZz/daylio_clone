part of 'main_bloc.dart';


sealed class MainState {
  DateTime get date;

  MainState copyWith( {
   DateTime? date,
  });
}

@immutable
class MainState$Data implements MainState {

  const MainState$Data({
    required this.date,
  });

  @override
  final DateTime date;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MainState$Data &&
          runtimeType == other.runtimeType &&
          date == other.date;

  @override
  int get hashCode => date.hashCode;

  @override
  MainState$Data copyWith({
    DateTime? date,
  }) => MainState$Data(
      date: date ?? this.date,
    );
}
