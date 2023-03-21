package app.yukki.snowflake

import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    protected fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this.getFlutterEngine())
    }
}
