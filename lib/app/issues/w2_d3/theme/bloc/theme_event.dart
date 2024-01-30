part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class ToggleTheme extends ThemeEvent {
  final bool value;

  ToggleTheme({
    required this.value,
  });
}
