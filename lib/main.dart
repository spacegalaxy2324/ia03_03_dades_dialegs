import 'dart:developer';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'M08 - Entrada de dades i Diàlegs',
        home: const MyCustomForm(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ));
  }
}

enum DialogType {
  simpleDialog,
  alertDialog,
  showSnackBar,
  showModalBottomSheet
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});
  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final myController = TextEditingController();
  DialogType? _dialogTypeChosen = DialogType.simpleDialog;

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar el valor d\'un camp de text'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: myController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Text a mostrar',
              ),
            ),
          ),
          containerTypeCard(context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        onPressed: () {
          switch (_dialogTypeChosen) {
            case DialogType.simpleDialog:
              dialogSimple(context);
              break;
            case DialogType.alertDialog:
              alertDialog(context);
              break;
            case DialogType.showSnackBar:
              snackBar(context);
              break;
            case DialogType.showModalBottomSheet:
              dialogSMBS(context);
              break;
            case null:
              log('error');
          }
        },
        tooltip: 'Mostra el valor!',
        child: const Icon(Icons.text_fields),
      ),
    );
  }

  Card containerTypeCard(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(15.0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
            child: Text(
              'Tipus de contenidor',
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),
          RadioListTile<DialogType>(
            value: DialogType.simpleDialog,
            groupValue: _dialogTypeChosen,
            onChanged: (DialogType? value) {
              setState(() {
                _dialogTypeChosen = value;
              });
            },
            title: const Text('SimpleDialog'),
            subtitle: const Text(
                'Diàleg simple amb títol i descripció, sense cap botó de confirmació'),
          ),
          RadioListTile<DialogType>(
            value: DialogType.alertDialog,
            groupValue: _dialogTypeChosen,
            onChanged: (DialogType? value) {
              setState(() {
                _dialogTypeChosen = value;
              });
            },
            title: const Text('AlertDialog'),
            subtitle: const Text(
                'Diàleg simple amb títol, descripció i un botó de confirmació'),
          ),
          RadioListTile<DialogType>(
            value: DialogType.showSnackBar,
            groupValue: _dialogTypeChosen,
            onChanged: (DialogType? value) {
              setState(() {
                _dialogTypeChosen = value;
              });
            },
            title: const Text('showSnackBar'),
            subtitle: const Text(
                "Contenidor horitzontal situat en la zona inferior de la pantalla que ocupa tota la amplada de la pantalla amb un missatge curt i un diseny estandaritzat."),
            isThreeLine: true,
          ),
          RadioListTile<DialogType>(
            value: DialogType.showModalBottomSheet,
            groupValue: _dialogTypeChosen,
            onChanged: (DialogType? value) {
              setState(() {
                _dialogTypeChosen = value;
              });
            },
            title: const Text('showModalBottomSheet'),
            subtitle: const Text(
                "Contenidor modal situat en la zona inferior de la pantalla que ocupa tota la amplada de la pantalla amb una capacitat de personalització mes avançada"),
            isThreeLine: true,
          ),
        ],
      ),
    );
  }

  Future<void> dialogSimple(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('SimpleDialog'),
          content: Text(myController.text),
        );
      },
    );
  }

  void alertDialog(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('AlertDialog'),
        content: Text(myController.text),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Tancar'),
            child: const Text('Tancar'),
          ),
        ],
      ),
    );
  }

  void snackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(myController.text),
      action: SnackBarAction(
        label: 'Tancar',
        onPressed: () {
          deactivate();
        },
      ),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<dynamic> dialogSMBS(BuildContext context) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              height: 200,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(myController.text,
                        style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.fontSize,
                          color: Theme.of(context).colorScheme.onSecondary,
                        )),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Tancar BottomSheet'),
                    )
                  ],
                ),
              ));
        });
  }
}
