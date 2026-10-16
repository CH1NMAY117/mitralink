# MitraLink

**Companion Android app for Arogyavitals, a low-cost, modular maternal-health monitor for rural India.**

MitraLink is the mobile app built by Team Clinovators during the *Product Design & Prototyping Laboratory* course at the Jyoti and Bhupat Mehta School of Health Sciences and Technology (JBMSHST), IIT Guwahati (Jan–Apr 2025). It is a coursework prototype written in Flutter (Dart).

> **Status: prototype. Not a medical device and not clinically validated.** Do not use it for diagnosis or treatment decisions.

## What is in this repository

| Area | What it does |
| --- | --- |
| Login and profile | Local login screen and a user profile, stored on the phone with `shared_preferences` |
| Monitor | Screen to start monitoring and turn on Wi-Fi (see *Current limitations*) |
| Records | Readings (systolic/diastolic BP, SpO₂, temperature) are held in a `SensorData` model and kept on the device, so the app works without a network |
| Export | Exports saved readings to an Excel file (`sensor_data.xlsx`) |
| Consult | Opens the national eSanjeevani telemedicine portal and shows the user's location on a map |

## Current limitations

This snapshot is honest about where the prototype stopped:

- **The live device connection is not implemented.** `lib/screens/monitor_data_page.dart` enables Wi-Fi and contains the placeholder comment `// Add Arduino connection logic here`. The app does not yet fetch readings from the device.
- **Data model mismatch.** The app model has an SpO₂ field, but the companion firmware reports heart rate (BPM), temperature, systolic, diastolic and BP-module pulse.
- The Google Maps key in `AndroidManifest.xml` is a placeholder (`YOUR_GOOGLE_MAPS_API_KEY`). Add your own key to enable the map.

## How it fits the system

The Arogyavitals device is an Arduino Uno R4 WiFi that reads a pulse sensor, a temperature sensor and a blood-pressure module. It serves the latest values as JSON over HTTP. See the firmware repository: [Arduino-R4-WiFI-Code](https://github.com/CH1NMAY117/Arduino-R4-WiFI-Code).

## Run it

Requirements: Flutter SDK 3.7 or newer and an Android device or emulator.

```bash
git clone https://github.com/CH1NMAY117/mitralink.git
cd mitralink
flutter pub get
flutter run
```

## Team Clinovators

- **Chinmay Arora** (Pharmacy): MitraLink app, in Flutter
- **Sanjoy Kumar Basu** (Pharmacy): 3D-printed enclosure, designed in Fusion 360
- **Parijat Roychowdhury** (Biotechnology): project integration and clinical alignment
- **Rudrasish Mukherjee** (Electronics and Communication Engineering): circuit simulation in KiCad and Arduino integration

Thanks to Dr. Erwin Fuhrer, Dr. Subrata Pramanik, Prof. Subramani Kanagaraj and teaching assistants Sheetal Das and Vishal Tande for their mentorship.

## Licence

[MIT](LICENSE)
