import 'package:flutter/material.dart';

enum FieldType { NAME, PHONENUMBER, EMAIL, PASSWORD }

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({Key? key}) : super(key: key);

  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
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

class _RegisterFormPageState extends State<RegisterFormPage> {
  final formKey = GlobalKey<FormState>();
  User user = const User();
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

  void saveField(FieldType fieldType, String input) {
    if (fieldType == FieldType.NAME) {
      setState(() {
        user = user.copyWith(name: input);
      });
    } else if (fieldType == FieldType.EMAIL) {
      setState(() {
        user = user.copyWith(email: input);
      });
    } else if (fieldType == FieldType.PHONENUMBER) {
      setState(() {
        user = user.copyWith(phoneNumber: input);
      });
    } else if (fieldType == FieldType.PASSWORD) {
      setState(() {
        user = user.copyWith(password: input);
      });
    }
  }

  void register() {
    // Khi form gọi hàm validate thì tất cả các TextFormField sẽ gọi hàm validate.
    if (formKey.currentState!.validate()) {
      formKey.currentState!
          .save(); // khi form gọi hàm save thì tất cả các TextFormField sẽ gọi hàm save
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Register Success")));
      print(user.toString());
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Register Fail")));
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
      body: Padding(
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
                    validator: (value) => validateField(FieldType.NAME, value!),
                    onSaved: (value) => saveField(FieldType.NAME, value!),
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
                        saveField(FieldType.PHONENUMBER, value!),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Please Enter Email',
                      labelText: 'Email',
                    ),
                    validator: (value) =>
                        validateField(FieldType.EMAIL, value!),
                    onSaved: (value) => saveField(FieldType.EMAIL, value!),
                  ),
                  TextFormField(
                    obscureText: _passwordVisible == false,
                    decoration: InputDecoration(
                        hintText: 'Please Enter Password',
                        labelText: 'Password',
                        helperText: "Password must have greater or equal 6 characters",
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
                        saveField(FieldType.PASSWORD, value!),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // sử dụng SizedBox để tạo một khoảng space giữa Button và Form
            ElevatedButton(
              child: const Text('Register'),
              onPressed: register,
            ),
          ],
        ),
      ),
    );
  }
}
