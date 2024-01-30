import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'theme_event.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, bool> {
  ThemeBloc() : super(false) {
    on<ToggleTheme>(_onToggleTheme);
  }

  FutureOr<void> _onToggleTheme(ToggleTheme event, Emitter<bool> emit) {
    emit(event.value);
  }

  @override
  bool? fromJson(Map<String, dynamic> json) {
    return json["isDark"];
  }

  @override
  Map<String, dynamic>? toJson(bool state) {
    return {"isDark": state};
  }
}
