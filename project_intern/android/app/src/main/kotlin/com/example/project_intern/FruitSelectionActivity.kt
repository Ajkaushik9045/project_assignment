    package com.example.project_intern
    import androidx.appcompat.app.AppCompatActivity
    import android.os.Bundle
    import android.widget.ArrayAdapter
    import android.widget.Button
    import android.widget.ListView
    // import androidx.appcompat.app.AppCompatActivity
    import io.flutter.embedding.engine.FlutterEngine
    import io.flutter.plugin.common.MethodChannel

    class FruitSelectionActivity : AppCompatActivity() {
        private val fruitSelectionChannelName = "fruit_selection"
        private lateinit var fruitSelectionChannel: MethodChannel

        override fun onCreate(savedInstanceState: Bundle?) {
            super.onCreate(savedInstanceState)
            setContentView(R.layout.fruit_selection)

            // Initialize the ListView with fruits
            val fruitList = findViewById<ListView>(R.id.fruit_list)
            val fruits = listOf("Apple", "Banana", "Orange", "Mango", "Pineapple")
            val adapter = ArrayAdapter(this, android.R.layout.simple_list_item_multiple_choice, fruits)
            fruitList.adapter = adapter

            // Toggle selection on item click
            fruitList.setOnItemClickListener { _, _, position, _ ->
                val isChecked = fruitList.isItemChecked(position)
                fruitList.setItemChecked(position, !isChecked)
            }

            // Set up the fruitSelectionChannel
            fruitSelectionChannel = MethodChannel(FlutterEngine(this).dartExecutor.binaryMessenger, fruitSelectionChannelName)

            // Handle button click to send selected fruits to Flutter
            findViewById<Button>(R.id.btn_send_fruits).setOnClickListener {
                val selectedFruits = getSelectedFruitNames(fruitList)
                fruitSelectionChannel.invokeMethod("selectedFruits", selectedFruits)
            }
        }

        // Helper function to get selected fruit names
        private fun getSelectedFruitNames(fruitList: ListView): ArrayList<String> {
            val selectedFruits = ArrayList<String>()
            for (i in 0 until fruitList.count) {
                if (fruitList.isItemChecked(i)) {
                    selectedFruits.add(fruitList.adapter.getItem(i) as String)
                }
            }
            return selectedFruits
        }
    }