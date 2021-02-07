// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'src/stores/chat_list_page_store.dart';
import 'src/stores/chat_page_store.dart';
import 'src/services/sms_service.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.factory<ChatListPageStore>(() => ChatListPageStore(get<SmsService>()));
  gh.factory<ChatPageStore>(() => ChatPageStore(get<SmsService>()));

  // Eager singletons must be registered in the right order
  gh.singleton<SmsService>(SmsService());
  return get;
}
