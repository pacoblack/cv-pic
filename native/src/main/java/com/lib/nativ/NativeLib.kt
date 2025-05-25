package com.lib.nativ

class NativeLib {

    /**
     * A native method that is implemented by the 'nativ' native library,
     * which is packaged with this application.
     */
    external fun stringFromJNI(): String

    companion object {
        // Used to load the 'nativ' library on application startup.
        init {
            System.loadLibrary("nativ")
        }
    }
}