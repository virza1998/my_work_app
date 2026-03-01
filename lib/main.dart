import 'package:flutter/material.dart';

void main() => runApp(const WorkApp());

class WorkApp extends StatelessWidget {
  const WorkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Светлая тема
      theme: ThemeData(primarySwatch: Colors.blue), 
      // Настройка ТЕМНОЙ темы
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.amber, 
      ),
      // Принудительное включение темной темы
      themeMode: ThemeMode.dark, 
      home: const SelectionScreen(),
    );
  }
}

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({super.key});

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  String? selectedType;
  String? selectedCategory;
  String? selectedItem;

  final List<String> types = ['Ввод', 'Вывод'];
  final List<String> categories = ['ВВ оборудование', 'РЗА'];

  final Map<String, List<String>> itemsMap = {
    'ВВ оборудование': ['В-220 Х', 'В-220 К', 'СВ-220', 'ВЛ-220 Х', 'ВЛ-220 К'],
    'РЗА': [
      'НВЧЗ ВЛ-220 Х',
      'КСЗ ВЛ-220 Х',
      'ДФЗ ВЛ-220 К',
      'КСЗ ВЛ-220 К',
      'АПВ В-220 Х',
      'АПВ В-220 К'
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Помощник инженера')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("1. Тип работ:", style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedType,
              items: types.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (val) => setState(() {
                selectedType = val;
              }),
            ),
            const SizedBox(height: 20),

            if (selectedType != null) ...[
              const Text("2. Категория оборудования:", style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButton<String>(
                isExpanded: true,
                value: selectedCategory,
                items: categories.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (val) => setState(() {
                  selectedCategory = val;
                  selectedItem = null;
                }),
              ),
            ],

            const SizedBox(height: 20),

            if (selectedCategory != null) ...[
              const Text("3. Выберите наименование:", style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButton<String>(
                isExpanded: true,
                value: selectedItem,
                items: itemsMap[selectedCategory]!
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setState(() {
                  selectedItem = val;
                }),
              ),
            ],

            const SizedBox(height: 40),

            // ФИНАЛЬНЫЙ ТЕКСТ (Исправлен для темной темы)
            if (selectedItem != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2), 
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.greenAccent, width: 2),
                ),
                child: Column(
                  children: [
                    Text(
                      selectedItem!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22, 
                        fontWeight: FontWeight.bold, 
                        color: Colors.greenAccent,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Вы видите порядок ${selectedType?.toLowerCase()}а.\nСпасибо!",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18, 
                        color: Colors.white,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
