class Recipe {
  Recipe({
    required this.title,
    required this.ingredients,
    required this.steps,
    required this.url,
  });
  final String title;
  final List<String> ingredients;
  final List<String> steps;
  final String url;
}
