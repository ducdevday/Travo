library login;

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_project/app/common/enums/field_enum.dart';
import 'package:my_project/app/common/widgets/default_input_field.dart';
import 'package:my_project/app/common/widgets/my_primary_button.dart';
import 'package:my_project/app/config/app_color.dart';
import 'package:my_project/app/config/app_dimen.dart';
import 'package:my_project/app/config/app_style.dart';
import 'package:my_project/app/features/default/bloc/user_cubit.dart';
import 'package:my_project/app/features/default/page/default_page.dart';
import 'package:my_project/app/features/default/widgets/bottombar/my_bottom_nav_bar_cubit.dart';
import 'package:my_project/app/features/forgot_password/forgot_password.dart';
import 'package:my_project/app/features/home/home.dart';
import 'package:my_project/app/features/sign_up/sign_up.dart';
import 'package:my_project/app/utils/validate_field_util.dart';
import 'package:my_project/data/repositories/auth/auth_repository.dart';

part 'cubit/login_cubit.dart';
part 'cubit/login_state.dart';
part 'page/login_page.dart';