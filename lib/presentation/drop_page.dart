import 'package:flutter/material.dart';

class DropPage extends StatelessWidget {
  final dropValue = ValueNotifier('');
  final dropOpcoes = ['auud', 'basdas', 'casdasd'];

  DropPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ValueListenableBuilder(
            valueListenable: dropValue,
            builder: (BuildContext context, String value, _){
              return DropdownButton<String>(
                hint: const Text('escolha a moeda base'),
                value: (value.isEmpty)? null: value,
                onChanged: (escolha) => dropValue.value = escolha.toString(),
                items: dropOpcoes
                  .map((op) => DropdownMenuItem(
                    value: op,
                    child: Text(op),
                )).toList(),
              );
    },),
    ),
    );
  }
}
