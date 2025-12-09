import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/client/presentation/views/tabs/my_jobs/presentation/view_model/offers_notification_cubit/offers_notification_cubit.dart';
import 'di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(

 
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
  
)

Future<void> configureDependencies() async {
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => Supabase.instance.client);

  // 👇 لازم جداً — تسجيل الكيوبت هنا
  getIt.registerLazySingleton<OffersNotificationCubit>(
        () => OffersNotificationCubit(),
  );

  getIt.init();
}
