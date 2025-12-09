import 'package:flutter/material.dart';
import 'package:taskly/features/reviews/presentation/pages/reviews_page.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';
import 'package:taskly/features/auth/presentation/views/login_view.dart';
import 'package:taskly/features/auth/presentation/views/register_view.dart';
import 'package:taskly/features/client/presentation/views/client_home_view.dart';
import 'package:taskly/features/client/presentation/views/tabs/home/presentation/views/order_view.dart';
import 'package:taskly/features/messages/presentation/pages/user_chat_view.dart';
import 'package:taskly/features/freelancer/presentation/views/freelancer_home_view.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/find_work/presentation/views/favourite_orders_view.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/find_work/presentation/views/job_details_view.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/find_work/presentation/views/send_offer_view.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/profile/presentation/views/freelancer_earning_view.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/profile/presentation/views/request_withdrawal_view.dart';
import 'package:taskly/features/shared/presentation/views/change_password_view.dart';
import 'package:taskly/features/shared/presentation/views/privacy_policy_view.dart';
import 'package:taskly/features/shared/presentation/views/technical_support_view.dart';
import 'package:taskly/features/shared/presentation/views/user_account_view.dart';
import 'package:taskly/features/splash/presentation/views/splash_view.dart';
import 'package:taskly/features/welcome/presentation/views/welcome_view.dart';

import '../../features/auth/presentation/views/forget_password_view.dart';
import '../../features/auth/presentation/views/reset_password_view.dart';
import '../../features/freelancer/presentation/views/tabs/my_jobs/presentation/views/offer_details_view.dart';
import '../../features/messages/presentation/pages/admin_chat_view.dart';
import '../../features/payments/presentation/pages/client_payments_view.dart';
import '../../features/profile/domain/entities/user_info_entity/user_info_entity.dart';

class RoutesManager {
  static const String splash = "/";
  static const String welcome = "welcome";
  static const String login = "login";
  static const String register = "register";
  static const String clientHome = "clientHome";
  static const String freelancerHome = "freelancerHome";
  static const String serviceOrderView = "serviceOrderView";
  static const String chatView = "chatView";
  static const String jobDetailsView = "jobDetailsView";
  static const String sendOfferView = "sendOfferView";
  static const String technicalSupportView = "technicalSupportView";
  static const String privacyPolicyView = "privacyPolicyView";
  static const String userAccountView = "userAccountView";
  static const String changePasswordView = "changePasswordView";
  static const String freelancerEarningView = "freelancerEarningView";
  static const String requestWithdrawalView = "requestWithdrawalView";
  static const String favouriteOrdersView = "favouriteOrdersView";
  static const String offerDetailsView = "offerDetailsView";
  static const String clientPaymentsView = "clientPaymentsView";
  static const String reviewsView = "reviewsView";
  static const String adminChatView = "adminChatView";
  static const String forgetPasswordView = "forgetPasswordView";
   static const String resetPasswordView = "resetPasswordView";

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashView());

      case welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeView());
      case login:
        final role = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => LoginView(role: role));
      case register:
        final role = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => RegisterView(role: role));
      case clientHome:
        return MaterialPageRoute(builder: (_) => const ClientHomeView());
      case freelancerHome:
        return MaterialPageRoute(builder: (_) => const FreelancerHomeView());
      case RoutesManager.serviceOrderView:
        final args = settings.arguments as Map<String, dynamic>;

        final title = args['title'] as String;
        final category = args['category'] as String;

        return MaterialPageRoute(
          builder: (_) => OrderView(title: title, selectedCategory: category),
        );

      case chatView:
        final args = settings.arguments as Map<String, dynamic>;
        final currentUserAvatar = args['currentUserAvatar'] as String;
        final receiverAvatar = args['receiverAvatar'] as String;
        final order = args['order'] as OrderEntity;
        final currentUserId = args['currentUserId'] as String;
        final receiverId = args['receiverId'] as String;
        final receiverName = args['receiverName'] as String;
        final currentUserName = args['currentUserName'] as String;
        return MaterialPageRoute(
            builder: (_) => UserChatView(
              currentUserName: currentUserName,
                receiverName: receiverName,


                currentUserAvatar: currentUserAvatar,
                receiverAvatar: receiverAvatar,
                order: order,
                currentUserId: currentUserId,
                receiverId: receiverId));

      case jobDetailsView:
        final args = settings.arguments;
        final user = settings.arguments;
        if (args is OrderEntity) {
          return MaterialPageRoute(
            builder: (_) => JobDetailsView(orderEntity: args),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(child: Text('No order data provided')),
            ),
          );
        }

      case sendOfferView:
        final OrderEntity args = settings.arguments as OrderEntity;
        return MaterialPageRoute(
            builder: (_) => SendOfferView(
                  orderEntity: args,
                ));
      case technicalSupportView:
        return MaterialPageRoute(builder: (_) => const TechnicalSupportView());
      case privacyPolicyView:
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyView());
      case userAccountView:
        final args = settings.arguments;
        final userInfoEntity = args as UserInfoEntity;
        return MaterialPageRoute(builder: (_) =>   UserAccountView( userInfoEntity:  userInfoEntity,));
      case changePasswordView:
        return MaterialPageRoute(builder: (_) => const ChangePasswordView());

      case forgetPasswordView:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordView());
      case freelancerEarningView:
        return MaterialPageRoute(builder: (_) => const FreelancerEarningView());
      case resetPasswordView :
        return MaterialPageRoute(builder: (_) => const ResetPasswordView());
      case requestWithdrawalView:
        return MaterialPageRoute(builder: (_) => const RequestWithdrawalView());

      case favouriteOrdersView:
        return MaterialPageRoute(builder: (_) => const FavouriteOrdersView());
      case offerDetailsView:
        final args = settings.arguments as Map<String, dynamic>;
        final orderId = args['orderId'] as String;
        return MaterialPageRoute(
            builder: (_) => OfferDetailsView(
                  orderId: orderId,
                ));
      case clientPaymentsView:
        final args = settings.arguments as Map<String, dynamic>;
        final orderEntity = args['orderEntity'] as OrderEntity;

        return MaterialPageRoute(
            builder: (_) => ClientPaymentsView(
                  order: orderEntity,
                ));
      case reviewsView:
        final args = settings.arguments as Map<String, dynamic>?;

        if (args == null) {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(child: Text('No arguments provided')),
            ),
          );
        }

        final userId = args['userId'] as String?;
        final role = args['role'] as String?;
        final userName = args['userName'] as String?;
        final userRating = args['userRating'] as double?;
        final userImage = args['userImage'] as String? ?? '';

        if ([userId, role, userName, userRating].contains(null)) {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(child: Text('Incomplete arguments provided')),
            ),
          );
        }

        return MaterialPageRoute(
          builder: (_) => ReviewsPage(
            userId: userId!,
            userRole: role!,
            userName: userName!,
            userImage: userImage,
            userRating: userRating!,
          ),
        );
        case adminChatView:
          final args = settings.arguments as Map<String, dynamic>;
          final currentUserId = args['currentUserId'] as String;
          return MaterialPageRoute(builder:(context) =>  AdminChatView(currentUserId: currentUserId)
          );

      default:
        return MaterialPageRoute(builder: (_) => const Placeholder());
    }
  }
}
