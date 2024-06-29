import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/jelly_bean_model.dart';
import 'jelly_bean_detail.dart';

class JellyBeanListPage extends StatelessWidget {
  const JellyBeanListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<JellyBeanViewModel>(context);
    viewModel.fetchJellyBeans();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jelly Beans'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) {
                viewModel.searchJellyBeans(query);
              },
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: viewModel.jellyBeans.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: viewModel.jellyBeans.length,
              itemBuilder: (context, index) {
                final bean = viewModel.jellyBeans[index];
                return ListTile(
                  leading: Image.network(bean.imageUrl),
                  title: Text(bean.flavorName),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JellyBeanDetailPage(bean: bean),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
