library promo;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_project/app/common/enums/checkout_type.dart';
import 'package:my_project/app/common/widgets/my_alert_dialog.dart';
import 'package:my_project/app/common/widgets/my_secondary_button.dart';
import 'package:my_project/app/config/app_dimen.dart';
import 'package:my_project/app/config/app_path.dart';
import 'package:my_project/app/config/app_style.dart';
import 'package:my_project/app/features/checkout/checkout.dart';
import 'package:my_project/app/features/checkout_flight/checkout_flight.dart';
import 'package:my_project/data/model/promo_model.dart';
import 'package:my_project/data/repositories/promo/promo_repository.dart';

part 'cubit/promo_cubit.dart';
part 'cubit/promo_state.dart';
part 'page/promo_page.dart';
part 'widget/promo_header.dart';

