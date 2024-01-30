import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/app/issues/w2_d3/theme/bloc/theme_bloc.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ThemePage"),
      ),
      body: BlocBuilder<ThemeBloc, bool>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text("${state == true ? "Dark" : "Light"} Theme"),
                SwitchListTile(
                    value: state,
                    onChanged: (value) =>
                        context.read<ThemeBloc>().add(ToggleTheme(value: value)),
                  title: Text("Toggle Theme"),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
