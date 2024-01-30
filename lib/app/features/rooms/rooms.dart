library rooms;

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_project/app/common/widgets/image_fullscreen.dart';
import 'package:my_project/app/common/widgets/my_card.dart';
import 'package:my_project/app/common/widgets/my_primary_button.dart';
import 'package:my_project/app/common/widgets/my_skeleton_rectangle.dart';
import 'package:my_project/app/common/widgets/my_tooltip.dart';
import 'package:my_project/app/config/app_color.dart';
import 'package:my_project/app/config/app_dimen.dart';
import 'package:my_project/app/config/app_path.dart';
import 'package:my_project/app/config/app_style.dart';
import 'package:my_project/app/features/checkout/checkout.dart';
import 'package:my_project/app/utils/string_format_util.dart';
import 'package:my_project/data/model/room_model.dart';
import 'package:my_project/data/repositories/room/room_repository.dart';
import 'package:my_project/data/services/shared_service.dart';
import 'package:overlay_tooltip/overlay_tooltip.dart';
import 'package:overlay_tooltip/src/impl.dart';
import 'package:shimmer/shimmer.dart';

part 'bloc/rooms_bloc.dart';
part 'bloc/rooms_event.dart';
part 'bloc/rooms_state.dart';
part 'page/room_page.dart';
part 'widgets/room_header.dart';
part 'widgets/room_item.dart';
part 'widgets/room_item_select.dart';
part 'widgets/service_item.dart';