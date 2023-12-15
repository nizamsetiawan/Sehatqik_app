import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  final List<Map<String, String>> faqList = [
    {
      'question': 'Bagaimana cara memesan obat di aplikasi Sehat Qik?',
      'answer':
          'Untuk memesan obat, Anda dapat masuk ke bagian "Pesan Obat" di aplikasi kami. Di sana, Anda bisa mencari obat yang diinginkan dan menambahkannya ke keranjang belanja.',
    },
    {
      'question': 'Apakah ada batasan jumlah obat yang bisa saya pesan?',
      'answer':
          'Tidak ada batasan jumlah obat yang dapat Anda pesan. Namun, kami mendorong untuk memesan dengan jumlah yang sesuai kebutuhan.',
    },
    {
      'question': 'Berapa lama waktu pengiriman obat?',
      'answer':
          'Waktu pengiriman obat dapat bervariasi tergantung pada lokasi dan ketersediaan obat. Secara umum, kami berusaha untuk melakukan pengiriman dalam waktu 1-3 hari kerja setelah pesanan dikonfirmasi.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQs'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: faqList.length,
          itemBuilder: (context, index) {
            return ExpansionTile(
              title: Text(faqList[index]['question'] ?? ''),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(faqList[index]['answer'] ?? ''),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FAQPage(),
  ));
}
