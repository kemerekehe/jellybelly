import 'package:flutter/foundation.dart';

@immutable
class EntityJellyBean {
  final int beanId;
  final String flavorName;
  final String description;
  final String colorGroup;
  final String backgroundColor;
  final String imageUrl;
  final bool glutenFree;
  final bool sugarFree;
  final bool seasonal;
  final bool kosher;

  const EntityJellyBean({
    required this.beanId,
    required this.flavorName,
    required this.description,
    required this.colorGroup,
    required this.backgroundColor,
    required this.imageUrl,
    required this.glutenFree,
    required this.sugarFree,
    required this.seasonal,
    required this.kosher,
  });
}
