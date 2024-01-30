import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/app/issues/w2_d2/login/bloc/login_bloc.dart';

enum FieldType { EMAIL, PASSWORD }

class LoginFormPage extends StatefulWidget {
  const LoginFormPage({Key? key}) : super(key: key);

  @override
  State<LoginFormPage> createState() => _LoginFormPageState();
}

class _LoginFormPageState extends State<LoginFormPage> {
  String? validateField(FieldType fieldType, String input) {
    if (fieldType == FieldType.EMAIL) {
      final RegExp emailRegExp = RegExp(
        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
      );
      if (!emailRegExp.hasMatch(input)) {
        return "Email is not valid";
      }
    } else if (fieldType == FieldType.PASSWORD) {
      if (input.length < 6) {
        return "Password is not valid";
      }
    }
    return null;
  }

  bool isAllValid(LoginInitial state) {
    final RegExp emailRegExp = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );
    return emailRegExp.hasMatch(state.email) && state.password.length >= 6;
  }

  void saveField(BuildContext context, FieldType fieldType, String input) {
    context
        .read<LoginBloc>()
        .add(SaveField(fieldType: fieldType, input: input));
  }

  void login(BuildContext context) {
    context.read<LoginBloc>().add(DoLogin());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => LoginBloc(),
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Login Success")));
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            if (state is LoginInitial) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Column(
                      children: [
                        InputField(
                          title: "Email",
                          hint: "Input Your Email",
                          fieldType: FieldType.EMAIL,
                          saveField: (String value) {
                            saveField(context, FieldType.EMAIL, value);
                          },
                          validateField: (FieldType fieldType, String input) {
                            return validateField(fieldType, input);
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InputField(
                          title: "Password",
                          hint: "Input Your Password",
                          fieldType: FieldType.PASSWORD,
                          saveField: (String value) {
                            saveField(context, FieldType.PASSWORD, value);
                          },
                          validateField: (FieldType fieldType, String input) {
                            return validateField(fieldType, input);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // sử dụng SizedBox để tạo một khoảng space giữa Button và Form
                    ElevatedButton(
                      onPressed: isAllValid(state)
                          ? () {
                              login(context);
                            }
                          : null,
                      child: const Text('Login'),
                    ),
                  ],
                ),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}

class InputField extends StatefulWidget {
  final String title;
  final String hint;
  final FieldType fieldType;
  final Function(String) saveField;
  final Function(FieldType fieldType, String input) validateField;

  InputField(
      {required this.title,
      required this.hint,
      required this.fieldType,
      required this.saveField,
      required this.validateField});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final TextEditingController _controller = TextEditingController();
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            widget.title,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            return widget.validateField(widget.fieldType, value!);
          },
          onChanged: (value) {
            widget.saveField(value);
          },
          obscureText: widget.fieldType == FieldType.PASSWORD &&
              _passwordVisible == false,
          controller: _controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            suffixIcon: widget.fieldType == FieldType.PASSWORD
                ? IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.black12,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  )
                : null,
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xffCCCCCC)),
                borderRadius: BorderRadius.circular(8)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xffCCCCCC)),
                borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xffCCCCCC)),
                borderRadius: BorderRadius.circular(8)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xffCCCCCC)),
                borderRadius: BorderRadius.circular(8)),
            hintText: widget.hint,
          ),
        ),
      ],
    );
  }
}

class User {
  final String? email;
  final String? password;

  const User({
    this.email = "",
    this.password = "",
  });

  User copyWith({
    String? email,
    String? password,
  }) {
    return User(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  String toString() {
    return 'User{email: $email, password: $password}';
  }
}
