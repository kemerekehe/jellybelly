import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/authview_model.dart';
import '../viewmodels/jelly_bean_model.dart';
import 'jelly_bean_detail.dart';

class JellyBeanListPage extends StatefulWidget {
  const JellyBeanListPage({Key? key}) : super(key: key);

  @override
  _JellyBeanListPageState createState() => _JellyBeanListPageState();
}

class _JellyBeanListPageState extends State<JellyBeanListPage> {
  bool _showSearchBar = false;
  final TextEditingController _searchController = TextEditingController();
  late AuthViewModel authViewModel;

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<JellyBeanViewModel>(context, listen: false);
    viewModel.fetchJellyBeans();
  }

  Future<void> _refreshJellyBeans() async {
    final viewModel = Provider.of<JellyBeanViewModel>(context, listen: false);
    await viewModel.fetchJellyBeans();
  }

  void _toggleSearchBar() {
    setState(() {
      _showSearchBar = !_showSearchBar;
    });
  }

  @override
  Widget build(BuildContext context) {
    authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final viewModel = Provider.of<JellyBeanViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jelly Beans'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _toggleSearchBar,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authViewModel.logout();
              Navigator.of(context).pushReplacementNamed('/dashboard');
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade400, Colors.blue.shade200],
          ),
        ),
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: _showSearchBar ? 60.0 : 0.0,
              padding: const EdgeInsets.all(8.0),
              child: _showSearchBar
                  ? TextField(
                controller: _searchController,
                onChanged: (query) {
                  viewModel.searchJellyBeans(query);
                },
                decoration: const InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                ),
              )
                  : null,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshJellyBeans,
                child: viewModel.isFetching
                    ? const Center(child: CircularProgressIndicator())
                    : GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: viewModel.jellyBeans.length,
                  itemBuilder: (context, index) {
                    final bean = viewModel.jellyBeans[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JellyBeanDetailPage(bean: bean),
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 5.0,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network(
                                bean.imageUrl,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Positioned(
                              bottom: 8.0,
                              left: 8.0,
                              right: 8.0,
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                color: Colors.black54,
                                child: Text(
                                  bean.flavorName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
