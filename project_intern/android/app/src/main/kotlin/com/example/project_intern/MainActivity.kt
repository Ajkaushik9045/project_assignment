package com.example.project_intern

import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val ttsChannelName = "tts"
    private lateinit var textToSpeechHelper: TextToSpeechHelper

    private val fruitSelectionChannelName = "fruit_selection"
    private lateinit var fruitSelectionChannel: MethodChannel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // setContentView(R.layout.FruitSelectionActivity)

        textToSpeechHelper = TextToSpeechHelper(this)

        // Set up the fruitSelectionChannel
        val flutterEngine = flutterEngine ?: return
        fruitSelectionChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, fruitSelectionChannelName)
        fruitSelectionChannel.setMethodCallHandler { call, result ->
            if (call.method == "navigateToFruitSelection") {
                startActivity(Intent(this, FruitSelectionActivity::class.java))
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Set up the TextToSpeechHelper channel
        val ttsChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, ttsChannelName)
        ttsChannel.setMethodCallHandler { call, result ->
            if (call.method == "textToSpeech") {
                val text = call.arguments<String>() ?: ""
                textToSpeechHelper.speakText(text)
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        textToSpeechHelper.shutdown()
    }
}
