# libzstd
libzstd docker container. It build libzstd include filis and libs for 4 platforms(armeabi-v7a, arm64-v8a, x86, x86_64) and stores it in share folder. For more information visit https://collaboraonline.github.io/post/build-code-android/.


## clone libzstd repository
```
git clone https://android.googlesource.com/platform/external/zstd/ android-zstd
```

## build docker image
```
$ ./build.sh
```

## run container 
```
$ ./start.sh
```

## run install script inside container
```
# ./install.sh
```

