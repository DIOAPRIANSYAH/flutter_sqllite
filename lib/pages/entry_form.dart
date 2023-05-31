import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../dbHelper/sql_helper.dart';
import '../model/item.dart';

class EntryForm extends StatefulWidget {
  const EntryForm({
    Key? key,
    this.item,
  }) : super(key: key);
  final Item? item;
  @override
  State<EntryForm> createState() => EntryFormState();
}

class EntryFormState extends State<EntryForm> {
  late Item item = Item(name: '', price: 0, stok: 0, kodeBarang: '');
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stokController = TextEditingController();
  TextEditingController kodeBarangController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.item != null) {
      nameController.text = widget.item!.name;
      priceController.text = widget.item!.price.toString();
      stokController.text = widget.item!.stok.toString();
      kodeBarangController.text = widget.item!.kodeBarang;
    }
    return Scaffold(
      appBar: AppBar(
        title: widget.item == null ? const Text('Tambah') : const Text('Ubah'),
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: <Widget>[
          // Nama Barang
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 80,
            child: TextField(
              controller: nameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Nama Barang',
                hintText: 'Input Nama Barang',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onChanged: (value) {
                // TODO: Method untuk form nama barang
              },
            ),
          ),
          const SizedBox(height: 16),
          // Harga Barang
          SizedBox(
            height: 80,
            child: TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Harga Barang',
                hintText: 'Input Harga Barang',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              autofocus: false,
              onChanged: (value) {
                // TODO: Method untuk form harga barang
              },
            ),
          ),
          const SizedBox(height: 16),
          // Stok Barang
          SizedBox(
            height: 80,
            child: TextField(
              controller: stokController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Stok Barang',
                hintText: 'Input Stok Barang',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onChanged: (value) {
                // TODO: Method untuk form stok barang
              },
            ),
          ),
          const SizedBox(height: 16),
          // Kode Barang
          SizedBox(
            height: 80,
            child: TextField(
              controller: kodeBarangController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Kode Barang',
                hintText: 'Input Kode Barang',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onChanged: (value) {
                // TODO: Method untuk form kode barang
              },
            ),
          ),
          const SizedBox(height: 32),
          // Tombol Simpan dan Batal
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Simpan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    if (widget.item == null) {
                      print('database');
                      // Tambah data
                      item = Item(
                        name: nameController.text,
                        price: int.parse(priceController.text),
                        stok: int.parse(stokController.text),
                        kodeBarang: kodeBarangController.text,
                      );
                      final Future<Database> dbFuture = SQLHelper.db();
                      Future<int> id = SQLHelper.createItem(item);
                      print(id);
                    } else {
                      // Ubah data
                      item.id = widget.item!.id;
                      item.name = nameController.text;
                      item.price = int.parse(priceController.text);
                      item.stok = int.parse(stokController.text);
                      item.kodeBarang = kodeBarangController.text;
                      SQLHelper.updateItem(item);
                    }
                    print('Disini Datanya');
                    // Kembali ke layar sebelumnya dengan membawa objek it
                    print(item.name);
                    Navigator.pop(context, item);
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Batal',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
