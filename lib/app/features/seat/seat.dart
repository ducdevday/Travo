library seat;

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_project/app/common/widgets/default_header.dart';
import 'package:my_project/app/common/widgets/my_card.dart';
import 'package:my_project/app/common/widgets/my_primary_button.dart';
import 'package:my_project/app/config/app_color.dart';
import 'package:my_project/app/config/app_dimen.dart';
import 'package:my_project/app/config/app_path.dart';
import 'package:my_project/app/config/app_style.dart';
import 'package:my_project/app/features/checkout_flight/checkout_flight.dart';
import 'package:my_project/app/utils/string_format_util.dart';
import 'package:my_project/data/model/seat_model.dart';
import 'package:my_project/data/model/seat_place_model.dart';

part 'bloc/seat_bloc.dart';
part 'bloc/seat_event.dart';
part 'bloc/seat_state.dart';
part 'page/seat_page.dart';
part 'widgets/seat_item.dart';
