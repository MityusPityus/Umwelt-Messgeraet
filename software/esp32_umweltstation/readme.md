# ESP32 Umweltmessstation Software

Diese Software steuert die komplette Umweltmessstation.

## Hauptfunktionen

### Sensorik

Auslesen des BME680 Sensors:

- Temperatur
- Luftfeuchtigkeit
- Luftdruck
- Gaswert

### Echtzeituhr

Verwendung eines DS3231 RTC-Moduls für:

- Uhrzeit
- Datum

Die Uhr funktioniert vollständig offline und benötigt keine Internetverbindung.

### Anzeige

Darstellung der Messwerte auf einem ST7796S 4-Zoll-TFT-Display.

Angezeigt werden:

- Temperatur
- Luftfeuchtigkeit
- Luftdruck
- Luftqualität
- Uhrzeit
- Datum

### Touchbedienung

Der XPT2046 Touchcontroller ermöglicht:

- Öffnen der Statistikansicht
- Öffnen des 24h-Graphen
- Öffnen des Alarmprotokolls
- Navigation zwischen den Ansichten

### Luftqualitätsbewertung

Die Luftqualität wird anhand des Gaswiderstands des BME680 bewertet.

| Gaswert | Bewertung |
|----------|----------|
| >= 100 kOhm | Gut |
| 70 - 99.9 kOhm | Mittel |
| < 70 kOhm | Schlecht |

### Alarmfunktion

Bei schlechter Luftqualität:

- Aktivierung des Buzzers
- Anzeige einer Warnung auf dem Display

Der Alarm kann über einen Taster quittiert werden.

### Datenspeicherung

Die Messdaten werden lokal im Flash-Speicher gespeichert.

Verwendete Technologie:

- LittleFS

Die Speicherung erfolgt ohne Internetverbindung.

### Statistik

Folgende Statistiken stehen zur Verfügung:

- Durchschnittswerte des aktuellen Tages
- Durchschnittswerte der letzten 24 Stunden

### Graph

Grafische Darstellung der letzten 24 Stunden für:

- Temperatur
- Luftfeuchtigkeit
- Luftdruck
- Gaswert

### Alarmprotokoll

Speicherung von Alarmereignissen mit:

- Zeitstempel
- Temperatur
- Luftfeuchtigkeit
- Luftdruck
- Gaswert

## Verwendete Bibliotheken

- Adafruit_GFX
- Adafruit_ST7796S
- Adafruit_BME680
- Adafruit_Sensor
- RTClib
- XPT2046_Touchscreen
- LittleFS

## Hauptdatei

```text
esp32_umweltstation.ino
