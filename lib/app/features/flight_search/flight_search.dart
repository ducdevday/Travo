library flight_search;

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_project/app/common/enums/field_enum.dart';
import 'package:my_project/app/common/widgets/default_header.dart';
import 'package:my_project/app/common/widgets/flight_input_field.dart';
import 'package:my_project/app/common/widgets/my_field_container.dart';
import 'package:my_project/app/common/widgets/my_primary_button.dart';
import 'package:my_project/app/config/app_color.dart';
import 'package:my_project/app/config/app_dimen.dart';
import 'package:my_project/app/config/app_path.dart';
import 'package:my_project/app/config/app_style.dart';
import 'package:my_project/app/features/flight/flight.dart';
import 'package:my_project/app/utils/string_format_util.dart';
import 'package:my_project/app/utils/validate_field_util.dart';
import 'package:my_project/data/model/seat_model.dart';

part 'cubit/flight_search_cubit.dart';
part 'cubit/flight_search_state.dart';
part 'pages/flight_search_page.dart';