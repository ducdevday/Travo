library flight;

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_project/app/common/enums/flight_sort_type.dart';
import 'package:my_project/app/common/widgets/filter_option.dart';
import 'package:my_project/app/common/widgets/my_confirm_dialog.dart';
import 'package:my_project/app/common/widgets/my_primary_button.dart';
import 'package:my_project/app/common/widgets/my_secondary_button.dart';
import 'package:my_project/app/common/widgets/my_skeleton_rectangle.dart';
import 'package:my_project/app/common/widgets/sort_item.dart';
import 'package:my_project/app/config/app_color.dart';
import 'package:my_project/app/config/app_dimen.dart';
import 'package:my_project/app/config/app_path.dart';
import 'package:my_project/app/config/app_style.dart';
import 'package:my_project/app/features/checkout_flight/checkout_flight.dart';
import 'package:my_project/app/utils/string_format_util.dart';
import 'package:my_project/data/model/flight_model.dart';
import 'package:my_project/data/model/seat_model.dart';
import 'package:my_project/data/repositories/flight/flight_repository.dart';
import 'package:shimmer/shimmer.dart';

part 'bloc/flight_bloc.dart';
part 'bloc/flight_event.dart';
part 'bloc/flight_state.dart';
part 'pages/flight_page.dart';
part 'widgets/flight_filter_bottom_sheet.dart';
part 'widgets/flight_header.dart';
part 'widgets/flight_item.dart';