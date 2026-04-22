import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/history_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final historyProvider = Provider.of<HistoryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculation History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              //Bật Dialog xác nhận trước khi xóa
              historyProvider.clearHistory();
            },
          )
        ],
      ),
      body: historyProvider.history.isEmpty
          ? const Center(child: Text('No history yet'))
          : ListView.builder(
              itemCount: historyProvider.history.length,
              itemBuilder: (context, index) {
                final item = historyProvider.history[index];
                return ListTile(
                  title: Text(
                    item.expression,
                    style: const TextStyle(color: Colors.grey, fontSize: 18),
                    textAlign: TextAlign.right,
                  ),
                  subtitle: Text(
                    item.result,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                    textAlign: TextAlign.right,
                  ),
                  onTap: () {
                    //TODO: Truyền item.result ngược lại màn hình chính khi click
                    Navigator.pop(context);
                  },
                );
              },
            ),
    );
  }
}