// lib/data/models/model_jellybean.dart

class ModelJellyBean {
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

  ModelJellyBean({
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

  factory ModelJellyBean.fromJson(Map<String, dynamic> json) {
    return ModelJellyBean(
      beanId: json['beanId'],
      flavorName: json['flavorName'],
      description: json['description'],
      colorGroup: json['colorGroup'],
      backgroundColor: json['backgroundColor'],
      imageUrl: json['imageUrl'],
      glutenFree: json['glutenFree'] ?? false,
      sugarFree: json['sugarFree'] ?? false,
      seasonal: json['seasonal'] ?? false,
      kosher: json['kosher'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'beanId': beanId,
      'flavorName': flavorName,
      'description': description,
      'colorGroup': colorGroup,
      'backgroundColor': backgroundColor,
      'imageUrl': imageUrl,
      'glutenFree': glutenFree,
      'sugarFree': sugarFree,
      'seasonal': seasonal,
      'kosher': kosher,
    };
  }
}
