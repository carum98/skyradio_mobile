# <img src="./assets/logo.png" width="30" height="30" /> SkyRadio Mobile

Mobile application for SkyRadio

Frontend: [SkyRadio Frontend](https://github.com/carum98/skyradio-frontend)

Backend: [SkyRadio Backend](https://github.com/carum98/skyradio-api)

## Compilation

### Android
```bash
flutter build appbundle --obfuscate --split-debug-info=obfuscate --dart-define-from-file=.env/prod.json
```

### iOS
```bash
flutter build ipa --dart-define-from-file=.env/prod.json
```


