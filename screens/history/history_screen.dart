import 'package:flutter/material.dart';
import 'package:chitra_ai/constants/app_colors.dart';
import 'package:chitra_ai/models/image_model.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool _isLoading = true;
  final List<ImageModel> _historyItems = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    // Simulated API call
    await Future.delayed(const Duration(seconds: 1));
    
    // Replace with actual API data
    setState(() {
      _historyItems.addAll([
        ImageModel(
          id: '1',
          originalPath: 'path/to/original',
          resultPath: 'path/to/result',
          prompt: 'Add a beach background',
          createdAt: DateTime.now(),
        ),
        ImageModel(
          id: '2',
          originalPath: 'path/to/original',
          resultPath: 'path/to/result',
          prompt: 'Make me wear a blue t-shirt',
          createdAt: DateTime.now(),
        ),
      ]);
      _isLoading = false;
    });
  }

  Widget _buildHistoryItem(ImageModel item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.gradientStart,
            AppColors.gradientEnd,
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _navigateToResult(item),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildImagePreview(item.originalPath),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward, color: Colors.white54),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildImagePreview(item.resultPath),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item.prompt,
                    style: AppStyles.bodyText,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Generated ${_formatDate(item.createdAt)}',
                        style: AppStyles.caption,
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.white54),
                        onPressed: () => _deleteItem(item.id),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePreview(String path) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: NetworkImage(path),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void _navigateToResult(ImageModel item) {
    Navigator.pushNamed(
      context,
      '/image-result',
      arguments: item,
    );
  }

  void _deleteItem(String id) {
    // Implement delete functionality
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: AppStyles.mainBackground,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _historyItems.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.history, size: 64, color: AppColors.accentColor),
                        const SizedBox(height: 16),
                        Text(
                          'No Generation History',
                          style: AppStyles.heading,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Your processed images will appear here',
                          style: AppStyles.bodyText,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _historyItems.length,
                    itemBuilder: (context, index) => _buildHistoryItem(_historyItems[index]),
                  ),
      ),
    );
  }
}
