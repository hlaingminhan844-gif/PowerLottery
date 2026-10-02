import 'package:flutter/material.dart';

void main() {
  runApp(const LotteryApp());
}

class LotteryApp extends StatelessWidget {
  const LotteryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'မြန်မာ့ထီတိုက် App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const MainHomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _currentIndex = 0;

  // Tabs screens
  final List<Widget> _screens = [
    const InventoryScreen(),
    const SalesScreen(),
    const WinningCheckerScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ထီတိုက် စီမံခန့်ခွဲမှု စနစ်', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green[700],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green[700],
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'အက္ခရာ'),
          BottomNavigationBarItem(icon: Icon(Icons.point_of_sale), label: 'အရောင်း'),
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: 'ပေါက်စဉ်စစ်ရန်'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'ပြင်ဆင်ရန်'),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

// -------------------------------------------------------------
// ၁. အက္ခရာ စီမံခန့်ခွဲမှုပိုင်း (Alphabet Management)
// -------------------------------------------------------------
class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final List<String> _alphabets = ['က', 'ခ', 'ဂ', 'ဃ', 'င', 'စ', 'ဆ', 'ဇ', 'ဈ', 'ည', 'ဋ', 'ဌ', 'ဍ', 'ဎ', 'ဏ', 'တ', 'ထ', 'ဒ', 'ဓ', 'န', 'ပ', 'ဖ', 'ဗ', 'ဘ', 'မ', 'ယ', 'ရ', 'လ', 'ဝ', 'သ', 'ဟ', 'ဠ', 'အ'];
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('ရရှိနိုင်သော ထီအက္ခရာများ (က - အ)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _alphabets.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.green[50],
                  elevation: 2,
                  child: Center(
                    child: Text(
                      _alphabets[index],
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------
// ၂. အရောင်းစာရင်းသွင်းမှုပိုင်း (Sales Entry with Multiple Modes)
// -------------------------------------------------------------
class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  String _selectedMode = 'တစ်စောင်ချင်း';
  final List<String> _modes = ['တစ်စောင်ချင်း', 'ဂဏန်းစဉ်လိုက် (Range)', 'အက္ခရာအစုံ (Multi-Alphabet)'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('ထီလက်မှတ် ရောင်းချမှု မှတ်တမ်းတင်ရန်', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: _selectedMode,
            decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'အရောင်း ပုံစံရွေးချယ်ပါ'),
            items: _modes.map((mode) => DropdownMenuItem(value: mode, child: Text(mode))).toList(),
            onChanged: (value) {
              setState(() {
                _selectedMode = value!;
              });
            },
          ),
          const SizedBox(height: 20),
          if (_selectedMode == 'တစ်စောင်ချင်း') ...[
            const TextField(decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'အက္ခရာ (ဥပမာ - က)')),
            const SizedBox(height: 10),
            const TextField(decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'ဂဏန်း ၆ လုံး (ဥပမာ - 123456)')),
          ] else if (_selectedMode == 'ဂဏန်းစဉ်လိုက် (Range)') ...[
            const TextField(decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'အက္ခရာ')),
            const SizedBox(height: 10),
            const TextField(decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'စတင်မည့် ဂဏန်း (Start)')),
            const SizedBox(height: 10),
            const TextField(decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'ဆုံးမည့် ဂဏန်း (End)')),
          ] else ...[
            const TextField(decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'အက္ခရာ အစ (ဥပမာ - က)')),
            const SizedBox(height: 10),
            const TextField(decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'အက္ခရာ အဆုံး (ဥပမာ - အ)')),
            const SizedBox(height: 10),
            const TextField(decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'တူညီသော ဂဏန်း ၆ လုံး')),
          ],
          const SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: const Size(double.infinity, 50)),
            onPressed: () {
              // အရောင်းစာရင်း သိမ်းဆည်းရန် Logic
            },
            icon: const Icon(Icons.save, color: Colors.white),
            label: const Text('အရောင်းစာရင်း အတည်ပြုမည်', style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------
// ၃. ထီပေါက်စဉ်နှင့် သီးသန့်ဆုမဲများ စစ်ဆေးခြင်း (Winning Checker)
// -------------------------------------------------------------
class WinningCheckerScreen extends StatefulWidget {
  const WinningCheckerScreen({super.key});

  @override
  State<WinningCheckerScreen> createState() => _WinningCheckerScreenState();
}

class _WinningCheckerScreenState extends State<WinningCheckerScreen> {
  final TextEditingController _alphabetController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  String _resultText = '';

  void _checkWinning() {
    String alphabet = _alphabetController.text.trim();
    String number = _numberController.text.trim();

    // ဥပမာ စစ်ဆေးချက် Logic (Sequential Left-to-Right Match)
    setState(() {
      if (number == '123456') {
        _resultText = ' ဂုဏ်ယူပါတယ်! ပထမဆု (၆ လုံးတူ) ပေါက်ပါသည်!';
      } else if (number.startsWith('12345')) {
        _resultText = ' အက္ခရာနှင့် ဂဏန်း ၅ လုံးတူဆု ပေါက်ပါသည်!';
      } else if (number.startsWith('1234')) {
        _resultText = ' အက္ခရာနှင့် ဂဏန်း ၄ လုံးတူဆု ပေါက်ပါသည်!';
      } else if (number.startsWith('123')) {
        _resultText = ' အက္ခရာနှင့် ဂဏန်း ၃ လုံးတူဆု ပေါက်ပါသည်!';
      } else if (number.startsWith('12')) {
        _resultText = ' အက္ခရာနှင့် ဂဏန်း ၂ လုံးတူဆု ပေါက်ပါသည်!';
      } else if (number.startsWith('1')) {
        _resultText = ' အက္ခရာနှင့် ဂဏန်း ၁ လုံးတူဆု ပေါက်ပါသည်!';
      } else {
        _resultText = ' မပေါက်ပါ (ကံကောင်းပါစေ)';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('ထီပေါက်စဉ် တိုက်ဆိုင်စစ်ဆေးရန်', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          TextField(
            controller: _alphabetController,
            decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'အက္ခရာ (ဥပမာ - က)'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _numberController,
            keyboardType: TextInputType.number,
            maxLength: 6,
            decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'ဂဏန်း ၆ လုံး (ဥပမာ - 123456)'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, minimumSize: const Size(double.infinity, 50)),
            onPressed: _checkWinning,
            child: const Text('ပေါက်မပေါက် စစ်ဆေးမည်', style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              _resultText,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------
// ၄. အချက်အလက်များ ပြင်ဆင်ခြင်းနှင့် စာရင်းချုပ်ပိုင်း (Settings & Edit)
// -------------------------------------------------------------
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(Context context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text('အချက်အလက်များ စီမံပြင်ဆင်ခြင်း', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        ListTile(
          leading: const Icon(Icons.edit, color: Colors.green),
          title: const Text('မှားယွင်းစာရင်း ပြင်ဆင်ရန် / ဖျက်ရန်'),
          subtitle: const Text('ရောင်းပြီးသား သို့မဟုတ် ထည့်သွင်းထားသော စာရင်းများကို ပြင်ရန်'),
          onTap: () {},
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.list_alt, color: Colors.blue),
          title: const Text('နေ့စဉ် / လစဉ် အရောင်းစာရင်းချုပ်'),
          subtitle: const Text('ဝင်ငွေ၊ ထွက်ငွေနှင့် လက်ကျန်စာရင်းများ ကြည့်ရန်'),
          onTap: () {},
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.cloud_sync, color: Colors.orange),
          title: const Text('Database Backup / Sync'),
          subtitle: const Text('အချက်အလက်များကို Cloud သို့ သိမ်းဆည်းရန်'),
          onTap: () {},
        ),
      ],
    );
  }
}
