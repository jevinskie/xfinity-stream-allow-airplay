TARGETS := PPPrimetimeTweak.dylib

all: PPPrimetimeTweak.dylib

.PHONY: clean

clean:
	rm -rf $(TARGETS)

PPPrimetimeTweak.dylib: PPPrimetimeTweak.m
	xcrun --sdk iphoneos clang -arch arm64 -shared -framework Foundation -miphoneos-version-min=9.0 -Oz -o $@ $^