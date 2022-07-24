fvm flutter clean
fvm flutter pub cache repair
# cd ios
# pod repo update
# rm -rf Podfile.lock
# rm -rf Podfile
# rm -rf Pdos
rm -Rf .symlinks
rm -Rf Flutter/Flutter.framework
rm -Rf Flutter/Flutter.podspec
fvm flutter packages pub get
fvm flutter pub run build_runner build --delete-conflicting-outputs
