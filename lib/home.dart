import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerCep = TextEditingController();
  String _resultado = 'Resultado';

  _recuperarCep() async {
    String cepDigitado = _controllerCep.text;
    var url = Uri.parse('http://viacep.com.br/ws/${cepDigitado}/json/');
    http.Response response;

    response = await http.get(url);
    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno['logradouro'];
    String complemento = retorno['complemento'];
    String bairro = retorno['bairro'];
    String localidade = retorno['localidade'];

    setState(() {
      _resultado = '${logradouro}, ${complemento}, bairro: ${bairro}';
    });

    print(
        'Resposta lougradouro ${logradouro} complemento: ${complemento} bairro: ${bairro}');

    //print('reposta: ' + response.statusCode.toString());
    //print('resposta: ' + response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Consulta CEP',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0XFF0DFF85),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: <Widget>[

            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Digite o CEP',
              ),
              style: TextStyle(fontSize: 20, color: Colors.black),
              controller: _controllerCep,
            ),

            SizedBox(
              height: 30,
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                primary: Color(0XFF0DFF85),
                fixedSize: Size(
                  200,
                  56,
                ),
              ),
              child: Text(
                'Clique aqui',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: _recuperarCep,
            ),

            SizedBox(
              height: 10,
            ),

            Text(
              _resultado,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
