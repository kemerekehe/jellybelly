import 'package:flutter/material.dart';
import '../../domain/usecases/get_jelly_beans.dart';
import '../../domain/entities/entity_jellybean.dart';

class JellyBeanViewModel extends ChangeNotifier {
  final GetJellyBeans getJellyBeans;
  List<EntityJellyBean> _allJellyBeans = [];
  List<EntityJellyBean> _filteredJellyBeans = [];

  JellyBeanViewModel({required this.getJellyBeans});

  List<EntityJellyBean> get jellyBeans => _filteredJellyBeans;

  Future<void> fetchJellyBeans() async {
    final jellyBeans = await getJellyBeans.call();
    _allJellyBeans = jellyBeans;
    _filteredJellyBeans = jellyBeans;
    notifyListeners();
  }

  void searchJellyBeans(String query) {
    if (query.isEmpty) {
      _filteredJellyBeans = _allJellyBeans;
    } else {
      _filteredJellyBeans = _allJellyBeans.where((bean) {
        return bean.flavorName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}
