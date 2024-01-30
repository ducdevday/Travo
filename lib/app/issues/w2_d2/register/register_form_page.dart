import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/app/issues/w2_d2/register/bloc/register_bloc.dart';

enum FieldType { NAME, PHONENUMBER, EMAIL, PASSWORD }

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({Key? key}) : super(key: key);

  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  final formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  String? validateField(FieldType fieldType, String input) {
    if (fieldType == FieldType.NAME) {
      if (input.isEmpty) {
        return "Please fill this field";
      }
    } else if (fieldType == FieldType.EMAIL) {
      final RegExp emailRegExp = RegExp(
        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
      );
      if (!emailRegExp.hasMatch(input)) {
        return "Email is not valid";
      }
    } else if (fieldType == FieldType.PHONENUMBER) {
      if (input.length != 10) {
        return "PhoneNumber is not valid";
      }
    } else if (fieldType == FieldType.PASSWORD) {
      if (input.length < 6) {
        return "Password is not valid";
      }
    }
    return null;
  }

  void saveField(
    BuildContext context,
    FieldType fieldType,
    String input,
  ) {
    context
        .read<RegisterBloc>()
        .add(SaveField(fieldType: fieldType, input: input));
  }

  void register(BuildContext context) {
    // Khi form gọi hàm validate thì tất cả các TextFormField sẽ gọi hàm validate.
    if (formKey.currentState!.validate()) {
      formKey.currentState!
          .save(); // khi form gọi hàm save thì tất cả các TextFormField sẽ gọi hàm save
      context.read<RegisterBloc>().add(const DoRegister());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Register"),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => RegisterBloc(),
        child: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state.status == RegisterStatus.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Register Success")));
            } else if (state.status == RegisterStatus.fail) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Register Fail")));
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Form(
                    key: formKey, // gán key cho Form
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Please Enter Name',
                            labelText: 'Name',
                          ),
                          validator: (value) =>
                              validateField(FieldType.NAME, value!),
                          onSaved: (value) =>
                              saveField(context, FieldType.NAME, value!),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Please Enter Phone Number',
                            labelText: 'Phone Number',
                          ),
                          validator: (value) =>
                              validateField(FieldType.PHONENUMBER, value!),
                          onSaved: (value) =>
                              saveField(context, FieldType.PHONENUMBER, value!),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'Please Enter Email',
                            labelText: 'Email',
                          ),
                          validator: (value) =>
                              validateField(FieldType.EMAIL, value!),
                          onSaved: (value) =>
                              saveField(context, FieldType.EMAIL, value!),
                        ),
                        TextFormField(
                          obscureText: _passwordVisible == false,
                          decoration: InputDecoration(
                              hintText: 'Please Enter Password',
                              labelText: 'Password',
                              helperText:
                                  "Password must have greater or equal 6 characters",
                              suffixIcon: IconButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              )),
                          validator: (value) =>
                              validateField(FieldType.PASSWORD, value!),
                          onSaved: (value) =>
                              saveField(context, FieldType.PASSWORD, value!),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // sử dụng SizedBox để tạo một khoảng space giữa Button và Form
                  ElevatedButton(
                    child: const Text('Register'),
                    onPressed: () {
                      register(context);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class User {
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? password;

  const User({
    this.name = "",
    this.email = "",
    this.phoneNumber = "",
    this.password = "",
  });

  User copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? password,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
    );
  }

  @override
  String toString() {
    return 'User{name: $name, email: $email, phoneNumber: $phoneNumber, password: $password}';
  }
}
