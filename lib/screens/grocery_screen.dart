import 'package:flutter/material.dart';
import 'empty_grocery_screen.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import 'grocery_item_screen.dart';
import 'grocery_list_screen.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Tapping the button presents the screen to create or add an item.
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Returns the GroceryManager available in the tree.
          final manager = Provider.of<GroceryManager>(context, listen: false);
          // Navigator.push() adds a new route to the stack of routes.
          Navigator.push(
            context,
            // MaterialPageRoute replaces the entire screen with a platform-specific transition.
            MaterialPageRoute(
              // Creates a new GroceryItemScreen within the route’s builder callback.
              builder: (context) => GroceryItemScreen(
                // onCreate defines what to do with the created item.
                onCreate: (item) {
                  // addItem() adds this new item to the list of items.
                  manager.addItem(item);
                  // Once the item is added to the list, pop removes the top navigation route item, GroceryItemScreen, to show the list of grocery items.
                  Navigator.pop(context);
                },
                // onUpdate will never get called since you are creating a new item.
                onUpdate: (item) {},
              ),
            ),
          );
        },
      ),
      body: buildGroceryScreen(),
    );
  }

  // buildGroceryScreen() is a helper function that decides which widget tree to construct.
  Widget buildGroceryScreen() {
    // Wrap widgets inside a Consumer, which listens for GroceryManager state changes.
    return Consumer<GroceryManager>(
      // Consumer rebuilds the widgets below itself when the grocery manager items changes.
      builder: (context, manager, child) {
        // If there are grocery items in the list, show the GroceryListScreen.
        if (manager.groceryItems.isNotEmpty) {
          return GroceryListScreen(manager: manager);
        } else {
          // If there are no grocery items, show the EmptyGroceryScreen.
          return const EmptyGroceryScreen();
        }
      },
    );
  }
}
