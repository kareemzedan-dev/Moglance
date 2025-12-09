// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

import '../../features/attachments/data/data_sources/remote/attachments_remote_data_source/attachments_remote_data_source.dart'
    as _i1020;
import '../../features/attachments/data/data_sources_impl/remote/attachments_remote_data_source_impl/attachments_remote_data_source_impl.dart'
    as _i568;
import '../../features/attachments/data/repositories/attachments_repository_impl/attachments_repository_impl.dart'
    as _i727;
import '../../features/attachments/domain/repositories/attachments_repository/attachments_repository.dart'
    as _i345;
import '../../features/attachments/domain/use_cases/delete_attachments/delete_attachments_use_case.dart'
    as _i416;
import '../../features/attachments/domain/use_cases/download_attachments/download_attachments.dart'
    as _i197;
import '../../features/attachments/domain/use_cases/upload_attachments/upload_attachments_use_case.dart'
    as _i231;
import '../../features/attachments/presentation/manager/delete_attachments_view_model/delete_attachments_view_model.dart'
    as _i195;
import '../../features/attachments/presentation/manager/download_attachments_view_model/download_attachments_view_model.dart'
    as _i338;
import '../../features/attachments/presentation/manager/upload_attachments_view_model/upload_attachments_view_model.dart'
    as _i11;
import '../../features/attachments/presentation/manager/upload_order_attachments_view_model/upload_order_attachments_view_model.dart'
    as _i679;
import '../../features/auth/data/data_sources/remote/auth_remote_data_source.dart'
    as _i432;
import '../../features/auth/data/data_sources/remote/change_password_remote_data_source/change_password_remote_data_source.dart'
    as _i610;
import '../../features/auth/data/data_sources/remote/forget_password_remote_data_source/forget_password_remote_data_source.dart'
    as _i246;
import '../../features/auth/data/data_sources/remote/reset_password_remote_data_source/reset_password_remote_data_source.dart'
    as _i869;
import '../../features/auth/data/data_sources_impl/remote/auth_remote_data_source_impl.dart'
    as _i420;
import '../../features/auth/data/data_sources_impl/remote/change_password_remote_data_source_impl/change_password_remote_data_source_impl.dart'
    as _i443;
import '../../features/auth/data/data_sources_impl/remote/forget_password_remote_data_source_impl/forget_password_remote_data_source_impl.dart'
    as _i176;
import '../../features/auth/data/data_sources_impl/remote/reset_password_remote_data_source_impl/reset_password_remote_data_source_impl.dart'
    as _i253;
import '../../features/auth/data/repos_impl/auth/auth_repo_impl.dart' as _i529;
import '../../features/auth/data/repos_impl/auth/change_password_repo_impl/change_password_repo_impl.dart'
    as _i475;
import '../../features/auth/data/repos_impl/auth/forget_password_repo_impl/forget_password_repo_impl.dart'
    as _i303;
import '../../features/auth/domain/repos/auth/auth_repo.dart' as _i746;
import '../../features/auth/domain/repos/auth/change_password_repo/change_password_repo.dart'
    as _i131;
import '../../features/auth/domain/repos/auth/forget_password_repo/forget_password_repo.dart'
    as _i562;
import '../../features/auth/domain/repos/auth/reset_password_repo/reset_password_repo.dart'
    as _i391;
import '../../features/auth/domain/use_cases/auth/auth_use_case.dart' as _i630;
import '../../features/auth/domain/use_cases/auth/change_password_use_case/change_password_use_case.dart'
    as _i647;
import '../../features/auth/domain/use_cases/auth/forget_password_use_case/forget_password_use_case.dart'
    as _i1013;
import '../../features/auth/domain/use_cases/auth/reset_password_use_case/reset_password_use_case.dart'
    as _i667;
import '../../features/auth/presentation/cubit/auth_view_model.dart' as _i745;
import '../../features/auth/presentation/cubit/change_password_view_model/change_password_view_model.dart'
    as _i205;
import '../../features/auth/presentation/cubit/forget_password_view_model/forget_password_view_model.dart'
    as _i1025;
import '../../features/client/data/data_sources/remote/delete_order_data_source/delete_order_data_source.dart'
    as _i673;
import '../../features/client/data/data_sources/remote/home_remote_data_source.dart'
    as _i307;
import '../../features/client/data/data_sources/remote/my_jobs_remote_data_source.dart'
    as _i41;
import '../../features/client/data/data_sources_impl/remote/delete_order_data_source_impl/delete_order_data_source_impl.dart'
    as _i930;
import '../../features/client/data/data_sources_impl/remote/home_remote_data_source_impl.dart'
    as _i426;
import '../../features/client/data/data_sources_impl/remote/my_jobs_remote_data_source_impl.dart'
    as _i95;
import '../../features/client/data/repos/home/home_repo_impl.dart' as _i86;
import '../../features/client/data/repos/my_jobs/delete_order_repo_impl/delete_order_repo_impl.dart'
    as _i402;
import '../../features/client/data/repos/my_jobs/my_jobs_repo_impl.dart'
    as _i1023;
import '../../features/client/domain/repos/home/home_repos.dart' as _i660;
import '../../features/client/domain/repos/my_jobs/delete_order_repo/delete_order_repo.dart'
    as _i337;
import '../../features/client/domain/repos/my_jobs/my_jobs_repo.dart' as _i896;
import '../../features/client/domain/use_cases/home/get_all_freelancers_use_case/get_all_freelancers_use_case.dart'
    as _i988;
import '../../features/client/domain/use_cases/home/get_all_services_use_case/get_all_services_use_case.dart'
    as _i628;
import '../../features/client/domain/use_cases/home/place_order_use_case/place_order_use_case.dart'
    as _i904;
import '../../features/client/domain/use_cases/my_jobs/accept_offer_use_case/accept_offer_use_case.dart'
    as _i213;
import '../../features/client/domain/use_cases/my_jobs/delete_order_use_case/delete_order_use_case.dart'
    as _i859;
import '../../features/client/domain/use_cases/my_jobs/get_offers_for_order_use_case/get_offers_for_order_use_case.dart'
    as _i863;
import '../../features/client/domain/use_cases/my_jobs/subscribe_to_offer_status_use_case/subscribe_to_offer_status_use_case.dart'
    as _i86;
import '../../features/client/domain/use_cases/my_jobs/subscribe_to_order_status_use_case/subscribe_to_order_status_use_case.dart'
    as _i576;
import '../../features/client/domain/use_cases/my_jobs/subscribe_to_orders_use_case/subscribe_to_orders_use_case.dart'
    as _i454;
import '../../features/client/domain/use_cases/my_jobs/update_offer_status_use_case/update_offer_status_use_case.dart'
    as _i530;
import '../../features/client/presentation/views/tabs/home/presentation/view_model/fetch_all_freelancers_view_model/fetch_all_freelancers_view_model.dart'
    as _i670;
import '../../features/client/presentation/views/tabs/home/presentation/view_model/place_order_view_model/place_order_view_model.dart'
    as _i779;
import '../../features/client/presentation/views/tabs/home/presentation/view_model/services_view_model/services_view_model.dart'
    as _i869;
import '../../features/client/presentation/views/tabs/my_jobs/presentation/view_model/client_order_status_view_model/client_order_status_view_model.dart'
    as _i765;
import '../../features/client/presentation/views/tabs/my_jobs/presentation/view_model/delete_order_view_model/delete_order_view_model.dart'
    as _i413;
import '../../features/client/presentation/views/tabs/my_jobs/presentation/view_model/get_offers_view_model/get_offers_view_model.dart'
    as _i920;
import '../../features/client/presentation/views/tabs/my_jobs/presentation/view_model/get_order_view_model.dart/get_order_view_model.dart'
    as _i855;
import '../../features/client/presentation/views/tabs/my_jobs/presentation/view_model/offers_notification_cubit/offers_notification_cubit.dart'
    as _i445;
import '../../features/client/presentation/views/tabs/my_jobs/presentation/view_model/update_offer_status_view_model/update_offer_status_view_model.dart'
    as _i376;
import '../../features/freelancer/data/data_sources/remote/earings_remote_data_source/add_earning_remote_data_source/add_earning_remote_data_source.dart'
    as _i224;
import '../../features/freelancer/data/data_sources/remote/earings_remote_data_source/get_earning_remote_data_source/get_earning_remote_data_source.dart'
    as _i706;
import '../../features/freelancer/data/data_sources/remote/earings_remote_data_source/get_withdrawal_history_remote_data_source/get_withdrawal_history_remote_data_source.dart'
    as _i329;
import '../../features/freelancer/data/data_sources/remote/earings_remote_data_source/place_withdrawal_balance_remote_data_source/place_withdrawal_balance_remote_data_source.dart'
    as _i778;
import '../../features/freelancer/data/data_sources/remote/favorite_order_remote_data_source/add_favorite_order_remote_data_source/add_favorite_order_remote_data_source.dart'
    as _i121;
import '../../features/freelancer/data/data_sources/remote/favorite_order_remote_data_source/get_favorite_order_remote_data_source/get_favorite_order_remote_data_source.dart'
    as _i490;
import '../../features/freelancer/data/data_sources/remote/favorite_order_remote_data_source/get_favourite_order_details_remote_data_source/get_favourite_order_details_remote_data_source.dart'
    as _i504;
import '../../features/freelancer/data/data_sources/remote/favorite_order_remote_data_source/is_order_favorite_remote_data_source/is_order_favorite_remote_data_source.dart'
    as _i346;
import '../../features/freelancer/data/data_sources/remote/favorite_order_remote_data_source/remove_favorite_order_remote_data_source/remove_favorite_order_remote_data_source.dart'
    as _i302;
import '../../features/freelancer/data/data_sources/remote/freelancer_orders/fetch_private_orders_remote_data_source/fetch_private_orders_remote_data_source.dart'
    as _i765;
import '../../features/freelancer/data/data_sources/remote/freelancer_orders/fetch_public_orders_remote_data_source/fetch_public_orders_remote_data_source.dart'
    as _i13;
import '../../features/freelancer/data/data_sources/remote/freelancer_orders/subscribe_to_private_orders_remote_data_source/subscribe_to_private_orders_remote_data_source.dart'
    as _i118;
import '../../features/freelancer/data/data_sources/remote/freelancer_orders/subscribe_to_public_orders_remote_data_source/subscribe_to_public_orders_remote_data_source.dart'
    as _i701;
import '../../features/freelancer/data/data_sources/remote/freelancer_orders/update_order_status_remote_data_source/update_order_status_remote_data_source.dart'
    as _i254;
import '../../features/freelancer/data/data_sources/remote/freelancer_orders/withdraw_offer_remote_data_source/withdraw_offer_remote_data_source.dart'
    as _i735;
import '../../features/freelancer/data/data_sources/remote/get_commission_remote_data_source/get_commission_remote_data_source.dart'
    as _i884;
import '../../features/freelancer/data/data_sources/remote/offer_data_source.dart'
    as _i358;
import '../../features/freelancer/data/data_sources_impl/remote/earings_remote_data_source_impl/add_earning_remote_data_source_impl/add_earning_remote_data_source_impl.dart'
    as _i806;
import '../../features/freelancer/data/data_sources_impl/remote/earings_remote_data_source_impl/get_earning_remote_data_source_impl/get_earning_remote_data_source_impl.dart'
    as _i874;
import '../../features/freelancer/data/data_sources_impl/remote/earings_remote_data_source_impl/get_withdrawal_history_remote_data_source_impl/get_withdrawal_history_remote_data_source_impl.dart'
    as _i715;
import '../../features/freelancer/data/data_sources_impl/remote/earings_remote_data_source_impl/place_withdrawal_balance_remote_data_source_impl/place_withdrawal_balance_remote_data_source_impl.dart'
    as _i633;
import '../../features/freelancer/data/data_sources_impl/remote/favorite_order_remote_data_source_impl/add_favorite_order_remote_data_source_impl/add_favorite_order_remote_data_source_impl.dart'
    as _i362;
import '../../features/freelancer/data/data_sources_impl/remote/favorite_order_remote_data_source_impl/get_favorite_order_remote_data_source_impl/get_favorite_order_remote_data_source_impl.dart'
    as _i740;
import '../../features/freelancer/data/data_sources_impl/remote/favorite_order_remote_data_source_impl/get_favourite_order_details_remote_data_source_impl/get_favourite_order_details_remote_data_source_impl.dart'
    as _i835;
import '../../features/freelancer/data/data_sources_impl/remote/favorite_order_remote_data_source_impl/is_order_favorite_remote_data_source_impl/is_order_favorite_remote_data_source_impl.dart'
    as _i216;
import '../../features/freelancer/data/data_sources_impl/remote/favorite_order_remote_data_source_impl/remove_favorite_order_remote_data_source_impl/remove_favorite_order_remote_data_source_impl.dart'
    as _i327;
import '../../features/freelancer/data/data_sources_impl/remote/freelancer_orders/fetch_private_orders_remote_data_source_impl/fetch_private_orders_remote_data_source_impl.dart'
    as _i919;
import '../../features/freelancer/data/data_sources_impl/remote/freelancer_orders/fetch_public_orders_remote_data_source_impl/fetch_public_orders_remote_data_source_impl.dart'
    as _i301;
import '../../features/freelancer/data/data_sources_impl/remote/freelancer_orders/subscribe_to_private_orders_remote_data_source_impl/subscribe_to_private_orders_remote_data_source_impl.dart'
    as _i737;
import '../../features/freelancer/data/data_sources_impl/remote/freelancer_orders/subscribe_to_public_orders_remote_data_source_impl/subscribe_to_public_orders_remote_data_source_impl.dart'
    as _i1004;
import '../../features/freelancer/data/data_sources_impl/remote/freelancer_orders/update_order_status_remote_data_source_impl/update_order_status_remote_data_source_impl.dart'
    as _i1028;
import '../../features/freelancer/data/data_sources_impl/remote/freelancers_offers/withdraw_offer_remote_data_source_impl/withdraw_offer_remote_data_source_impl.dart'
    as _i148;
import '../../features/freelancer/data/data_sources_impl/remote/get_commission_remote_data_source_impl/get_commission_remote_data_source_impl.dart'
    as _i22;
import '../../features/freelancer/data/data_sources_impl/remote/offer_remote_data_source_impl.dart'
    as _i35;
import '../../features/freelancer/data/repos/earings_repos_impl/add_earning_repo_impl/add_earning_repo_impl.dart'
    as _i862;
import '../../features/freelancer/data/repos/earings_repos_impl/get_earing_repo_impl/get_earing_repo_impl.dart'
    as _i636;
import '../../features/freelancer/data/repos/earings_repos_impl/get_withdrawal_history_repo_impl/get_withdrawal_history_repo_impl.dart'
    as _i216;
import '../../features/freelancer/data/repos/earings_repos_impl/place_withdrawal_balance_repo_impl/place_withdrawal_balance_repo_impl.dart'
    as _i536;
import '../../features/freelancer/data/repos/favorite_order_repos_impl/add_favorite_order_repo_impl/add_favorite_order_repo_impl.dart'
    as _i961;
import '../../features/freelancer/data/repos/favorite_order_repos_impl/get_favorite_order_repo_impl/get_favorite_order_repo_impl.dart'
    as _i678;
import '../../features/freelancer/data/repos/favorite_order_repos_impl/get_favourite_order_details_repo_impl/get_favourite_order_details_repo_impl.dart'
    as _i453;
import '../../features/freelancer/data/repos/favorite_order_repos_impl/is_order_favorite_repo_impl/is_order_favorite_repo_impl.dart'
    as _i1032;
import '../../features/freelancer/data/repos/favorite_order_repos_impl/remove_favorite_order_repo_impl/remove_favorite_order_repo_impl.dart'
    as _i43;
import '../../features/freelancer/data/repos/freelancer_order_repo_impl/fetch_private_orders_repo_impl/fetch_private_orders_repo_impl.dart'
    as _i101;
import '../../features/freelancer/data/repos/freelancer_order_repo_impl/fetch_public_orders_repo_impl/fetch_public_orders_repo_impl.dart'
    as _i216;
import '../../features/freelancer/data/repos/freelancer_order_repo_impl/subscribe_to_private_orders_repo_impl/subscribe_to_private_orders_repo_impl.dart'
    as _i512;
import '../../features/freelancer/data/repos/freelancer_order_repo_impl/subscribe_to_public_orders_repo_impl/subscribe_to_public_orders_repo_impl.dart'
    as _i211;
import '../../features/freelancer/data/repos/freelancer_order_repo_impl/update_order_status_repo_impl/update_order_status_repo_impl.dart'
    as _i90;
import '../../features/freelancer/data/repos/freelancer_order_repo_impl/withdraw_offer_repo_impl/withdraw_offer_repo_impl.dart'
    as _i753;
import '../../features/freelancer/data/repos/get_commission_repo_impl/get_commission_repo_impl.dart'
    as _i948;
import '../../features/freelancer/data/repos/offer_repository_impl/offer_repository_impl.dart'
    as _i792;
import '../../features/freelancer/domain/repos/earings_repos/add_earing_repo/add_earing_repo.dart'
    as _i241;
import '../../features/freelancer/domain/repos/earings_repos/get_earning_repo/get_earning_repo.dart'
    as _i176;
import '../../features/freelancer/domain/repos/earings_repos/get_withdrawal_history_repo/get_withdrawal_history_repo.dart'
    as _i563;
import '../../features/freelancer/domain/repos/earings_repos/place_withdrawal_balance_repo/place_withdrawal_balance_repo.dart'
    as _i199;
import '../../features/freelancer/domain/repos/favorite_order_repos/add_favorite_order_repo/add_favorite_order_repo.dart'
    as _i679;
import '../../features/freelancer/domain/repos/favorite_order_repos/get_favorite_order_repo/get_favorite_order_repo.dart'
    as _i554;
import '../../features/freelancer/domain/repos/favorite_order_repos/get_favourite_order_details_repo/get_favourite_order_details.dart'
    as _i6;
import '../../features/freelancer/domain/repos/favorite_order_repos/is_order_favorite_repo/is_order_favorite_repo.dart'
    as _i663;
import '../../features/freelancer/domain/repos/favorite_order_repos/remove_favorite_order_repo/remove_favorite_order_repo.dart'
    as _i157;
import '../../features/freelancer/domain/repos/freelancer_order_repo/fetch_private_orders_repo/fetch_private_orders_repo.dart'
    as _i646;
import '../../features/freelancer/domain/repos/freelancer_order_repo/fetch_public_orders_repo/fetch_public_orders_repo.dart'
    as _i1016;
import '../../features/freelancer/domain/repos/freelancer_order_repo/subscribe_to_private_orders_repo/subscribe_to_private_orders_repo.dart'
    as _i221;
import '../../features/freelancer/domain/repos/freelancer_order_repo/subscribe_to_public_orders_repo/subscribe_to_public_orders_repo.dart'
    as _i453;
import '../../features/freelancer/domain/repos/freelancer_order_repo/update_order_status_repo/update_order_status_repo.dart'
    as _i778;
import '../../features/freelancer/domain/repos/freelancer_order_repo/withdraw_offer_repo/withdraw_offer_repo.dart'
    as _i773;
import '../../features/freelancer/domain/repos/offer_repository/get_commission_repo/get_commission_repo.dart'
    as _i566;
import '../../features/freelancer/domain/repos/offer_repository/offer_repository.dart'
    as _i363;
import '../../features/freelancer/domain/use_cases/add_earning_use_case/add_earning_use_case.dart'
    as _i403;
import '../../features/freelancer/domain/use_cases/add_favorite_order_use_case/add_favorite_order_repo.dart'
    as _i891;
import '../../features/freelancer/domain/use_cases/fetch_order_details_use_case/fetch_order_details_use_case.dart'
    as _i988;
import '../../features/freelancer/domain/use_cases/fetch_private_orders_use_case/fetch_private_orders_use_case.dart'
    as _i2;
import '../../features/freelancer/domain/use_cases/fetch_public_orders_use_case/fetch_public_orders_use_case.dart'
    as _i166;
import '../../features/freelancer/domain/use_cases/get_commission_use_case/get_commission_use_case.dart'
    as _i935;
import '../../features/freelancer/domain/use_cases/get_earning_use_case/get_earning_use_case.dart'
    as _i922;
import '../../features/freelancer/domain/use_cases/get_favorite_order_use_case/get_favorite_order_repo.dart'
    as _i347;
import '../../features/freelancer/domain/use_cases/get_favourite_order_details_use_case/get_favourite_order_details_use_case.dart'
    as _i221;
import '../../features/freelancer/domain/use_cases/get_freelancer_offers_use_case/get_freelancer_offers_use_case.dart'
    as _i90;
import '../../features/freelancer/domain/use_cases/get_withdrawal_history_use_case/get_withdrawal_history_use_case.dart'
    as _i169;
import '../../features/freelancer/domain/use_cases/is_order_favorite_use_case/is_order_favorite_repo.dart'
    as _i451;
import '../../features/freelancer/domain/use_cases/place_withdrawal_balance_use_case/place_withdrawal_balance_use_case.dart'
    as _i788;
import '../../features/freelancer/domain/use_cases/remove_favorite_order_use_case/remove_favorite_order_repo.dart'
    as _i772;
import '../../features/freelancer/domain/use_cases/send_offer_use_case/send_offer_use_case.dart'
    as _i626;
import '../../features/freelancer/domain/use_cases/subscribe_to_private_orders_use_case/subscribe_to_private_orders_use_case.dart'
    as _i532;
import '../../features/freelancer/domain/use_cases/subscribe_to_public_orders_use_case/subscribe_to_public_orders_use_case.dart'
    as _i253;
import '../../features/freelancer/domain/use_cases/update_order_status_use_case/update_order_status_use_case.dart'
    as _i785;
import '../../features/freelancer/domain/use_cases/withdraw_offer_use_case/withdraw_offer_use_case.dart'
    as _i380;
import '../../features/freelancer/presentation/cubit/add_earnings_view_model/add_earnings_view_model.dart'
    as _i775;
import '../../features/freelancer/presentation/cubit/fetch_order_details_view_model/fetch_order_details_view_model.dart'
    as _i644;
import '../../features/freelancer/presentation/cubit/freelancer_info_view_model/freelancer_info_view_model.dart'
    as _i776;
import '../../features/freelancer/presentation/cubit/get_freelancer_offers_view_model/get_freelancer_offers_view_model.dart'
    as _i552;
import '../../features/freelancer/presentation/cubit/get_total_earnings_view_model/get_total_earnings_view_model.dart'
    as _i196;
import '../../features/freelancer/presentation/cubit/get_withdrawal_history_view_model/get_withdrawal_history_view_model.dart'
    as _i364;
import '../../features/freelancer/presentation/cubit/place_withdrawal_balance_view_model/place_withdrawal_balance_view_model.dart'
    as _i195;
import '../../features/freelancer/presentation/cubit/update_order_status_view_model/update_order_status_view_model.dart'
    as _i975;
import '../../features/freelancer/presentation/cubit/withdraw_offer_view_model/withdraw_offer_view_model.dart'
    as _i278;
import '../../features/freelancer/presentation/views/tabs/find_work/presentation/view_model/add_favorite_order_view_model/add_favorite_order_view_model.dart'
    as _i78;
import '../../features/freelancer/presentation/views/tabs/find_work/presentation/view_model/freelancer_private_orders_view_model/freelancer_private_orders_view_model.dart'
    as _i370;
import '../../features/freelancer/presentation/views/tabs/find_work/presentation/view_model/freelancer_public_order_view_model/freelancer_public_order_view_model.dart'
    as _i1000;
import '../../features/freelancer/presentation/views/tabs/find_work/presentation/view_model/get_commission_view_model/get_commission_view_model.dart'
    as _i946;
import '../../features/freelancer/presentation/views/tabs/find_work/presentation/view_model/get_favorite_order_view_model/get_favorite_order_view_model.dart'
    as _i553;
import '../../features/freelancer/presentation/views/tabs/find_work/presentation/view_model/get_favourite_order_details_view_model/get_favourite_order_details_view_model.dart'
    as _i737;
import '../../features/freelancer/presentation/views/tabs/find_work/presentation/view_model/is_order_favorite_view_model/is_order_favorite_view_model.dart'
    as _i123;
import '../../features/freelancer/presentation/views/tabs/find_work/presentation/view_model/remove_favorite_order_view_model/remove_favorite_order_view_model.dart'
    as _i520;
import '../../features/freelancer/presentation/views/tabs/find_work/presentation/view_model/send_offer_view_model/send_offer_view_model.dart'
    as _i658;
import '../../features/freelancer/presentation/views/tabs/find_work/presentation/view_model/subscribe_to_private_orders_view_model/subscribe_to_private_orders_view_model.dart'
    as _i823;
import '../../features/freelancer/presentation/views/tabs/find_work/presentation/view_model/subscribe_to_public_orders_view_model/subscribe_to_public_orders_view_model.dart'
    as _i656;
import '../../features/messages/data/data_sources/remote/delete_message_remote_data_source/delete_message_remote_data_source.dart'
    as _i191;
import '../../features/messages/data/data_sources/remote/get_accepted_order_message_remote_data_source/get_accepted_order_message_remote_data_source.dart'
    as _i1006;
import '../../features/messages/data/data_sources/remote/get_admin_messages_remote_data_source/get_admin_messages_remote_data_source.dart'
    as _i815;
import '../../features/messages/data/data_sources/remote/get_conversations_remote_data_source/get_conversations_remote_data_source.dart'
    as _i572;
import '../../features/messages/data/data_sources/remote/get_order_messages_remote_data_source/get_order_messages_remote_data_source.dart'
    as _i219;
import '../../features/messages/data/data_sources/remote/mark_messages_as_read_remote_data_source/mark_messages_as_read_remote_data_source.dart'
    as _i458;
import '../../features/messages/data/data_sources/remote/send_messages_remote_data_source/send_messages_remote_data_source.dart'
    as _i902;
import '../../features/messages/data/data_sources/remote/send_to_admin_messages_remote_data_source/send_to_admin_messages_remote_data_source.dart'
    as _i876;
import '../../features/messages/data/data_sources/remote/subscribe_to_admin_messages_remote_data_source/subscribe_to_admin_messages_remote_data_source.dart'
    as _i798;
import '../../features/messages/data/data_sources/remote/subscribe_to_messages_remote_data_source/subscribe_to_messages_remote_data_source.dart'
    as _i462;
import '../../features/messages/data/data_sources/remote/subscribe_to_unread_messages_remote_data_source/subscribe_to_unread_messages_remote_data_source.dart'
    as _i864;
import '../../features/messages/data/data_sources/remote/user_status_remote_data_source/user_status_remote_data_source.dart'
    as _i703;
import '../../features/messages/data/data_sources_impl/remote/delete_message_remote_data_source_impl/delete_message_remote_data_source_impl.dart'
    as _i65;
import '../../features/messages/data/data_sources_impl/remote/get_accepted_order_message_remote_data_source_impl/get_accepted_order_message_remote_data_source_impl.dart'
    as _i113;
import '../../features/messages/data/data_sources_impl/remote/get_admin_messages_remote_data_source_impl/get_admin_messages_remote_data_source_impl.dart'
    as _i422;
import '../../features/messages/data/data_sources_impl/remote/get_conversations_remote_data_source_impl/get_conversations_remote_data_source_impl.dart'
    as _i160;
import '../../features/messages/data/data_sources_impl/remote/get_order_messages_remote_data_source_impl/get_order_messages_remote_data_source_impl.dart'
    as _i652;
import '../../features/messages/data/data_sources_impl/remote/mark_messages_as_read_remote_data_source_impl/mark_messages_as_read_remote_data_source_impl.dart'
    as _i1015;
import '../../features/messages/data/data_sources_impl/remote/send_messages_remote_data_source_impl/send_messages_remote_data_source_impl.dart'
    as _i522;
import '../../features/messages/data/data_sources_impl/remote/send_to_admin_messages_remote_data_source_impl/send_to_admin_messages_remote_data_source_impl.dart'
    as _i832;
import '../../features/messages/data/data_sources_impl/remote/subscribe_to_admin_messages_remote_data_source_impl/subscribe_to_admin_messages_remote_data_source_impl.dart'
    as _i579;
import '../../features/messages/data/data_sources_impl/remote/subscribe_to_messages_remote_data_source_impl/subscribe_to_messages_remote_data_source_impl.dart'
    as _i894;
import '../../features/messages/data/data_sources_impl/remote/subscribe_to_unread_messages_remote_data_source_impl/subscribe_to_unread_messages_remote_data_source_impl.dart'
    as _i164;
import '../../features/messages/data/data_sources_impl/remote/user_status_remote_data_source_impl/user_status_remote_data_source_impl.dart'
    as _i301;
import '../../features/messages/data/repositories/delete_message_repo_impl/delete_message_repo_impl.dart'
    as _i718;
import '../../features/messages/data/repositories/get_accepted_order_message_repo_impl/get_accepted_order_message_repo_impl.dart'
    as _i1048;
import '../../features/messages/data/repositories/get_admin_messages_repo_impl/get_admin_messages_repo_impl.dart'
    as _i1006;
import '../../features/messages/data/repositories/get_conversation_repo_impl/get_conversation_repo_impl.dart'
    as _i402;
import '../../features/messages/data/repositories/get_order_messages_repo_impl/get_order_messages_repo_impl.dart'
    as _i661;
import '../../features/messages/data/repositories/mark_messages_as_read_repo_impl/mark_messages_as_read_repo_impl.dart'
    as _i718;
import '../../features/messages/data/repositories/send_messages_repo_impl/send_messages_repo_impl.dart'
    as _i406;
import '../../features/messages/data/repositories/send_to_admin_messages_repo_impl/send_to_admin_messages_repo_impl.dart'
    as _i329;
import '../../features/messages/data/repositories/subscribe_to_admin_messages_repo_impl/subscribe_to_admin_messages_repo_impl.dart'
    as _i1062;
import '../../features/messages/data/repositories/subscribe_to_messages_repo_impl/subscribe_to_messages_repo_impl.dart'
    as _i92;
import '../../features/messages/data/repositories/subscribe_to_unread_messages_repo_impl/subscribe_to_unread_messages_repo_impl.dart'
    as _i420;
import '../../features/messages/data/repositories/user_status_repo_impl/user_status_repo_impl.dart'
    as _i755;
import '../../features/messages/domain/repositories/messages_repos/delete_message_repo/delete_message_repo.dart'
    as _i469;
import '../../features/messages/domain/repositories/messages_repos/get_accepted_order_message_repo/get_accepted_order_message_repo.dart'
    as _i81;
import '../../features/messages/domain/repositories/messages_repos/get_admin_messages_repo/get_admin_messages_repo.dart'
    as _i686;
import '../../features/messages/domain/repositories/messages_repos/get_conversation_repo/get_conversation_repo.dart'
    as _i257;
import '../../features/messages/domain/repositories/messages_repos/get_order_messages_repo/get_order_messages_repo.dart'
    as _i833;
import '../../features/messages/domain/repositories/messages_repos/mark_messages_as_read_repo/mark_messages_as_read_repo.dart'
    as _i113;
import '../../features/messages/domain/repositories/messages_repos/send_messages_repo/send_messages_repo.dart'
    as _i201;
import '../../features/messages/domain/repositories/messages_repos/send_to_admin_messages_repo/send_to_admin_messages_repo.dart'
    as _i493;
import '../../features/messages/domain/repositories/messages_repos/subscribe_to_admin_messages_repo/subscribe_to_admin_messages_repo.dart'
    as _i953;
import '../../features/messages/domain/repositories/messages_repos/subscribe_to_messages_repo/subscribe_to_messages_repo.dart'
    as _i196;
import '../../features/messages/domain/repositories/messages_repos/subscribe_to_unread_messages_repo/subscribe_to_unread_messages_repo.dart'
    as _i175;
import '../../features/messages/domain/repositories/messages_repos/user_status_repo/user_status_repo.dart'
    as _i325;
import '../../features/messages/domain/use_cases/delete_message_use_case/delete_message_use_case.dart'
    as _i988;
import '../../features/messages/domain/use_cases/get_accepted_order_message_use_case/get_accepted_order_message_use_case.dart'
    as _i997;
import '../../features/messages/domain/use_cases/get_admin_messages_use_case/get_admin_messages_use_case.dart'
    as _i841;
import '../../features/messages/domain/use_cases/get_conversations_use_case/get_conversations_use_case.dart'
    as _i61;
import '../../features/messages/domain/use_cases/get_order_messages_use_case/get_order_messages_use_case.dart'
    as _i416;
import '../../features/messages/domain/use_cases/mark_message_read_use_case/mark_message_read_use_case.dart'
    as _i367;
import '../../features/messages/domain/use_cases/send_message_use_case/send_message_use_case.dart'
    as _i366;
import '../../features/messages/domain/use_cases/send_to_admin_messages_use_case/send_to_admin_messages_use_case.dart'
    as _i929;
import '../../features/messages/domain/use_cases/subscribe_to_admin_messages_use_case/subscribe_to_admin_messages_use_case.dart'
    as _i1022;
import '../../features/messages/domain/use_cases/subscribe_to_messages_use_case/subscribe_to_messages_use_case.dart'
    as _i172;
import '../../features/messages/domain/use_cases/subscribe_to_unread_messages_use_case/subscribe_to_unread_messages_use_case.dart'
    as _i1021;
import '../../features/messages/domain/use_cases/user_status_use_case/user_status_use_case.dart'
    as _i258;
import '../../features/messages/presentation/manager/chat_avatars_view_model/chat_avatars_view_model.dart'
    as _i44;
import '../../features/messages/presentation/manager/chat_with_admin_view_model/chat_with_admin_view_model.dart'
    as _i584;
import '../../features/messages/presentation/manager/get_accepted_order_message_view_model/get_accepted_order_message_view_model.dart'
    as _i12;
import '../../features/messages/presentation/manager/get_admin_messages_view_model/get_admin_messages_view_model.dart'
    as _i662;
import '../../features/messages/presentation/manager/get_conversations_view_model/get_conversations_view_model.dart'
    as _i42;
import '../../features/messages/presentation/manager/get_messages_view_model/get_messages_view_model.dart'
    as _i389;
import '../../features/messages/presentation/manager/mark_message_as_read_view_model/mark_message_as_read_view_model.dart'
    as _i832;
import '../../features/messages/presentation/manager/messages_view_model/messages_view_model.dart'
    as _i147;
import '../../features/messages/presentation/manager/send_message_view_model/send_message_view_model.dart'
    as _i602;
import '../../features/messages/presentation/manager/send_to_admin_messages_view_model/send_to_admin_messages_view_model.dart'
    as _i744;
import '../../features/messages/presentation/manager/subscribe_to_admin_messages_view_model/subscribe_to_admin_messages_view_model.dart'
    as _i448;
import '../../features/messages/presentation/manager/subscribe_to_messages_view_model/subscribe_to_messages_view_model.dart'
    as _i61;
import '../../features/messages/presentation/manager/subscribe_to_unread_messages_view_model/subscribe_to_unread_messages_view_model.dart'
    as _i380;
import '../../features/messages/presentation/manager/unread_messages_badge_view_model/unread_messages_badge_view_model.dart'
    as _i881;
import '../../features/messages/presentation/manager/user_status_view_model/user_status_view_model.dart'
    as _i953;
import '../../features/payments/data/data_sources/remote/create_payment_remote_data_source.dart'
    as _i968;
import '../../features/payments/data/data_sources/remote/get_bank_accounts_remote_data_source/get_bank_accounts_remote_data_source.dart'
    as _i92;
import '../../features/payments/data/data_sources/remote/get_payment_remote_data_source.dart'
    as _i315;
import '../../features/payments/data/data_sources_impl/remote/create_payment_remote_data_source_impl.dart'
    as _i795;
import '../../features/payments/data/data_sources_impl/remote/get_bank_accounts_remote_data_source_impl/get_bank_accounts_remote_data_source_impl.dart'
    as _i326;
import '../../features/payments/data/data_sources_impl/remote/get_payment_remote_data_source_impl.dart'
    as _i696;
import '../../features/payments/data/repositories/get_bank_accounts_repo_impl/get_bank_accounts_repo_impl.dart'
    as _i706;
import '../../features/payments/data/repositories/payment_repo_impl/payment_repo_impl.dart'
    as _i488;
import '../../features/payments/domain/repositories/get_bank_account_repos/get_bank_account_repos.dart'
    as _i408;
import '../../features/payments/domain/repositories/payment_repos/payment_repo.dart'
    as _i815;
import '../../features/payments/domain/use_cases/create_payment_use_case/create_payment_use_case.dart'
    as _i618;
import '../../features/payments/domain/use_cases/get_bank_accounts_use_case/get_bank_accounts_use_case.dart'
    as _i837;
import '../../features/payments/domain/use_cases/get_payment/get_payment.dart'
    as _i848;
import '../../features/payments/presentation/manager/create_payment_view_model/create_payment_view_model.dart'
    as _i517;
import '../../features/payments/presentation/manager/get_bank_account_view_model/get_bank_account_view_model.dart'
    as _i227;
import '../../features/payments/presentation/manager/get_payment_view_model/get_payment_view_model.dart'
    as _i483;
import '../../features/profile/data/data_sources/profile_remote_data_source.dart'
    as _i1012;
import '../../features/profile/data/data_sources/update_user_profile_remote_data_source/update_user_profile_remote_data_source.dart'
    as _i748;
import '../../features/profile/data/data_sources_impl/profile_remote_data_source_impl.dart'
    as _i226;
import '../../features/profile/data/data_sources_impl/update_user_profile_remote_data_source_impl/update_user_profile_remote_data_source_impl.dart'
    as _i965;
import '../../features/profile/data/repositories/profile/profile_repo_impl.dart'
    as _i541;
import '../../features/profile/data/repositories/update_user_profile_repo_impl/update_user_profile_repo_impl.dart'
    as _i62;
import '../../features/profile/domain/entities/user_info_entity/user_info_entity.dart'
    as _i730;
import '../../features/profile/domain/repositories/profile/profile_repo.dart'
    as _i821;
import '../../features/profile/domain/repositories/update_user_profile_repo/update_user_profile_repo.dart'
    as _i517;
import '../../features/profile/domain/use_cases/profile/profile_use_case.dart'
    as _i585;
import '../../features/profile/domain/use_cases/update_user_profile_use_case/update_user_profile_use_case.dart'
    as _i669;
import '../../features/profile/presentation/manager/profile_view_model/profile_view_model.dart'
    as _i1003;
import '../../features/profile/presentation/manager/update_user_profile_view_model/update_user_profile_view_model.dart'
    as _i34;
import '../../features/reviews/data/data_sources/remote/reviews_remote_data_source/reviews_remote_data_source.dart'
    as _i114;
import '../../features/reviews/data/data_sources/remote/submit_rating_remote_data_source/submit_rating_remote_data_source.dart'
    as _i913;
import '../../features/reviews/data/data_sources_impl/remote/reviews_remote_data_source_impl/reviews_remote_data_source_impl.dart'
    as _i716;
import '../../features/reviews/data/data_sources_impl/remote/submit_rating_remote_data_source_impl/submit_rating_remote_data_source_impl.dart'
    as _i346;
import '../../features/reviews/data/repositories/reviews_repo_impl/reviews_repo_impl.dart'
    as _i81;
import '../../features/reviews/data/repositories/submit_rating_repo_impl/submit_rating_repo_impl.dart'
    as _i557;
import '../../features/reviews/domain/repositories/reviews_repo/reviews_repo.dart'
    as _i420;
import '../../features/reviews/domain/repositories/submit_rating_repo/submit_rating_repo.dart'
    as _i805;
import '../../features/reviews/domain/use_cases/get_user_reviews_use_case/get_user_reviews_use_case.dart'
    as _i701;
import '../../features/reviews/domain/use_cases/submit_rating_use_case/submit_rating_use_case.dart'
    as _i769;
import '../../features/reviews/presentation/manager/get_user_reviews_view_model/get_user_reviews_view_model.dart'
    as _i163;
import '../../features/reviews/presentation/manager/submit_rating_view_model/submit_rating_view_model.dart'
    as _i504;
import '../../features/shared/data/data_sources/remote/impl/orders_remote_data_source_impl.dart'
    as _i237;
import '../../features/shared/data/data_sources/remote/orders_remote_data_source.dart'
    as _i159;
import '../../features/shared/data/repos/orders/orders_repo_impl.dart' as _i553;
import '../../features/shared/domain/repos/orders/orders_repo.dart' as _i46;
import '../../features/shared/domain/use_cases/orders/orders_use_case.dart'
    as _i759;
import '../../features/shared/presentation/manager/subscribe_to_order_record_view_model/subscribe_to_order_record_view_model.dart'
    as _i28;
import '../services/file_uploaded_services.dart' as _i383;
import '../services/supabase_service.dart' as _i374;
import '../services/user_status_service.dart' as _i870;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i445.OffersNotificationCubit>(
      () => _i445.OffersNotificationCubit(),
    );
    gh.singleton<_i383.FilePickerService>(() => _i383.FilePickerService());
    gh.factory<_i114.ReviewsRemoteDataSource>(
      () => _i716.ReviewsRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.singleton<_i374.SupabaseService>(
      () => _i374.SupabaseService(gh<_i454.SupabaseClient>()),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i864.SubscribeToUnreadMessagesRemoteDataSource>(
      () => _i164.SubscribeToUnreadMessagesRemoteDataSourceImpl(
        gh<_i454.SupabaseClient>(),
      ),
    );
    gh.factory<_i224.AddEarningRemoteDataSource>(
      () => _i806.AddEarningRemoteDataSourceImpl(
        supabaseService: gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i610.ChangePasswordRemoteDataSource>(
      () =>
          _i443.ChangePasswordRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.factory<_i876.SendToAdminMessagesRemoteDataSource>(
      () => _i832.SendToAdminMessagesRemoteDataSourceImpl(
        gh<_i454.SupabaseClient>(),
      ),
    );
    gh.factory<_i458.MarkMessagesAsReadRemoteDataSource>(
      () => _i1015.MarkMessagesAsReadRemoteDataSourceImpl(
        supabaseService: gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i778.PlaceWithdrawalBalanceRemoteDataSource>(
      () => _i633.PlaceWithdrawalBalanceRemoteDataSourceImpl(
        supabaseService: gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i884.GetCommissionRemoteDataSource>(
      () => _i22.GetCommissionRemoteDataSourceImpl(
        supabaseService: gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i1006.GetAcceptedOrderMessageRemoteDataSource>(
      () => _i113.GetAcceptedOrderMessageRemoteDataSourceImpl(
        supabaseService: gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i315.GetPaymentRemoteDataSource>(
      () => _i696.GetPaymentRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.factory<_i92.GetBankAccountsRemoteDataSource>(
      () => _i326.GetBankAccountsRemoteDataSourceImpl(
        gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i199.PlaceWithdrawalBalanceRepo>(
      () => _i536.PlaceWithdrawalBalanceRepoImpl(
        placeWithdrawalBalanceRemoteDataSource:
            gh<_i778.PlaceWithdrawalBalanceRemoteDataSource>(),
      ),
    );
    gh.factory<_i788.PlaceWithdrawalBalanceUseCase>(
      () => _i788.PlaceWithdrawalBalanceUseCase(
        placeWithdrawalBalanceRepo: gh<_i199.PlaceWithdrawalBalanceRepo>(),
      ),
    );
    gh.factory<_i246.ForgetPasswordRemoteDataSource>(
      () =>
          _i176.ForgetPasswordRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.factory<_i175.SubscribeToUnreadMessagesRepo>(
      () => _i420.SubscribeToUnreadMessagesRepoImpl(
        gh<_i864.SubscribeToUnreadMessagesRemoteDataSource>(),
      ),
    );
    gh.factory<_i869.ResetPasswordRemoteDataSource>(
      () => _i253.ResetPasswordRemoteDataSourceImpl(),
    );
    gh.factory<_i566.GetCommissionRepo>(
      () => _i948.GetCommissionRepoImpl(
        getCommissionRemoteDataSource:
            gh<_i884.GetCommissionRemoteDataSource>(),
      ),
    );
    gh.factory<_i131.ChangePasswordRepo>(
      () => _i475.ChangePasswordRepoImpl(
        gh<_i610.ChangePasswordRemoteDataSource>(),
      ),
    );
    gh.factory<_i968.CreatePaymentRemoteDataSource>(
      () => _i795.CreatePaymentRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.factory<_i13.FetchPublicOrdersRemoteDataSource>(
      () => _i301.FetchPublicOrdersRemoteDataSourceImpl(
        gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i913.SubmitRatingRemoteDataSource>(
      () => _i346.SubmitRatingRemoteDataSourceImpl(gh<_i374.SupabaseService>()),
    );
    gh.factory<_i493.SendToAdminMessagesRepo>(
      () => _i329.SendToAdminMessagesRepoImpl(
        gh<_i876.SendToAdminMessagesRemoteDataSource>(),
      ),
    );
    gh.factory<_i815.PaymentRepos>(
      () => _i488.CreatePaymentRepoImpl(
        gh<_i968.CreatePaymentRemoteDataSource>(),
        gh<_i315.GetPaymentRemoteDataSource>(),
      ),
    );
    gh.factory<_i121.AddFavoriteOrderRemoteDataSource>(
      () => _i362.AddFavoriteOrderRemoteDataSourceImpl(
        gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i408.GetBankAccountsRepos>(
      () => _i706.GetBankAccountsRepoImpl(
        gh<_i92.GetBankAccountsRemoteDataSource>(),
      ),
    );
    gh.factory<_i219.GetOrderMessagesRemoteDataSource>(
      () => _i652.GetOrderMessagesRemoteDataSourceImpl(
        gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i358.OfferRemoteDataSource>(
      () => _i35.OfferRemoteDataSourceImpl(gh<_i374.SupabaseService>()),
    );
    gh.factory<_i902.SendMessagesRemoteDataSource>(
      () => _i522.SendMessagesRemoteDataSourceImpl(gh<_i374.SupabaseService>()),
    );
    gh.factory<_i765.FetchPrivateOrdersRemoteDataSource>(
      () => _i919.FetchPrivateOrdersRemoteDataSourceImpl(
        gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i420.ReviewsRepo>(
      () => _i81.ReviewsRepoImpl(
        remoteDataSource: gh<_i114.ReviewsRemoteDataSource>(),
      ),
    );
    gh.factory<_i832.MarkMessageAsReadViewModel>(
      () => _i832.MarkMessageAsReadViewModel(
        gh<_i458.MarkMessagesAsReadRemoteDataSource>(),
      ),
    );
    gh.factory<_i432.AuthRemoteDataSource>(
      () => _i420.AuthRemoteDataSourceImpl(gh<_i374.SupabaseService>()),
    );
    gh.factory<_i735.WithdrawOfferRemoteDataSource>(
      () =>
          _i148.WithdrawOfferRemoteDataSourceImpl(gh<_i374.SupabaseService>()),
    );
    gh.factory<_i504.GetFavouriteOrderDetailsRemoteDataSource>(
      () => _i835.GetFavouriteOrderDetailsRemoteDataSourceImpl(
        gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i833.GetOrderMessagesRepo>(
      () => _i661.GetOrderMessagesRepoImpl(
        remoteDataSource: gh<_i219.GetOrderMessagesRemoteDataSource>(),
      ),
    );
    gh.factory<_i673.DeleteOrderRemoteDataSource>(
      () => _i930.DeleteOrderDataSourceImpl(gh<_i374.SupabaseService>()),
    );
    gh.factory<_i490.GetFavoriteOrderRemoteDataSource>(
      () => _i740.GetFavoriteOrderRemoteDataSourceImpl(
        gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i363.OfferRepository>(
      () => _i792.OfferRepositoryImpl(gh<_i358.OfferRemoteDataSource>()),
    );
    gh.factory<_i746.AuthRepo>(
      () => _i529.AuthRepoImpl(gh<_i432.AuthRemoteDataSource>()),
    );
    gh.factory<_i302.RemoveFavoriteOrderRemoteDataSource>(
      () => _i327.RemoveFavoriteOrderRemoteDataSourceImpl(
        gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i118.SubscribeToPrivateOrdersRemoteDataSource>(
      () => _i737.SubscribeToPrivateOrdersRemoteDataSourceImpl(
        gh<_i374.SupabaseService>(),
        gh<_i765.FetchPrivateOrdersRemoteDataSource>(),
      ),
    );
    gh.factory<_i562.ForgetPasswordRepo>(
      () => _i303.ForgetPasswordRepoImpl(
        gh<_i246.ForgetPasswordRemoteDataSource>(),
      ),
    );
    gh.factory<_i191.DeleteMessageRemoteDataSource>(
      () => _i65.DeleteMessageRemoteDataSourceImpl(gh<_i374.SupabaseService>()),
    );
    gh.factory<_i572.GetConversationsRemoteDataSource>(
      () => _i160.GetUserConversationsRemoteDataSourceImpl(
        gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i159.OrdersRemoteDataSource>(
      () => _i237.OrdersRemoteDataSourceImpl(gh<_i374.SupabaseService>()),
    );
    gh.factory<_i41.MyJobsRemoteDataSource>(
      () => _i95.MyJobsRemoteDataSourceImpl(gh<_i374.SupabaseService>()),
    );
    gh.lazySingleton<_i416.GetOrderMessagesUseCase>(
      () => _i416.GetOrderMessagesUseCase(gh<_i833.GetOrderMessagesRepo>()),
    );
    gh.factory<_i1021.SubscribeToUnreadMessagesUseCase>(
      () => _i1021.SubscribeToUnreadMessagesUseCase(
        gh<_i175.SubscribeToUnreadMessagesRepo>(),
      ),
    );
    gh.factory<_i837.GetBankAccountsUseCase>(
      () => _i837.GetBankAccountsUseCase(gh<_i408.GetBankAccountsRepos>()),
    );
    gh.factory<_i257.GetConversationRepo>(
      () => _i402.GetConversationRepoImpl(
        gh<_i572.GetConversationsRemoteDataSource>(),
      ),
    );
    gh.factory<_i346.IsOrderFavoriteRemoteDataSource>(
      () => _i216.IsOrderFavoriteRemoteDataSourceImpl(
        gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i703.UserStatusRemoteDataSource>(
      () => _i301.UserStatusRemoteDataSourceImpl(gh<_i374.SupabaseService>()),
    );
    gh.factory<_i1012.ProfileRemoteDataSource>(
      () => _i226.ProfileRemoteDataSourceImpl(gh<_i374.SupabaseService>()),
    );
    gh.factory<_i647.ChangePasswordUseCase>(
      () => _i647.ChangePasswordUseCase(gh<_i131.ChangePasswordRepo>()),
    );
    gh.factory<_i748.UpdateUserProfileRemoteDataSource>(
      () => _i965.UpdateUserProfileRemoteDataSourceImpl(
        gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i241.AddEarningRepo>(
      () => _i862.AddEarningRepoImpl(
        addEarningRemoteDataSource: gh<_i224.AddEarningRemoteDataSource>(),
      ),
    );
    gh.singleton<_i870.UserStatusService>(
      () => _i870.UserStatusService(gh<_i374.SupabaseService>()),
    );
    gh.factory<_i815.GetAdminMessagesRemoteDataSource>(
      () => _i422.GetAdminMessagesRemoteDataSourceImpl(
        gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i701.SubscribeToPublicOrdersRemoteDataSource>(
      () => _i1004.SubscribeToPublicOrdersRemoteDataSourceImpl(
        gh<_i374.SupabaseService>(),
        gh<_i13.FetchPublicOrdersRemoteDataSource>(),
      ),
    );
    gh.factory<_i667.ResetPasswordUseCase>(
      () => _i667.ResetPasswordUseCase(gh<_i391.ResetPasswordRepo>()),
    );
    gh.factory<_i1013.ForgetPasswordUseCase>(
      () => _i1013.ForgetPasswordUseCase(gh<_i562.ForgetPasswordRepo>()),
    );
    gh.factory<_i798.SubscribeToAdminMessagesRemoteDataSource>(
      () => _i579.SubscribeToAdminMessagesRemoteDataSourceImpl(
        gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i254.UpdateOrderStatusRemoteDataSource>(
      () => _i1028.UpdateOrderStatusRemoteDataSourceImpl(
        gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i988.FetchOrderDetailsUseCase>(
      () => _i988.FetchOrderDetailsUseCase(gh<_i363.OfferRepository>()),
    );
    gh.factory<_i227.GetBankAccountViewModel>(
      () => _i227.GetBankAccountViewModel(gh<_i837.GetBankAccountsUseCase>()),
    );
    gh.factory<_i389.GetMessagesViewModel>(
      () => _i389.GetMessagesViewModel(gh<_i416.GetOrderMessagesUseCase>()),
    );
    gh.factory<_i644.FetchOrderDetailsViewModel>(
      () => _i644.FetchOrderDetailsViewModel(
        gh<_i988.FetchOrderDetailsUseCase>(),
      ),
    );
    gh.factory<_i157.RemoveFavoriteOrderRepo>(
      () => _i43.RemoveFavoriteOrderRepoImpl(
        gh<_i302.RemoveFavoriteOrderRemoteDataSource>(),
      ),
    );
    gh.factory<_i462.SubscribeToMessagesRemoteDataSource>(
      () => _i894.SubscribeToMessagesRemoteDataSourceImpl(
        supabaseService: gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i701.GetUserReviewsUseCase>(
      () => _i701.GetUserReviewsUseCase(gh<_i420.ReviewsRepo>()),
    );
    gh.factory<_i307.HomeRemoteDataSource>(
      () => _i426.HomeRemoteDataSourceImpl(
        supabaseService: gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i805.SubmitRatingRepo>(
      () => _i557.SubmitRatingRepoImpl(
        remoteDataSource: gh<_i913.SubmitRatingRemoteDataSource>(),
      ),
    );
    gh.factory<_i403.AddEarningUseCase>(
      () => _i403.AddEarningUseCase(addEarningRepo: gh<_i241.AddEarningRepo>()),
    );
    gh.factory<_i1020.AttachmentsRemoteDataSource>(
      () => _i568.AttachmentsRemoteDataSourceImpl(
        gh<_i361.Dio>(),
        gh<_i374.SupabaseService>(),
        gh<_i454.SupabaseClient>(),
      ),
    );
    gh.factory<_i706.GetEarningRemoteDataSource>(
      () => _i874.GetEarningRemoteDataSourceImpl(
        supabaseService: gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i953.SubscribeToAdminMessagesRepo>(
      () => _i1062.SubscribeToAdminMessagesRepoImpl(
        gh<_i798.SubscribeToAdminMessagesRemoteDataSource>(),
      ),
    );
    gh.factory<_i195.PlaceWithdrawalBalanceViewModel>(
      () => _i195.PlaceWithdrawalBalanceViewModel(
        gh<_i788.PlaceWithdrawalBalanceUseCase>(),
      ),
    );
    gh.factory<_i929.SendToAdminMessagesUseCase>(
      () =>
          _i929.SendToAdminMessagesUseCase(gh<_i493.SendToAdminMessagesRepo>()),
    );
    gh.factory<_i329.GetWithdrawalHistoryRemoteDataSource>(
      () => _i715.GetWithdrawalHistoryRemoteDataSourceImpl(
        supabaseService: gh<_i374.SupabaseService>(),
      ),
    );
    gh.factory<_i325.UserStatusRepo>(
      () => _i755.UserStatusRepoImpl(gh<_i703.UserStatusRemoteDataSource>()),
    );
    gh.factory<_i630.AuthUseCase>(
      () => _i630.AuthUseCase(gh<_i746.AuthRepo>()),
    );
    gh.factory<_i935.GetCommissionUseCase>(
      () => _i935.GetCommissionUseCase(
        getCommissionRepo: gh<_i566.GetCommissionRepo>(),
      ),
    );
    gh.factory<_i896.MyJobsRepo>(
      () => _i1023.MyJobsRepoImpl(
        myJobsRemoteDataSource: gh<_i41.MyJobsRemoteDataSource>(),
      ),
    );
    gh.factory<_i453.SubscribeToPublicOrdersRepo>(
      () => _i211.SubscribeToPublicOrdersRepoImpl(
        gh<_i701.SubscribeToPublicOrdersRemoteDataSource>(),
      ),
    );
    gh.factory<_i113.MarkMessagesAsReadRepo>(
      () => _i718.MarkMessagesAsReadRepoImpl(
        gh<_i458.MarkMessagesAsReadRemoteDataSource>(),
      ),
    );
    gh.factory<_i81.GetAcceptedOrderMessageRepo>(
      () => _i1048.GetAcceptedOrderMessageRepoImpl(
        getAcceptedOrderMessageRemoteDataSource:
            gh<_i1006.GetAcceptedOrderMessageRemoteDataSource>(),
      ),
    );
    gh.factory<_i1016.FetchPublicOrdersRepo>(
      () => _i216.FetchPublicOrdersRepoImpl(
        gh<_i13.FetchPublicOrdersRemoteDataSource>(),
      ),
    );
    gh.factory<_i61.GetConversationsUseCase>(
      () => _i61.GetConversationsUseCase(gh<_i257.GetConversationRepo>()),
    );
    gh.factory<_i205.ChangePasswordViewModel>(
      () => _i205.ChangePasswordViewModel(gh<_i647.ChangePasswordUseCase>()),
    );
    gh.factory<_i337.DeleteOrderRepo>(
      () => _i402.DeleteOrderRepoImpl(gh<_i673.DeleteOrderRemoteDataSource>()),
    );
    gh.factory<_i679.AddFavoriteOrderRepo>(
      () => _i961.AddFavoriteOrderRepoImpl(
        gh<_i121.AddFavoriteOrderRemoteDataSource>(),
      ),
    );
    gh.factory<_i686.GetAdminMessagesRepo>(
      () => _i1006.GetAdminMessagesRepoImpl(
        gh<_i815.GetAdminMessagesRemoteDataSource>(),
      ),
    );
    gh.factory<_i1025.ForgetPasswordViewModel>(
      () => _i1025.ForgetPasswordViewModel(gh<_i1013.ForgetPasswordUseCase>()),
    );
    gh.factory<_i618.CreatePaymentUseCase>(
      () => _i618.CreatePaymentUseCase(gh<_i815.PaymentRepos>()),
    );
    gh.factory<_i946.GetCommissionViewModel>(
      () => _i946.GetCommissionViewModel(gh<_i935.GetCommissionUseCase>()),
    );
    gh.factory<_i554.GetFavoriteOrderRepo>(
      () => _i678.GetFavoriteOrderRepoImpl(
        gh<_i490.GetFavoriteOrderRemoteDataSource>(),
      ),
    );
    gh.factory<_i778.UpdateOrderStatusRepo>(
      () => _i90.UpdateOrderStatusRepoImpl(
        gh<_i254.UpdateOrderStatusRemoteDataSource>(),
      ),
    );
    gh.factory<_i196.SubscribeToMessagesRepo>(
      () => _i92.SubscribeToMessagesRepoImpl(
        remoteDataSource: gh<_i462.SubscribeToMessagesRemoteDataSource>(),
      ),
    );
    gh.factory<_i46.OrdersRepo>(
      () => _i553.OrdersRepoImpl(
        ordersRemoteDataSource: gh<_i159.OrdersRemoteDataSource>(),
      ),
    );
    gh.factory<_i821.ProfileRepo>(
      () => _i541.ProfileRepoImpl(gh<_i1012.ProfileRemoteDataSource>()),
    );
    gh.factory<_i345.AttachmentsRepository>(
      () => _i727.AttachmentsRepositoryImpl(
        gh<_i1020.AttachmentsRemoteDataSource>(),
      ),
    );
    gh.factory<_i6.GetFavoriteOrderDetailsRepo>(
      () => _i453.GetFavouriteOrderDetailsRepoImpl(
        gh<_i504.GetFavouriteOrderDetailsRemoteDataSource>(),
      ),
    );
    gh.factory<_i163.GetUserReviewsViewModel>(
      () => _i163.GetUserReviewsViewModel(gh<_i701.GetUserReviewsUseCase>()),
    );
    gh.factory<_i769.SubmitRatingUseCase>(
      () => _i769.SubmitRatingUseCase(gh<_i805.SubmitRatingRepo>()),
    );
    gh.factory<_i772.RemoveFavoriteOrderUseCase>(
      () =>
          _i772.RemoveFavoriteOrderUseCase(gh<_i157.RemoveFavoriteOrderRepo>()),
    );
    gh.factory<_i646.FetchPrivateOrdersRepo>(
      () => _i101.FetchPrivateOrdersRepoImpl(
        gh<_i765.FetchPrivateOrdersRemoteDataSource>(),
      ),
    );
    gh.factory<_i775.AddEarningsViewModel>(
      () => _i775.AddEarningsViewModel(gh<_i403.AddEarningUseCase>()),
    );
    gh.factory<_i848.GetPaymentUseCase>(
      () => _i848.GetPaymentUseCase(gh<_i815.PaymentRepos>()),
    );
    gh.factory<_i773.WithdrawOfferRepo>(
      () => _i753.WithdrawOfferRepoImpl(
        gh<_i735.WithdrawOfferRemoteDataSource>(),
      ),
    );
    gh.factory<_i745.AuthViewModel>(
      () => _i745.AuthViewModel(authUseCase: gh<_i630.AuthUseCase>()),
    );
    gh.factory<_i201.SendMessagesRepo>(
      () =>
          _i406.SendMessagesRepoImpl(gh<_i902.SendMessagesRemoteDataSource>()),
    );
    gh.factory<_i504.SubmitRatingViewModel>(
      () => _i504.SubmitRatingViewModel(gh<_i769.SubmitRatingUseCase>()),
    );
    gh.factory<_i380.SubscribeToUnreadMessagesViewModel>(
      () => _i380.SubscribeToUnreadMessagesViewModel(
        gh<_i1021.SubscribeToUnreadMessagesUseCase>(),
      ),
    );
    gh.factory<_i759.OrdersUseCase>(
      () => _i759.OrdersUseCase(gh<_i46.OrdersRepo>()),
    );
    gh.factory<_i563.GetWithdrawalHistoryRepo>(
      () => _i216.GetWithdrawalHistoryRepoImpl(
        getWithdrawalHistoryRemoteDataSource:
            gh<_i329.GetWithdrawalHistoryRemoteDataSource>(),
      ),
    );
    gh.factory<_i660.HomeRepos>(
      () => _i86.HomeRepoImpl(
        homeremoteDataSource: gh<_i307.HomeRemoteDataSource>(),
      ),
    );
    gh.factory<_i221.SubscribeToPrivateOrdersRepo>(
      () => _i512.SubscribeToPrivateOrdersRepoImpl(
        gh<_i118.SubscribeToPrivateOrdersRemoteDataSource>(),
      ),
    );
    gh.factory<_i469.DeleteMessageRepo>(
      () => _i718.DeleteMessageRepoImpl(
        gh<_i191.DeleteMessageRemoteDataSource>(),
      ),
    );
    gh.factory<_i517.UpdateUserProfileRepo>(
      () => _i62.UpdateUserProfileRepoImpl(
        gh<_i748.UpdateUserProfileRemoteDataSource>(),
      ),
    );
    gh.factory<_i90.GetFreelancerOffersUseCase>(
      () => _i90.GetFreelancerOffersUseCase(
        offerRepository: gh<_i363.OfferRepository>(),
      ),
    );
    gh.factory<_i626.SendOfferUseCase>(
      () =>
          _i626.SendOfferUseCase(offerRepository: gh<_i363.OfferRepository>()),
    );
    gh.lazySingleton<_i988.DeleteMessageUseCase>(
      () => _i988.DeleteMessageUseCase(gh<_i469.DeleteMessageRepo>()),
    );
    gh.factory<_i663.IsOrderFavoriteRepo>(
      () => _i1032.IsOrderFavoriteRepoImpl(
        gh<_i346.IsOrderFavoriteRemoteDataSource>(),
      ),
    );
    gh.factory<_i483.GetPaymentViewModel>(
      () => _i483.GetPaymentViewModel(gh<_i848.GetPaymentUseCase>()),
    );
    gh.factory<_i416.DeleteAttachmentsUseCase>(
      () => _i416.DeleteAttachmentsUseCase(
        attachmentsRepository: gh<_i345.AttachmentsRepository>(),
      ),
    );
    gh.factory<_i231.UploadAttachmentsUseCase>(
      () => _i231.UploadAttachmentsUseCase(
        attachmentsRepository: gh<_i345.AttachmentsRepository>(),
      ),
    );
    gh.factory<_i176.GetTotalEarningRepo>(
      () => _i636.GetEarningRepoImpl(
        getTotalEarningRemoteDataSource: gh<_i706.GetEarningRemoteDataSource>(),
      ),
    );
    gh.factory<_i347.GetFavoriteOrderUseCase>(
      () => _i347.GetFavoriteOrderUseCase(gh<_i554.GetFavoriteOrderRepo>()),
    );
    gh.lazySingleton<_i367.MarkMessagesAsReadUseCase>(
      () => _i367.MarkMessagesAsReadUseCase(gh<_i113.MarkMessagesAsReadRepo>()),
    );
    gh.factory<_i197.DownloadAttachmentsUseCase>(
      () => _i197.DownloadAttachmentsUseCase(gh<_i345.AttachmentsRepository>()),
    );
    gh.factory<_i258.UserStatusUseCase>(
      () => _i258.UserStatusUseCase(userStatusRepo: gh<_i325.UserStatusRepo>()),
    );
    gh.factory<_i1022.SubscribeToAdminMessagesUseCase>(
      () => _i1022.SubscribeToAdminMessagesUseCase(
        gh<_i953.SubscribeToAdminMessagesRepo>(),
      ),
    );
    gh.factory<_i213.AcceptOfferUseCase>(
      () => _i213.AcceptOfferUseCase(gh<_i896.MyJobsRepo>()),
    );
    gh.factory<_i863.GetOffersForOrderUseCase>(
      () => _i863.GetOffersForOrderUseCase(gh<_i896.MyJobsRepo>()),
    );
    gh.factory<_i86.SubscribeToOfferStatusUseCase>(
      () => _i86.SubscribeToOfferStatusUseCase(gh<_i896.MyJobsRepo>()),
    );
    gh.factory<_i576.SubscribeToOrderStatusUseCase>(
      () => _i576.SubscribeToOrderStatusUseCase(gh<_i896.MyJobsRepo>()),
    );
    gh.factory<_i454.SubscribetToOrdersUseCase>(
      () => _i454.SubscribetToOrdersUseCase(gh<_i896.MyJobsRepo>()),
    );
    gh.factory<_i530.UpdateOfferStatusUseCase>(
      () => _i530.UpdateOfferStatusUseCase(gh<_i896.MyJobsRepo>()),
    );
    gh.factory<_i451.IsOrderFavoriteUseCase>(
      () => _i451.IsOrderFavoriteUseCase(gh<_i663.IsOrderFavoriteRepo>()),
    );
    gh.factory<_i859.DeleteOrderUseCase>(
      () => _i859.DeleteOrderUseCase(gh<_i337.DeleteOrderRepo>()),
    );
    gh.factory<_i172.SubscribeToMessagesUseCase>(
      () =>
          _i172.SubscribeToMessagesUseCase(gh<_i196.SubscribeToMessagesRepo>()),
    );
    gh.factory<_i253.SubscribeToPublicOrdersUseCase>(
      () => _i253.SubscribeToPublicOrdersUseCase(
        subscribeToPublicOrdersRepo: gh<_i453.SubscribeToPublicOrdersRepo>(),
      ),
    );
    gh.factoryParam<
      _i147.MessagesViewModel,
      _i147.OnConversationUpdated?,
      dynamic
    >(
      (onConversationUpdated, _) => _i147.MessagesViewModel(
        gh<_i416.GetOrderMessagesUseCase>(),
        gh<_i172.SubscribeToMessagesUseCase>(),
        onConversationUpdated: onConversationUpdated,
      ),
    );
    gh.factory<_i338.DownloadAttachmentsViewModel>(
      () => _i338.DownloadAttachmentsViewModel(
        gh<_i197.DownloadAttachmentsUseCase>(),
      ),
    );
    gh.factory<_i997.GetAcceptedOrderMessagesUseCase>(
      () => _i997.GetAcceptedOrderMessagesUseCase(
        gh<_i81.GetAcceptedOrderMessageRepo>(),
      ),
    );
    gh.factory<_i520.RemoveFavoriteOrderViewModel>(
      () => _i520.RemoveFavoriteOrderViewModel(
        gh<_i772.RemoveFavoriteOrderUseCase>(),
      ),
    );
    gh.factory<_i855.GetOrderViewModel>(
      () => _i855.GetOrderViewModel(
        gh<_i759.OrdersUseCase>(),
        gh<_i576.SubscribeToOrderStatusUseCase>(),
      ),
    );
    gh.factory<_i988.GetAllFreelancersUseCase>(
      () => _i988.GetAllFreelancersUseCase(gh<_i660.HomeRepos>()),
    );
    gh.factory<_i585.ProfileUseCase>(
      () => _i585.ProfileUseCase(gh<_i821.ProfileRepo>()),
    );
    gh.factory<_i744.SendToAdminMessagesViewModel>(
      () => _i744.SendToAdminMessagesViewModel(
        gh<_i929.SendToAdminMessagesUseCase>(),
      ),
    );
    gh.factory<_i552.GetFreelancerOffersViewModel>(
      () => _i552.GetFreelancerOffersViewModel(
        gh<_i90.GetFreelancerOffersUseCase>(),
      ),
    );
    gh.factory<_i785.UpdateOrderStatusUseCase>(
      () => _i785.UpdateOrderStatusUseCase(gh<_i778.UpdateOrderStatusRepo>()),
    );
    gh.factory<_i881.UnreadMessagesBadgeViewModel>(
      () => _i881.UnreadMessagesBadgeViewModel(
        gh<_i416.GetOrderMessagesUseCase>(),
        gh<_i172.SubscribeToMessagesUseCase>(),
      ),
    );
    gh.factory<_i517.CreatePaymentViewModel>(
      () => _i517.CreatePaymentViewModel(gh<_i618.CreatePaymentUseCase>()),
    );
    gh.factory<_i166.FetchPublicOrdersUseCase>(
      () => _i166.FetchPublicOrdersUseCase(
        fetchPublicOrdersRepo: gh<_i1016.FetchPublicOrdersRepo>(),
      ),
    );
    gh.factory<_i28.SubscribeOrdersRecordViewModel>(
      () => _i28.SubscribeOrdersRecordViewModel(
        subscribeOrderUseCase: gh<_i759.OrdersUseCase>(),
      ),
    );
    gh.factory<_i448.SubscribeToAdminMessagesViewModel>(
      () => _i448.SubscribeToAdminMessagesViewModel(
        gh<_i1022.SubscribeToAdminMessagesUseCase>(),
      ),
    );
    gh.factory<_i380.WithdrawOfferUseCase>(
      () => _i380.WithdrawOfferUseCase(gh<_i773.WithdrawOfferRepo>()),
    );
    gh.factory<_i221.GetFavoriteOrderDetailsUseCase>(
      () => _i221.GetFavoriteOrderDetailsUseCase(
        gh<_i6.GetFavoriteOrderDetailsRepo>(),
      ),
    );
    gh.factory<_i42.GetConversationsViewModel>(
      () => _i42.GetConversationsViewModel(gh<_i61.GetConversationsUseCase>()),
    );
    gh.factory<_i12.GetAcceptedOrderMessageViewModel>(
      () => _i12.GetAcceptedOrderMessageViewModel(
        gh<_i997.GetAcceptedOrderMessagesUseCase>(),
      ),
    );
    gh.factory<_i841.GetAdminMessagesUseCase>(
      () => _i841.GetAdminMessagesUseCase(gh<_i686.GetAdminMessagesRepo>()),
    );
    gh.factory<_i891.AddFavoriteOrderUseCase>(
      () => _i891.AddFavoriteOrderUseCase(gh<_i679.AddFavoriteOrderRepo>()),
    );
    gh.lazySingleton<_i366.SendMessageUseCase>(
      () => _i366.SendMessageUseCase(gh<_i201.SendMessagesRepo>()),
    );
    gh.factory<_i584.ChatWithAdminViewModel>(
      () => _i584.ChatWithAdminViewModel(
        gh<_i841.GetAdminMessagesUseCase>(),
        gh<_i1022.SubscribeToAdminMessagesUseCase>(),
      ),
    );
    gh.factory<_i123.IsOrderFavoriteViewModel>(
      () => _i123.IsOrderFavoriteViewModel(gh<_i451.IsOrderFavoriteUseCase>()),
    );
    gh.factory<_i662.GetAdminMessagesViewModel>(
      () =>
          _i662.GetAdminMessagesViewModel(gh<_i841.GetAdminMessagesUseCase>()),
    );
    gh.factory<_i278.WithdrawOfferViewModel>(
      () => _i278.WithdrawOfferViewModel(gh<_i380.WithdrawOfferUseCase>()),
    );
    gh.factory<_i920.GetOffersViewModel>(
      () => _i920.GetOffersViewModel(gh<_i863.GetOffersForOrderUseCase>()),
    );
    gh.factory<_i553.GetFavoriteOrderViewModel>(
      () =>
          _i553.GetFavoriteOrderViewModel(gh<_i347.GetFavoriteOrderUseCase>()),
    );
    gh.factory<_i2.FetchPrivateOrdersUseCase>(
      () => _i2.FetchPrivateOrdersUseCase(gh<_i646.FetchPrivateOrdersRepo>()),
    );
    gh.factory<_i975.UpdateOrderStatusViewModel>(
      () => _i975.UpdateOrderStatusViewModel(
        gh<_i785.UpdateOrderStatusUseCase>(),
      ),
    );
    gh.factory<_i11.UploadAttachmentsViewModel>(
      () =>
          _i11.UploadAttachmentsViewModel(gh<_i231.UploadAttachmentsUseCase>()),
    );
    gh.factory<_i679.UploadOrderAttachmentsViewModel>(
      () => _i679.UploadOrderAttachmentsViewModel(
        gh<_i231.UploadAttachmentsUseCase>(),
      ),
    );
    gh.factory<_i1000.FreelancerPublicOrdersViewModel>(
      () => _i1000.FreelancerPublicOrdersViewModel(
        gh<_i166.FetchPublicOrdersUseCase>(),
        gh<_i253.SubscribeToPublicOrdersUseCase>(),
      ),
    );
    gh.factory<_i376.UpdateOfferStatusViewModel>(
      () => _i376.UpdateOfferStatusViewModel(
        gh<_i530.UpdateOfferStatusUseCase>(),
        gh<_i213.AcceptOfferUseCase>(),
      ),
    );
    gh.factory<_i628.GetAllServicesUseCase>(
      () => _i628.GetAllServicesUseCase(gh<_i660.HomeRepos>()),
    );
    gh.factory<_i904.PlaceOrderUseCase>(
      () => _i904.PlaceOrderUseCase(gh<_i660.HomeRepos>()),
    );
    gh.factory<_i776.FreelancerInfoViewModel>(
      () => _i776.FreelancerInfoViewModel(gh<_i585.ProfileUseCase>()),
    );
    gh.factory<_i1003.ProfileViewModel>(
      () => _i1003.ProfileViewModel(gh<_i585.ProfileUseCase>()),
    );
    gh.factory<_i169.GetWithdrawalHistoryUseCase>(
      () => _i169.GetWithdrawalHistoryUseCase(
        getWithdrawalHistoryRepo: gh<_i563.GetWithdrawalHistoryRepo>(),
      ),
    );
    gh.factory<_i669.UpdateUserProfileUseCase>(
      () => _i669.UpdateUserProfileUseCase(gh<_i517.UpdateUserProfileRepo>()),
    );
    gh.factory<_i44.ChatAvatarsCubit>(
      () => _i44.ChatAvatarsCubit(gh<_i1003.ProfileViewModel>()),
    );
    gh.factory<_i658.SendOfferViewModel>(
      () => _i658.SendOfferViewModel(gh<_i626.SendOfferUseCase>()),
    );
    gh.factory<_i532.SubscribeToPrivateOrdersUseCase>(
      () => _i532.SubscribeToPrivateOrdersUseCase(
        gh<_i221.SubscribeToPrivateOrdersRepo>(),
      ),
    );
    gh.factory<_i670.FetchAllFreelancersViewModel>(
      () => _i670.FetchAllFreelancersViewModel(
        gh<_i988.GetAllFreelancersUseCase>(),
      ),
    );
    gh.factory<_i413.DeleteOrderViewModel>(
      () => _i413.DeleteOrderViewModel(gh<_i859.DeleteOrderUseCase>()),
    );
    gh.factory<_i61.SubscribeToMessagesViewModel>(
      () => _i61.SubscribeToMessagesViewModel(
        gh<_i172.SubscribeToMessagesUseCase>(),
      ),
    );
    gh.factory<_i364.GetWithdrawalHistoryViewModel>(
      () => _i364.GetWithdrawalHistoryViewModel(
        gh<_i169.GetWithdrawalHistoryUseCase>(),
      ),
    );
    gh.factory<_i953.UserStatusViewModel>(
      () => _i953.UserStatusViewModel(gh<_i258.UserStatusUseCase>()),
    );
    gh.factory<_i195.DeleteAttachmentsViewModel>(
      () => _i195.DeleteAttachmentsViewModel(
        gh<_i416.DeleteAttachmentsUseCase>(),
      ),
    );
    gh.factory<_i922.GetEarningUseCase>(
      () => _i922.GetEarningUseCase(
        getEarningRepo: gh<_i176.GetTotalEarningRepo>(),
      ),
    );
    gh.factory<_i765.ClientOrderStatusViewModel>(
      () => _i765.ClientOrderStatusViewModel(
        gh<_i454.SubscribetToOrdersUseCase>(),
      ),
    );
    gh.factory<_i656.SubscribeToPublicOrdersViewModel>(
      () => _i656.SubscribeToPublicOrdersViewModel(
        gh<_i253.SubscribeToPublicOrdersUseCase>(),
        gh<_i166.FetchPublicOrdersUseCase>(),
      ),
    );
    gh.factory<_i602.SendMessageViewModel>(
      () => _i602.SendMessageViewModel(gh<_i366.SendMessageUseCase>()),
    );
    gh.factory<_i78.AddFavoriteOrderViewModel>(
      () => _i78.AddFavoriteOrderViewModel(gh<_i891.AddFavoriteOrderUseCase>()),
    );
    gh.factory<_i370.FreelancerPrivateOrdersViewModel>(
      () => _i370.FreelancerPrivateOrdersViewModel(
        gh<_i532.SubscribeToPrivateOrdersUseCase>(),
      ),
    );
    gh.factory<_i823.SubscribeToPrivateOrdersViewModel>(
      () => _i823.SubscribeToPrivateOrdersViewModel(
        gh<_i532.SubscribeToPrivateOrdersUseCase>(),
        gh<_i2.FetchPrivateOrdersUseCase>(),
      ),
    );
    gh.factory<_i737.GetFavouriteOrderDetailsViewModel>(
      () => _i737.GetFavouriteOrderDetailsViewModel(
        gh<_i221.GetFavoriteOrderDetailsUseCase>(),
      ),
    );
    gh.factory<_i869.ServicesViewModel>(
      () => _i869.ServicesViewModel(gh<_i628.GetAllServicesUseCase>()),
    );
    gh.factory<_i196.GetTotalEarningsViewModel>(
      () => _i196.GetTotalEarningsViewModel(gh<_i922.GetEarningUseCase>()),
    );
    gh.factory<_i34.UpdateUserProfileViewModel>(
      () => _i34.UpdateUserProfileViewModel(
        gh<_i669.UpdateUserProfileUseCase>(),
        gh<_i730.UserInfoEntity>(),
      ),
    );
    gh.factory<_i779.PlaceOrderViewModel>(
      () => _i779.PlaceOrderViewModel(gh<_i904.PlaceOrderUseCase>()),
    );
    return this;
  }
}
