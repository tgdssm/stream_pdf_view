package com.example.stream_pdf_view


import android.content.Context
import android.util.Log
import android.view.View
import androidx.annotation.NonNull
import com.github.barteksc.pdfviewer.PDFView
import com.github.barteksc.pdfviewer.listener.OnLoadCompleteListener
import com.github.barteksc.pdfviewer.scroll.DefaultScrollHandle
import com.github.barteksc.pdfviewer.scroll.ScrollHandle
import com.github.barteksc.pdfviewer.util.FitPolicy
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import java.io.BufferedInputStream
import java.net.HttpURLConnection
import java.net.URL
import kotlinx.coroutines.*

/** StreamPdfViewPlugin */
class StreamPdfViewPlugin: FlutterPlugin {
  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    flutterPluginBinding.platformViewRegistry.registerViewFactory(
      "stream_pdf_view", PDFViewFactory(flutterPluginBinding.binaryMessenger)
    )
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
//    channel.setMethodCallHandler(null)
  }

}

class PDFViewFactory(private val messenger: BinaryMessenger) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
  override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
    return FlutterPDFView(context, messenger)
  }

}

class FlutterPDFView internal constructor(
  context: Context,
  messenger: BinaryMessenger,
) : PlatformView, MethodCallHandler {
  private val methodChannel: MethodChannel
  private var pdfView : PDFView

  init {
    methodChannel = MethodChannel(messenger, "stream_pdf_view")
    pdfView = PDFView(context, null)
    methodChannel.setMethodCallHandler(this)
  }

  override fun getView(): View {
    return pdfView
  }

  override fun dispose() {
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when(call.method) {
      "openPdf" -> {
        val urlPdf = call.arguments as String
        loadAndShowPdf(urlPdf, result)
      }
    }
  }

  @OptIn(DelicateCoroutinesApi::class)
  private fun loadAndShowPdf(url: String, result: Result) {
    GlobalScope.launch {
      val bytes = downloadPdf(url)
      withContext(Dispatchers.Main) {
        Log.println(Log.INFO, null, "TEST")
        openPdf(bytes)
        result.success(null)
      }
    }
  }

  private fun downloadPdf(url: String) : ByteArray {
    val connection = URL(url).openConnection() as HttpURLConnection
    connection.doInput = true
    connection.connect()
    val inputStream = BufferedInputStream(connection.inputStream)
    val bytes = inputStream.readBytes()
    connection.disconnect()
    return bytes
  }

  private fun openPdf(bytes: ByteArray) {
    pdfView.fromBytes(bytes).onLoad { Log.println(Log.INFO, null, "Completed") }.load()
  }
}

