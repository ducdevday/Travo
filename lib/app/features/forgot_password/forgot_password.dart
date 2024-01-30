library forgot_password;

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_project/app/common/enums/field_enum.dart';
import 'package:my_project/app/common/widgets/default_input_field.dart';
import 'package:my_project/app/common/widgets/my_confirm_dialog.dart';
import 'package:my_project/app/common/widgets/my_primary_button.dart';
import 'package:my_project/app/config/app_dimen.dart';
import 'package:my_project/app/features/sign_up/sign_up.dart';
import 'package:my_project/app/utils/validate_field_util.dart';
import 'package:my_project/data/repositories/auth/auth_repository.dart';

part 'cubit/forgot_password_cubit.dart';
part 'cubit/forgot_password_state.dart';
part 'page/forgot_password_page.dart';
