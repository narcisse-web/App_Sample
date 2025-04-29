import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diabetes Management',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    PatientPage(),
    LaboratoirePage(),
    LipidPanelPage(),
    MetabolicPanelPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Diabetes Management')),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Patient'),
          BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Lab'),
          BottomNavigationBarItem(icon: Icon(Icons.bloodtype), label: 'Lipid'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), label: 'Metabolic'),
        ],
      ),
    );
  }
}

class PatientPage extends StatefulWidget {
  @override
  _PatientPageState createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _dobController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Full Name'),
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            GestureDetector(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (date != null) {
                  setState(() {
                    _selectedDate = date;
                    _dobController.text = DateFormat('yyyy-MM-dd').format(date);
                  });
                }
              },
              child: AbsorbPointer(
                child: TextFormField(
                  controller: _dobController,
                  decoration: InputDecoration(labelText: 'Date of Birth'),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Weight (kg)'),
                    keyboardType: TextInputType.number,
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Height (cm)'),
                    keyboardType: TextInputType.number,
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                  ),
                ),
              ],
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Activity Factor'),
              items: ['No exercise', 'Mild', 'Moderate']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {},
              validator: (value) => value == null ? 'Required' : null,
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Category'),
              items: ['Fasting glucose', 'Non fasting']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {},
              validator: (value) => value == null ? 'Required' : null,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Glucose (mmol/L)'),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _formKey.currentState!.validate(),
              child: Text('Save Patient Data'),
            ),
          ],
        ),
      ),
    );
  }
}

class LaboratoirePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          _buildDateTimeField(),
          TextFormField(
              decoration: InputDecoration(labelText: 'Ketones (mmol/L)')),
          TextFormField(decoration: InputDecoration(labelText: 'HbA1c (%)')),
          ElevatedButton(onPressed: () {}, child: Text('Save Lab Data')),
        ],
      ),
    );
  }

  Widget _buildDateTimeField() {
    return Row(
      children: [
        Expanded(
            child:
                TextFormField(decoration: InputDecoration(labelText: 'Date'))),
        SizedBox(width: 16),
        Expanded(
            child:
                TextFormField(decoration: InputDecoration(labelText: 'Time'))),
      ],
    );
  }
}

class LipidPanelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextFormField(
              decoration:
                  InputDecoration(labelText: 'Total Cholesterol (mmol/L)')),
          TextFormField(decoration: InputDecoration(labelText: 'LDL (mmol/L)')),
          TextFormField(decoration: InputDecoration(labelText: 'HDL (mmol/L)')),
          TextFormField(
              decoration: InputDecoration(labelText: 'Triglycerides (mmol/L)')),
          ElevatedButton(onPressed: () {}, child: Text('Save Lipid Data')),
        ],
      ),
    );
  }
}

class MetabolicPanelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          _buildDateTimeField(),
          TextFormField(
              decoration: InputDecoration(labelText: 'Creatine (μmol/L)')),
          TextFormField(
              decoration: InputDecoration(labelText: 'Creatine Clearance')),
          TextFormField(decoration: InputDecoration(labelText: 'eGFR')),
          TextFormField(
              decoration: InputDecoration(labelText: 'Albumin (g/L)')),
          TextFormField(
              decoration: InputDecoration(labelText: 'Calcium (mmol/L)')),
          TextFormField(
              decoration: InputDecoration(labelText: 'Sodium (mmol/L)')),
          TextFormField(
              decoration: InputDecoration(labelText: 'Bicarbonate (mmol/L)')),
          TextFormField(
              decoration: InputDecoration(labelText: 'Chloride (mmol/L)')),
          TextFormField(
              decoration: InputDecoration(labelText: 'Total Protein (g/L)')),
          TextFormField(decoration: InputDecoration(labelText: 'ALP (U/L)')),
          TextFormField(decoration: InputDecoration(labelText: 'AST (U/L)')),
          TextFormField(decoration: InputDecoration(labelText: 'ALT (U/L)')),
          TextFormField(
              decoration: InputDecoration(labelText: 'Bilirubin (μmol/L)')),
          TextFormField(decoration: InputDecoration(labelText: 'BUN (mmol/L)')),
          ElevatedButton(onPressed: () {}, child: Text('Save Metabolic Data')),
        ],
      ),
    );
  }

  Widget _buildDateTimeField() {
    return Row(
      children: [
        Expanded(
            child:
                TextFormField(decoration: InputDecoration(labelText: 'Date'))),
        SizedBox(width: 16),
        Expanded(
            child:
                TextFormField(decoration: InputDecoration(labelText: 'Time'))),
      ],
    );
  }
}
