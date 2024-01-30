library contact;

import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/app/common/enums/checkout_type.dart';
import 'package:my_project/app/common/enums/field_enum.dart';
import 'package:my_project/app/common/widgets/default_input_field.dart';
import 'package:my_project/app/common/widgets/my_confirm_dialog.dart';
import 'package:my_project/app/common/widgets/my_primary_button.dart';
import 'package:my_project/app/common/widgets/phone_input_field.dart';
import 'package:my_project/app/config/app_color.dart';
import 'package:my_project/app/config/app_dimen.dart';
import 'package:my_project/app/config/app_path.dart';
import 'package:my_project/app/config/app_style.dart';
import 'package:my_project/app/features/checkout/checkout.dart';
import 'package:my_project/app/features/checkout_flight/checkout_flight.dart';
import 'package:my_project/app/utils/validate_field_util.dart';
import 'package:my_project/data/model/guest_model.dart';

part 'cubit/contact_cubit.dart';

part 'cubit/contact_state.dart';

part 'page/contact_page.dart';

part 'widgets/contact_header.dart';
