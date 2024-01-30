library booking_detail;

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_project/app/common/enums/payment_type.dart';
import 'package:my_project/app/common/widgets/my_card.dart';
import 'package:my_project/app/common/widgets/my_error.dart';
import 'package:my_project/app/common/widgets/my_loading.dart';
import 'package:my_project/app/common/widgets/my_skeleton_rectangle.dart';
import 'package:my_project/app/config/app_color.dart';
import 'package:my_project/app/config/app_dimen.dart';
import 'package:my_project/app/config/app_path.dart';
import 'package:my_project/app/config/app_style.dart';
import 'package:my_project/app/features/checkout/checkout.dart';
import 'package:my_project/app/features/default/page/default_page.dart';
import 'package:my_project/app/utils/card_util.dart';
import 'package:my_project/app/utils/string_format_util.dart';
import 'package:my_project/data/model/booking_detail_model.dart';
import 'package:my_project/data/model/card_model.dart';
import 'package:my_project/data/model/guest_model.dart';
import 'package:my_project/data/model/promo_model.dart';
import 'package:my_project/data/repositories/booking/booking_repository.dart';
import 'package:ticket_material/ticket_material.dart';

part 'bloc/booking_detail_bloc.dart';

part 'bloc/booking_detail_event.dart';

part 'bloc/booking_detail_state.dart';

part 'page/booking_detail_page.dart';

part 'widgets/booking_date_detail.dart';

part 'widgets/booking_detail_header.dart';

part 'widgets/contact_detail.dart';

part 'widgets/payment_detail.dart';

part 'widgets/promo_detail.dart';

part 'widgets/total_price_detail.dart';
