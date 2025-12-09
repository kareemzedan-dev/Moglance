import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Moglance'**
  String get appTitle;

  /// No description provided for @client.
  ///
  /// In en, this message translates to:
  /// **'Client'**
  String get client;

  /// No description provided for @freelancer.
  ///
  /// In en, this message translates to:
  /// **'Freelancer'**
  String get freelancer;

  /// No description provided for @sar.
  ///
  /// In en, this message translates to:
  /// **'SAR'**
  String get sar;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Organize work, connect,\n and succeed!'**
  String get welcomeMessage;

  /// No description provided for @freelancerTitle.
  ///
  /// In en, this message translates to:
  /// **'I\'m a Freelancer'**
  String get freelancerTitle;

  /// No description provided for @freelancerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Find projects & grow your career'**
  String get freelancerSubtitle;

  /// No description provided for @clientTitle.
  ///
  /// In en, this message translates to:
  /// **'I\'m a Client'**
  String get clientTitle;

  /// No description provided for @clientSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Hire talents to get your work done'**
  String get clientSubtitle;

  /// No description provided for @createFreelancerAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Freelancer Account'**
  String get createFreelancerAccount;

  /// No description provided for @createClientAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Client Account'**
  String get createClientAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get login;

  /// No description provided for @registerFreelancerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign up to find work'**
  String get registerFreelancerSubtitle;

  /// No description provided for @registerClientSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign up to hire the best talent'**
  String get registerClientSubtitle;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create my account'**
  String get createAccount;

  /// No description provided for @thisFieldIsRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get thisFieldIsRequired;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @privacyPolicyAgreement.
  ///
  /// In en, this message translates to:
  /// **'By creating an account you agree to the '**
  String get privacyPolicyAgreement;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'privacy policy'**
  String get privacyPolicy;

  /// No description provided for @termsAgreement.
  ///
  /// In en, this message translates to:
  /// **' and to the '**
  String get termsAgreement;

  /// No description provided for @termsOfUse.
  ///
  /// In en, this message translates to:
  /// **'terms of use'**
  String get termsOfUse;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternetConnection;

  /// No description provided for @emailAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'Email already exists or not confirmed. Please check your email.'**
  String get emailAlreadyExists;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong, please try again'**
  String get somethingWentWrong;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed. Please check your email and password.'**
  String get loginFailed;

  /// No description provided for @notRegisteredAsRole.
  ///
  /// In en, this message translates to:
  /// **'You are not registered as {role}. Please use the correct account.'**
  String notRegisteredAsRole(Object role);

  /// No description provided for @googleLoginCancelled.
  ///
  /// In en, this message translates to:
  /// **'Google login cancelled'**
  String get googleLoginCancelled;

  /// No description provided for @accountAlreadyRegistered.
  ///
  /// In en, this message translates to:
  /// **'This account is already registered as {existingRole}. You cannot register as {role}.'**
  String accountAlreadyRegistered(Object existingRole, Object role);

  /// No description provided for @userRegisteredSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'User registered successfully'**
  String get userRegisteredSuccessfully;

  /// No description provided for @userLoginSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'User Login successfully'**
  String get userLoginSuccessfully;

  /// No description provided for @googleLoginSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Google login successful'**
  String get googleLoginSuccessful;

  /// No description provided for @dashboardDescription.
  ///
  /// In en, this message translates to:
  /// **'Manage all freelancers and clients in one dashboard'**
  String get dashboardDescription;

  /// No description provided for @performanceTracking.
  ///
  /// In en, this message translates to:
  /// **'Track orders, monitor performance, and keep everything under control'**
  String get performanceTracking;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @letsGo.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Go'**
  String get letsGo;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @users.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get users;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @payments.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get payments;

  /// No description provided for @rate_experience.
  ///
  /// In en, this message translates to:
  /// **'Rate Your Experience'**
  String get rate_experience;

  /// No description provided for @experience_with.
  ///
  /// In en, this message translates to:
  /// **'How was your experience with {name}?'**
  String experience_with(Object name);

  /// No description provided for @add_comment.
  ///
  /// In en, this message translates to:
  /// **'Add a comment (optional)'**
  String get add_comment;

  /// No description provided for @share_experience.
  ///
  /// In en, this message translates to:
  /// **'Share your experience...'**
  String get share_experience;

  /// No description provided for @submit_rating.
  ///
  /// In en, this message translates to:
  /// **'Submit Rating'**
  String get submit_rating;

  /// No description provided for @rating_success.
  ///
  /// In en, this message translates to:
  /// **'Rating submitted successfully!'**
  String get rating_success;

  /// No description provided for @rating_fail.
  ///
  /// In en, this message translates to:
  /// **'Failed to submit rating'**
  String get rating_fail;

  /// No description provided for @excellent.
  ///
  /// In en, this message translates to:
  /// **'Excellent!'**
  String get excellent;

  /// No description provided for @very_good.
  ///
  /// In en, this message translates to:
  /// **'Very Good'**
  String get very_good;

  /// No description provided for @good.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get good;

  /// No description provided for @fair.
  ///
  /// In en, this message translates to:
  /// **'Fair'**
  String get fair;

  /// No description provided for @poor.
  ///
  /// In en, this message translates to:
  /// **'Poor'**
  String get poor;

  /// No description provided for @hiUser.
  ///
  /// In en, this message translates to:
  /// **'Hi {name},'**
  String hiUser(Object name);

  /// No description provided for @welcomeTaskly.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Moglance'**
  String get welcomeTaskly;

  /// No description provided for @revenueTrend.
  ///
  /// In en, this message translates to:
  /// **'Revenue Trend'**
  String get revenueTrend;

  /// No description provided for @totalRevenueInfo.
  ///
  /// In en, this message translates to:
  /// **'Total revenue growth over time'**
  String get totalRevenueInfo;

  /// No description provided for @orderVolume.
  ///
  /// In en, this message translates to:
  /// **'Order Volume'**
  String get orderVolume;

  /// No description provided for @dailyOrderInfo.
  ///
  /// In en, this message translates to:
  /// **'Daily order completion rate'**
  String get dailyOrderInfo;

  /// No description provided for @categoryDistribution.
  ///
  /// In en, this message translates to:
  /// **'Category Distribution'**
  String get categoryDistribution;

  /// No description provided for @serviceCategoryInfo.
  ///
  /// In en, this message translates to:
  /// **'Service categories by revenue share'**
  String get serviceCategoryInfo;

  /// No description provided for @errorPrefix.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String errorPrefix(Object message);

  /// No description provided for @dashboardOrders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get dashboardOrders;

  /// No description provided for @dashboardEarnings.
  ///
  /// In en, this message translates to:
  /// **'Earnings'**
  String get dashboardEarnings;

  /// No description provided for @dashboardClients.
  ///
  /// In en, this message translates to:
  /// **'Clients'**
  String get dashboardClients;

  /// No description provided for @dashboardFreelancers.
  ///
  /// In en, this message translates to:
  /// **'Freelancers'**
  String get dashboardFreelancers;

  /// No description provided for @pendingVerifications.
  ///
  /// In en, this message translates to:
  /// **'Pending Verifications'**
  String get pendingVerifications;

  /// No description provided for @disputesNeedingReview.
  ///
  /// In en, this message translates to:
  /// **'Disputes Needing Review'**
  String get disputesNeedingReview;

  /// No description provided for @pendingPayments.
  ///
  /// In en, this message translates to:
  /// **'Pending Payments'**
  String get pendingPayments;

  /// No description provided for @lateOrders.
  ///
  /// In en, this message translates to:
  /// **'Late Orders'**
  String get lateOrders;

  /// No description provided for @kpiTitle.
  ///
  /// In en, this message translates to:
  /// **'Key Performance Indicators'**
  String get kpiTitle;

  /// No description provided for @trendsTitle.
  ///
  /// In en, this message translates to:
  /// **'Visual Trends & Insights'**
  String get trendsTitle;

  /// No description provided for @monthlyView.
  ///
  /// In en, this message translates to:
  /// **'Monthly View'**
  String get monthlyView;

  /// No description provided for @pendingActionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Pending Action & Alerts'**
  String get pendingActionsTitle;

  /// No description provided for @exportCSVTitle.
  ///
  /// In en, this message translates to:
  /// **'Export Financial CSV'**
  String get exportCSVTitle;

  /// No description provided for @exportMoneyCSV.
  ///
  /// In en, this message translates to:
  /// **'Export Money CSV'**
  String get exportMoneyCSV;

  /// No description provided for @categoryAcademic.
  ///
  /// In en, this message translates to:
  /// **'Academic'**
  String get categoryAcademic;

  /// No description provided for @categoryReports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get categoryReports;

  /// No description provided for @categoryMindMaps.
  ///
  /// In en, this message translates to:
  /// **'Mind Maps'**
  String get categoryMindMaps;

  /// No description provided for @categoryTranslation.
  ///
  /// In en, this message translates to:
  /// **'Translation'**
  String get categoryTranslation;

  /// No description provided for @categorySummaries.
  ///
  /// In en, this message translates to:
  /// **'Summaries'**
  String get categorySummaries;

  /// No description provided for @categoryProjects.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get categoryProjects;

  /// No description provided for @categoryPresentations.
  ///
  /// In en, this message translates to:
  /// **'Presentations'**
  String get categoryPresentations;

  /// No description provided for @categorySPSS.
  ///
  /// In en, this message translates to:
  /// **'SPSS'**
  String get categorySPSS;

  /// No description provided for @categoryProofreading.
  ///
  /// In en, this message translates to:
  /// **'Proofreading'**
  String get categoryProofreading;

  /// No description provided for @categoryCV.
  ///
  /// In en, this message translates to:
  /// **'CV'**
  String get categoryCV;

  /// No description provided for @categoryProgramming.
  ///
  /// In en, this message translates to:
  /// **'Programming'**
  String get categoryProgramming;

  /// No description provided for @categoryCourses.
  ///
  /// In en, this message translates to:
  /// **'Courses'**
  String get categoryCourses;

  /// No description provided for @categoryConsulting.
  ///
  /// In en, this message translates to:
  /// **'Consulting'**
  String get categoryConsulting;

  /// No description provided for @categoryDesign.
  ///
  /// In en, this message translates to:
  /// **'Design'**
  String get categoryDesign;

  /// No description provided for @categoryEngineering.
  ///
  /// In en, this message translates to:
  /// **'Engineering'**
  String get categoryEngineering;

  /// No description provided for @categoryFinance.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get categoryFinance;

  /// No description provided for @legendAcademic.
  ///
  /// In en, this message translates to:
  /// **'Academic Sources'**
  String get legendAcademic;

  /// No description provided for @legendReports.
  ///
  /// In en, this message translates to:
  /// **'Scientific Reports'**
  String get legendReports;

  /// No description provided for @legendMindMaps.
  ///
  /// In en, this message translates to:
  /// **'Mind Maps'**
  String get legendMindMaps;

  /// No description provided for @legendTranslation.
  ///
  /// In en, this message translates to:
  /// **'Languages & Translation'**
  String get legendTranslation;

  /// No description provided for @legendSummaries.
  ///
  /// In en, this message translates to:
  /// **'Summaries'**
  String get legendSummaries;

  /// No description provided for @legendProjects.
  ///
  /// In en, this message translates to:
  /// **'Scientific Projects'**
  String get legendProjects;

  /// No description provided for @legendPresentations.
  ///
  /// In en, this message translates to:
  /// **'Presentations'**
  String get legendPresentations;

  /// No description provided for @legendSPSS.
  ///
  /// In en, this message translates to:
  /// **'SPSS Analysis'**
  String get legendSPSS;

  /// No description provided for @legendProofreading.
  ///
  /// In en, this message translates to:
  /// **'Proofreading'**
  String get legendProofreading;

  /// No description provided for @legendCV.
  ///
  /// In en, this message translates to:
  /// **'CV / Resume'**
  String get legendCV;

  /// No description provided for @legendProgramming.
  ///
  /// In en, this message translates to:
  /// **'Programming & Web Design'**
  String get legendProgramming;

  /// No description provided for @legendCourses.
  ///
  /// In en, this message translates to:
  /// **'Courses & Tutorials'**
  String get legendCourses;

  /// No description provided for @legendConsulting.
  ///
  /// In en, this message translates to:
  /// **'Specialized Consulting'**
  String get legendConsulting;

  /// No description provided for @legendDesign.
  ///
  /// In en, this message translates to:
  /// **'Graphic Design'**
  String get legendDesign;

  /// No description provided for @legendEngineering.
  ///
  /// In en, this message translates to:
  /// **'Engineering Services'**
  String get legendEngineering;

  /// No description provided for @legendFinance.
  ///
  /// In en, this message translates to:
  /// **'Financial & Accounting'**
  String get legendFinance;

  /// No description provided for @manageDashboard.
  ///
  /// In en, this message translates to:
  /// **'Manage Dashboard'**
  String get manageDashboard;

  /// No description provided for @manageUsers.
  ///
  /// In en, this message translates to:
  /// **'Manage Users'**
  String get manageUsers;

  /// No description provided for @searchByName.
  ///
  /// In en, this message translates to:
  /// **'Search by name'**
  String get searchByName;

  /// No description provided for @searchByEmail.
  ///
  /// In en, this message translates to:
  /// **'Search by email'**
  String get searchByEmail;

  /// No description provided for @clients.
  ///
  /// In en, this message translates to:
  /// **'Clients'**
  String get clients;

  /// No description provided for @freelancers.
  ///
  /// In en, this message translates to:
  /// **'Freelancers'**
  String get freelancers;

  /// No description provided for @totalOrders.
  ///
  /// In en, this message translates to:
  /// **'Total Orders'**
  String get totalOrders;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @earnings.
  ///
  /// In en, this message translates to:
  /// **'Earnings'**
  String get earnings;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @keyPerformanceIndicators.
  ///
  /// In en, this message translates to:
  /// **'Key Performance Indicators'**
  String get keyPerformanceIndicators;

  /// No description provided for @visualTrendsInsights.
  ///
  /// In en, this message translates to:
  /// **'Visual Trends & Insights'**
  String get visualTrendsInsights;

  /// No description provided for @pendingActionAlerts.
  ///
  /// In en, this message translates to:
  /// **'Pending Action & Alerts'**
  String get pendingActionAlerts;

  /// No description provided for @exportFinancialCSV.
  ///
  /// In en, this message translates to:
  /// **'Export Financial CSV'**
  String get exportFinancialCSV;

  /// No description provided for @academic.
  ///
  /// In en, this message translates to:
  /// **'Academic'**
  String get academic;

  /// No description provided for @reports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reports;

  /// No description provided for @mindMaps.
  ///
  /// In en, this message translates to:
  /// **'Mind Maps'**
  String get mindMaps;

  /// No description provided for @translation.
  ///
  /// In en, this message translates to:
  /// **'Translation'**
  String get translation;

  /// No description provided for @summaries.
  ///
  /// In en, this message translates to:
  /// **'Summaries'**
  String get summaries;

  /// No description provided for @projects.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get projects;

  /// No description provided for @presentations.
  ///
  /// In en, this message translates to:
  /// **'Presentations'**
  String get presentations;

  /// No description provided for @spss.
  ///
  /// In en, this message translates to:
  /// **'SPSS'**
  String get spss;

  /// No description provided for @proofreading.
  ///
  /// In en, this message translates to:
  /// **'Proofreading'**
  String get proofreading;

  /// No description provided for @cv.
  ///
  /// In en, this message translates to:
  /// **'CV'**
  String get cv;

  /// No description provided for @programming.
  ///
  /// In en, this message translates to:
  /// **'Programming'**
  String get programming;

  /// No description provided for @courses.
  ///
  /// In en, this message translates to:
  /// **'Courses'**
  String get courses;

  /// No description provided for @consulting.
  ///
  /// In en, this message translates to:
  /// **'Consulting'**
  String get consulting;

  /// No description provided for @design.
  ///
  /// In en, this message translates to:
  /// **'Design'**
  String get design;

  /// No description provided for @engineering.
  ///
  /// In en, this message translates to:
  /// **'Engineering'**
  String get engineering;

  /// No description provided for @finance.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get finance;

  /// No description provided for @academicSources.
  ///
  /// In en, this message translates to:
  /// **'Academic Sources'**
  String get academicSources;

  /// No description provided for @scientificReports.
  ///
  /// In en, this message translates to:
  /// **'Scientific Reports'**
  String get scientificReports;

  /// No description provided for @languagesTranslation.
  ///
  /// In en, this message translates to:
  /// **'Languages & Translation'**
  String get languagesTranslation;

  /// No description provided for @scientificProjects.
  ///
  /// In en, this message translates to:
  /// **'Scientific Projects'**
  String get scientificProjects;

  /// No description provided for @spssAnalysis.
  ///
  /// In en, this message translates to:
  /// **'SPSS Analysis'**
  String get spssAnalysis;

  /// No description provided for @cvResume.
  ///
  /// In en, this message translates to:
  /// **'CV / Resume'**
  String get cvResume;

  /// No description provided for @programmingWebDesign.
  ///
  /// In en, this message translates to:
  /// **'Programming & Web Design'**
  String get programmingWebDesign;

  /// No description provided for @coursesTutorials.
  ///
  /// In en, this message translates to:
  /// **'Courses & Tutorials'**
  String get coursesTutorials;

  /// No description provided for @specializedConsulting.
  ///
  /// In en, this message translates to:
  /// **'Specialized Consulting'**
  String get specializedConsulting;

  /// No description provided for @graphicDesign.
  ///
  /// In en, this message translates to:
  /// **'Graphic Design'**
  String get graphicDesign;

  /// No description provided for @engineeringServices.
  ///
  /// In en, this message translates to:
  /// **'Engineering Services'**
  String get engineeringServices;

  /// No description provided for @financialAccounting.
  ///
  /// In en, this message translates to:
  /// **'Financial & Accounting'**
  String get financialAccounting;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @sortedBy.
  ///
  /// In en, this message translates to:
  /// **'Sorted By'**
  String get sortedBy;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @highestRating.
  ///
  /// In en, this message translates to:
  /// **'Highest Rating'**
  String get highestRating;

  /// No description provided for @mostEarnings.
  ///
  /// In en, this message translates to:
  /// **'Most Earnings'**
  String get mostEarnings;

  /// No description provided for @mostCompleted.
  ///
  /// In en, this message translates to:
  /// **'Most Completed'**
  String get mostCompleted;

  /// No description provided for @newest.
  ///
  /// In en, this message translates to:
  /// **'Newest'**
  String get newest;

  /// No description provided for @oldest.
  ///
  /// In en, this message translates to:
  /// **'Oldest'**
  String get oldest;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @suspended.
  ///
  /// In en, this message translates to:
  /// **'Suspended'**
  String get suspended;

  /// No description provided for @inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @verifiedFreelancer.
  ///
  /// In en, this message translates to:
  /// **'Verified Freelancer'**
  String get verifiedFreelancer;

  /// No description provided for @userDetails.
  ///
  /// In en, this message translates to:
  /// **'User Details'**
  String get userDetails;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone:'**
  String get phone;

  /// No description provided for @registrationDate.
  ///
  /// In en, this message translates to:
  /// **'Registration Date:'**
  String get registrationDate;

  /// No description provided for @lastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last Updated:'**
  String get lastUpdated;

  /// No description provided for @adminActions.
  ///
  /// In en, this message translates to:
  /// **'Admin Actions'**
  String get adminActions;

  /// No description provided for @activeDeactivate.
  ///
  /// In en, this message translates to:
  /// **'Active/Deactivate'**
  String get activeDeactivate;

  /// No description provided for @sendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get sendMessage;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @unverify.
  ///
  /// In en, this message translates to:
  /// **'Unverify'**
  String get unverify;

  /// No description provided for @activityStatistics.
  ///
  /// In en, this message translates to:
  /// **'Activity Statistics'**
  String get activityStatistics;

  /// No description provided for @noOrdersYet.
  ///
  /// In en, this message translates to:
  /// **'No Orders Yet'**
  String get noOrdersYet;

  /// No description provided for @filtersTooltip.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filtersTooltip;

  /// No description provided for @notAvailable.
  ///
  /// In en, this message translates to:
  /// **'Not Available'**
  String get notAvailable;

  /// No description provided for @unassigned.
  ///
  /// In en, this message translates to:
  /// **'Unassigned'**
  String get unassigned;

  /// No description provided for @jobs.
  ///
  /// In en, this message translates to:
  /// **'jobs'**
  String get jobs;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @orderDetails.
  ///
  /// In en, this message translates to:
  /// **'Order Details'**
  String get orderDetails;

  /// No description provided for @manageOrders.
  ///
  /// In en, this message translates to:
  /// **'Manage Orders'**
  String get manageOrders;

  /// No description provided for @searchForOrder.
  ///
  /// In en, this message translates to:
  /// **'Search for order'**
  String get searchForOrder;

  /// No description provided for @searchByStatus.
  ///
  /// In en, this message translates to:
  /// **'Search by status'**
  String get searchByStatus;

  /// No description provided for @searchByClientName.
  ///
  /// In en, this message translates to:
  /// **'Search by client name'**
  String get searchByClientName;

  /// No description provided for @delayed.
  ///
  /// In en, this message translates to:
  /// **'Delayed'**
  String get delayed;

  /// No description provided for @newOrder.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newOrder;

  /// No description provided for @progress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progress;

  /// No description provided for @delivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get delivered;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @noOrdersHere.
  ///
  /// In en, this message translates to:
  /// **'No orders here'**
  String get noOrdersHere;

  /// No description provided for @late.
  ///
  /// In en, this message translates to:
  /// **'Late'**
  String get late;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @loadingUserInfo.
  ///
  /// In en, this message translates to:
  /// **'Loading client & freelancer info...'**
  String get loadingUserInfo;

  /// No description provided for @clientDetails.
  ///
  /// In en, this message translates to:
  /// **'Client Details'**
  String get clientDetails;

  /// No description provided for @freelancerDetails.
  ///
  /// In en, this message translates to:
  /// **'Freelancer Details'**
  String get freelancerDetails;

  /// No description provided for @requestId.
  ///
  /// In en, this message translates to:
  /// **'Request ID'**
  String get requestId;

  /// No description provided for @offerId.
  ///
  /// In en, this message translates to:
  /// **'Offer ID'**
  String get offerId;

  /// No description provided for @orderTimeline.
  ///
  /// In en, this message translates to:
  /// **'Order Timeline'**
  String get orderTimeline;

  /// No description provided for @cancelOrder.
  ///
  /// In en, this message translates to:
  /// **'Cancel Order'**
  String get cancelOrder;

  /// No description provided for @orderCreated.
  ///
  /// In en, this message translates to:
  /// **'Order Created'**
  String get orderCreated;

  /// No description provided for @paymentConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Payment Confirmed'**
  String get paymentConfirmed;

  /// No description provided for @workStarted.
  ///
  /// In en, this message translates to:
  /// **'Work Started'**
  String get workStarted;

  /// No description provided for @delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get delivery;

  /// No description provided for @deadlineExpired.
  ///
  /// In en, this message translates to:
  /// **'Deadline Expired'**
  String get deadlineExpired;

  /// No description provided for @noCategory.
  ///
  /// In en, this message translates to:
  /// **'No Category'**
  String get noCategory;

  /// No description provided for @offers.
  ///
  /// In en, this message translates to:
  /// **'Offers'**
  String get offers;

  /// No description provided for @filterBy.
  ///
  /// In en, this message translates to:
  /// **'Filter by:'**
  String get filterBy;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @offersReceived.
  ///
  /// In en, this message translates to:
  /// **'Offers Received'**
  String get offersReceived;

  /// No description provided for @posted.
  ///
  /// In en, this message translates to:
  /// **'Posted'**
  String get posted;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @noDescription.
  ///
  /// In en, this message translates to:
  /// **'No Description'**
  String get noDescription;

  /// No description provided for @created.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get created;

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paid;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get inProgress;

  /// No description provided for @accepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get accepted;

  /// No description provided for @paidPending.
  ///
  /// In en, this message translates to:
  /// **'Paid (Pending Confirmation)'**
  String get paidPending;

  /// No description provided for @deadline.
  ///
  /// In en, this message translates to:
  /// **'Deadline'**
  String get deadline;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @id.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get id;

  /// No description provided for @attachments.
  ///
  /// In en, this message translates to:
  /// **'Attachments'**
  String get attachments;

  /// No description provided for @serviceType.
  ///
  /// In en, this message translates to:
  /// **'Service Type'**
  String get serviceType;

  /// No description provided for @budget.
  ///
  /// In en, this message translates to:
  /// **'Budget'**
  String get budget;

  /// No description provided for @createdAt.
  ///
  /// In en, this message translates to:
  /// **'Created At'**
  String get createdAt;

  /// No description provided for @updatedAt.
  ///
  /// In en, this message translates to:
  /// **'Updated At'**
  String get updatedAt;

  /// No description provided for @offersCount.
  ///
  /// In en, this message translates to:
  /// **'Offers Count'**
  String get offersCount;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @commissionPercentage.
  ///
  /// In en, this message translates to:
  /// **'Commission Percentage'**
  String get commissionPercentage;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @noReviews.
  ///
  /// In en, this message translates to:
  /// **'No Reviews'**
  String get noReviews;

  /// No description provided for @noReviewsHere.
  ///
  /// In en, this message translates to:
  /// **'No reviews here'**
  String get noReviewsHere;

  /// No description provided for @noReviewsForThisFreelancer.
  ///
  /// In en, this message translates to:
  /// **'No reviews for this freelancer'**
  String get noReviewsForThisFreelancer;

  /// No description provided for @noReviewsForThisClient.
  ///
  /// In en, this message translates to:
  /// **'No reviews for this client'**
  String get noReviewsForThisClient;

  /// No description provided for @reviewsGiven.
  ///
  /// In en, this message translates to:
  /// **'Reviews Given'**
  String get reviewsGiven;

  /// No description provided for @reviewsReceived.
  ///
  /// In en, this message translates to:
  /// **'Reviews Received'**
  String get reviewsReceived;

  /// No description provided for @noReviewsGiven.
  ///
  /// In en, this message translates to:
  /// **'No reviews given'**
  String get noReviewsGiven;

  /// No description provided for @noReviewsReceived.
  ///
  /// In en, this message translates to:
  /// **'No reviews received'**
  String get noReviewsReceived;

  /// No description provided for @noReviewsGivenForThisClient.
  ///
  /// In en, this message translates to:
  /// **'No reviews given for this client'**
  String get noReviewsGivenForThisClient;

  /// No description provided for @noReviewsGivenForThisFreelancer.
  ///
  /// In en, this message translates to:
  /// **'No reviews given for this freelancer'**
  String get noReviewsGivenForThisFreelancer;

  /// No description provided for @noReviewsReceivedForThisClient.
  ///
  /// In en, this message translates to:
  /// **'No reviews received for this client'**
  String get noReviewsReceivedForThisClient;

  /// No description provided for @service1.
  ///
  /// In en, this message translates to:
  /// **'Providing academic sources and references'**
  String get service1;

  /// No description provided for @service2.
  ///
  /// In en, this message translates to:
  /// **'Scientific reports'**
  String get service2;

  /// No description provided for @service3.
  ///
  /// In en, this message translates to:
  /// **'Mind maps'**
  String get service3;

  /// No description provided for @service4.
  ///
  /// In en, this message translates to:
  /// **'Languages and translation'**
  String get service4;

  /// No description provided for @service5.
  ///
  /// In en, this message translates to:
  /// **'Summarizing books, articles, and lectures'**
  String get service5;

  /// No description provided for @service6.
  ///
  /// In en, this message translates to:
  /// **'Scientific projects'**
  String get service6;

  /// No description provided for @service7.
  ///
  /// In en, this message translates to:
  /// **'Presentations (PowerPoint)'**
  String get service7;

  /// No description provided for @service8.
  ///
  /// In en, this message translates to:
  /// **'Statistical analysis (SPSS)'**
  String get service8;

  /// No description provided for @service9.
  ///
  /// In en, this message translates to:
  /// **'Proofreading'**
  String get service9;

  /// No description provided for @service10.
  ///
  /// In en, this message translates to:
  /// **'Resume/CV'**
  String get service10;

  /// No description provided for @service11.
  ///
  /// In en, this message translates to:
  /// **'Programming and web design'**
  String get service11;

  /// No description provided for @service12.
  ///
  /// In en, this message translates to:
  /// **'Tutorials and courses'**
  String get service12;

  /// No description provided for @service13.
  ///
  /// In en, this message translates to:
  /// **'Specialized consultations by field'**
  String get service13;

  /// No description provided for @service14.
  ///
  /// In en, this message translates to:
  /// **'Graphic design 🎨'**
  String get service14;

  /// No description provided for @service15.
  ///
  /// In en, this message translates to:
  /// **'Engineering services'**
  String get service15;

  /// No description provided for @service16.
  ///
  /// In en, this message translates to:
  /// **'Financial and accounting services'**
  String get service16;

  /// No description provided for @orderNow.
  ///
  /// In en, this message translates to:
  /// **'Order Now'**
  String get orderNow;

  /// No description provided for @noServicesFound.
  ///
  /// In en, this message translates to:
  /// **'No services found'**
  String get noServicesFound;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @continuewithface.
  ///
  /// In en, this message translates to:
  /// **'Continue with Facebook'**
  String get continuewithface;

  /// No description provided for @continuewithapple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get continuewithapple;

  /// No description provided for @welcome_to_taskly.
  ///
  /// In en, this message translates to:
  /// **'Welcome To Taskly'**
  String get welcome_to_taskly;

  /// No description provided for @search_for_services.
  ///
  /// In en, this message translates to:
  /// **'Search for services'**
  String get search_for_services;

  /// No description provided for @order_created_success.
  ///
  /// In en, this message translates to:
  /// **'Order created successfully'**
  String get order_created_success;

  /// No description provided for @something_went_wrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong, try again later'**
  String get something_went_wrong;

  /// No description provided for @title_label.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title_label;

  /// No description provided for @category_label.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category_label;

  /// No description provided for @description_label.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description_label;

  /// No description provided for @deadline_label.
  ///
  /// In en, this message translates to:
  /// **'Deadline'**
  String get deadline_label;

  /// No description provided for @attachments_label.
  ///
  /// In en, this message translates to:
  /// **'Attachments'**
  String get attachments_label;

  /// No description provided for @hiring_method_label.
  ///
  /// In en, this message translates to:
  /// **'Hiring Method'**
  String get hiring_method_label;

  /// No description provided for @submit_button.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit_button;

  /// No description provided for @error_enter_title.
  ///
  /// In en, this message translates to:
  /// **'Please enter title'**
  String get error_enter_title;

  /// No description provided for @error_choose_category.
  ///
  /// In en, this message translates to:
  /// **'Please choose category'**
  String get error_choose_category;

  /// No description provided for @error_enter_description.
  ///
  /// In en, this message translates to:
  /// **'Please enter description'**
  String get error_enter_description;

  /// No description provided for @error_enter_deadline.
  ///
  /// In en, this message translates to:
  /// **'Please enter deadline'**
  String get error_enter_deadline;

  /// No description provided for @error_add_attachments.
  ///
  /// In en, this message translates to:
  /// **'Please add attachments'**
  String get error_add_attachments;

  /// No description provided for @error_select_hiring_method.
  ///
  /// In en, this message translates to:
  /// **'Please select hiring method'**
  String get error_select_hiring_method;

  /// No description provided for @error_wait_attachments.
  ///
  /// In en, this message translates to:
  /// **'Please wait until all attachments are uploaded'**
  String get error_wait_attachments;

  /// No description provided for @error_select_freelancer.
  ///
  /// In en, this message translates to:
  /// **'Please select freelancer'**
  String get error_select_freelancer;

  /// No description provided for @description_hint.
  ///
  /// In en, this message translates to:
  /// **'Write your description here'**
  String get description_hint;

  /// No description provided for @enter_time.
  ///
  /// In en, this message translates to:
  /// **'Enter time'**
  String get enter_time;

  /// No description provided for @uploading.
  ///
  /// In en, this message translates to:
  /// **'Uploading...'**
  String get uploading;

  /// No description provided for @uploaded_successfully.
  ///
  /// In en, this message translates to:
  /// **'Uploaded Successfully ✅'**
  String get uploaded_successfully;

  /// No description provided for @no_files_uploaded_yet.
  ///
  /// In en, this message translates to:
  /// **'No files uploaded yet'**
  String get no_files_uploaded_yet;

  /// No description provided for @files_uploaded_count.
  ///
  /// In en, this message translates to:
  /// **'{count} files uploaded'**
  String files_uploaded_count(Object count);

  /// No description provided for @file_not_found_for_deletion.
  ///
  /// In en, this message translates to:
  /// **'File not found for deletion'**
  String get file_not_found_for_deletion;

  /// No description provided for @failed_to_delete_file.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete file'**
  String get failed_to_delete_file;

  /// No description provided for @file_deleted_successfully.
  ///
  /// In en, this message translates to:
  /// **'File deleted successfully'**
  String get file_deleted_successfully;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String error(Object error);

  /// No description provided for @public_posting_title.
  ///
  /// In en, this message translates to:
  /// **'Public Posting'**
  String get public_posting_title;

  /// No description provided for @public_posting_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Post your request publicly and receive multiple proposals'**
  String get public_posting_subtitle;

  /// No description provided for @hire_specific_freelancer_title.
  ///
  /// In en, this message translates to:
  /// **'Hire Specific Freelancer'**
  String get hire_specific_freelancer_title;

  /// No description provided for @hire_specific_freelancer_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Send your request directly to a specific freelancer as a private offer'**
  String get hire_specific_freelancer_subtitle;

  /// No description provided for @private_badge.
  ///
  /// In en, this message translates to:
  /// **'Private'**
  String get private_badge;

  /// No description provided for @search_freelancers_hint.
  ///
  /// In en, this message translates to:
  /// **'Search freelancers by name...'**
  String get search_freelancers_hint;

  /// No description provided for @choose_best_match_hint.
  ///
  /// In en, this message translates to:
  /// **'Choose the best match for your project'**
  String get choose_best_match_hint;

  /// No description provided for @service_order.
  ///
  /// In en, this message translates to:
  /// **'Service Order'**
  String get service_order;

  /// No description provided for @statistical_analysis.
  ///
  /// In en, this message translates to:
  /// **'Statistical Analysis'**
  String get statistical_analysis;

  /// No description provided for @resume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resume;

  /// No description provided for @tutorials.
  ///
  /// In en, this message translates to:
  /// **'Tutorials'**
  String get tutorials;

  /// No description provided for @consultations.
  ///
  /// In en, this message translates to:
  /// **'Consultations'**
  String get consultations;

  /// No description provided for @graphic_design.
  ///
  /// In en, this message translates to:
  /// **'Graphic Design'**
  String get graphic_design;

  /// No description provided for @engineering_services.
  ///
  /// In en, this message translates to:
  /// **'Engineering Services'**
  String get engineering_services;

  /// No description provided for @financial_services.
  ///
  /// In en, this message translates to:
  /// **'Financial Services'**
  String get financial_services;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @no_pending_orders_yet.
  ///
  /// In en, this message translates to:
  /// **'No pending orders yet'**
  String get no_pending_orders_yet;

  /// No description provided for @no_orders_in_progress.
  ///
  /// In en, this message translates to:
  /// **'No orders in progress'**
  String get no_orders_in_progress;

  /// No description provided for @no_completed_orders.
  ///
  /// In en, this message translates to:
  /// **'No completed orders'**
  String get no_completed_orders;

  /// No description provided for @no_cancelled_orders.
  ///
  /// In en, this message translates to:
  /// **'No cancelled orders'**
  String get no_cancelled_orders;

  /// No description provided for @unverified_freelancer.
  ///
  /// In en, this message translates to:
  /// **'Unverified Freelancer'**
  String get unverified_freelancer;

  /// No description provided for @payment_under_review.
  ///
  /// In en, this message translates to:
  /// **'Payment under review'**
  String get payment_under_review;

  /// No description provided for @paid_now.
  ///
  /// In en, this message translates to:
  /// **'Paid Now {amount} SAR'**
  String paid_now(Object amount);

  /// No description provided for @confirm_delete.
  ///
  /// In en, this message translates to:
  /// **'Confirm Delete'**
  String get confirm_delete;

  /// No description provided for @delete_confirmation_message.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this order?'**
  String get delete_confirmation_message;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @no_offers_yet.
  ///
  /// In en, this message translates to:
  /// **'No offers yet'**
  String get no_offers_yet;

  /// No description provided for @offer_accepted_successfully.
  ///
  /// In en, this message translates to:
  /// **'Offer accepted successfully'**
  String get offer_accepted_successfully;

  /// No description provided for @offer_rejected_successfully.
  ///
  /// In en, this message translates to:
  /// **'Offer rejected successfully'**
  String get offer_rejected_successfully;

  /// No description provided for @error_temp.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error_temp;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @decline_offer.
  ///
  /// In en, this message translates to:
  /// **'Decline Offer'**
  String get decline_offer;

  /// No description provided for @accept_offer.
  ///
  /// In en, this message translates to:
  /// **'Accept Offer'**
  String get accept_offer;

  /// No description provided for @start_chat.
  ///
  /// In en, this message translates to:
  /// **'Start Chat'**
  String get start_chat;

  /// No description provided for @view_less.
  ///
  /// In en, this message translates to:
  /// **'View Less'**
  String get view_less;

  /// No description provided for @view_more.
  ///
  /// In en, this message translates to:
  /// **'View More'**
  String get view_more;

  /// No description provided for @waiting.
  ///
  /// In en, this message translates to:
  /// **'Waiting'**
  String get waiting;

  /// No description provided for @file_viewer.
  ///
  /// In en, this message translates to:
  /// **'File Viewer'**
  String get file_viewer;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @upload_warning_message.
  ///
  /// In en, this message translates to:
  /// **'You have uploaded payment proof but haven\'t pressed Make Payment. Are you sure you want to leave?'**
  String get upload_warning_message;

  /// No description provided for @stay.
  ///
  /// In en, this message translates to:
  /// **'Stay'**
  String get stay;

  /// No description provided for @leave.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get leave;

  /// No description provided for @upload_payment_proof.
  ///
  /// In en, this message translates to:
  /// **'Upload Payment Proof'**
  String get upload_payment_proof;

  /// No description provided for @secure_payment_note.
  ///
  /// In en, this message translates to:
  /// **'🔒 Secure payment. Funds will not be released until the work is completed.'**
  String get secure_payment_note;

  /// No description provided for @payment_under_review_message.
  ///
  /// In en, this message translates to:
  /// **'📢 Don\'t worry, your payment request is under review.\nIt usually doesn\'t take long.'**
  String get payment_under_review_message;

  /// No description provided for @payment_status.
  ///
  /// In en, this message translates to:
  /// **'Payment Status'**
  String get payment_status;

  /// No description provided for @awaiting_approval.
  ///
  /// In en, this message translates to:
  /// **'Awaiting approval'**
  String get awaiting_approval;

  /// No description provided for @amount_sar.
  ///
  /// In en, this message translates to:
  /// **'Amount: {amount} SAR'**
  String amount_sar(Object amount);

  /// No description provided for @contact_us_note.
  ///
  /// In en, this message translates to:
  /// **'📣 If you have any questions, please contact us. We are here to help!'**
  String get contact_us_note;

  /// No description provided for @chat_with_admin.
  ///
  /// In en, this message translates to:
  /// **'Chat with Admin Now'**
  String get chat_with_admin;

  /// No description provided for @upload_note.
  ///
  /// In en, this message translates to:
  /// **'Note: After completing the transfer, please upload a photo of the receipt or a screenshot from your banking app as proof of payment.'**
  String get upload_note;

  /// No description provided for @leave_warning_message.
  ///
  /// In en, this message translates to:
  /// **'You have uploaded payment proof but haven\'t pressed Make Payment. Are you sure you want to leave?'**
  String get leave_warning_message;

  /// No description provided for @creating_payment.
  ///
  /// In en, this message translates to:
  /// **'Creating payment...'**
  String get creating_payment;

  /// No description provided for @payment_created_success.
  ///
  /// In en, this message translates to:
  /// **'Payment created successfully, please wait for admin approval'**
  String get payment_created_success;

  /// No description provided for @make_payment.
  ///
  /// In en, this message translates to:
  /// **'Make Payment'**
  String get make_payment;

  /// No description provided for @please_upload_proof.
  ///
  /// In en, this message translates to:
  /// **'Please upload payment proof'**
  String get please_upload_proof;

  /// No description provided for @please_wait_uploads.
  ///
  /// In en, this message translates to:
  /// **'Please wait until all attachments are uploaded'**
  String get please_wait_uploads;

  /// No description provided for @iban_number.
  ///
  /// In en, this message translates to:
  /// **'IBAN Number'**
  String get iban_number;

  /// No description provided for @account_number.
  ///
  /// In en, this message translates to:
  /// **'Account Number'**
  String get account_number;

  /// No description provided for @account_name.
  ///
  /// In en, this message translates to:
  /// **'Account Name'**
  String get account_name;

  /// No description provided for @swift_code.
  ///
  /// In en, this message translates to:
  /// **'SWIFT Code'**
  String get swift_code;

  /// No description provided for @wait_uploads.
  ///
  /// In en, this message translates to:
  /// **'Please wait until all attachments are uploaded'**
  String get wait_uploads;

  /// No description provided for @upload_payment_proof_first.
  ///
  /// In en, this message translates to:
  /// **'Please upload payment proof'**
  String get upload_payment_proof_first;

  /// No description provided for @payment_proof_uploaded_success.
  ///
  /// In en, this message translates to:
  /// **'Payment proof uploaded successfully'**
  String get payment_proof_uploaded_success;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @find_work.
  ///
  /// In en, this message translates to:
  /// **'Find Work'**
  String get find_work;

  /// No description provided for @my_jobs.
  ///
  /// In en, this message translates to:
  /// **'My Jobs'**
  String get my_jobs;

  /// No description provided for @messages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messages;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @search_for_orders.
  ///
  /// In en, this message translates to:
  /// **'Search for orders...'**
  String get search_for_orders;

  /// No description provided for @search_for_private_orders.
  ///
  /// In en, this message translates to:
  /// **'Search for private orders...'**
  String get search_for_private_orders;

  /// No description provided for @search_for_public_orders.
  ///
  /// In en, this message translates to:
  /// **'Search for public orders...'**
  String get search_for_public_orders;

  /// No description provided for @search_for_favorite_orders.
  ///
  /// In en, this message translates to:
  /// **'Search for favorite orders...'**
  String get search_for_favorite_orders;

  /// No description provided for @public_requests.
  ///
  /// In en, this message translates to:
  /// **'Public Requests'**
  String get public_requests;

  /// No description provided for @private_requests.
  ///
  /// In en, this message translates to:
  /// **'Private Requests'**
  String get private_requests;

  /// No description provided for @account_under_verification.
  ///
  /// In en, this message translates to:
  /// **'Your account is under verification.\nPlease wait until your request is approved.'**
  String get account_under_verification;

  /// No description provided for @send_offers.
  ///
  /// In en, this message translates to:
  /// **'Send offers'**
  String get send_offers;

  /// No description provided for @send_offer.
  ///
  /// In en, this message translates to:
  /// **'Send offer'**
  String get send_offer;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// No description provided for @weeks.
  ///
  /// In en, this message translates to:
  /// **'Weeks'**
  String get weeks;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get days;

  /// No description provided for @hour.
  ///
  /// In en, this message translates to:
  /// **'Hour'**
  String get hour;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'Hours'**
  String get hours;

  /// No description provided for @minute.
  ///
  /// In en, this message translates to:
  /// **'Minute'**
  String get minute;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get minutes;

  /// No description provided for @just_now.
  ///
  /// In en, this message translates to:
  /// **'just now'**
  String get just_now;

  /// No description provided for @minutes_ago.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes ago'**
  String minutes_ago(Object minutes);

  /// No description provided for @minute_ago.
  ///
  /// In en, this message translates to:
  /// **'1 minute ago'**
  String get minute_ago;

  /// No description provided for @hours_ago.
  ///
  /// In en, this message translates to:
  /// **'{hours} hours ago'**
  String hours_ago(Object hours);

  /// No description provided for @hour_ago.
  ///
  /// In en, this message translates to:
  /// **'1 hour ago'**
  String get hour_ago;

  /// No description provided for @days_ago.
  ///
  /// In en, this message translates to:
  /// **'{days} days ago'**
  String days_ago(Object days);

  /// No description provided for @day_ago.
  ///
  /// In en, this message translates to:
  /// **'1 day ago'**
  String get day_ago;

  /// No description provided for @online.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get online;

  /// No description provided for @last_seen_unknown.
  ///
  /// In en, this message translates to:
  /// **'Last seen: Unknown'**
  String get last_seen_unknown;

  /// No description provided for @last_seen_today.
  ///
  /// In en, this message translates to:
  /// **'Last seen today at {time}'**
  String last_seen_today(Object time);

  /// No description provided for @last_seen_yesterday.
  ///
  /// In en, this message translates to:
  /// **'Last seen yesterday at {time}'**
  String last_seen_yesterday(Object time);

  /// No description provided for @last_seen_days_ago.
  ///
  /// In en, this message translates to:
  /// **'Last seen {days} days ago'**
  String last_seen_days_ago(Object days);

  /// No description provided for @last_seen_on_date.
  ///
  /// In en, this message translates to:
  /// **'Last seen on {date}'**
  String last_seen_on_date(Object date);

  /// No description provided for @time_suffix_ago.
  ///
  /// In en, this message translates to:
  /// **' ago'**
  String get time_suffix_ago;

  /// No description provided for @time_suffix_left.
  ///
  /// In en, this message translates to:
  /// **' left'**
  String get time_suffix_left;

  /// No description provided for @time_day.
  ///
  /// In en, this message translates to:
  /// **'day'**
  String get time_day;

  /// No description provided for @time_days.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get time_days;

  /// No description provided for @time_hour.
  ///
  /// In en, this message translates to:
  /// **'hour'**
  String get time_hour;

  /// No description provided for @time_hours.
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get time_hours;

  /// No description provided for @time_minute.
  ///
  /// In en, this message translates to:
  /// **'minute'**
  String get time_minute;

  /// No description provided for @time_minutes.
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get time_minutes;

  /// No description provided for @unknown_client.
  ///
  /// In en, this message translates to:
  /// **'Unknown Client'**
  String get unknown_client;

  /// No description provided for @jobs_posted.
  ///
  /// In en, this message translates to:
  /// **'{count} jobs posted'**
  String jobs_posted(Object count);

  /// No description provided for @no_public_orders_available.
  ///
  /// In en, this message translates to:
  /// **'No public orders available'**
  String get no_public_orders_available;

  /// No description provided for @no_private_orders_available.
  ///
  /// In en, this message translates to:
  /// **'No private orders available'**
  String get no_private_orders_available;

  /// No description provided for @job_details.
  ///
  /// In en, this message translates to:
  /// **'Job Details'**
  String get job_details;

  /// No description provided for @about_this_job.
  ///
  /// In en, this message translates to:
  /// **'About this job'**
  String get about_this_job;

  /// No description provided for @project_duration.
  ///
  /// In en, this message translates to:
  /// **'Project Duration'**
  String get project_duration;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @withdraw_offer.
  ///
  /// In en, this message translates to:
  /// **'Withdraw offer'**
  String get withdraw_offer;

  /// No description provided for @withdrawing.
  ///
  /// In en, this message translates to:
  /// **'Withdrawing...'**
  String get withdrawing;

  /// No description provided for @proposal_description.
  ///
  /// In en, this message translates to:
  /// **'Proposal description'**
  String get proposal_description;

  /// No description provided for @delete_this_offer.
  ///
  /// In en, this message translates to:
  /// **'Delete this offer'**
  String get delete_this_offer;

  /// No description provided for @no_rejected_offers.
  ///
  /// In en, this message translates to:
  /// **'No rejected offers'**
  String get no_rejected_offers;

  /// No description provided for @no_completed_projects_yet.
  ///
  /// In en, this message translates to:
  /// **'No completed projects yet'**
  String get no_completed_projects_yet;

  /// No description provided for @no_accepted_offers.
  ///
  /// In en, this message translates to:
  /// **'No accepted offers'**
  String get no_accepted_offers;

  /// No description provided for @no_pending_offers.
  ///
  /// In en, this message translates to:
  /// **'No pending offers'**
  String get no_pending_offers;

  /// No description provided for @send_offer_title.
  ///
  /// In en, this message translates to:
  /// **'Send offer'**
  String get send_offer_title;

  /// No description provided for @project_details.
  ///
  /// In en, this message translates to:
  /// **'Project Details :'**
  String get project_details;

  /// No description provided for @proposal_price.
  ///
  /// In en, this message translates to:
  /// **'Proposal Price :'**
  String get proposal_price;

  /// No description provided for @enter_price_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter price'**
  String get enter_price_hint;

  /// No description provided for @price_after_commission.
  ///
  /// In en, this message translates to:
  /// **'Price after commission:'**
  String get price_after_commission;

  /// No description provided for @delivery_time.
  ///
  /// In en, this message translates to:
  /// **'Delivery Time :'**
  String get delivery_time;

  /// No description provided for @enter_time_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter time'**
  String get enter_time_hint;

  /// No description provided for @offer_description_hint.
  ///
  /// In en, this message translates to:
  /// **'Explain how you will execute this project, including methods or any specific conditions....'**
  String get offer_description_hint;

  /// No description provided for @description_error.
  ///
  /// In en, this message translates to:
  /// **'Please enter a description'**
  String get description_error;

  /// No description provided for @price_error.
  ///
  /// In en, this message translates to:
  /// **'Please enter a price'**
  String get price_error;

  /// No description provided for @delivery_time_error.
  ///
  /// In en, this message translates to:
  /// **'Please enter a delivery time'**
  String get delivery_time_error;

  /// No description provided for @offer_sent_success.
  ///
  /// In en, this message translates to:
  /// **'Offer sent successfully'**
  String get offer_sent_success;

  /// No description provided for @exportOrdersCSVTitle.
  ///
  /// In en, this message translates to:
  /// **'Export Orders CSV'**
  String get exportOrdersCSVTitle;

  /// No description provided for @noConversationsFound.
  ///
  /// In en, this message translates to:
  /// **'No conversations found'**
  String get noConversationsFound;

  /// No description provided for @orderId.
  ///
  /// In en, this message translates to:
  /// **'Order ID'**
  String get orderId;

  /// No description provided for @totalPrice.
  ///
  /// In en, this message translates to:
  /// **'Total Price'**
  String get totalPrice;

  /// No description provided for @bankAccountManagement.
  ///
  /// In en, this message translates to:
  /// **'Bank Account Management'**
  String get bankAccountManagement;

  /// No description provided for @managePayments.
  ///
  /// In en, this message translates to:
  /// **'Manage Payments'**
  String get managePayments;

  /// No description provided for @editBankAccount.
  ///
  /// In en, this message translates to:
  /// **'Edit Bank Account'**
  String get editBankAccount;

  /// No description provided for @clientPayments.
  ///
  /// In en, this message translates to:
  /// **'Client Payments'**
  String get clientPayments;

  /// No description provided for @freelancerWithdrawals.
  ///
  /// In en, this message translates to:
  /// **'Freelancer Withdrawals'**
  String get freelancerWithdrawals;

  /// No description provided for @paymentDetails.
  ///
  /// In en, this message translates to:
  /// **'Payment Details'**
  String get paymentDetails;

  /// No description provided for @paymentID.
  ///
  /// In en, this message translates to:
  /// **'Payment ID'**
  String get paymentID;

  /// No description provided for @freelancerID.
  ///
  /// In en, this message translates to:
  /// **'Freelancer ID'**
  String get freelancerID;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @accountNumber.
  ///
  /// In en, this message translates to:
  /// **'Account Number'**
  String get accountNumber;

  /// No description provided for @freelancerInfo.
  ///
  /// In en, this message translates to:
  /// **'Freelancer Info'**
  String get freelancerInfo;

  /// No description provided for @balance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balance;

  /// No description provided for @requestedWithdraw.
  ///
  /// In en, this message translates to:
  /// **'Requested Withdraw'**
  String get requestedWithdraw;

  /// No description provided for @clientID.
  ///
  /// In en, this message translates to:
  /// **'Client ID'**
  String get clientID;

  /// No description provided for @addBankAccount.
  ///
  /// In en, this message translates to:
  /// **'Add Bank Account'**
  String get addBankAccount;

  /// No description provided for @bankTransferReceipt.
  ///
  /// In en, this message translates to:
  /// **'Bank Transfer Receipt'**
  String get bankTransferReceipt;

  /// No description provided for @basicInformation.
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get basicInformation;

  /// No description provided for @accountDetails.
  ///
  /// In en, this message translates to:
  /// **'Account Details'**
  String get accountDetails;

  /// No description provided for @additionalDetails.
  ///
  /// In en, this message translates to:
  /// **'Additional Details'**
  String get additionalDetails;

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get accountSettings;

  /// No description provided for @bankName.
  ///
  /// In en, this message translates to:
  /// **'Bank Name'**
  String get bankName;

  /// No description provided for @accountName.
  ///
  /// In en, this message translates to:
  /// **'Account Name'**
  String get accountName;

  /// No description provided for @iban.
  ///
  /// In en, this message translates to:
  /// **'IBAN'**
  String get iban;

  /// No description provided for @swiftCode.
  ///
  /// In en, this message translates to:
  /// **'SWIFT Code'**
  String get swiftCode;

  /// No description provided for @notesOptional.
  ///
  /// In en, this message translates to:
  /// **'Notes (Optional)'**
  String get notesOptional;

  /// No description provided for @activeAccount.
  ///
  /// In en, this message translates to:
  /// **'Active Account'**
  String get activeAccount;

  /// No description provided for @enableOrDisableBankAccount.
  ///
  /// In en, this message translates to:
  /// **'Enable or disable this bank account'**
  String get enableOrDisableBankAccount;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @bankAccountSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Bank account saved successfully ✅'**
  String get bankAccountSavedSuccessfully;

  /// No description provided for @bankAccountUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Bank account updated successfully ✅'**
  String get bankAccountUpdatedSuccessfully;

  /// No description provided for @bankAccountDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Bank account deleted successfully ✅'**
  String get bankAccountDeletedSuccessfully;

  /// No description provided for @noAccountsFound.
  ///
  /// In en, this message translates to:
  /// **'No accounts found'**
  String get noAccountsFound;

  /// No description provided for @deactivateAccount.
  ///
  /// In en, this message translates to:
  /// **'Deactivate account'**
  String get deactivateAccount;

  /// No description provided for @activateAccount.
  ///
  /// In en, this message translates to:
  /// **'Activate account'**
  String get activateAccount;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @searchPayments.
  ///
  /// In en, this message translates to:
  /// **'Search payments'**
  String get searchPayments;

  /// No description provided for @searchWithdrawals.
  ///
  /// In en, this message translates to:
  /// **'Search withdrawals'**
  String get searchWithdrawals;

  /// No description provided for @searchBankAccount.
  ///
  /// In en, this message translates to:
  /// **'Search bank account'**
  String get searchBankAccount;

  /// No description provided for @welcomeAdmin.
  ///
  /// In en, this message translates to:
  /// **'Welcome Admin now\nmanage your dashboard'**
  String get welcomeAdmin;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @technical_support.
  ///
  /// In en, this message translates to:
  /// **'Technical Support'**
  String get technical_support;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @change_password.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get change_password;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy_policy;

  /// No description provided for @terms_conditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get terms_conditions;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'User Name'**
  String get userName;

  /// No description provided for @enterUserName.
  ///
  /// In en, this message translates to:
  /// **'Enter User Name'**
  String get enterUserName;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @enterEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter Email Address'**
  String get enterEmailAddress;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Phone Number'**
  String get enterPhoneNumber;

  /// No description provided for @profileImage.
  ///
  /// In en, this message translates to:
  /// **'Profile Image'**
  String get profileImage;

  /// No description provided for @updateProfile.
  ///
  /// In en, this message translates to:
  /// **'Update Profile'**
  String get updateProfile;

  /// No description provided for @profileUpdateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdateSuccess;

  /// No description provided for @profileUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Profile update failed, try again later'**
  String get profileUpdateFailed;

  /// No description provided for @fillRequiredFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill Email and User Name fields'**
  String get fillRequiredFields;

  /// No description provided for @lightTheme.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get lightTheme;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get darkTheme;

  /// No description provided for @systemDefault.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get systemDefault;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get arabic;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @privacyPolicyWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Moglance! Your privacy is very important to us. This Privacy Policy explains how we collect, use, and protect your personal information when you use our application, whether you are a Client or a Freelancer.'**
  String get privacyPolicyWelcome;

  /// No description provided for @informationWeCollect.
  ///
  /// In en, this message translates to:
  /// **'1. Information We Collect'**
  String get informationWeCollect;

  /// No description provided for @informationWeCollectDesc.
  ///
  /// In en, this message translates to:
  /// **'- Account Information: name, email, phone number, profile details.\n- Service & Order Details: tasks created, accepted, and completed.\n- Payment Information: billing details and transaction history.\n- Device Information: device type, OS, and IP address.'**
  String get informationWeCollectDesc;

  /// No description provided for @howWeUseInfo.
  ///
  /// In en, this message translates to:
  /// **'2. How We Use Your Information'**
  String get howWeUseInfo;

  /// No description provided for @howWeUseInfoDesc.
  ///
  /// In en, this message translates to:
  /// **'We use your information to create and manage accounts, match Clients with Freelancers, facilitate communication, process payments, improve app performance, and ensure security.'**
  String get howWeUseInfoDesc;

  /// No description provided for @sharingData.
  ///
  /// In en, this message translates to:
  /// **'3. Sharing Your Data'**
  String get sharingData;

  /// No description provided for @sharingDataDesc.
  ///
  /// In en, this message translates to:
  /// **'We do not sell your personal data. We may share information only with:\n- Other Users (limited profile details to complete tasks).\n- Third-party services (Firebase, Supabase, payment processors).\n- Legal authorities if required by law.'**
  String get sharingDataDesc;

  /// No description provided for @dataSecurity.
  ///
  /// In en, this message translates to:
  /// **'4. Data Security'**
  String get dataSecurity;

  /// No description provided for @dataSecurityDesc.
  ///
  /// In en, this message translates to:
  /// **'We implement industry-standard measures to protect your data, but no method of transmission or storage is 100% secure.'**
  String get dataSecurityDesc;

  /// No description provided for @yourRights.
  ///
  /// In en, this message translates to:
  /// **'5. Your Rights'**
  String get yourRights;

  /// No description provided for @yourRightsDesc.
  ///
  /// In en, this message translates to:
  /// **'You have the right to access, update, or delete your personal data and to contact us regarding any privacy concerns.'**
  String get yourRightsDesc;

  /// No description provided for @cookiesTracking.
  ///
  /// In en, this message translates to:
  /// **'6. Cookies & Tracking'**
  String get cookiesTracking;

  /// No description provided for @cookiesTrackingDesc.
  ///
  /// In en, this message translates to:
  /// **'Moglance may use cookies and similar technologies to personalize your experience and analyze app usage.'**
  String get cookiesTrackingDesc;

  /// No description provided for @policyUpdates.
  ///
  /// In en, this message translates to:
  /// **'7. Policy Updates'**
  String get policyUpdates;

  /// No description provided for @policyUpdatesDesc.
  ///
  /// In en, this message translates to:
  /// **'We may update this Privacy Policy from time to time. Continued use of Moglance means you agree to the updated terms.'**
  String get policyUpdatesDesc;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @changePasswordDesc.
  ///
  /// In en, this message translates to:
  /// **'Enter your old password then enter your new password to change your password.'**
  String get changePasswordDesc;

  /// No description provided for @oldPassword.
  ///
  /// In en, this message translates to:
  /// **'Old Password'**
  String get oldPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPassword;

  /// No description provided for @enterOldPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Old Password'**
  String get enterOldPassword;

  /// No description provided for @enterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter New Password'**
  String get enterNewPassword;

  /// No description provided for @enterConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter Confirm New Password'**
  String get enterConfirmPassword;

  /// No description provided for @passwordChangedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully'**
  String get passwordChangedSuccess;

  /// No description provided for @passwordValidation.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordValidation;

  /// No description provided for @passwordsNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsNotMatch;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @contactUsOn.
  ///
  /// In en, this message translates to:
  /// **'Contact Us on:'**
  String get contactUsOn;

  /// No description provided for @sendMessageOn.
  ///
  /// In en, this message translates to:
  /// **'Or send us a message on:'**
  String get sendMessageOn;

  /// No description provided for @faq.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get faq;

  /// No description provided for @howToRequestService.
  ///
  /// In en, this message translates to:
  /// **'How to request a service?'**
  String get howToRequestService;

  /// No description provided for @howToDeleteService.
  ///
  /// In en, this message translates to:
  /// **'How to delete a service request?'**
  String get howToDeleteService;

  /// No description provided for @howToContactSupport.
  ///
  /// In en, this message translates to:
  /// **'How to contact support?'**
  String get howToContactSupport;

  /// No description provided for @howToChatWithAdmin.
  ///
  /// In en, this message translates to:
  /// **'How to chat directly with the admin?'**
  String get howToChatWithAdmin;

  /// No description provided for @howToUpdateProfile.
  ///
  /// In en, this message translates to:
  /// **'How to update my profile?'**
  String get howToUpdateProfile;

  /// No description provided for @howToChangePassword.
  ///
  /// In en, this message translates to:
  /// **'How to change my password?'**
  String get howToChangePassword;

  /// No description provided for @howToChangeName.
  ///
  /// In en, this message translates to:
  /// **'How to change my name?'**
  String get howToChangeName;

  /// No description provided for @requestServiceAnswer.
  ///
  /// In en, this message translates to:
  /// **'To request a service, go to the services page, choose the service you need, fill in the details, and submit your request.'**
  String get requestServiceAnswer;

  /// No description provided for @deleteServiceAnswer.
  ///
  /// In en, this message translates to:
  /// **'To delete a service request, go to the \'My Jobs\' tab, find your request under \'Pending\', open it, and tap the delete button. Confirm to remove it.'**
  String get deleteServiceAnswer;

  /// No description provided for @contactSupportAnswer.
  ///
  /// In en, this message translates to:
  /// **'You can contact us via phone, email, or send a message through the Contact Us section above.'**
  String get contactSupportAnswer;

  /// No description provided for @chatWithAdminAnswer.
  ///
  /// In en, this message translates to:
  /// **'To chat directly with the admin, go to the \'Messages\' tab. You will find a pinned chat where you can send your messages and get a response from the admin.'**
  String get chatWithAdminAnswer;

  /// No description provided for @updateProfileAnswer.
  ///
  /// In en, this message translates to:
  /// **'Go to your profile page, click edit, and update your name, email, or password as needed.'**
  String get updateProfileAnswer;

  /// No description provided for @changePasswordAnswer.
  ///
  /// In en, this message translates to:
  /// **'Go to your profile page, click edit, and update your password as needed.'**
  String get changePasswordAnswer;

  /// No description provided for @changeNameAnswer.
  ///
  /// In en, this message translates to:
  /// **'Go to your profile page, click edit, and update your name as needed.'**
  String get changeNameAnswer;

  /// No description provided for @withdrawalRequest.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal Request'**
  String get withdrawalRequest;

  /// No description provided for @withdrawalHistory.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal History'**
  String get withdrawalHistory;

  /// No description provided for @freelancerWallet.
  ///
  /// In en, this message translates to:
  /// **'Freelancer Wallet'**
  String get freelancerWallet;

  /// No description provided for @availableBalance.
  ///
  /// In en, this message translates to:
  /// **'Available Balance'**
  String get availableBalance;

  /// No description provided for @totalEarnings.
  ///
  /// In en, this message translates to:
  /// **'Total Earnings'**
  String get totalEarnings;

  /// No description provided for @withdrawn.
  ///
  /// In en, this message translates to:
  /// **'Withdrawn'**
  String get withdrawn;

  /// No description provided for @withdrawalAmount.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal Amount'**
  String get withdrawalAmount;

  /// No description provided for @enterAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter Amount'**
  String get enterAmount;

  /// No description provided for @selectPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Select Payment Method'**
  String get selectPaymentMethod;

  /// No description provided for @vodafoneCash.
  ///
  /// In en, this message translates to:
  /// **'Vodafone Cash'**
  String get vodafoneCash;

  /// No description provided for @instapay.
  ///
  /// In en, this message translates to:
  /// **'InstaPay'**
  String get instapay;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileNumber;

  /// No description provided for @enterMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter mobile number'**
  String get enterMobileNumber;

  /// No description provided for @submitRequest.
  ///
  /// In en, this message translates to:
  /// **'Submit Request'**
  String get submitRequest;

  /// No description provided for @withdrawalRequestPlacedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal request placed successfully'**
  String get withdrawalRequestPlacedSuccessfully;

  /// No description provided for @enterValidAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid amount'**
  String get enterValidAmount;

  /// No description provided for @selectMethodAndEnterPhone.
  ///
  /// In en, this message translates to:
  /// **'Select method and enter phone'**
  String get selectMethodAndEnterPhone;

  /// No description provided for @vodafoneCashNote.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Please enter the Vodafone Cash number registered in your name'**
  String get vodafoneCashNote;

  /// No description provided for @analytics.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get analytics;

  /// No description provided for @availableForWithdrawal.
  ///
  /// In en, this message translates to:
  /// **'Available for withdrawal'**
  String get availableForWithdrawal;

  /// No description provided for @completedOrders.
  ///
  /// In en, this message translates to:
  /// **'Completed orders'**
  String get completedOrders;

  /// No description provided for @requestWithdrawal.
  ///
  /// In en, this message translates to:
  /// **'Request Withdrawal'**
  String get requestWithdrawal;

  /// No description provided for @dashboardSection.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboardSection;

  /// No description provided for @withdrawBalance.
  ///
  /// In en, this message translates to:
  /// **'Withdraw Balance'**
  String get withdrawBalance;

  /// No description provided for @myOrders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get myOrders;

  /// No description provided for @workSection.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get workSection;

  /// No description provided for @reviewsRatings.
  ///
  /// In en, this message translates to:
  /// **'Reviews & Ratings'**
  String get reviewsRatings;

  /// No description provided for @supportSection.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get supportSection;

  /// No description provided for @technicalSupport.
  ///
  /// In en, this message translates to:
  /// **'Technical Support'**
  String get technicalSupport;

  /// No description provided for @accountSection.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get accountSection;

  /// No description provided for @settingsSection.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsSection;

  /// No description provided for @termsConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsConditions;

  /// No description provided for @somethingWentWrongTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong, Please try again Later'**
  String get somethingWentWrongTryAgain;

  /// No description provided for @errorFetchingEarnings.
  ///
  /// In en, this message translates to:
  /// **'Error fetching earnings'**
  String get errorFetchingEarnings;

  /// No description provided for @withdrawalHistoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No withdrawal history found'**
  String get withdrawalHistoryEmpty;

  /// No description provided for @cannotWithdrawMoreThanBalance.
  ///
  /// In en, this message translates to:
  /// **'You cannot withdraw more than your available balance {balance} SAR'**
  String cannotWithdrawMoreThanBalance(Object balance);

  /// No description provided for @cannotWithdrawMoreThanBalance_placeholder.
  ///
  /// In en, this message translates to:
  /// **'{balance}'**
  String cannotWithdrawMoreThanBalance_placeholder(Object balance);

  /// No description provided for @admin_support.
  ///
  /// In en, this message translates to:
  /// **'Admin Support'**
  String get admin_support;

  /// No description provided for @checkOrderStatusMessage.
  ///
  /// In en, this message translates to:
  /// **'Please check the order status in the Messages section and contact the client if needed.'**
  String get checkOrderStatusMessage;

  /// No description provided for @chat_with_admin_support.
  ///
  /// In en, this message translates to:
  /// **'Chat with Admin Support'**
  String get chat_with_admin_support;

  /// No description provided for @offerCompletedMessage.
  ///
  /// In en, this message translates to:
  /// **'This offer has been completed. You can leave a review or check the order details in Messages.'**
  String get offerCompletedMessage;

  /// No description provided for @orderPending.
  ///
  /// In en, this message translates to:
  /// **'System: The order is still pending. No offer has been accepted yet.'**
  String get orderPending;

  /// No description provided for @orderAccepted.
  ///
  /// In en, this message translates to:
  /// **'System: The offer has been accepted. Waiting for payment before work can start.'**
  String get orderAccepted;

  /// No description provided for @orderPaid.
  ///
  /// In en, this message translates to:
  /// **'System: Payment has been submitted and is under review. Work will begin as soon as possible.'**
  String get orderPaid;

  /// No description provided for @orderInProgress.
  ///
  /// In en, this message translates to:
  /// **'System: Order payment has been confirmed, you can start working on it now.'**
  String get orderInProgress;

  /// No description provided for @orderWaiting.
  ///
  /// In en, this message translates to:
  /// **'System: Work has been submitted to the client for review.'**
  String get orderWaiting;

  /// No description provided for @orderCompleted.
  ///
  /// In en, this message translates to:
  /// **'System: The order has been completed successfully.'**
  String get orderCompleted;

  /// No description provided for @orderCancelled.
  ///
  /// In en, this message translates to:
  /// **'System: This order has been cancelled.'**
  String get orderCancelled;

  /// No description provided for @orderUnknown.
  ///
  /// In en, this message translates to:
  /// **'Order status unknown.'**
  String get orderUnknown;

  /// No description provided for @payNowButton.
  ///
  /// In en, this message translates to:
  /// **'Pay Now {budget}SAR'**
  String payNowButton(Object budget);

  /// No description provided for @submitDeliveryButton.
  ///
  /// In en, this message translates to:
  /// **'Submit Delivery'**
  String get submitDeliveryButton;

  /// No description provided for @workReceivedButton.
  ///
  /// In en, this message translates to:
  /// **'Work Received'**
  String get workReceivedButton;

  /// No description provided for @submitDeliveryConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to submit the delivery?'**
  String get submitDeliveryConfirmation;

  /// No description provided for @workReceivedConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you have received the work?'**
  String get workReceivedConfirmation;

  /// No description provided for @rateClient.
  ///
  /// In en, this message translates to:
  /// **'Rate Client'**
  String get rateClient;

  /// No description provided for @rateFreelancer.
  ///
  /// In en, this message translates to:
  /// **'Rate Freelancer'**
  String get rateFreelancer;

  /// No description provided for @already_offered.
  ///
  /// In en, this message translates to:
  /// **'Already Offered'**
  String get already_offered;

  /// No description provided for @no_messages_yet.
  ///
  /// In en, this message translates to:
  /// **'No messages yet'**
  String get no_messages_yet;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get takePhoto;

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get chooseFromGallery;

  /// No description provided for @typeAMessage.
  ///
  /// In en, this message translates to:
  /// **'Type a message'**
  String get typeAMessage;

  /// No description provided for @chat_with_freelancer.
  ///
  /// In en, this message translates to:
  /// **'Chat with Freelancer'**
  String get chat_with_freelancer;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
