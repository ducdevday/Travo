library booking_flight_detail;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_project/app/common/widgets/my_card.dart';
import 'package:my_project/app/common/widgets/my_error.dart';
import 'package:my_project/app/common/widgets/my_loading.dart';
import 'package:my_project/app/config/app_color.dart';
import 'package:my_project/app/config/app_dimen.dart';
import 'package:my_project/app/config/app_path.dart';
import 'package:my_project/app/config/app_style.dart';
import 'package:my_project/app/features/booking_detail/booking_detail.dart';
import 'package:my_project/app/features/booking_flight_detail/bloc/booking_flight_detail_bloc.dart';
import 'package:my_project/app/features/checkout/checkout.dart';
import 'package:my_project/app/features/checkout_flight/checkout_flight.dart';
import 'package:my_project/app/features/default/page/default_page.dart';
import 'package:my_project/app/utils/string_format_util.dart';
import 'package:my_project/data/model/booking_flight_detail_model.dart';
import 'package:my_project/data/model/guest_model.dart';
import 'package:my_project/data/repositories/booking_flight/booking_flight_repository.dart';

part 'page/booking_flight_detail_page.dart';

part 'widgets/booking_flight_detail_header.dart';

part 'widgets/contact_detail.dart';
