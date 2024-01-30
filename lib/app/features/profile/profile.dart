library profile;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/app/common/widgets/my_avatar.dart';
import 'package:my_project/app/common/widgets/my_card.dart';
import 'package:my_project/app/common/widgets/my_confirm_dialog.dart';
import 'package:my_project/app/common/widgets/my_developing.dart';
import 'package:my_project/app/common/widgets/my_primary_button.dart';
import 'package:my_project/app/config/app_dimen.dart';
import 'package:my_project/app/config/app_path.dart';
import 'package:my_project/app/config/app_style.dart';
import 'package:my_project/app/features/default/bloc/user_cubit.dart';
import 'package:my_project/app/features/forgot_password/forgot_password.dart';
import 'package:my_project/app/features/login/login.dart';
import 'package:my_project/app/features/personal_infomation/personal_information.dart';
import 'package:url_launcher/url_launcher.dart';

part 'page/profile_page.dart';
part 'widgets/profile_header.dart';
part 'widgets/setting_item.dart';

