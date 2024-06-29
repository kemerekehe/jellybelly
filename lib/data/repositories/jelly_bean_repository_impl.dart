import '../../domain/entities/entity_jellybean.dart';
import '../../domain/repositories/jelly_bean_repository.dart';
import '../models/model_jellybean.dart';
import '../resources/api_service.dart';
import '../resources/local_data_source_impl.dart';

class JellyBeanRepositoryImpl implements JellyBeanRepository {
  final ApiService apiService;

  JellyBeanRepositoryImpl({
    required this.apiService,
  });

  @override
  Future<List<EntityJellyBean>> getJellyBeans() async {
    List<ModelJellyBean> modelBeans = await apiService.fetchJellyBeans();
    return modelBeans.map((bean) => EntityJellyBean(
      flavorName: bean.flavorName,
      description: bean.description,
      imageUrl: bean.imageUrl,
      beanId: bean.beanId,
      colorGroup: bean.colorGroup,
      backgroundColor: bean.backgroundColor,
      glutenFree: bean.glutenFree,
      sugarFree: bean.sugarFree,
      seasonal: bean.seasonal,
      kosher: bean.kosher,
    )).toList();
  }
}
