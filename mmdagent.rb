require 'formula'

class Mmdagent < Formula
  homepage 'http://www.mmdagent.jp/'
  url 'http://downloads.sf.net/project/mmdagent/MMDAgent/MMDAgent-1.3.1/MMDAgent-1.3.1.zip'
  sha1 '181d355856ccd087ed8c0090c9d18758d864bb1e'
  head 'http://svn.code.sf.net/p/mmdagent/code/MMDAgent/'

  def patches
    # fix for problem at case sensitive file system.
    DATA
  end

  def install
    ENV.j1

    if build.head?
      system "make cocoa"
    else
      ENV.m32
      system "make carbon"
    end
    prefix.install "Release"

    (bin/"MMDAgent").write <<-EOS.undent
        #!/bin/bash
        #{prefix}/Release/MMDAgent.app/Contents/MacOS/MMDAgent "$@"
    EOS
    (bin/"MMDAgent").chmod 0755

  end
end

__END__
diff -Naur a/Plugin_Audio/Audio_Thread.cpp b/Plugin_Audio/Audio_Thread.cpp
--- a/Plugin_Audio/Audio_Thread.cpp	2013-05-15 16:16:44.000000000 +0200
+++ b/Plugin_Audio/Audio_Thread.cpp	2013-05-14 17:36:14.000000000 +0200
@@ -48,7 +48,7 @@
 #ifdef __APPLE__
 #include <Carbon/Carbon.h>
 #include <AudioToolbox/ExtendedAudioFile.h>
-#include <audiounit/AudioUnit.h>
+#include <AudioUnit/AudioUnit.h>
 #endif /* __APPLE__ */
 
 #include "MMDAgent.h"
