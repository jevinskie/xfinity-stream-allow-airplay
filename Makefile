TARGETS := PPPrimetimeTweak.dylib PPPrimetimeTweak-armv7.dylib PPPrimetimeTweak-arm64.dylib xs-patched-unsigned.ipa

all: $(TARGETS)

.PHONY: clean

clean:
	rm -rf $(TARGETS) unzipped

PPPrimetimeTweak-armv7.dylib: PPPrimetimeTweak.m
	xcrun --sdk iphoneos clang -arch armv7 -shared -framework Foundation -miphoneos-version-min=9.0 -Oz -o $@ $^

PPPrimetimeTweak-arm64.dylib: PPPrimetimeTweak.m
	xcrun --sdk iphoneos clang -arch arm64 -shared -framework Foundation -miphoneos-version-min=9.0 -Oz -o $@ $^

PPPrimetimeTweak.dylib: PPPrimetimeTweak-armv7.dylib PPPrimetimeTweak-arm64.dylib
	lipo -create -arch armv7 PPPrimetimeTweak-armv7.dylib -arch arm64 PPPrimetimeTweak-arm64.dylib -output $@

xs-patched-unsigned.ipa: xs-orig-decrypted.ipa PPPrimetimeTweak.dylib
	rm -rf unzipped $@
	unzip -d unzipped xs-orig-decrypted.ipa
	mkdir  unzipped/Payload/Xfinity\ Stream.app/Tweaks
	cp PPPrimetimeTweak.dylib unzipped/Payload/Xfinity\ Stream.app/Tweaks
	optool install -c load -p "@executable_path/Tweaks/PPPrimetimeTweak.dylib" -t unzipped/Payload/Xfinity\ Stream.app/Xfinity\ Stream
	cd unzipped && zip -9r ../xs-patched-unsigned.ipa Payload
