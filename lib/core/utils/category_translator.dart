import 'package:flutter/material.dart';
import 'package:taskly/config/l10n/app_localizations.dart';

class CategoryTranslator {
  /// 🔹 يرجع خريطة التصنيفات باللغتين (المفتاح = من الباك، القيمة = من localizations)
  static Map<String, String> getCategoriesMap(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return {
      "academic_sources": local.academicSources,
      "scientific_reports": local.scientificReports,
      "mind_maps": local.mindMaps,
      "translation": local.translation,
      "summaries": local.summaries,
      "scientific_projects": local.scientificProjects,
      "presentations": local.presentations,
      "statistical_analysis": local.statistical_analysis,
      "proofreading": local.proofreading,
      "resume": local.resume,
      "programming": local.programming,
      "tutorials": local.tutorials,
      "consultations": local.consultations,
      "graphic_design": local.graphic_design,
      "engineering_services": local.engineering_services,
      "financial_services": local.financial_services,
      "other": local.other,
    };
  }

  /// 🔹 ميثود عامة ترجّع الاسم بالعربي بناءً على القيمة اللي جاية من الباك
  static String getArabicName(BuildContext context, String backendValue) {
    final categories = getCategoriesMap(context);
    return categories[backendValue] ?? backendValue;
  }
}
