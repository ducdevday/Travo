import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_project/app/issues/w2_d4/register/bloc/register_bloc.dart';
import 'package:my_project/data/repositories/auth/auth_repository.dart';

enum FieldType { NAME, PHONENUMBER, EMAIL, PASSWORD }

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({Key? key}) : super(key: key);

  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  final formKey = GlobalKey<FormState>();
  User user = const User();

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
    FieldType fieldType,
    String input,
  ) {
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

  bool isAllValid() {
    return validateField(FieldType.NAME, user.name!) == null &&
        validateField(FieldType.EMAIL, user.email!) == null &&
        validateField(FieldType.PHONENUMBER, user.phoneNumber!) == null &&
        validateField(FieldType.PASSWORD, user.password!) == null;
  }

  void register(BuildContext context) {
    // Khi form gọi hàm validate thì tất cả các TextFormField sẽ gọi hàm validate.
    if (formKey.currentState!.validate()) {
      formKey.currentState!
          .save(); // khi form gọi hàm save thì tất cả các TextFormField sẽ gọi hàm save
      context.read<RegisterBloc>().add(DoRegister(
          name: user.name!,
          phoneNumber: user.phoneNumber!,
          email: user.email!,
          password: user.password!));
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
        create: (context) =>
            RegisterBloc(authRepository: context.read<AuthRepository>()),
        child: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state.status == RegisterStatus.loading) {
              EasyLoading.show(maskType: EasyLoadingMaskType.black);
            } else if (state.status == RegisterStatus.success) {
              EasyLoading.dismiss();
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Register Success")));
            } else if (state.status == RegisterStatus.fail) {
              EasyLoading.dismiss();
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message ?? "Register Fail")));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Form(
                      key: formKey, // gán key cho Form
                      child: Column(
                        children: [
                          InputField(
                            title: "Name",
                            hint: "Input Your Name",
                            fieldType: FieldType.NAME,
                            saveField: (String value) {
                              saveField(FieldType.NAME, value);
                            },
                            validateField: (FieldType fieldType, String input) {
                              return validateField(fieldType, input);
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InputField(
                            title: "Phone Number",
                            hint: "Input Your Phone Number",
                            fieldType: FieldType.PHONENUMBER,
                            saveField: (String value) {
                              saveField(FieldType.PHONENUMBER, value);
                            },
                            validateField: (FieldType fieldType, String input) {
                              return validateField(fieldType, input);
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InputField(
                            title: "Email",
                            hint: "Input Your Email",
                            fieldType: FieldType.EMAIL,
                            saveField: (String value) {
                              saveField(FieldType.EMAIL, value);
                            },
                            validateField: (FieldType fieldType, String input) {
                              return validateField(fieldType, input);
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InputField(
                            title: "Password",
                            hint: "Input Your Password",
                            fieldType: FieldType.PASSWORD,
                            saveField: (String value) {
                              saveField(FieldType.PASSWORD, value);
                            },
                            validateField: (FieldType fieldType, String input) {
                              return validateField(fieldType, input);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // sử dụng SizedBox để tạo một khoảng space giữa Button và Form
                    ElevatedButton(
                      child: const Text('Register'),
                      onPressed: isAllValid()
                          ? () {
                              register(context);
                            }
                          : null,
                    ),
                  ],
                ),
              ),
            );
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
  final FocusNode _focusNode = FocusNode();
  String? errorText;
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        errorText = widget.validateField(widget.fieldType, _controller.text);
      }
    });
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
          keyboardType: widget.fieldType == FieldType.PHONENUMBER
              ? TextInputType.number
              : TextInputType.text,
          onFieldSubmitted: (_) {
            setState(() {
              errorText =
                  widget.validateField(widget.fieldType, _controller.text);
            });
          },
          validator: (value) {
            return widget.validateField(widget.fieldType, value!);
          },
          onChanged: (value) {
            widget.saveField(value);
          },
          obscureText: widget.fieldType == FieldType.PASSWORD &&
              _passwordVisible == false,
          controller: _controller,
          focusNode: _focusNode,
          decoration: InputDecoration(
            errorText: errorText,
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


  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json["name"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      password: json["password"],
    );
  }

  @override
  String toString() {
    return 'User{name: $name, email: $email, phoneNumber: $phoneNumber, password: $password}';
  }
}
