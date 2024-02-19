part of 'main_bloc.dart';

sealed class MainEvent {}

class MainEvent$AddTime implements MainEvent {}

class MainEvent$ReduceTime implements MainEvent {}
