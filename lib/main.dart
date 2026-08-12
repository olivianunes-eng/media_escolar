

import 'package:flutter/material.dart'; //Importar mtodos os componentes do Flutter

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true
      ),
      home: MediaEscolarPage()
    );
  }
}

class MediaEscolarPage extends StatefulWidget{
  const MediaEscolarPage({super.key});

  @override
  State<MediaEscolarPage> createState () => _MediaEscolarPageState();
  }

class _MediaEscolarPageState extends State<MediaEscolarPage>{
  
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController nota1Controller = TextEditingController();
  final TextEditingController nota2Controller = TextEditingController();
  final TextEditingController nota3Controller = TextEditingController();
  final TextEditingController nota4Controller = TextEditingController();
  final TextEditingController frequenciaController = TextEditingController();

  String nomeAluno= '';
  String situacao='';
  String motivo = '';
  double media = 0;
  double maiorNota = 0;
  double menorNota = 0;
  double pontosFaltantes = 0;
  double frequencia = 0;

  void calcularMedia(){
    String nome = nomeController.text.trim();

    double? nota1 = double.tryParse(
        nota1Controller.text.replaceAll(",", "."),
    );
    double? nota2 = double.tryParse(
        nota2Controller.text.replaceAll(",", "."),
    );
    double? nota3 = double.tryParse(
        nota3Controller.text.replaceAll(",", "."),
    );
    double? nota4 = double.tryParse(
        nota4Controller.text.replaceAll(",", "."),
    );
    double? frequenciaAluno = double.tryParse(
    frequenciaController.text.replaceAll(",", "."),
    );

    if(
      nome.isEmpty || nota1 == null || nota2 == null || nota3 == null || nota4 == null || frequenciaAluno == null
      ){
        mostrarMensagem('Preencha todos os campos corretamente');
        return;
    }

    if(
      nota1 < 0  ||nota1 > 10 || nota2 < 0  || nota2 > 10 || nota3 < 0 || nota4 > 10 || nota4 < 0 || nota4 > 10 
    ){
      mostrarMensagem('As notas devem estar entre 0 e 10.');
      return;
    }

    if (frequenciaAluno < 0 || frequenciaAluno > 100) {
      mostrarMensagem('A frequência deve estar entre 0 e 100%.');
      return;
    }

    double mediaCalculada = (nota1 + nota2 + nota3 + nota4) /4;
    double maiorNotaCalculada = [nota1, nota2, nota3, nota4].reduce((a, b) => a > b ? a : b,
    );
    double menorNotaCalculada = [nota1, nota2, nota3, nota4].reduce((a, b) => a < b ? a : b,
    );
    double pontosFaltantesCalculados = 0;

    if (mediaCalculada < 7) {
      pontosFaltantesCalculados = 7 - mediaCalculada;
    }

    String situacaoCalculada;

    if (frequenciaAluno < 75) {
    situacaoCalculada = 'REPROVADO';
   motivo = 'Frequência abaixo de 75%';
  } else if (mediaCalculada >= 7) {
  situacaoCalculada = 'APROVADO';
  motivo = '';
  } else if (mediaCalculada >= 5) {
  situacaoCalculada = 'RECUPERAÇÃO';
  motivo = '';
  } else {
  situacaoCalculada = 'REPROVADO';
  motivo = 'Média abaixo de 5';
  }



    setState(() {
      nomeAluno = nome;
      media = mediaCalculada;
      situacao = situacaoCalculada;
      maiorNota = maiorNotaCalculada;
      menorNota = menorNotaCalculada;
      pontosFaltantes = pontosFaltantesCalculados;
      frequencia = frequenciaAluno;
    });


  }

  void mostrarMensagem(String mensagem){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem)
        ) ,
    );
  }

  void limpar(){
    nomeController.clear();
    nota1Controller.clear();
    nota2Controller.clear();
    nota3Controller.clear();
    nota4Controller.clear();

    setState(() {
      nomeAluno = '';
      media = 0;
      situacao = '';
      maiorNota = 0;
      menorNota = 0;
    });
  }

  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de Média"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.school,size: 80),   

            const SizedBox(height:10),     

            const Text(
              'Média Escolar',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5,),

            const Text(
                'Digite o nome e as três notas do aluno',
                textAlign: TextAlign.center,
            ),

            const SizedBox(height: 25,),

            TextField(
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome do aluno',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Exemplo: Henry'
                ),
            ),

            const SizedBox(height: 15,),

            TextField(
                controller: nota1Controller,
                decoration: const InputDecoration(
                  labelText: 'Nota 1',
                  hintText: 'Digite uma nota de 0 a 10',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.edit),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true
                ),
            ) ,

             const SizedBox(height: 15,),

            TextField(
                controller: nota2Controller,
                decoration: const InputDecoration(
                  labelText: 'Nota 2',
                  hintText: 'Digite uma nota de 0 a 10',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.edit),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true
                ),
            ) ,

             const SizedBox(height: 15,),

            TextField(
                controller: nota3Controller,
                decoration: const InputDecoration(
                  labelText: 'Nota 3',
                  hintText: 'Digite uma nota de 0 a 10',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.edit),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true
                ),
            ) ,
             const SizedBox(height: 15,),

            TextField(
                controller: nota4Controller,
                decoration: const InputDecoration(
                  labelText: 'Nota 4',
                  hintText: 'Digite uma nota de 0 a 10',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.edit),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true
                ),
            ) ,

            const SizedBox(height: 20,),

            const SizedBox(height: 15),

             TextField(
                controller: frequenciaController,
                decoration: const InputDecoration(
                labelText: 'Frequência',
                hintText: 'Digite a frequência de 0 a 100%',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_today),
                suffixText: '%',
                  ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: calcularMedia, 
              icon: const Icon(Icons.calculate),
              label: const Text('Calcular média')
            ),

            const SizedBox(height: 15,),

            OutlinedButton.icon(
              onPressed: limpar,
              icon: const Icon(Icons.clear),
              label: const Text('Limpar')
            ),

            const SizedBox(height: 25,),

            if(situacao.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        nomeAluno,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        'Média: ${media.toStringAsFixed(1)}',
                        style: const TextStyle(
                          fontSize: 20
                        ),
                      ),
                      const SizedBox(height: 10,),

                      Text(
                         'Maior nota: ${maiorNota.toStringAsFixed(1)}',
                        style: const TextStyle(
                        fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10,),

                      Text(
                         'Menor nota: ${menorNota.toStringAsFixed(1)}',
                        style: const TextStyle(
                        fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 10,),

                      if (media < 7)
                      Text(
                          'Pontos que faltaram para aprovação: ${pontosFaltantes.toStringAsFixed(1)}',
                        style: const TextStyle(
                        fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),

                      Text(
                        'Frequência: ${frequencia.toStringAsFixed(1)}%',
                        style: const TextStyle(
                        fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 20),

                      Text(
                        situacao,
                          style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                ),
              ),

          ],
        ),
        
      ),
    );
  }
}