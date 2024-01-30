library checkout;

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_project/app/common/enums/checkout_type.dart';
import 'package:my_project/app/common/enums/payment_type.dart';
import 'package:my_project/app/common/widgets/my_alert_dialog.dart';
import 'package:my_project/app/common/widgets/my_card.dart';
import 'package:my_project/app/common/widgets/my_confirm_dialog.dart';
import 'package:my_project/app/common/widgets/my_primary_button.dart';
import 'package:my_project/app/common/widgets/my_radio.dart';
import 'package:my_project/app/common/widgets/my_skeleton_rectangle.dart';
import 'package:my_project/app/config/app_color.dart';
import 'package:my_project/app/config/app_dimen.dart';
import 'package:my_project/app/config/app_path.dart';
import 'package:my_project/app/config/app_style.dart';
import 'package:my_project/app/features/add_card/add_card.dart';
import 'package:my_project/app/features/booking_date/booking_date.dart';
import 'package:my_project/app/features/booking_detail/booking_detail.dart';
import 'package:my_project/app/features/checkout_flight/checkout_flight.dart';
import 'package:my_project/app/features/contact/contact.dart';
import 'package:my_project/app/features/default/bloc/user_cubit.dart';
import 'package:my_project/app/features/promo/promo.dart';
import 'package:my_project/app/features/rooms/rooms.dart';
import 'package:my_project/app/utils/card_util.dart';
import 'package:my_project/app/utils/string_format_util.dart';
import 'package:my_project/data/model/booking_model.dart';
import 'package:my_project/data/model/card_model.dart';
import 'package:my_project/data/model/guest_model.dart';
import 'package:my_project/data/model/promo_model.dart';
import 'package:my_project/data/model/room_model.dart';
import 'package:my_project/data/repositories/booking/booking_repository.dart';
import 'package:ticket_material/ticket_material.dart';

part 'bloc/checkout_bloc.dart';

part 'bloc/checkout_event.dart';

part 'bloc/checkout_state.dart';

part 'page/checkout_page.dart';

part 'widgets/add_button.dart';

part 'widgets/booking_and_review_step.dart';

part 'widgets/booking_date_infomation.dart';

part 'widgets/card_item.dart';

part 'widgets/checkout_header.dart';

part 'widgets/confirm_step.dart';

part 'widgets/contact_information.dart';

part 'widgets/go_to_confirm_button.dart';

part 'widgets/go_to_payment_button.dart';

part 'widgets/payment_information.dart';

part 'widgets/payment_step.dart';

part 'widgets/promo_information.dart';

part 'widgets/room_item_booking.dart';

part 'widgets/room_item_confirm.dart';

part 'widgets/total_price_infomation.dart';
