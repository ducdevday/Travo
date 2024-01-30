library personal_information;

import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_project/app/common/enums/field_enum.dart';
import 'package:my_project/app/common/widgets/country_input_field.dart';
import 'package:my_project/app/common/widgets/default_input_field.dart';
import 'package:my_project/app/common/widgets/my_avatar.dart';
import 'package:my_project/app/common/widgets/my_confirm_dialog.dart';
import 'package:my_project/app/common/widgets/my_primary_button.dart';
import 'package:my_project/app/common/widgets/phone_input_field.dart';
import 'package:my_project/app/config/app_color.dart';
import 'package:my_project/app/config/app_dimen.dart';
import 'package:my_project/app/config/app_path.dart';
import 'package:my_project/app/config/app_style.dart';
import 'package:my_project/app/features/default/bloc/user_cubit.dart';
import 'package:my_project/app/utils/validate_field_util.dart';
import 'package:my_project/data/model/user_model.dart';
import 'package:my_project/data/repositories/user/user_repository.dart';
import 'package:my_project/data/services/shared_service.dart';

part 'cubit/personal_information_cubit.dart';
part 'cubit/personal_information_state.dart';
part 'page/personal_information_page.dart';
part 'widgets/personal_information_header.dart';

