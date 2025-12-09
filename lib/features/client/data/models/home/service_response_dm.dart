import 'package:taskly/features/client/domain/entities/home/service_response_entity.dart';


 

class ServiceDm extends ServiceEntity {
  ServiceDm({
    required super.title,
    required super.icon,
    required super.color,
    required super.buttonText,
    required super.image,
    required super.key,
  });

factory ServiceDm.fromJson(Map<String, dynamic> json) {
  return ServiceDm(
    title: json['title']?.toString() ?? '',
    icon: json['icon']?.toString() ?? '',
    color: json['color']?.toString() ?? '#009688', // لون افتراضي
    buttonText: json['button_text']?.toString() ?? 'عرض',
    key: json['key']?.toString() ?? '',
    image: json['image']?.toString() ?? '',
  );
}

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'icon': icon,
      'color': color,
      'button_text': buttonText,
      'image': image,
      'key': key,
    };
  }
}
