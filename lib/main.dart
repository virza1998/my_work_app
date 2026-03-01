import 'package:flutter/material.dart';

void main() => runApp(const WorkApp());

class WorkApp extends StatelessWidget {
  const WorkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.amber,
      ),
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
      appBar: AppBar(title: const Text('Перечень операций')),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            // Используем загруженное фото
            image: AssetImage('psk1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        // Затемняющий фильтр поверх фото (65%), чтобы текст был виден
        child: Container(
          color: Colors.black.withOpacity(0.65),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:, // Темный фон меню
                  value: selectedType,
                  items: types.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (val) => setState(() {
                    selectedType = val;
                  }),
                ),
                const SizedBox(height: 20),
                if (selectedType != null) ...,
                    value: selectedCategory,
                    items: categories.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                    onChanged: (val) => setState(() {
                      selectedCategory = val;
                      selectedItem = null;
                    }),
                  ),
                ],
                const SizedBox(height: 20),
                if (selectedCategory != null) ...,
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
                if (selectedItem != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      // Полупрозрачный зеленый фон для результата
                      color: Colors.green.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.greenAccent, width: 2),
                    ),
                    child: Column(
                      children:,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
