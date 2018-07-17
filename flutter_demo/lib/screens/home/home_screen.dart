import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class HomeScreen extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}
class RandomWordsState extends State<HomeScreen> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = new Set<WordPair>();

    Widget build(BuildContext context) {
      
      //final wordPair = new WordPair.random();
      //return new Text(wordPair.asPascalCase);

      return new Scaffold (
        appBar: new AppBar(
          title: new Text('Startup Name Generator'),
          actions: <Widget>[new IconButton(icon: new Icon(Icons.list),onPressed: _pushSaved)],
        ),
        body: _buildSuggestions(),
      );
    } 
    void _pushSaved() {
      // Go to Detail page with Favorite Items
     Navigator.of(context).push(
        new MaterialPageRoute(
          builder: (context) {
            final tiles = _saved.map(
              (pair) {
                return new ListTile(
                  title: new Text(pair.asPascalCase,
                  style: _biggerFont,
                  ),
                );
              }
            );
            final divided = ListTile.divideTiles(context: context, tiles: tiles).toList();

            return new Scaffold(
              appBar: new AppBar(title: new Text("Saved Word Pairs")),
              body: new ListView(children: divided),
            );
          }
        )
      );
    }
    Widget _buildSuggestions() {
        return new ListView.builder(
          padding: EdgeInsets.all(5.0),
          itemBuilder: (context,i) {
            if (i.isOdd) return new Divider();
            final index = i ~/ 2;
            if (index >= _suggestions.length) {
              _suggestions.addAll(generateWordPairs().take(10));
            }
            return _buildRow(_suggestions[index]);
          }
        );
      }
    Widget _buildRow(WordPair pair) {
      print("building Row.....");
      final isSavedPair = _saved.contains(pair);
        return new ListTile(
          title: new Text(pair.asPascalCase,style: _biggerFont,),
          trailing: new Icon(isSavedPair ? Icons.favorite : Icons.favorite_border, color: isSavedPair ? Colors.red : null),
          // On tap event in List 
          onTap: () {
            setState(() {
                          if(isSavedPair) {
                            _saved.remove(pair);
                          } else {
                            _saved.add(pair);
                          }
                        });
          },
        );
      }
}