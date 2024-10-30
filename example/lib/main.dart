import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:transact_pay/transact_pay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transact Pay API Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Example API Key and Encryption Key
  String apiKey = "PGW-PUBLICKEY-TEST-5D9411AB210740019FF1374C896D86D0";
  String encryptionKey =
      "NDA5NiE8UlNBS2V5VmFsdWU+PE1vZHVsdXM+cW5rdlhOWHRYdEF0Mi9RcDB4SzBSUXpXYTVKRWc5T0xTNFBqYzZKcmN1eDg4bmJsd2Fyd0h4dnlrUy9STk92eFltU2ZPTlEzbW9vM1hhaWpXd2IwbnVVOTJ4anBmSzByb0FYaFo0emdHVUdlS081emY4enlncExTYzFqS05MMFNXZHZWYndMeTN3WHJiRTBrSjZJRWVvSThLRSs0anRndzY1R084Z3hJeGpibjhNemI5YVNreFdaSnVMRFRLNzJHcGcxYkwrNDBLYnVNc2tVWlJVTGxhNC84Y1dYSlpId2JINjRWNkNHQlVMMGVQUmQ4dnB3aEhySzhZSlZaRGxuYTdNbmxQVjdoeGg1Q0dabkVsNy91WEJjaGYvTExLOFNyckdnRWN1anFKWEZxMm9nUlEwNzBxN2RmOXBNZ0Q5YXpTK3dya2dBck9wNnVFcXBFQ1NnbXlvb1VMZFV2MTBhQk4xRUN5YTY2UnhuV3dEck5QZktSWjU4ZmFlNnJkelpMaExlajNId2VJRjZYcHpwL280VTlmVDVwOFNWTStHK1FZalFFV0RieldhYzMyMUIxRVhWc2xkMXFFTDJzZEk0UEFWNy9DWUcwS2hvR256NVdyZnNBQ1lRRUFkQm16MXM1NktYZnczV3dYVDJoUE1xWWtTZ2c4ejFiR1AxWTZJeDU3RHViUjdVcDlwc2taV0ptUzdNdkM1NnRHN1F6OUdiNzBjVTRiNXYvYkdBZnNMNUlRanBrc2QyRENsU2U0Vm5oNEcyWE0xeTEzS0gyZWVvNnViMUczdVBUMGtzZ2RxSXRtdjFKcmN3SThWaXJOWG9oeW1xL2xpbWg1VUhDTWhzMUhlUTQwMXIvNWt0S200bDJISFMvdXhNcmZlUmVEVTRWMXVBZTNQRU1jUDg9PC9Nb2R1bHVzPjxFeHBvbmVudD5BUUFCPC9FeHBvbmVudD48L1JTQUtleVZhbHVlPg==";

  late TransactPay transactPay;
  late Future<String> createOrderFuture;
  late Future<String> payWithCardFuture;
  late Future<String> getBanksFuture;

  @override
  void initState() {
    super.initState();
    transactPay = TransactPay(apiKey: apiKey, encryptionKey: encryptionKey);

    // Initialize the futures once to prevent multiple API calls
    createOrderFuture = createOrder();
    payWithCardFuture = payWithCard();
    getBanksFuture = getBanks();
  }

  Future<String> fetchData(Function apiCall) async {
    try {
      http.Response response = await apiCall();
      return 'Status: ${response.statusCode}\nBody: ${response.body}';
    } catch (e) {
      return 'Error: $e';
    }
  }

  Future<String> createOrder() {
    Map<String, dynamic> payload = {
      "customer": {
        "firstname": "transact",
        "lastname": "pay",
        "mobile": "+2348134509421",
        "country": "NG",
        "email": "email@transactpay.ai"
      },
      "order": {
        "amount": 200,
        "reference": "12137e00034hjekhke",
        "description": "Pay",
        "currency": "NGN"
      },
      "payment": {"RedirectUrl": "https://www.hi.com"}
    };
    return fetchData(() => transactPay.createOrder(payload));
  }

  Future<String> payWithCard() {
    Map<String, dynamic> payload = {
      "reference": "12137e00034hjekhke",
      "paymentoption": "C",
      "country": "NG",
      "card": {
        "cardnumber": "5123450000784608",
        "expirymonth": "01",
        "expiryyear": "39",
        "cvv": "193"
      }
    };
    return fetchData(() => transactPay.payWithCard(payload));
  }

  Future<String> getBanks() {
    Map<String, dynamic> payload = {};
    return fetchData(() => transactPay.banks());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transact Pay API Demo'),
      ),
      body: ListView(
        children: [
          buildApiResultTile('Create Order', createOrderFuture),
          buildApiResultTile('Pay with Card', payWithCardFuture),
          buildApiResultTile('Get Banks', getBanksFuture),
        ],
      ),
    );
  }

  Widget buildApiResultTile(String title, Future<String> apiFuture) {
    return FutureBuilder<String>(
      future: apiFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListTile(
            title: Text(title),
            subtitle: const Text('Loading...'),
            leading: const CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return ListTile(
            title: Text(title),
            subtitle: Text('Error: ${snapshot.error}'),
            leading: const Icon(Icons.error, color: Colors.red),
          );
        } else {
          return ListTile(
            title: Text(title),
            subtitle: Text(snapshot.data ?? 'No data'),
            leading: const Icon(Icons.check_circle, color: Colors.green),
          );
        }
      },
    );
  }
}
