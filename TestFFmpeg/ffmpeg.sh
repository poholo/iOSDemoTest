./configure --target-os=linux --prefix=$PREFIX \
--enable-cross-compile \
--enable-runtime-cpudetect \
--disable-asm \
--arch=arm \
--cc=$PREBUILT/linux-x86_64/bin/arm-linux-androideabi-gcc \
--cross-prefix=$PREBUILT/linux-x86_64/bin/arm-linux-androideabi- \
--disable-stripping \
--nm=$PREBUILT/linux-x86_64/bin/arm-linux-androideabi-gcc-nm \
--sysroot=$PLATFORM \
--enable-gpl --enable-shared --disable-static --enable-small \
--disable-ffprobe --disable-ffplay --disable-ffmpeg --disable-ffserver --disable-debug \
--extra-cflags="-fPIC -DANDROID -D__thumb__ -mthumb -Wfatal-errors -Wno-deprecated -mfloat-abi=softfp -marm -march=armv7-a"


./configure --prefix=./build \
--disable-encoders  \
--disable-decoders  \
--disable-hwaccels  \
--disable-muxers    \
--disable-demuxers  \
--disable-parsers   \
--disable-bsfs  \
--disable-protocols \
--disable-indevs    \
--disable-devices   \
--disable-filters   \
--enable-libx264    \
--enable-libfdk-aac \
--enable-gpl    \
--enable-nonfree    \
--enable-muxer=mp4


./configure --disable-ffmpeg    \
--disable-ffplay \
--disable-ffserver  \
--disable-ffprobe\
--disable-doc \
--disable-bzlib \
--target-os=darwin  \
--enable-cross-compile  \
--enable-version3   \
--arch=arm  \
--cpu=cortex-a8 \
--enable-pic    \
--extra-cflags='-arch armv7 -miphoneos-version-min=6.0'     \
--extra-ldflags='-arch armv7 -miphoneos-version-min=6.0'    \
--extra-cflags='-mfpu=neon -mfloat-abi=softfp'  \
--enable-neon   \
--enable-optimizations  \
--disable-debug \
--disable-armv5te   \
--disable-armv6 \
--disable-armv6t2   \
--enable-small  \
--cc=/Applications/XCode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang   \
--sysroot=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS7.1.sdk \
Configured with: --prefix=/Applications/Xcode.app/Contents/Developer/usr --with-gxx-include-dir=/usr/include/c++/4.2.1
Configured with: --prefix=/Applications/Xcode.app/Contents/Developer/usr --with-gxx-include-dir=/usr/include/c++/4.2.1



./configure --disable-ffmpeg --disable-ffplay --disable-ffserver --disable-ffprobe --disable-doc --disable-bzlib --target-os=darwin --enable-cross-compile --enable-version3 --arch=arm64 --enable-pic --extra-cflags='-arch arm64 -miphoneos-version-min=6.0' --extra-ldflags='-arch arm64 -miphoneos-version-min=6.0' --extra-cflags='-mfpu=neon -mfloat-abi=softfp' --enable-neon --enable-optimizations --disable-debug --disable-armv5te --disable-armv6 --disable-armv6t2 --enable-small --cc=/Applications/XCode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang  --sysroot=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS12.1.sdk 


--disable-gpl --disable-nonfree --enable-runtime-cpudetect --disable-gray --disable-swscale-alpha --disable-programs --disable-ffmpeg --disable-ffplay --disable-ffprobe --disable-ffserver --disable-doc --disable-htmlpages --disable-manpages --disable-podpages --disable-txtpages --disable-avdevice --enable-avcodec --enable-avformat --enable-avutil --enable-swresample --enable-swscale --disable-postproc --enable-avfilter --disable-avresample --enable-network --disable-d3d11va --disable-dxva2 --disable-vaapi --disable-vda --disable-vdpau --disable-videotoolbox --disable-encoders --enable-encoder=png --disable-decoders --enable-decoder=aac --enable-decoder=aac_latm --enable-decoder=flv --enable-decoder=h264 --enable-decoder=mp3* --enable-decoder=vp6f --enable-decoder=flac --enable-decoder=hevc --enable-decoder=vp8 --enable-decoder=vp9 --disable-hwaccels --disable-muxers --enable-muxer=mp4 --disable-demuxers --enable-demuxer=aac --enable-demuxer=concat --enable-demuxer=data --enable-demuxer=flv --enable-demuxer=hls --enable-demuxer=live_flv --enable-demuxer=mov --enable-demuxer=mp3 --enable-demuxer=mpegps --enable-demuxer=mpegts --enable-demuxer=mpegvideo --enable-demuxer=flac --enable-demuxer=hevc --enable-demuxer=webm_dash_manifest --disable-parsers --enable-parser=aac --enable-parser=aac_latm --enable-parser=h264 --enable-parser=flac --enable-parser=hevc --enable-bsfs --disable-bsf=chomp --disable-bsf=dca_core --disable-bsf=dump_extradata --disable-bsf=hevc_mp4toannexb --disable-bsf=imx_dump_header --disable-bsf=mjpeg2jpeg --disable-bsf=mjpega_dump_header --disable-bsf=mov2textsub --disable-bsf=mp3_header_decompress --disable-bsf=mpeg4_unpack_bframes --disable-bsf=noise --disable-bsf=remove_extradata --disable-bsf=text2movsub --disable-bsf=vp9_superframe --enable-protocols --enable-protocol=async --disable-protocol=bluray --disable-protocol=concat --disable-protocol=crypto --disable-protocol=ffrtmpcrypt --enable-protocol=ffrtmphttp --disable-protocol=gopher --disable-protocol=icecast --disable-protocol=librtmp* --disable-protocol=libssh --disable-protocol=md5 --disable-protocol=mmsh --disable-protocol=mmst --disable-protocol=rtmp* --enable-protocol=rtmp --enable-protocol=rtmpt --disable-protocol=rtp --disable-protocol=sctp --disable-protocol=srtp --disable-protocol=subfile --disable-protocol=unix --disable-devices --disable-filters --disable-iconv --disable-audiotoolbox --disable-videotoolbox --disable-linux-perf --disable-bzlib --enable-cross-compile --disable-stripping --arch=arm64 --target-os=darwin --enable-static --disable-shared  --enable-pic --enable-neon --enable-optimizations --enable-debug --enable-small --prefix=/Users/mjc/Desktop/code/ijkplayer/ios/build/ffmpeg-arm64/output  xcrun -sdk iphoneos clang
