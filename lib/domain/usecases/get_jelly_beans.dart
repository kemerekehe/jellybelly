import '../entities/entity_jellybean.dart';
import '../repositories/jelly_bean_repository.dart';

class GetJellyBeans {
  final JellyBeanRepository repository;

  GetJellyBeans(this.repository);

  Future<List<EntityJellyBean>> call() async {
    return await repository.getJellyBeans();
  }
}
