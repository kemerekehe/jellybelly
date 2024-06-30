import 'package:flutter/material.dart';
import '../../domain/entities/entity_jellybean.dart';

class JellyBeanDetailPage extends StatelessWidget {
  final EntityJellyBean bean;

  const JellyBeanDetailPage({Key? key, required this.bean}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bean.flavorName),
        backgroundColor: Colors.blue, // Warna latar belakang AppBar
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.network(
                  bean.imageUrl,
                  fit: BoxFit.fitWidth, // Mengisi widget dengan gambar tanpa memotong
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Description:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.blue, // Warna teks deskripsi
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              bean.description,
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Details:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.blue, // Warna teks detail
              ),
            ),
            const SizedBox(height: 8.0),
            Table(
              border: TableBorder.all(color: Colors.blue), // Garis pinggir tabel
              children: [
                _buildDetailRow('Color Group', bean.colorGroup),
                _buildDetailRow('Background Color', bean.backgroundColor),
                _buildDetailRow('Gluten Free', bean.glutenFree ? 'Yes' : 'No'),
                _buildDetailRow('Sugar Free', bean.sugarFree ? 'Yes' : 'No'),
                _buildDetailRow('Seasonal', bean.seasonal ? 'Yes' : 'No'),
                _buildDetailRow('Kosher', bean.kosher ? 'Yes' : 'No'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildDetailRow(String label, String value) {
    return TableRow(
      children: [
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ),
      ],
    );
  }
}
