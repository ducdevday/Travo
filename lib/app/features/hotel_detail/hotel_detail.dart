library hotel_detail;

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_project/app/common/widgets/image_fullscreen.dart';
import 'package:my_project/app/common/widgets/my_developing.dart';
import 'package:my_project/app/common/widgets/my_primary_button.dart';
import 'package:my_project/app/common/widgets/my_skeleton_rectangle.dart';
import 'package:my_project/app/config/app_color.dart';
import 'package:my_project/app/config/app_dimen.dart';
import 'package:my_project/app/config/app_path.dart';
import 'package:my_project/app/config/app_style.dart';
import 'package:my_project/app/features/rooms/rooms.dart';
import 'package:my_project/app/utils/string_format_util.dart';
import 'package:my_project/data/model/hotel_model.dart';
import 'package:my_project/data/repositories/room/room_repository.dart';
import 'package:my_project/data/services/shared_service.dart';

part 'bloc/hotel_detail_bloc.dart';
part 'bloc/hotel_detail_event.dart';
part 'bloc/hotel_detail_state.dart';
part 'page/hotel_detail_page.dart';
part 'widgets/hotel_detail_header.dart';
part 'widgets/more_item.dart';