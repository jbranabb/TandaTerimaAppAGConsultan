import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:tandaterima/pages/pdf_page.dart';
import 'package:tandaterima/providers/recipt_provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final titleController = TextEditingController();

  final naBarController = TextEditingController();

  final merekController = TextEditingController();

  final typeController = TextEditingController();

  final jumlahController = TextEditingController();
  final unYtkMenerima = TextEditingController();
  final unYtkMenyerahkan = TextEditingController();

  final keteranganController = TextEditingController();
  void updateData(InventoryProvider provider, int index) {
    provider.updateData(
        index,
        InventoryRow(
            no: (index + 1).toString(),
            namaInventaris: naBarController.text,
            merek: merekController.text,
            type: typeController.text,
            jumlah: jumlahController.text,
            keterangan: keteranganController.text));
  }

  @override
  void dispose() {
    titleController.dispose();
    naBarController.dispose();
    merekController.dispose();
    typeController.dispose();
    jumlahController.dispose();
    keteranganController.dispose();
    super.dispose();
  }
   @override
  void initState() {
    requestStoragePermission();
    super.initState();
  }

  final List<String> listTittle = [
    'Inventaris',
    'Barang',
  ];
  String? iselected;

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<InventoryProvider>(context);
    final dateAndTitle = Provider.of<DateProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Input Tanda Terima',
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(19),
                child: Column(
                  children: [
                   Padding(
                padding: const EdgeInsets.all(0.0),
                child: DropdownButtonFormField(
                  // padding: EdgeInsets.all(20),
                  decoration: InputDecoration(
                    border:
                        OutlineInputBorder(
                          
                        ), // Ini akan memberi border standar
                    enabledBorder: OutlineInputBorder(
                      
                      borderSide: BorderSide(color: Colors.grey.shade600, width: 1.0),
                    ),
                  ),
                  hint: Text('Pilih Tipe Tanda Terima'),
                  isExpanded: true,
                  value: iselected,
                  onChanged: (value) {
                    setState(() {
                      iselected = value;
                      titleController.text = value.toString();
                      print(titleController);
                    });
                  },
                  items: listTittle
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text('$e'),
                          ))
                      .toList(),
                ),
              ),
                    SizedBox(
                      height: 15,
                    ),
                    MyTextField(
                      label: 'Nama Barang',
                      opsional: '',
                      keyboard: TextInputType.name,
                      controller: naBarController,
                      capitaliz: TextCapitalization.words,
                      onChanged: (value) {
                        // Update data saat user mengetik
                        final dataProvider = Provider.of<InventoryProvider>(
                            context,
                            listen: false);
                        updateData(dataProvider, dataProvider.rows.length - 1);
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    MyTextField(
                      label: 'Merek',
                      opsional: '',
                      capitaliz: TextCapitalization.words,
                      keyboard: TextInputType.text,
                      controller: merekController,
                      onChanged: (value) {
                        // UpdateData data saat user mengetik
                        final dataProvider = Provider.of<InventoryProvider>(
                            context,
                            listen: false);
                        updateData(dataProvider, dataProvider.rows.length - 1);
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    MyTextField(
                      label: 'Type',
                      opsional: '',
                      capitaliz: TextCapitalization.words,
                      keyboard: TextInputType.name,
                      controller: typeController,
                      onChanged: (value) {
                        // UpdateData data saat user mengetik
                        final dataProvider = Provider.of<InventoryProvider>(
                            context,
                            listen: false);
                        updateData(dataProvider, dataProvider.rows.length - 1);
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    MyTextField(
                      capitaliz: TextCapitalization.words,
                      label: 'Jumlah',
                      opsional: '',
                      keyboard: TextInputType.number,
                      controller: jumlahController,
                      onChanged: (value) {
                        // UpdateData data saat user mengetik
                        final dataProvider = Provider.of<InventoryProvider>(
                            context,
                            listen: false);
                        updateData(dataProvider, dataProvider.rows.length - 1);
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    MyTextField(
                      capitaliz: TextCapitalization.words,
                      label: 'Keterangan',
                      opsional: '',
                      keyboard: TextInputType.text,
                      controller: keteranganController,
                      onChanged: (value) {
                        // UpdateData data saat user mengetik
                        final dataProvider = Provider.of<InventoryProvider>(
                            context,
                            listen: false);
                        updateData(dataProvider, dataProvider.rows.length - 1);
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    MyTextField(
                      capitaliz: TextCapitalization.words,
                      label: 'Untuk Yang Menyerahkan',
                      opsional: '',
                      keyboard: TextInputType.text,
                      controller: unYtkMenyerahkan,
                  
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    MyTextField(
                      capitaliz: TextCapitalization.words,
                      label: 'Untuk Yang Menerima',
                      opsional: '',
                      keyboard: TextInputType.text,
                      controller: unYtkMenerima,
                      
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue[100],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          context.read<InventoryProvider>().deleteLastRow();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.red,
                              duration: Durations.long3,
                              content: Consumer<InventoryProvider>(
                                  builder: (context, value, child) {
                                return
                                     Text(
                                        'Mengahapus Row Ke ${dataProvider.rows.length + 1} ');
                              })));
                        },
                        icon: Icon(Icons.remove, color: Colors.red),
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<InventoryProvider>().addRows();
                          updateData(
                              dataProvider, dataProvider.rows.length - 1);
                          print(dataProvider.rows.length - 1);

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.blue,
                              duration: Durations.long3,
                              content: Text(
                                  'Menambahkan ${dataProvider.rows.length - 1} Row')));
                        },
                        icon: Icon(Icons.add, color: Colors.blue,),
                      ),
                      Text('|'),
                      IconButton(
                        onPressed: () {
                          dateAndTitle.updateVoucher(
                            title: titleController.text,
                            unYtkMenerima: unYtkMenerima.text,
                            unYtkMenyerahkan:  unYtkMenyerahkan.text,
                            );
                            print(unYtkMenerima.text);
                            print(unYtkMenyerahkan.text);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.green,
                              duration: Durations.long3,
                              content: Text('Mengirim Data', )));
                        },
                        icon: Icon(Icons.send, color: Colors.green,),
                      ),
                      IconButton(
                        onPressed: () {
                          naBarController.clear();
                          merekController.clear();
                          typeController.clear();
                          jumlahController.clear();
                          keteranganController.clear();
                          unYtkMenerima.clear();
                          unYtkMenyerahkan.clear();

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.blueGrey,
                              duration: Durations.long3,
                              content: Text('Refreshed')));
                        },
                        icon: Icon(Icons.refresh, color: Colors.blueGrey,),
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PDFViewerPage(),
                      ));
                },
                child: const Text('Generate & Preview'),
      
              ),
              SizedBox(height: 10,),
              Text(' Total Baris Sekarang : ${dataProvider.rows.length}'),
              SizedBox(height: 30,),
              Text('Powered by Jibran', style: TextStyle(color: Colors.grey),),
              SizedBox(height: 30,),

            ],
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  String label;
  String? opsional;
  TextInputType keyboard;
  TextCapitalization capitaliz;
  TextEditingController controller;
  final Function(String)? onChanged;
  MyTextField({
    this.opsional,
    required this.capitaliz,
    required this.controller,
    required this.keyboard,
    required this.label,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return TextField(
      autofocus: true,
      controller: controller,
      textCapitalization: capitaliz ,
      keyboardType: keyboard,
      onChanged: onChanged,
      decoration: InputDecoration(
          labelText: label,
          hintText: 'Masukan $label di sini $opsional',
          border: OutlineInputBorder()),
    );
  }
}
