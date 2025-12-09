import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  getIt.init();
}