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
        colorScheme: const ColorScheme.dark(primary: Colors.amber),
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
    'РЗА': ['НВЧЗ ВЛ-220 Х', 'КСЗ ВЛ-220 Х', 'ДФЗ ВЛ-220 К', 'КСЗ ВЛ-220 К', 'АПВ В-220 Х', 'АПВ В-220 К'],
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
            image: AssetImage('psk1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black.withOpacity(0.65),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Выбор категории
                DropdownButton<String>(
                  hint: const Text("Выберите категорию"),
                  value: selectedCategory,
                  isExpanded: true,
                  items: categories.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedCategory = val;
                      selectedItem = null; // Сброс при смене категории
                    });
                  },
                ),
                const SizedBox(height: 20),
                
                // Выбор элемента (появляется только если выбрана категория)
                if (selectedCategory != null)
                  DropdownButton<String>(
                    hint: const Text("Выберите элемент"),
                    value: selectedItem,
                    isExpanded: true,
                    items: itemsMap[selectedCategory!]!.map((e) {
                      return DropdownMenuItem(value: e, child: Text(e));
                    }).toList(),
                    onChanged: (val) => setState(() {
                      selectedItem = val;
                    }),
                  ),
                
                const SizedBox(height: 40),
                
                // Финальный блок с результатом
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
                        Text("Выбрано: $selectedItem", 
                             style: const TextStyle(fontSize: 18, color: Colors.white)),
                      ],
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
