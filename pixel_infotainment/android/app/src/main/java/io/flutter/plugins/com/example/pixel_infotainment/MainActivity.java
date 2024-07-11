package com.example.pixel_infotainment;

import android.os.Bundle;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    static {
        System.loadLibrary("hello-lib");
    }
    
    private native String setStation(float station);

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), "com.example.pixel_infotainment/methodchannel")
            .setMethodCallHandler(
                (call, result) -> {
                    if(call.method.equals("setStation")){
                        double currentFrequencyValue = call.argument("frequencyValue");
                        String res = setStation((float)currentFrequencyValue);
                        result.success(res);
                    }
                    
                    else {
                        result.notImplemented();
                    }
                }
            );
    }
}
