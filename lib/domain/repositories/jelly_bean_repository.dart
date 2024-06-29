import '../entities/entity_jellybean.dart';

abstract class JellyBeanRepository {
  Future<List<EntityJellyBean>> getJellyBeans();
}
