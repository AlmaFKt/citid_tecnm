import 'package:flutter/material.dart';

class ArticleDetail extends StatefulWidget {
  final Map<String, dynamic> article;

  ArticleDetail({required this.article});

  @override
  _ArticleDetailState createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  late String selectedArea;
  late String selectedTheme;
  late String selectedReviewer;
  late bool isPaid;
  late bool isAccepted;

  final List<String> areas = [
    'ISC',
    'Computer Science',
    'Physics',
    'Biology',
    'Chemistry'
  ];
  final List<String> themes = [
    'Desarrollo de aplicaciones',
    'Inteligencia Artificial',
    'AI',
    'Quantum Mechanics',
    'Genetics',
    'Organic Chemistry'
  ];
  final Map<String, List<String>> reviewers = {
    'ISC': ['Mario Humberto', 'Dr. Smith', 'Prof. Johnson'],
    'Computer Science': ['Dr. Smith', 'Prof. Johnson'],
    'Physics': ['Dr. Einstein', 'Prof. Curie'],
    'Biology': ['Dr. Watson', 'Prof. Crick'],
    'Chemistry': ['Dr. Bohr', 'Prof. Pauling'],
  };

  @override
  void initState() {
    super.initState();
    selectedArea = widget.article['area'];
    selectedTheme = widget.article['tema'];
    selectedReviewer = widget.article['revisor'];
    isPaid = widget.article['pagado'];
    isAccepted = widget.article['autorizado'];

    if (!areas.contains(selectedArea)) {
      areas.add(selectedArea);
    }
    if (!themes.contains(selectedTheme)) {
      themes.add(selectedTheme);
    }
    if (!reviewers.containsKey(selectedArea)) {
      reviewers[selectedArea] = [selectedReviewer];
    } else if (!reviewers[selectedArea]!.contains(selectedReviewer)) {
      reviewers[selectedArea]!.add(selectedReviewer);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.article['nombreArticulo']),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ponente: ${widget.article['nombrePonente']}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedArea,
              items: areas.map((String area) {
                return DropdownMenuItem<String>(
                  value: area,
                  child: Text(area),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedArea = newValue!;
                  selectedReviewer = reviewers[selectedArea]!.first;
                });
              },
              decoration: InputDecoration(
                labelText: 'Área del artículo',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedTheme,
              items: themes.map((String theme) {
                return DropdownMenuItem<String>(
                  value: theme,
                  child: Text(theme),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedTheme = newValue!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Temática del artículo',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedReviewer,
              items: reviewers[selectedArea]!.map((String reviewer) {
                return DropdownMenuItem<String>(
                  value: reviewer,
                  child: Text(reviewer),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedReviewer = newValue!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Revisor del artículo',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text('Pagado: '),
                Switch(
                  value: isPaid,
                  onChanged: (value) {
                    setState(() {
                      isPaid = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text('Autorizado: '),
                Switch(
                  value: isAccepted,
                  onChanged: (value) {
                    setState(() {
                      isAccepted = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
