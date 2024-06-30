import 'package:flutter/material.dart';
import '../../domain/usecases/get_jelly_beans.dart';
import '../../domain/entities/entity_jellybean.dart';

class JellyBeanViewModel extends ChangeNotifier {
  final GetJellyBeans getJellyBeans;
  List<EntityJellyBean> _allJellyBeans = [];
  List<EntityJellyBean> _filteredJellyBeans = [];
  bool _isFetching = false;

  JellyBeanViewModel({required this.getJellyBeans}) {
    fetchJellyBeans(); // Panggil fetchJellyBeans saat view model dibuat
  }

  List<EntityJellyBean> get jellyBeans => _filteredJellyBeans;
  bool get isFetching => _isFetching;

  Future<void> fetchJellyBeans() async {
    _isFetching = true;
    notifyListeners();

    try {
      final jellyBeans = await getJellyBeans.call();
      _allJellyBeans = jellyBeans;
      _filteredJellyBeans = jellyBeans;
    } catch (e) {
      // Handle error jika diperlukan
      print('Error fetching jelly beans: $e');
    } finally {
      _isFetching = false;
      notifyListeners();
    }
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
