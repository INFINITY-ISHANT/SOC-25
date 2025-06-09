import 'package:flutter/material.dart';
import 'quote.dart';
import 'quote_card.dart';

void main()=>
  runApp(MaterialApp(
    home: Quotelist()  ,
  ));


class Quotelist extends StatefulWidget {
  const Quotelist({super.key});

  @override
  State<Quotelist> createState() => _QuotelistState();
}

class _QuotelistState extends State<Quotelist> {
  List<Quote> quotes = [
    Quote(text:'dreams dont work unless you do',author:'anaya'),
    Quote(text: 'time is money', author: 'anaya'),
    Quote(text: 'truth is rarely pure and never simple', author: 'ishant')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Awesome Quotes'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: quotes.map((quote)=>NewCard(quote: quote,delete:(){
          setState(() {
            quotes.remove(quote);
          });

        },)).toList(),
    ),
    );
  }
}

