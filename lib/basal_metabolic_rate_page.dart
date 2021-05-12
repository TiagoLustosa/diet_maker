import 'package:diet_maker/models/basal_metabolic_rate_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BasalMetabolicRatePage extends StatefulWidget {
  @override
  _BasalMetabolicRatePage createState() => _BasalMetabolicRatePage();
}

class _BasalMetabolicRatePage extends State<BasalMetabolicRatePage> {
  final BasalMetabolicRateModel model = BasalMetabolicRateModel();
  final _form = GlobalKey<FormState>();
  _calculateBmr() {
    if (!_form.currentState.validate()) {
      return;
    }
    if (model.gender == Gender.MALE) {
      setState(() {
        model.result = 66.47 +
            (13.75 * model.weight) +
            (5.003 * model.height) -
            (6.755 * model.age);
      });
    } else {
      setState(() {
        model.result = 655.1 +
            (9.563 * model.weight) +
            (1.85 * model.height) -
            (4.676 * model.age);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Cálculo da taxa metabólica basal')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Selecione o gênero',
              style: TextStyle(fontSize: 24),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                        title: Text('Masculino'),
                        value: Gender.MALE,
                        groupValue: model.gender,
                        onChanged: (value) {
                          setState(() {
                            model.gender = value;
                          });
                        }),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: Text('Feminino'),
                      value: Gender.FEMALE,
                      groupValue: model.gender,
                      onChanged: (value) {
                        setState(() {
                          model.gender = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Form(
              key: _form,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return 'Por favor informe uma idade ex: 25';
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (value) => model.age = int.parse(value),
                    decoration: InputDecoration(
                      labelText: 'Informe a idade',
                    ),
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return 'Por favor informe o peso ex: 75.2';
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r"[0-9.]"))
                    ],
                    onChanged: (value) => model.weight = double.parse(value),
                    decoration: InputDecoration(
                      labelText: 'Informe o peso em kilos Kg',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.trim().isEmpty) {
                        return 'Por favor informe a altura ex: 175';
                      }
                      return null;
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) => model.height = int.parse(value),
                    decoration: InputDecoration(
                      labelText: 'Informe a altura em Centímetros cm',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: _calculateBmr,
              child: Text('Calcular'),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              model.result == null
                  ? ''
                  : 'Sua taxa metabólica basal é de ${model.result.toStringAsFixed(2)}kcal',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
