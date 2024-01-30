library home;

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_project/app/common/widgets/my_avatar.dart';
import 'package:my_project/app/common/widgets/my_developing.dart';
import 'package:my_project/app/common/widgets/my_skeleton_rectangle.dart';
import 'package:my_project/app/config/app_color.dart';
import 'package:my_project/app/config/app_dimen.dart';
import 'package:my_project/app/config/app_path.dart';
import 'package:my_project/app/config/app_style.dart';
import 'package:my_project/app/features/default/bloc/user_cubit.dart';
import 'package:my_project/app/features/default/widgets/bottombar/my_bottom_nav_bar_cubit.dart';
import 'package:my_project/app/features/flight_search/flight_search.dart';
import 'package:my_project/app/features/hotels/hotels.dart';
import 'package:my_project/app/features/profile/profile.dart';
import 'package:my_project/data/model/place_model.dart';
import 'package:my_project/data/repositories/place/place_repository.dart';
import 'package:my_project/data/services/shared_service.dart';
import 'package:shimmer/shimmer.dart';

part 'bloc/home_bloc.dart';
part 'bloc/home_event.dart';
part 'bloc/home_state.dart';
part 'page/home_page.dart';
part 'widgets/home_header.dart';
part 'widgets/home_item.dart';
part 'widgets/home_search_bar.dart';
part 'widgets/place_item.dart';
