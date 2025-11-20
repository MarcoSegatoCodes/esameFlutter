import 'package:flutter/material.dart';
import 'package:esame_flutter/recipe.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe.title)),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            recipe.title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Ingredienti:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          ...recipe.ingredients.map((ingredient) => Text(ingredient)),
          SizedBox(height: 20),
          Text(
            'Procedimento:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          ...recipe.steps.map((step) => Text(step)),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () async {
              final uri = Uri.parse(recipe.url);
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            },
            child: Text('Apri il link della ricetta'),
          ),
        ],
      ),
    );
  }
}
