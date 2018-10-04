#!/bin/sh
set -eux
cd /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core
trap 'git checkout Formula/poppler.rb' 0
git apply <<'EOF'
diff --git a/Formula/poppler.rb b/Formula/poppler.rb
index 5928bbcbc..5a7172f89 100644
--- a/Formula/poppler.rb
+++ b/Formula/poppler.rb
@@ -62,6 +62,18 @@ class Poppler < Formula
     end
 
     system "cmake", ".", *args
+    system "make"
+    Dir.glob("glib/*.gir") do |gir_path|
+      gir_content = File.read(gir_path).gsub(/(shared-library=".+?")/) do
+        $1.gsub(/@rpath/) {lib}
+      end
+      File.open(gir_path, "w") do |gir_file|
+        gir_file.print(gir_content)
+      end
+    end
+    Dir.glob("glib/*.typelib") do |typelib_path|
+      rm_f(typelib_path)
+    end
     system "make", "install"
     system "make", "clean"
     system "cmake", ".", "-DBUILD_SHARED_LIBS=OFF", *args
EOF
brew reinstall poppler --build-from-source
