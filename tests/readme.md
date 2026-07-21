# Durchgeführte Tests

Dieser Ordner enthält Testprogramme zur Einzelprüfung der wichtigsten Komponenten der ESP32 Umweltmessstation.

## Testübersicht

| Datei | Zweck | Ergebnis |
|---|---|---|
| i2c_scanner.ino | Prüfung der I2C-Geräte | BME680 und RTC wurden erkannt |
| rtc_test.ino | Test des DS3231 RTC-Moduls | Neues RTC-Modul zählt korrekt hoch |
| bme680_test.ino | Auslesen der Sensordaten | Temperatur, Feuchtigkeit, Druck und Gaswert werden gelesen |
| display_test.ino | Prüfung des ST7796S Displays | Anzeige und Ausrichtung erfolgreich getestet |
| touch_test.ino | Prüfung und Kalibrierung des XPT2046 Touchscreens | Touch funktioniert nach Kalibrierung |
| buzzer_button_test.ino | Prüfung von Buzzer und Button | Alarmton und Quittierung erfolgreich getestet |

## Besonderheiten

### RTC

Das erste RTC-Modul wurde zwar über I2C erkannt, zählte jedoch die Uhrzeit nicht weiter.  
Nach Austausch des Moduls funktionierte die RTC korrekt.

### Touch

Für den Touchscreen wurde zunächst eine andere XPT2046-Bibliothek getestet.  
Die finale Umsetzung verwendet:

```cpp
#include <XPT2046_Touchscreen.h>
