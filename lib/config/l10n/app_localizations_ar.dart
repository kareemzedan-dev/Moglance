// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'موج لانس';

  @override
  String get client => 'عميل';

  @override
  String get freelancer => 'مستقل';

  @override
  String get sar => 'ريال سعودي';

  @override
  String get welcomeMessage => 'رتب شغلك، تواصل،\n  وحقق النجاح!';

  @override
  String get freelancerTitle => 'أنا مستقل';

  @override
  String get freelancerSubtitle => 'ابحث عن مشاريع وطوّر مسيرتك';

  @override
  String get clientTitle => 'أنا عميل';

  @override
  String get clientSubtitle => 'وظّف المستقلين لإنجاز عملك';

  @override
  String get createFreelancerAccount => 'إنشاء حساب مستقل';

  @override
  String get createClientAccount => 'إنشاء حساب عميل';

  @override
  String get alreadyHaveAccount => 'لديك حساب بالفعل؟';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get registerFreelancerSubtitle => 'سجل للبحث عن عمل';

  @override
  String get registerClientSubtitle => 'سجل لتوظيف أفضل المواهب';

  @override
  String get firstName => 'الاسم الأول';

  @override
  String get lastName => 'اسم العائلة';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get createAccount => 'إنشاء حسابي';

  @override
  String get thisFieldIsRequired => 'هذا الحقل مطلوب';

  @override
  String get welcomeBack => 'مرحباً بعودتك';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get continueWithGoogle => 'المتابعة باستخدام جوجل';

  @override
  String get privacyPolicyAgreement => 'بإنشائك حساباً فإنك توافق على ';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get termsAgreement => ' و\nعلى ';

  @override
  String get termsOfUse => 'شروط الاستخدام';

  @override
  String get or => 'او';

  @override
  String get noInternetConnection => 'لا يوجد اتصال بالإنترنت';

  @override
  String get emailAlreadyExists =>
      'البريد الإلكتروني موجود بالفعل أو لم يتم التأكيد. يرجى التحقق من بريدك الإلكتروني.';

  @override
  String get somethingWentWrong => 'حدث خطأ ما، يرجى المحاولة مرة أخرى';

  @override
  String get loginFailed =>
      'فشل تسجيل الدخول. يرجى التحقق من البريد الإلكتروني وكلمة المرور.';

  @override
  String notRegisteredAsRole(Object role) {
    return 'أنت غير مسجل كـ $role. يرجى استخدام الحساب الصحيح.';
  }

  @override
  String get googleLoginCancelled => 'تم إلغاء تسجيل الدخول باستخدام جوجل';

  @override
  String accountAlreadyRegistered(Object existingRole, Object role) {
    return 'هذا الحساب مسجل بالفعل كـ $existingRole. لا يمكنك التسجيل كـ $role.';
  }

  @override
  String get userRegisteredSuccessfully => 'تم تسجيل المستخدم بنجاح';

  @override
  String get userLoginSuccessfully => 'تم تسجيل الدخول بنجاح';

  @override
  String get googleLoginSuccessful => 'تم تسجيل الدخول باستخدام جوجل بنجاح';

  @override
  String get dashboardDescription =>
      'إدارة كل المستقلين والعملاء في لوحة تحكم واحدة';

  @override
  String get performanceTracking =>
      'تتبع الطلبات، مراقبة الأداء، والحفاظ على كل شيء تحت السيطرة';

  @override
  String get skip => 'تخطي';

  @override
  String get letsGo => 'لنبدأ';

  @override
  String get dashboard => 'لوحة التحكم';

  @override
  String get users => 'المستخدمين';

  @override
  String get orders => 'الطلبات';

  @override
  String get payments => 'المدفوعات';

  @override
  String get rate_experience => 'قيّم تجربتك';

  @override
  String experience_with(Object name) {
    return 'كيف كانت تجربتك مع $name؟';
  }

  @override
  String get add_comment => 'أضف تعليقًا (اختياريًا)';

  @override
  String get share_experience => 'شاركنا تجربتك...';

  @override
  String get submit_rating => 'إرسال التقييم';

  @override
  String get rating_success => 'تم إرسال التقييم بنجاح!';

  @override
  String get rating_fail => 'فشل في إرسال التقييم';

  @override
  String get excellent => 'ممتاز!';

  @override
  String get very_good => 'جيد جدًا';

  @override
  String get good => 'جيد';

  @override
  String get fair => 'مقبول';

  @override
  String get poor => 'سيئ';

  @override
  String hiUser(Object name) {
    return 'مرحبًا $name،';
  }

  @override
  String get welcomeTaskly => 'مرحبًا بك في موج لانس';

  @override
  String get revenueTrend => 'اتجاه الإيرادات';

  @override
  String get totalRevenueInfo => 'نمو الإيرادات الإجمالي مع الوقت';

  @override
  String get orderVolume => 'حجم الطلبات';

  @override
  String get dailyOrderInfo => 'معدل إتمام الطلبات اليومي';

  @override
  String get categoryDistribution => 'توزيع الفئات';

  @override
  String get serviceCategoryInfo => 'فئات الخدمة حسب حصة الإيرادات';

  @override
  String errorPrefix(Object message) {
    return 'خطأ: $message';
  }

  @override
  String get dashboardOrders => 'الطلبات';

  @override
  String get dashboardEarnings => 'الإيرادات';

  @override
  String get dashboardClients => 'العملاء';

  @override
  String get dashboardFreelancers => 'المستقلين';

  @override
  String get pendingVerifications => 'التحققات المعلقة';

  @override
  String get disputesNeedingReview => 'النزاعات التي تحتاج مراجعة';

  @override
  String get pendingPayments => 'المدفوعات المعلقة';

  @override
  String get lateOrders => 'الطلبات المتأخرة';

  @override
  String get kpiTitle => 'المؤشرات الرئيسية للأداء';

  @override
  String get trendsTitle => 'الاتجاهات والرؤى البيانية';

  @override
  String get monthlyView => 'عرض شهري';

  @override
  String get pendingActionsTitle => 'الإجراءات والتنبيهات المعلقة';

  @override
  String get exportCSVTitle => 'تصدير CSV المالي';

  @override
  String get exportMoneyCSV => 'تصدير CSV للأموال';

  @override
  String get categoryAcademic => 'أكاديمي';

  @override
  String get categoryReports => 'تقارير';

  @override
  String get categoryMindMaps => 'خرائط ذهنية';

  @override
  String get categoryTranslation => 'ترجمة';

  @override
  String get categorySummaries => 'ملخصات';

  @override
  String get categoryProjects => 'مشاريع';

  @override
  String get categoryPresentations => 'عروض تقديمية';

  @override
  String get categorySPSS => 'SPSS';

  @override
  String get categoryProofreading => 'تدقيق لغوي';

  @override
  String get categoryCV => 'السيرة الذاتية';

  @override
  String get categoryProgramming => 'برمجة';

  @override
  String get categoryCourses => 'دورات';

  @override
  String get categoryConsulting => 'استشارات';

  @override
  String get categoryDesign => 'تصميم';

  @override
  String get categoryEngineering => 'هندسة';

  @override
  String get categoryFinance => 'تمويل';

  @override
  String get legendAcademic => 'مصادر أكاديمية';

  @override
  String get legendReports => 'تقارير علمية';

  @override
  String get legendMindMaps => 'خرائط ذهنية';

  @override
  String get legendTranslation => 'اللغات والترجمة';

  @override
  String get legendSummaries => 'ملخصات';

  @override
  String get legendProjects => 'مشاريع علمية';

  @override
  String get legendPresentations => 'عروض تقديمية';

  @override
  String get legendSPSS => 'تحليل SPSS';

  @override
  String get legendProofreading => 'تدقيق لغوي';

  @override
  String get legendCV => 'السيرة الذاتية';

  @override
  String get legendProgramming => 'برمجة وتصميم ويب';

  @override
  String get legendCourses => 'الدورات التعليمية';

  @override
  String get legendConsulting => 'استشارات متخصصة';

  @override
  String get legendDesign => 'تصميم جرافيك';

  @override
  String get legendEngineering => 'خدمات هندسية';

  @override
  String get legendFinance => 'المالية والمحاسبة';

  @override
  String get manageDashboard => 'ادارة اللوحة القيادية';

  @override
  String get manageUsers => 'إدارة المستخدمين';

  @override
  String get searchByName => 'ابحث بالاسم';

  @override
  String get searchByEmail => 'ابحث بالإيميل';

  @override
  String get clients => 'العملاء';

  @override
  String get freelancers => 'المستقلين';

  @override
  String get totalOrders => 'إجمالي الطلبات';

  @override
  String get completed => 'المكتملة';

  @override
  String get earnings => 'الأرباح';

  @override
  String get rating => 'التقييم';

  @override
  String get keyPerformanceIndicators => 'المؤشرات الرئيسية للأداء';

  @override
  String get visualTrendsInsights => 'الرؤى والاتجاهات البصرية';

  @override
  String get pendingActionAlerts => 'الإجراءات والتنبيهات المعلقة';

  @override
  String get exportFinancialCSV => 'تصدير CSV المالي';

  @override
  String get academic => 'أكاديمي';

  @override
  String get reports => 'تقارير';

  @override
  String get mindMaps => 'خرائط ذهنية';

  @override
  String get translation => 'ترجمة';

  @override
  String get summaries => 'ملخصات';

  @override
  String get projects => 'مشاريع';

  @override
  String get presentations => 'عروض تقديمية';

  @override
  String get spss => 'SPSS';

  @override
  String get proofreading => 'مراجعة لغوية';

  @override
  String get cv => 'السيرة الذاتية';

  @override
  String get programming => 'برمجة';

  @override
  String get courses => 'دورات';

  @override
  String get consulting => 'استشارات';

  @override
  String get design => 'تصميم';

  @override
  String get engineering => 'هندسة';

  @override
  String get finance => 'مالية';

  @override
  String get academicSources => 'مصادر أكاديمية';

  @override
  String get scientificReports => 'تقارير علمية';

  @override
  String get languagesTranslation => 'اللغات والترجمة';

  @override
  String get scientificProjects => 'مشاريع علمية';

  @override
  String get spssAnalysis => 'تحليل SPSS';

  @override
  String get cvResume => 'السيرة الذاتية / CV';

  @override
  String get programmingWebDesign => 'برمجة وتصميم مواقع';

  @override
  String get coursesTutorials => 'الدورات التعليمية';

  @override
  String get specializedConsulting => 'استشارات متخصصة';

  @override
  String get graphicDesign => 'تصميم جرافيكي';

  @override
  String get engineeringServices => 'خدمات هندسية';

  @override
  String get financialAccounting => 'الخدمات المالية والمحاسبية';

  @override
  String get clearAll => 'مسح الكل';

  @override
  String get status => 'الحالة';

  @override
  String get sortedBy => 'ترتيب حسب';

  @override
  String get apply => 'تطبيق';

  @override
  String get highestRating => 'أعلى تقييم';

  @override
  String get mostEarnings => 'الأكثر ربحًا';

  @override
  String get mostCompleted => 'الأكثر إكمالًا';

  @override
  String get newest => 'الأحدث';

  @override
  String get oldest => 'الأقدم';

  @override
  String get active => 'نشط';

  @override
  String get suspended => 'معلق';

  @override
  String get inactive => 'غير نشط';

  @override
  String get all => 'الكل';

  @override
  String get filters => 'الفلاتر';

  @override
  String get pending => 'قيد الانتظار';

  @override
  String get verifiedFreelancer => 'مستقل موثق';

  @override
  String get userDetails => 'تفاصيل المستخدم';

  @override
  String get phone => 'الهاتف:';

  @override
  String get registrationDate => 'تاريخ التسجيل:';

  @override
  String get lastUpdated => 'آخر تحديث:';

  @override
  String get adminActions => 'إجراءات المسؤول';

  @override
  String get activeDeactivate => 'تفعيل/تعطيل';

  @override
  String get sendMessage => 'إرسال رسالة';

  @override
  String get verify => 'توثيق';

  @override
  String get unverify => 'إلغاء التوثيق';

  @override
  String get activityStatistics => 'إحصائيات النشاط';

  @override
  String get noOrdersYet => 'لا توجد طلبات بعد';

  @override
  String get filtersTooltip => 'الفلاتر';

  @override
  String get notAvailable => 'غير متوفر';

  @override
  String get unassigned => 'غير معين';

  @override
  String get jobs => 'وظائف';

  @override
  String get reviews => 'التقييمات';

  @override
  String get orderDetails => 'تفاصيل الطلب';

  @override
  String get manageOrders => 'إدارة الطلبات';

  @override
  String get searchForOrder => 'البحث عن طلب';

  @override
  String get searchByStatus => 'البحث بالحالة';

  @override
  String get searchByClientName => 'البحث باسم العميل';

  @override
  String get delayed => 'متأخر';

  @override
  String get newOrder => 'جديد';

  @override
  String get progress => 'قيد التنفيذ';

  @override
  String get delivered => 'تم التسليم';

  @override
  String get cancelled => 'ملغي';

  @override
  String get noOrdersHere => 'لا توجد طلبات هنا';

  @override
  String get late => 'متأخر';

  @override
  String get viewDetails => 'عرض التفاصيل';

  @override
  String get loadingUserInfo => 'جاري تحميل معلومات العميل والمستقل...';

  @override
  String get clientDetails => 'تفاصيل العميل';

  @override
  String get freelancerDetails => 'تفاصيل المستقل';

  @override
  String get requestId => 'رقم الطلب';

  @override
  String get offerId => 'رقم العرض';

  @override
  String get orderTimeline => 'خطة زمنية للطلب';

  @override
  String get cancelOrder => 'إلغاء الطلب';

  @override
  String get orderCreated => 'تم إنشاء الطلب';

  @override
  String get paymentConfirmed => 'تم تأكيد الدفع';

  @override
  String get workStarted => 'بدأ العمل';

  @override
  String get delivery => 'موعد التسليم';

  @override
  String get deadlineExpired => 'انتهى الموعد النهائي';

  @override
  String get noCategory => 'لا يوجد تصنيف';

  @override
  String get offers => 'العروض';

  @override
  String get filterBy => 'فرز حسب';

  @override
  String get price => 'السعر';

  @override
  String get offersReceived => 'العروض المستلمة';

  @override
  String get posted => 'نشر منذ';

  @override
  String get description => 'الوصف';

  @override
  String get noDescription => 'لا يوجد وصف';

  @override
  String get created => 'تم الإنشاء';

  @override
  String get paid => 'تم الدفع';

  @override
  String get inProgress => 'قيد التنفيذ';

  @override
  String get accepted => 'تم القبول';

  @override
  String get paidPending => 'مدفوع (بانتظار التأكيد)';

  @override
  String get deadline => 'موعد الانتهاء';

  @override
  String get rejected => 'مرفوض';

  @override
  String get id => 'الرقم التعريفي';

  @override
  String get attachments => 'المرفقات';

  @override
  String get serviceType => 'نوع الخدمة';

  @override
  String get budget => 'المبلغ';

  @override
  String get createdAt => 'موعد الانشاء';

  @override
  String get updatedAt => 'موعد التحديث';

  @override
  String get offersCount => ' عدد العروض';

  @override
  String get theme => 'الوضع';

  @override
  String get dark => 'مظلم';

  @override
  String get light => 'فاتح';

  @override
  String get language => 'اللغة';

  @override
  String get close => 'Close';

  @override
  String get commissionPercentage => 'نسبة التطبيق';

  @override
  String get save => 'حفظ';

  @override
  String get noReviews => 'لا توجد تقييمات';

  @override
  String get noReviewsHere => 'لا توجد تقييمات هنا';

  @override
  String get noReviewsForThisFreelancer => 'لا توجد تقييمات لهذا المستقل';

  @override
  String get noReviewsForThisClient => 'لا توجد تقييمات لهذا العميل';

  @override
  String get reviewsGiven => 'التقييمات المقدمة';

  @override
  String get reviewsReceived => 'التقييمات المستلمة';

  @override
  String get noReviewsGiven => 'لم يتم تقديم أي تقييمات';

  @override
  String get noReviewsReceived => 'لم يتم استلام أي تقييمات';

  @override
  String get noReviewsGivenForThisClient =>
      'لم يتم تقديم أي تقييمات لهذا العميل';

  @override
  String get noReviewsGivenForThisFreelancer =>
      'لم يتم تقديم أي تقييمات لهذا المستقل';

  @override
  String get noReviewsReceivedForThisClient =>
      'لم يتم استلام أي تقييمات لهذا العميل';

  @override
  String get service1 => 'توفير المصادر والمراجع الأكاديمية';

  @override
  String get service2 => 'التقارير العلمية';

  @override
  String get service3 => 'الخرائط الذهنية';

  @override
  String get service4 => 'اللغات والترجمة';

  @override
  String get service5 => 'تلخيص كتب - مقالات - محاضرات';

  @override
  String get service6 => 'مشاريع علمية';

  @override
  String get service7 => 'العروض التقديمية (PowerPoint)';

  @override
  String get service8 => 'تحليل إحصائي SPSS';

  @override
  String get service9 => 'تدقيق لغوي';

  @override
  String get service10 => 'سيره ذاتيه';

  @override
  String get service11 => 'البرمجة وتصميم المواقع';

  @override
  String get service12 => 'الشرح والدورات';

  @override
  String get service13 => 'إستشارات متخصصه حسب المجال';

  @override
  String get service14 => 'التصميم الجرافيكي 🎨';

  @override
  String get service15 => 'الخدمات الهندسية';

  @override
  String get service16 => 'الخدمات المالية والمحاسبية';

  @override
  String get orderNow => 'اطلب الان';

  @override
  String get noServicesFound => 'لا يوجد خدمات';

  @override
  String get forgotPassword => 'نسيت كلمه المرور؟';

  @override
  String get continuewithface => 'المتابعة باستخدام فيسبوك';

  @override
  String get continuewithapple => 'المتابعة باستخدام أبل';

  @override
  String get welcome_to_taskly => 'مرحبًا بك في Taskly';

  @override
  String get search_for_services => 'ابحث عن الخدمات';

  @override
  String get order_created_success => 'تم إنشاء الطلب بنجاح';

  @override
  String get something_went_wrong => 'حدث خطأ ما، حاول مرة أخرى لاحقًا';

  @override
  String get title_label => 'العنوان';

  @override
  String get category_label => 'الفئة';

  @override
  String get description_label => 'الوصف';

  @override
  String get deadline_label => 'الموعد النهائي';

  @override
  String get attachments_label => 'المرفقات';

  @override
  String get hiring_method_label => 'طريقة التوظيف';

  @override
  String get submit_button => 'إرسال';

  @override
  String get error_enter_title => 'الرجاء إدخال العنوان';

  @override
  String get error_choose_category => 'الرجاء اختيار الفئة';

  @override
  String get error_enter_description => 'الرجاء إدخال الوصف';

  @override
  String get error_enter_deadline => 'الرجاء إدخال الموعد النهائي';

  @override
  String get error_add_attachments => 'الرجاء إضافة المرفقات';

  @override
  String get error_select_hiring_method => 'الرجاء اختيار طريقة التوظيف';

  @override
  String get error_wait_attachments =>
      'يرجى الانتظار حتى يتم تحميل جميع المرفقات';

  @override
  String get error_select_freelancer => 'الرجاء اختيار المستقل';

  @override
  String get description_hint => 'اكتب وصفك هنا';

  @override
  String get enter_time => 'أدخل الوقت';

  @override
  String get uploading => 'جاري التحميل...';

  @override
  String get uploaded_successfully => 'تم التحميل بنجاح ✅';

  @override
  String get no_files_uploaded_yet => 'لم يتم رفع أي ملفات بعد';

  @override
  String files_uploaded_count(Object count) {
    return '$count ملفات تم رفعها';
  }

  @override
  String get file_not_found_for_deletion => 'الملف غير موجود للحذف';

  @override
  String get failed_to_delete_file => 'فشل حذف الملف';

  @override
  String get file_deleted_successfully => 'تم حذف الملف بنجاح';

  @override
  String error(Object error) {
    return 'خطأ';
  }

  @override
  String get public_posting_title => 'نشر عام';

  @override
  String get public_posting_subtitle =>
      'انشر طلبك بشكل عام واستقبل عروض متعددة';

  @override
  String get hire_specific_freelancer_title => 'توظيف مستقل محدد';

  @override
  String get hire_specific_freelancer_subtitle =>
      'أرسل طلبك مباشرة إلى مستقل معين كعرض خاص';

  @override
  String get private_badge => 'خاص';

  @override
  String get search_freelancers_hint => 'ابحث عن المستقلين بالاسم...';

  @override
  String get choose_best_match_hint => 'اختر الأنسب لمشروعك';

  @override
  String get service_order => 'طلب خدمة';

  @override
  String get statistical_analysis => 'تحليل إحصائي';

  @override
  String get resume => 'سيرة ذاتية';

  @override
  String get tutorials => 'دروس تعليمية';

  @override
  String get consultations => 'استشارات';

  @override
  String get graphic_design => 'تصميم جرافيكي';

  @override
  String get engineering_services => 'خدمات هندسية';

  @override
  String get financial_services => 'خدمات مالية';

  @override
  String get other => 'أخرى';

  @override
  String get no_pending_orders_yet => 'لا توجد طلبات معلقة بعد';

  @override
  String get no_orders_in_progress => 'لا توجد طلبات قيد التنفيذ';

  @override
  String get no_completed_orders => 'لا توجد طلبات مكتملة';

  @override
  String get no_cancelled_orders => 'لا توجد طلبات ملغاة';

  @override
  String get unverified_freelancer => 'مستقل غير موثق';

  @override
  String get payment_under_review => 'الدفع قيد المراجعة';

  @override
  String paid_now(Object amount) {
    return ' ادفع الآن $amount ريال سعودي';
  }

  @override
  String get confirm_delete => 'تأكيد الحذف';

  @override
  String get delete_confirmation_message =>
      'هل أنت متأكد أنك تريد حذف هذا الطلب؟';

  @override
  String get delete => 'حذف';

  @override
  String get no_offers_yet => 'لا توجد عروض بعد';

  @override
  String get offer_accepted_successfully => 'تم قبول العرض بنجاح';

  @override
  String get offer_rejected_successfully => 'تم رفض العرض بنجاح';

  @override
  String get error_temp => 'خطأ';

  @override
  String get loading => 'جاري التحميل';

  @override
  String get decline_offer => 'رفض العرض';

  @override
  String get accept_offer => 'قبول العرض';

  @override
  String get start_chat => 'بدء المحادثة';

  @override
  String get view_less => 'عرض أقل';

  @override
  String get view_more => 'عرض المزيد';

  @override
  String get waiting => 'انتظار';

  @override
  String get file_viewer => 'عارض الملفات';

  @override
  String get warning => 'تحذير';

  @override
  String get upload_warning_message =>
      'لقد قمت برفع إثبات الدفع ولكن لم تضغط على زر تنفيذ الدفع. هل أنت متأكد أنك تريد المغادرة؟';

  @override
  String get stay => 'البقاء';

  @override
  String get leave => 'المغادرة';

  @override
  String get upload_payment_proof => 'رفع إثبات الدفع';

  @override
  String get secure_payment_note =>
      '🔒 دفع آمن. لن يتم الإفراج عن المبلغ حتى يكتمل العمل.';

  @override
  String get payment_under_review_message =>
      '📢 لا تقلق، طلب الدفع الخاص بك قيد المراجعة.\nعادة لا يستغرق الأمر وقتًا طويلاً.';

  @override
  String get payment_status => 'حالة الدفع';

  @override
  String get awaiting_approval => 'في انتظار الموافقة';

  @override
  String amount_sar(Object amount) {
    return 'المبلغ: $amount ريال';
  }

  @override
  String get contact_us_note =>
      '📣 إذا كان لديك أي استفسار، لا تتردد في التواصل معنا. نحن هنا لمساعدتك!';

  @override
  String get chat_with_admin => 'تحدث مع الإدارة الآن';

  @override
  String get upload_note =>
      'ملاحظة: بعد إتمام التحويل، يرجى رفع صورة الإيصال أو لقطة شاشة من تطبيق البنك كدليل على الدفع.';

  @override
  String get leave_warning_message =>
      'لقد قمت برفع إثبات الدفع ولكن لم تضغط على زر تأكيد الدفع. هل أنت متأكد أنك تريد المغادرة؟';

  @override
  String get creating_payment => 'جاري إنشاء الدفع...';

  @override
  String get payment_created_success =>
      'تم إنشاء الدفع بنجاح، يرجى انتظار موافقة الإدارة';

  @override
  String get make_payment => 'إتمام الدفع';

  @override
  String get please_upload_proof => 'يرجى رفع إثبات الدفع';

  @override
  String get please_wait_uploads => 'يرجى الانتظار حتى يتم رفع جميع المرفقات';

  @override
  String get iban_number => 'رقم الآيبان';

  @override
  String get account_number => 'رقم الحساب';

  @override
  String get account_name => 'اسم الحساب';

  @override
  String get swift_code => 'رمز السويفت';

  @override
  String get wait_uploads => 'يرجى الانتظار حتى يتم رفع جميع المرفقات';

  @override
  String get upload_payment_proof_first => 'يرجى رفع إثبات الدفع أولاً';

  @override
  String get payment_proof_uploaded_success => 'تم رفع إثبات الدفع بنجاح';

  @override
  String get home => 'الرئيسية';

  @override
  String get find_work => 'ابحث عن عمل';

  @override
  String get my_jobs => 'طلباتي';

  @override
  String get messages => 'الرسائل';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get search_for_orders => 'ابحث عن الطلبات...';

  @override
  String get search_for_private_orders => 'ابحث عن الطلبات الخاصة...';

  @override
  String get search_for_public_orders => 'ابحث عن الطلبات العامة...';

  @override
  String get search_for_favorite_orders => 'ابحث عن الطلبات المفضلة...';

  @override
  String get public_requests => 'الطلبات العامة';

  @override
  String get private_requests => 'الطلبات الخاصة';

  @override
  String get account_under_verification =>
      'حسابك قيد المراجعة.\nيرجى الانتظار حتى يتم الموافقة على طلبك.';

  @override
  String get send_offers => 'إرسال العروض';

  @override
  String get send_offer => 'إرسال العرض';

  @override
  String get week => 'أسبوع';

  @override
  String get weeks => 'أسابيع';

  @override
  String get day => 'يوم';

  @override
  String get days => 'أيام';

  @override
  String get hour => 'ساعة';

  @override
  String get hours => 'ساعات';

  @override
  String get minute => 'دقيقة';

  @override
  String get minutes => 'دقائق';

  @override
  String get just_now => 'الآن';

  @override
  String minutes_ago(Object minutes) {
    return 'منذ $minutes دقائق';
  }

  @override
  String get minute_ago => 'منذ دقيقة واحدة';

  @override
  String hours_ago(Object hours) {
    return 'منذ $hours ساعات';
  }

  @override
  String get hour_ago => 'منذ ساعة واحدة';

  @override
  String days_ago(Object days) {
    return 'منذ $days أيام';
  }

  @override
  String get day_ago => 'منذ يوم واحد';

  @override
  String get online => 'متصل الآن';

  @override
  String get last_seen_unknown => 'آخر ظهور: غير معروف';

  @override
  String last_seen_today(Object time) {
    return 'آخر ظهور اليوم في $time';
  }

  @override
  String last_seen_yesterday(Object time) {
    return 'آخر ظهور أمس في $time';
  }

  @override
  String last_seen_days_ago(Object days) {
    return 'آخر ظهور منذ $days أيام';
  }

  @override
  String last_seen_on_date(Object date) {
    return 'آخر ظهور في $date';
  }

  @override
  String get time_suffix_ago => ' مضت';

  @override
  String get time_suffix_left => ' متبقية';

  @override
  String get time_day => 'يوم';

  @override
  String get time_days => 'أيام';

  @override
  String get time_hour => 'ساعة';

  @override
  String get time_hours => 'ساعات';

  @override
  String get time_minute => 'دقيقة';

  @override
  String get time_minutes => 'دقائق';

  @override
  String get unknown_client => 'عميل غير معروف';

  @override
  String jobs_posted(Object count) {
    return 'نُشرت $count وظيفة';
  }

  @override
  String get no_public_orders_available => 'لا توجد طلبات عامة متاحة';

  @override
  String get no_private_orders_available => 'لا توجد طلبات خاصه متاحه';

  @override
  String get job_details => 'تفاصيل الوظيفة';

  @override
  String get about_this_job => 'حول هذه الوظيفة';

  @override
  String get project_duration => 'مدة المشروع';

  @override
  String get unknown => 'غير معروف';

  @override
  String get withdraw_offer => 'سحب العرض';

  @override
  String get withdrawing => 'جارٍ السحب...';

  @override
  String get proposal_description => 'وصف العرض';

  @override
  String get delete_this_offer => 'حذف هذا العرض';

  @override
  String get no_rejected_offers => 'لا توجد عروض مرفوضة';

  @override
  String get no_completed_projects_yet => 'لا توجد مشاريع مكتملة بعد';

  @override
  String get no_accepted_offers => 'لا توجد عروض مقبولة';

  @override
  String get no_pending_offers => 'لا توجد عروض قيد الانتظار';

  @override
  String get send_offer_title => 'إرسال العرض';

  @override
  String get project_details => 'تفاصيل المشروع :';

  @override
  String get proposal_price => 'سعر العرض :';

  @override
  String get enter_price_hint => 'أدخل السعر';

  @override
  String get price_after_commission => 'السعر بعد العمولة:';

  @override
  String get delivery_time => 'مدة التسليم :';

  @override
  String get enter_time_hint => 'أدخل الوقت';

  @override
  String get offer_description_hint =>
      'اشرح كيف ستنفذ هذا المشروع، بما في ذلك الأساليب أو أي شروط محددة....';

  @override
  String get description_error => 'يرجى إدخال الوصف';

  @override
  String get price_error => 'يرجى إدخال السعر';

  @override
  String get delivery_time_error => 'يرجى إدخال مدة التسليم';

  @override
  String get offer_sent_success => 'تم إرسال العرض بنجاح';

  @override
  String get exportOrdersCSVTitle => 'تصدير CSV الطلبات';

  @override
  String get noConversationsFound => 'لا توجد محادثات';

  @override
  String get orderId => 'رقم الطلب';

  @override
  String get totalPrice => 'السعر الكلي';

  @override
  String get bankAccountManagement => 'إدارة الحساب البنكي';

  @override
  String get managePayments => 'إدارة المدفوعات';

  @override
  String get editBankAccount => 'تعديل الحساب البنكي';

  @override
  String get clientPayments => 'مدفوعات العميل';

  @override
  String get freelancerWithdrawals => 'سحوبات المستقل';

  @override
  String get paymentDetails => 'تفاصيل الدفع';

  @override
  String get paymentID => 'معرّف الدفع';

  @override
  String get freelancerID => 'معرّف المستقل';

  @override
  String get paymentMethod => 'طريقة الدفع';

  @override
  String get accountNumber => 'رقم الحساب';

  @override
  String get freelancerInfo => 'معلومات المستقل';

  @override
  String get balance => 'الرصيد';

  @override
  String get requestedWithdraw => 'السحب المطلوب';

  @override
  String get clientID => 'معرّف العميل';

  @override
  String get addBankAccount => 'إضافة حساب بنكي';

  @override
  String get bankTransferReceipt => 'إيصال التحويل البنكي';

  @override
  String get basicInformation => 'المعلومات الأساسية';

  @override
  String get accountDetails => 'تفاصيل الحساب';

  @override
  String get additionalDetails => 'تفاصيل إضافية';

  @override
  String get accountSettings => 'إعدادات الحساب';

  @override
  String get bankName => 'اسم البنك';

  @override
  String get accountName => 'اسم الحساب';

  @override
  String get iban => 'الايبان';

  @override
  String get swiftCode => 'رمز سويفت';

  @override
  String get notesOptional => 'ملاحظات (اختياري)';

  @override
  String get activeAccount => 'الحساب نشط';

  @override
  String get enableOrDisableBankAccount => 'تمكين أو تعطيل هذا الحساب البنكي';

  @override
  String get update => 'تحديث';

  @override
  String get deleteAccount => 'حذف الحساب';

  @override
  String get bankAccountSavedSuccessfully => 'تم حفظ الحساب البنكي بنجاح ✅';

  @override
  String get bankAccountUpdatedSuccessfully => 'تم تحديث الحساب البنكي بنجاح ✅';

  @override
  String get bankAccountDeletedSuccessfully => 'تم حذف الحساب البنكي بنجاح ✅';

  @override
  String get noAccountsFound => 'لا يوجد حسابات';

  @override
  String get deactivateAccount => 'تعطيل الحساب';

  @override
  String get activateAccount => 'تفعيل الحساب';

  @override
  String get edit => 'تعديل';

  @override
  String get notes => 'ملاحظات';

  @override
  String get searchPayments => 'بحث في المدفوعات';

  @override
  String get searchWithdrawals => 'بحث في السحوبات';

  @override
  String get searchBankAccount => 'بحث في الحسابات البنكية';

  @override
  String get welcomeAdmin =>
      'مرحبًا بك يا مسؤول\nادير لوحة التحكم الخاصة بك الآن';

  @override
  String get support => 'الدعم';

  @override
  String get technical_support => 'الدعم الفني';

  @override
  String get account => 'الحساب';

  @override
  String get change_password => 'تغيير كلمة المرور';

  @override
  String get settings => 'الإعدادات';

  @override
  String get privacy_policy => 'سياسة الخصوصية';

  @override
  String get terms_conditions => 'الشروط والأحكام';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get cancel => 'إلغاء';

  @override
  String get success => 'نجح';

  @override
  String get userName => 'اسم المستخدم';

  @override
  String get enterUserName => 'أدخل اسم المستخدم';

  @override
  String get emailAddress => 'البريد الإلكتروني';

  @override
  String get enterEmailAddress => 'أدخل البريد الإلكتروني';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get enterPhoneNumber => 'أدخل رقم الهاتف';

  @override
  String get profileImage => 'صورة الملف الشخصي';

  @override
  String get updateProfile => 'تحديث الملف الشخصي';

  @override
  String get profileUpdateSuccess => 'تم تحديث الملف الشخصي بنجاح';

  @override
  String get profileUpdateFailed =>
      'فشل تحديث الملف الشخصي، حاول مرة أخرى لاحقاً';

  @override
  String get fillRequiredFields =>
      'يرجى ملء حقلي البريد الإلكتروني واسم المستخدم';

  @override
  String get lightTheme => 'فاتح';

  @override
  String get darkTheme => 'داكن';

  @override
  String get systemDefault => 'افتراضي النظام';

  @override
  String get arabic => 'العربية';

  @override
  String get english => 'English';

  @override
  String get privacyPolicyWelcome =>
      'مرحباً بكم في موج لانس! خصوصيتك مهمة جداً لنا. تشرح سياسة الخصوصية هذه كيف نجمع ونستخدم ونحمي معلوماتك الشخصية عند استخدامك لتطبيقنا، سواء كنت عميلاً أو مستقلاً.';

  @override
  String get informationWeCollect => '1. المعلومات التي نجمعها';

  @override
  String get informationWeCollectDesc =>
      '- معلومات الحساب: الاسم، البريد الإلكتروني، رقم الهاتف، تفاصيل الملف الشخصي.\n- تفاصيل الخدمة والطلب: المهام المنشورة والمقبولة والمكتملة.\n- معلومات الدفع: تفاصيل الفواتير وسجل المعاملات.\n- معلومات الجهاز: نوع الجهاز، نظام التشغيل، وعنوان IP.';

  @override
  String get howWeUseInfo => '2. كيف نستخدم معلوماتك';

  @override
  String get howWeUseInfoDesc =>
      'نستخدم معلوماتك لإنشاء وإدارة الحسابات، ومطابقة العملاء مع المستقلين، وتسهيل التواصل، ومعالجة المدفوعات، وتحسين أداء التطبيق، وضمان الأمان.';

  @override
  String get sharingData => '3. مشاركة بياناتك';

  @override
  String get sharingDataDesc =>
      'لا نبيع بياناتك الشخصية. قد نشارك المعلومات فقط مع:\n- المستخدمين الآخرين (تفاصيل محدودة من الملف الشخصي لإكمال المهام).\n- خدمات الطرف الثالث (Firebase، Supabase، معالجات الدفع).\n- السلطات القانونية إذا تطلب القانون.';

  @override
  String get dataSecurity => '4. أمان البيانات';

  @override
  String get dataSecurityDesc =>
      'ننفذ إجراءات قياسية في الصناعة لحماية بياناتك، ولكن لا توجد طريقة نقل أو تخزين آمنة بنسبة 100%.';

  @override
  String get yourRights => '5. حقوقك';

  @override
  String get yourRightsDesc =>
      'لديك الحق في الوصول إلى بياناتك الشخصية وتحديثها أو حذفها، والتواصل معنا بشأن أي مخاوف تتعلق بالخصوصية.';

  @override
  String get cookiesTracking => '6. ملفات تعريف الارتباط والتتبع';

  @override
  String get cookiesTrackingDesc =>
      'قد يستخدم موج لانس ملفات تعريف الارتباط وتقنيات مماثلة لتخصيص تجربتك وتحليل استخدام التطبيق.';

  @override
  String get policyUpdates => '7. تحديثات السياسة';

  @override
  String get policyUpdatesDesc =>
      'قد نقوم بتحديث سياسة الخصوصية هذه من وقت لآخر. الاستمرار في استخدام موج لانس يعني موافقتك على الشروط المحدثة.';

  @override
  String get changePassword => 'تغيير كلمة المرور';

  @override
  String get changePasswordDesc =>
      'أدخل كلمة المرور القديمة ثم أدخل كلمة المرور الجديدة لتغيير كلمة المرور.';

  @override
  String get oldPassword => 'كلمة المرور القديمة';

  @override
  String get newPassword => 'كلمة المرور الجديدة';

  @override
  String get confirmNewPassword => 'تأكيد كلمة المرور الجديدة';

  @override
  String get enterOldPassword => 'أدخل كلمة المرور القديمة';

  @override
  String get enterNewPassword => 'أدخل كلمة المرور الجديدة';

  @override
  String get enterConfirmPassword => 'أدخل تأكيد كلمة المرور الجديدة';

  @override
  String get passwordChangedSuccess => 'تم تغيير كلمة المرور بنجاح';

  @override
  String get passwordValidation => 'يجب أن تكون كلمة المرور 6 أحرف على الأقل';

  @override
  String get passwordsNotMatch => 'كلمات المرور غير متطابقة';

  @override
  String get contactUs => 'اتصل بنا';

  @override
  String get contactUsOn => 'اتصل بنا على:';

  @override
  String get sendMessageOn => 'أو أرسل لنا رسالة على:';

  @override
  String get faq => 'الأسئلة الشائعة';

  @override
  String get howToRequestService => 'كيفية طلب خدمة؟';

  @override
  String get howToDeleteService => 'كيفية حذف طلب خدمة؟';

  @override
  String get howToContactSupport => 'كيفية التواصل مع الدعم؟';

  @override
  String get howToChatWithAdmin => 'كيفية الدردشة مباشرة مع المسؤول؟';

  @override
  String get howToUpdateProfile => 'كيفية تحديث ملفي الشخصي؟';

  @override
  String get howToChangePassword => 'كيفية تغيير كلمة المرور؟';

  @override
  String get howToChangeName => 'كيفية تغيير اسمي؟';

  @override
  String get requestServiceAnswer =>
      'لطلب خدمة، انتقل إلى صفحة الخدمات، اختر الخدمة التي تحتاجها، املأ التفاصيل، وأرسل طلبك.';

  @override
  String get deleteServiceAnswer =>
      'لحذف طلب خدمة، انتقل إلى علامة تبويب \'وظائفي\'، ابحث عن طلبك تحت \'قيد الانتظار\'، افتحه، وانقر على زر الحذف. قم بالتأكيد لإزالته.';

  @override
  String get contactSupportAnswer =>
      'يمكنك التواصل معنا عبر الهاتف أو البريد الإلكتروني أو إرسال رسالة عبر قسم اتصل بنا أعلاه.';

  @override
  String get chatWithAdminAnswer =>
      'للدردشة مباشرة مع المسؤول، انتقل إلى علامة تبويب \'الرسائل\'. ستجد محادثة مثبتة حيث يمكنك إرسال رسائلك والحصول على رد من المسؤول.';

  @override
  String get updateProfileAnswer =>
      'انتقل إلى صفحة ملفك الشخصي، انقر على تعديل، وقم بتحديث اسمك أو بريدك الإلكتروني أو كلمة المرور حسب الحاجة.';

  @override
  String get changePasswordAnswer =>
      'انتقل إلى صفحة ملفك الشخصي، انقر على تعديل، وقم بتحديث كلمة المرور حسب الحاجة.';

  @override
  String get changeNameAnswer =>
      'انتقل إلى صفحة ملفك الشخصي، انقر على تعديل، وقم بتعديل اسمك حسب الحاجة.';

  @override
  String get withdrawalRequest => 'طلب سحب';

  @override
  String get withdrawalHistory => 'سجل السحوبات';

  @override
  String get freelancerWallet => 'محفظة المستقل';

  @override
  String get availableBalance => 'الرصيد المتاح';

  @override
  String get totalEarnings => 'إجمالي الأرباح';

  @override
  String get withdrawn => 'المسحوب';

  @override
  String get withdrawalAmount => 'مبلغ السحب';

  @override
  String get enterAmount => 'أدخل المبلغ';

  @override
  String get selectPaymentMethod => 'اختر طريقة الدفع';

  @override
  String get vodafoneCash => 'فودافون كاش';

  @override
  String get instapay => 'إنستا باي';

  @override
  String get mobileNumber => 'رقم الجوال';

  @override
  String get enterMobileNumber => 'أدخل رقم الجوال';

  @override
  String get submitRequest => 'إرسال الطلب';

  @override
  String get withdrawalRequestPlacedSuccessfully => 'تم تقديم طلب السحب بنجاح';

  @override
  String get enterValidAmount => 'أدخل مبلغًا صالحًا';

  @override
  String get selectMethodAndEnterPhone => 'اختر الطريقة وأدخل الرقم';

  @override
  String get vodafoneCashNote => '⚠️ يرجى إدخال رقم فودافون كاش المسجل باسمك';

  @override
  String get analytics => 'التحليلات';

  @override
  String get availableForWithdrawal => 'متاح للسحب';

  @override
  String get completedOrders => 'الطلبات المكتملة';

  @override
  String get requestWithdrawal => 'طلب سحب';

  @override
  String get dashboardSection => 'لوحة التحكم';

  @override
  String get withdrawBalance => 'سحب الرصيد';

  @override
  String get myOrders => 'طلباتي';

  @override
  String get workSection => 'العمل';

  @override
  String get reviewsRatings => 'التقييمات والمراجعات';

  @override
  String get supportSection => 'الدعم';

  @override
  String get technicalSupport => 'الدعم الفني';

  @override
  String get accountSection => 'الحساب';

  @override
  String get settingsSection => 'الإعدادات';

  @override
  String get termsConditions => 'الشروط والأحكام';

  @override
  String get somethingWentWrongTryAgain => 'حدث خطأ، يرجى المحاولة لاحقًا';

  @override
  String get errorFetchingEarnings => 'حدث خطأ أثناء جلب الأرباح';

  @override
  String get withdrawalHistoryEmpty => 'لم يتم العثور على سجل السحوبات';

  @override
  String cannotWithdrawMoreThanBalance(Object balance) {
    return 'لا يمكنك سحب أكثر من رصيدك المتاح $balance ريال';
  }

  @override
  String cannotWithdrawMoreThanBalance_placeholder(Object balance) {
    return '$balance';
  }

  @override
  String get admin_support => 'خدمة العملاء';

  @override
  String get checkOrderStatusMessage =>
      'يرجى التحقق من حالة الطلب في قسم الرسائل والتواصل مع العميل إذا لزم الأمر.';

  @override
  String get chat_with_admin_support => 'الدردشة مع الدعم';

  @override
  String get offerCompletedMessage =>
      'تم إتمام هذا العرض. يمكنك ترك تقييم أو التحقق من تفاصيل الطلب في الرسائل.';

  @override
  String get orderPending =>
      'النظام: الطلب مازال قيد الانتظار. لم يتم قبول أي عرض بعد.';

  @override
  String get orderAccepted =>
      'النظام: تم قبول العرض. في انتظار الدفع قبل بدء العمل.';

  @override
  String get orderPaid =>
      'النظام: تم تقديم الدفع وهو تحت المراجعة. سيبدأ العمل في أقرب وقت ممكن.';

  @override
  String get orderInProgress =>
      'النظام: تم تأكيد الدفع، يمكنك البدء في العمل الآن.';

  @override
  String get orderWaiting => 'النظام: تم تسليم العمل للعميل للمراجعة.';

  @override
  String get orderCompleted => 'النظام: تم إتمام الطلب بنجاح.';

  @override
  String get orderCancelled => 'النظام: تم إلغاء هذا الطلب.';

  @override
  String get orderUnknown => 'حالة الطلب غير معروفة.';

  @override
  String payNowButton(Object budget) {
    return 'ادفع الآن $budget ريال';
  }

  @override
  String get submitDeliveryButton => 'تسليم العمل';

  @override
  String get workReceivedButton => 'تم استلام العمل';

  @override
  String get submitDeliveryConfirmation => 'هل أنت متأكد أنك تريد تسليم العمل؟';

  @override
  String get workReceivedConfirmation => 'هل أنت متأكد أنك استلمت العمل؟';

  @override
  String get rateClient => 'تقييم العميل';

  @override
  String get rateFreelancer => 'تقييم المستقل';

  @override
  String get already_offered => 'العرض تم ارساله بالفعل';

  @override
  String get no_messages_yet => 'لا يوجد رسائل متاحه';

  @override
  String get takePhoto => 'التقاط صورة';

  @override
  String get chooseFromGallery => 'اختيار من المعرض';

  @override
  String get typeAMessage => 'اكتب رسالتك';

  @override
  String get chat_with_freelancer => 'التحدث مع المستقل';
}
