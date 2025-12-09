import '../../config/l10n/app_localizations.dart';
import '../../features/client/domain/entities/home/service_response_entity.dart';
import '../utils/assets_manager.dart';

List<ServiceEntity> getLocalServices(AppLocalizations local) {
  return [
    ServiceEntity(
      key: 'academic_sources', // مناسب لـ "توفير المصادر والمراجع الأكاديمية"
      title: local.service1,
      icon: 'menu_book',
      color: '#2196F3',
      buttonText: local.orderNow,
      image: Assets.assetsAcademicSources,
    ),
    ServiceEntity(
      key: 'scientific_reports', // مناسب لـ "التقارير العلمية"
      title: local.service2,
      icon: 'description',
      color: '#3F51B5',
      buttonText: local.orderNow,
      image: Assets.assetsScientificReports
    ),
    ServiceEntity(
      key: 'mind_maps', // مناسب لـ "الخرائط الذهنية"
      title: local.service3,
      icon: 'account_tree',
      color: '#009688',
      buttonText: local.orderNow,
      image: Assets.assetsMindMaps,
    ),
    ServiceEntity(
      key: 'translation', // مناسب لـ "اللغات والترجمة"
      title: local.service4,
      icon: 'translate',
      color: '#FF9800',
      buttonText: local.orderNow,
      image: Assets.assetsTranslation,
    ),
    ServiceEntity(
      key: 'summaries', // مناسب لـ "تلخيص كتب - مقالات - محاضرات"
      title: local.service5,
      icon: 'notes',
      color: '#9C27B0',
      buttonText: local.orderNow,
      image: Assets.assetsSummaries,
    ),
    ServiceEntity(
      key: 'scientific_projects',
      title: local.service6,
      icon: 'science',
      color: '#4CAF50',
      buttonText: local.orderNow,
      image: Assets.assetsScientificProjects,

    ),
    ServiceEntity(
      key: 'presentations',
      title: local.service7,
      icon: 'slideshow',
      color: '#F44336',
      buttonText: local.orderNow,
      image: Assets.assetsPresentations,

    ),
    ServiceEntity(
      key: 'statistical_analysis',
      title: local.service8,
      icon: 'analytics',
      color: '#673AB7',
      buttonText: local.orderNow,
      image: Assets.assetsStatisticalAnalysis,

    ),
    ServiceEntity(
      key: 'proofreading',
      title: local.service9,
      icon: 'spellcheck',
      color: '#795548',
      buttonText: local.orderNow,
      image: Assets.assetsProofreading,

    ),
    ServiceEntity(
      key: 'resume',
      title: local.service10,
      icon: 'work',
      color: '#607D8B',
      buttonText: local.orderNow,
      image: Assets.assetsResume,

    ),
    ServiceEntity(
      key: 'programming',
      title: local.service11,
      icon: 'code',
      color: '#00BCD4',
      buttonText: local.orderNow,
      image: Assets.assetsProgramming,

    ),
    ServiceEntity(
      key: 'tutorials',
      title: local.service12,
      icon: 'school',
      color: '#03A9F4',
      buttonText: local.orderNow,
      image: Assets.assetsTutorials,

    ),
    ServiceEntity(
      key: 'consultations',
      title: local.service13,
      icon: 'support_agent',
      color: '#FF5722',
      buttonText: local.orderNow,
      image: Assets.assetsConsultations,

    ),
    ServiceEntity(
      key: 'graphic_design',
      title: local.service14,
      icon: 'brush',
      color: '#E91E63',
      buttonText: local.orderNow,
      image: Assets.assetsGraphicDesign,

    ),
    ServiceEntity(
      key: 'engineering_services',
      title: local.service15,
      icon: 'notes',
      color: '#9E9E9E',
      buttonText: local.orderNow,
      image: Assets.assetsEngineeringServices,

    ),
    ServiceEntity(
      key: 'financial_services',
      title: local.service16,
      icon: 'account_balance',
      color: '#8BC34A',
      buttonText: local.orderNow,
      image: Assets.assetsFinancialServices,

    ),
  ];
}
