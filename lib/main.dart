import 'package:flutter/material.dart';
import 'package:esame_flutter/recipe.dart';
import 'package:esame_flutter/recipe_detail.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecipesBookApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const RecipeListState(title: 'Broccoli Recipes Book'),
    );
  }
}

class RecipeListState extends StatefulWidget {
  const RecipeListState({super.key, required this.title});
  final String title;

  @override
  State<RecipeListState> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeListState> {
  final List<Recipe> recipes = [
    Recipe(
      title: 'Vellutata di Broccoli',
      ingredients: [
        '1) Broccoli  (450g);',
        '2) Patate (400g);',
        '3) 1 Porro;',
        '4) Timo (2 rametti);',
        '5) 700ml di brodo vegetale;',
        '6) Sale e pepe q.b.;',
        '7) Burro (30g);',
      ],
      steps: [
        '- Per preparare la vellutata ai broccoli iniziate mondando e tagliando a fette sottili il porro.',
        '- Poi sbucciate le patate e tagliatele a dadini. Lavate quindi i broccoli eliminando i gambi e dividendoli in cimette.',
        '- In un tegame capiente ponete il burro a fondere, aggiungete i porri e fateli appassire per qualche minuto a fiamma dolce.',
        '- e fateli appassire a fuoco basso per 10-15 minuti, senza fargli prendere colore.',
        '- Aggiungete nel tegame le patate e i broccoli e fateli rosolare per qualche minuto mescolando',
        '- poi aggiungete il brodo vegetale caldo e continuate la cottura per circa 30 minuti a fuoco dolce, salando e pepando',
        '- Trascorso il tempo indicato, passate le verdure con un frullatore ad immersione. Rimettete la vellutata così ottenuta sul fuoco',
        '- aggiustate di sale e aggiungete qualche fogliolina di timo',
        '- Servite la vostra vellutata di broccoli ben calda. BUON APPETITO!',
      ],
      url: 'https://ricette.giallozafferano.it/Vellutata-di-broccoli.html',
    ),
    Recipe(
      title: 'Carbonara',
      ingredients: [
        '1) Troccoli (pasta) (320g);',
        '2) Broccoli (450g);',
        '3) Aglio (1);',
        '4)Olio extra vergine d\'oliva;',
        '5) Sale e pepe nero q.b.;',
      ],
      steps: [
        '- Per prima cosa staccate le cimette dei broccoli dal torsolo centrale',
        '- Poi sciacquatele sotto l\'acqua corrente. Portate al bollore una pentola colma di acqua salata',
        '- e non appena inizierà a bollire versate i broccoli',
        '- Cuocete per circa dieci minuti',
        '- Intanto soffiggete uno spicchio d\'aglio in un filo d \'olio, in una pentola dai bordi alti ',
        '- Scolate i broccoli, tenendo da parte l\'acqua di cottura e trasferiteli in pentola',
        '- Tenete qualche piccola cimetta intera da parte ',
        '- che poi unirete alla pasta finita. Aggiungete ai broccoli un po\' d\'acqua',
        '- Salate, pepate e cuocete a fuoco medio dolce per circa 20 minuti, o almeno finché non risulteranno cotti e ridotti quasi in crema. Se dovesse essere necessario aggiungete altra acqua. A fine cottura eliminate lo spicchio d\'aglio ',
        '- Cuocete i troccoli al dente nell’acqua in cui avete lessato i broccoli portata al bollore',
        '- regolate i tempi in base alle indicazioni della confezione. Al condimento unite i broccoli tenuti da parte',
        '- Scolate la pasta e unitela alla crema di broccoli',
        '- Aggiungete un mestolo di acqua di cottura, regolandovi in base alla cremosità del condimento',
        '- Saltate la pasta con i broccoli per qualche istante quindi servitela con pepe a piacere BUON APPETITO!',
      ],
      url: 'https://ricette.giallozafferano.it/Pasta-con-broccoli.html',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return ListTile(
            title: Text(recipe.title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDetailScreen(recipe: recipe),
                ),
              );
            },
            trailing: IconButton(
              onPressed: () async {
                final uri = Uri.parse(recipe.url);
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              },
              icon: Icon(Icons.link),
            ),
          );
        },
      ),
    );
  }
}
