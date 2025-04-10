class ImageModel {
  final String id;
  final String originalPath;
  final String resultPath;
  final String prompt;
  final DateTime createdAt;

  ImageModel({
    required this.id,
    required this.originalPath,
    required this.resultPath,
    required this.prompt,
    required this.createdAt,
  });
}
