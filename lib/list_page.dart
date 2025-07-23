import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/add_data_page.dart';
import 'package:untitled1/list_map_provider.dart';
import 'package:untitled1/theme_provider.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Page"),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return IconButton(
                icon: Icon(
                  themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                ),
                onPressed: () {
                  themeProvider.toggleTheme();
                },
              );
            },
          )
        ],
      ),


      body: Consumer<ListMapProvider>(
        builder: (context, provider, __) {
          final allData = provider.getData();

          return allData.isNotEmpty
              ? ListView.builder(
            itemCount: allData.length,
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(allData[index]['name'] ?? ''),
                subtitle: Text(allData[index]['email'] ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        // ✅ Optional: Navigate to Edit Page or show Edit Dialog
                        context.read<ListMapProvider>().updateData({
                          "name": "Updated Contact",
                          "email": "shahriar@gmail.com", // ✅ fixed email
                        }, index);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Contact updated")),
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<ListMapProvider>().deleteData(index);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Contact deleted")),
                        );
                      },
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                    ),
                  ],
                ),
              );
            },
          )
              : const Center(child: Text("No contacts found"));
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddDataPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
