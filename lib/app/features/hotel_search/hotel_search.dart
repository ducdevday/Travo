library hotel_search;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_project/app/config/app_color.dart';
import 'package:my_project/app/config/app_dimen.dart';
import 'package:my_project/app/config/app_path.dart';
import 'package:my_project/app/config/app_style.dart';
import 'package:my_project/app/features/hotels/hotels.dart';
import 'package:my_project/data/model/hotel_model.dart';
import 'package:my_project/data/repositories/hotel/hotel_repository.dart';

part "cubit/hotel_search_cubit.dart";
part 'cubit/hotel_search_state.dart';
part 'page/hotel_search_page.dart';
part 'widgets/hotel_search_bar.dart';
part 'widgets/hotel_search_header.dart';
