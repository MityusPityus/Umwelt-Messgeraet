# Software

In diesem Ordner befindet sich der Hauptcode der ESP32 Umweltmessstation.

## Hauptfunktionen

- Initialisierung von Display, Touch, BME680 und RTC
- Anzeige aktueller Messwerte
- Bewertung der Luftqualität
- Alarmfunktion über Buzzer
- Alarmquittierung über Button
- Touch-Navigation
- Statistikscreen
- 24h Graphscreen
- Alarm-Protokoll
- Speicherung der Messwerte mit LittleFS

## Wichtig

Der aktuelle Code verwendet für die Präsentation ein kurzes Speicherintervall:

```cpp
const unsigned long logInterval = 30000;
