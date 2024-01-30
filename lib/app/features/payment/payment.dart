library payment;

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_project/app/common/enums/checkout_type.dart';
import 'package:my_project/app/common/widgets/default_header.dart';
import 'package:my_project/app/common/widgets/my_card.dart';
import 'package:my_project/app/common/widgets/my_skeleton_rectangle.dart';
import 'package:my_project/app/config/app_color.dart';
import 'package:my_project/app/config/app_dimen.dart';
import 'package:my_project/app/config/app_path.dart';
import 'package:my_project/app/config/app_style.dart';
import 'package:my_project/app/features/booking_detail/booking_detail.dart';
import 'package:my_project/app/features/booking_flight_detail/booking_flight_detail.dart';
import 'package:my_project/app/features/default/bloc/user_cubit.dart';
import 'package:my_project/app/features/flight/flight.dart';
import 'package:my_project/app/utils/string_format_util.dart';
import 'package:my_project/data/model/booking_detail_model.dart';
import 'package:my_project/data/model/booking_flight_detail_model.dart';
import 'package:my_project/data/repositories/booking/booking_repository.dart';
import 'package:my_project/data/repositories/booking_flight/booking_flight_repository.dart';
import 'package:my_project/data/services/shared_service.dart';
import 'package:shimmer/shimmer.dart';

part 'bloc/payment_bloc.dart';
part 'bloc/payment_event.dart';
part 'bloc/payment_state.dart';
part 'page/pagement_page.dart';

