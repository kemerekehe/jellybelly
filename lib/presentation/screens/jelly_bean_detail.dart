import 'package:flutter/material.dart';
import '../../domain/entities/entity_jellybean.dart';

class JellyBeanDetailPage extends StatelessWidget {
  final EntityJellyBean bean;

  const JellyBeanDetailPage({super.key, required this.bean});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bean.flavorName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(bean.imageUrl),
            const SizedBox(height: 16),
            Text(
              bean.description,
              style: const TextStyle(fontSize: 18),
            ),
            // Add other bean details here
          ],
        ),
      ),
    );
  }
}