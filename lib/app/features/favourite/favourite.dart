library favourite;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/app/common/widgets/default_header.dart';
import 'package:my_project/app/common/widgets/my_confirm_dialog.dart';
import 'package:my_project/app/common/widgets/my_skeleton_rectangle.dart';
import 'package:my_project/app/config/app_color.dart';
import 'package:my_project/app/config/app_dimen.dart';
import 'package:my_project/app/config/app_style.dart';
import 'package:my_project/app/features/home/home.dart';
import 'package:my_project/app/features/hotels/hotels.dart';
import 'package:my_project/data/model/hotel_model.dart';
import 'package:my_project/data/model/place_model.dart';
import 'package:my_project/data/repositories/hotel/hotel_repository.dart';
import 'package:my_project/data/repositories/place/place_repository.dart';
import 'package:my_project/data/services/shared_service.dart';
import 'package:shimmer/shimmer.dart';

part 'cubit/favourite_cubit.dart';
part 'cubit/favourite_state.dart';
part 'page/favourite_page.dart';
