# Keep Flutter and GetX packages
-keep class io.flutter.** { *; }
-keep class get.** { *; }

# Keep generated code
-keep class androidx.** { *; }
-keep class com.example.tms_mobileapp.** { *; }  # Replace with your actual app package name

# Prevent stripping out Flutter's resources
-keep class io.flutter.embedding.engine.** { *; }

# Keep Play Core classes (if you're using Play Core or Split Installation)
-keep class com.google.android.play.core.** { *; }
