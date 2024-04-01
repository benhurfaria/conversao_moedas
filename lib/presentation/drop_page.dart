import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importei este pacote para usar TextInputFormatter.
import 'package:moedas/application/moedas_store.dart';

import '../domain/moeda.dart';

class DropPage extends StatefulWidget {
  final MoedasStore moedasStore;

  DropPage(this.moedasStore);

  @override
  _DropPageState createState() => _DropPageState();
}

class _DropPageState extends State<DropPage> {
  String? dropValueBase;
  String? dropValueDestino;
  TextEditingController _controller = TextEditingController(); // Controlador para o campo de texto.
  bool camposPreenchidos = true; // Variável para controlar se os campos estão preenchidos ou não.

  @override
  Widget build(BuildContext context) {
    final dropOpcoes = widget.moedasStore.moedasList;

    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: widget.moedasStore,
          builder: (BuildContext context, Widget? child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Moeda Base',
                            style: TextStyle(fontSize: 18), // Tamanho do texto
                          ),
                        ),
                        DropdownButton<String>(
                          hint: const Text('Escolha a moeda base'),
                          value: dropValueBase,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropValueBase =
                                  newValue; // Atualiza o valor selecionado no dropdown
                            });
                          },
                          items: dropOpcoes.map((op) {
                            return DropdownMenuItem(
                              value: op.nome,
                              child: Text(op.nome),
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: 100,
                          width: 200,
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              labelText: 'Insira um valor',
                            ),
                            keyboardType: TextInputType.numberWithOptions(decimal: true), // Teclado numérico com ponto decimal.
                            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$'))], // Permite apenas números float.
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Moeda Destino',
                            style: TextStyle(fontSize: 18), // Tamanho do texto
                          ),
                        ),
                        DropdownButton<String>(
                          hint: const Text('Escolha a moeda de destino'),
                          value: dropValueDestino,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropValueDestino =
                                  newValue; // Atualiza o valor selecionado no dropdown
                            });
                          },
                          items: dropOpcoes.map((op) {
                            return DropdownMenuItem(
                              value: op.nome,
                              child: Text(op.nome),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Visibility(
                  visible:!camposPreenchidos,
                  child:
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      'Todos os campos são obrigatórios',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),),
                ElevatedButton(
                  onPressed: () {
                    // Verifica se os campos estão preenchidos
                    if (dropValueBase == null || dropValueDestino == null || _controller.text.isEmpty) {
                      setState(() {
                        camposPreenchidos = false; // Define que os campos não estão preenchidos
                      });
                      return; // Sai da função se algum campo não estiver preenchido
                    }

                    // Se todos os campos estiverem preenchidos, prossegue com a conversão
                    double valorBase = widget.moedasStore.moedasList
                        .firstWhere((moeda) => moeda.nome == dropValueBase,
                        orElse: () => Moeda(nome: '', cotacao: 0.0))
                        .cotacao;
                    double valorDestino = widget.moedasStore.moedasList
                        .firstWhere((moeda) => moeda.nome == dropValueDestino,
                        orElse: () => Moeda(nome: '', cotacao: 0.0))
                        .cotacao;
                    double resultado = double.parse(_controller.text) * valorBase / valorDestino;
                    String? frase = 'Convertendo ${dropValueBase ?? ''} para ${dropValueDestino ?? ''}: \n\n Resultado: ${resultado.toStringAsFixed(2) ?? ''}';
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text(frase),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Converter'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
