# ESP32 Umweltmessstation

Dieses Projekt umfasst die Entwicklung einer offlinefähigen Umweltmessstation auf Basis eines ESP32.

Die Umweltstation misst verschiedene Raumklimawerte, zeigt diese auf einem 4-Zoll-TFT-Display an und kann bei schlechter Luftqualität eine akustische Warnung ausgeben. Zusätzlich besitzt das Gerät eine Touch-Bedienung, eine lokale Datenspeicherung, Statistikfunktionen und ein 3D-gedrucktes Gehäuse.

## Funktionen

- Messung von Temperatur
- Messung der Luftfeuchtigkeit
- Messung des Luftdrucks
- Bewertung der Luftqualität über den Gaswert des BME680
- Anzeige von Uhrzeit und Datum über ein DS3231 RTC-Modul
- Offline-Betrieb ohne Internetverbindung
- Touch-Bedienung über XPT2046
- Akustischer Alarm über Buzzer bei schlechter Luftqualität
- Alarm-Quittierung über Button
- Lokale Messwertspeicherung mit LittleFS
- Statistikansicht für Tages- und 24h-Durchschnitt
- Graphanzeige der letzten 24 Stunden
- Alarm-Protokoll mit Zeitstempel und Messwerten
- Individuell konstruiertes 3D-Gehäuse

## Verwendete Hardware

| Komponente | Zweck |
|---|---|
| ESP32 Dev Board | Zentrale Steuereinheit |
| BME680 | Messung von Temperatur, Feuchtigkeit, Druck und Gaswert |
| DS3231 RTC | Offline-Uhrzeit und Datum |
| ST7796S TFT Display | Anzeige der Messwerte |
| XPT2046 Touchcontroller | Touch-Bedienung |
| Aktiver Buzzer | Akustischer Alarm |
| Push Button | Alarm quittieren |
| 3D-gedrucktes Gehäuse | Schutz und Montage der Komponenten |

## Software-Funktionen

Die Hauptsoftware liest regelmäßig die Sensordaten aus, aktualisiert das Display und bewertet die Luftqualität anhand des Gaswiderstands. Bei schlechter Luftqualität wird ein Alarm ausgelöst, der über einen Button quittiert werden kann.

Die Messwerte werden lokal im internen Flash-Speicher des ESP32 über LittleFS gespeichert. Dadurch ist keine Internetverbindung notwendig. Die gespeicherten Werte werden für Statistik- und Graphfunktionen verwendet.

## Kalibrierung

Während des Projekts wurden die Messwerte mit einem externen Hygrometer verglichen.

Ermittelte Abweichungen:

- Temperatur: Sensor zeigte ca. 3,6 °C zu hoch
- Luftfeuchtigkeit: Sensor lag ca. 3,4 % unter dem Vergleichswert
- Gaswert:
  - Fenster offen: ca. 132,5 kOhm
  - Fenster geschlossen: ca. 88,7 kOhm
  - angepustet: ca. 60 kOhm

Daraus wurden folgende Luftqualitätsbereiche abgeleitet:

| Gaswert | Bewertung |
|---|---|
| >= 100 kOhm | Gut |
| 70 - 99,9 kOhm | Mittel |
| < 70 kOhm | Schlecht |

## Projektstatus

Aktueller Stand:

- Hardware aufgebaut
- RTC-Modul erfolgreich ausgetauscht
- Display und Touch funktionieren
- Sensorwerte werden angezeigt
- Statistik- und Graphfunktionen sind integriert
- Alarm-Protokoll ist integriert
- Gehäuse wurde gedruckt und montiert
- Kurzzeit- und Plausibilitätstests wurden durchgeführt

Der geplante 24h-Dauertest konnte aus Zeitgründen vor der Präsentation nicht vollständig durchgeführt werden. Stattdessen wurde ein mehrstündiger Funktionstest mit Vergleichsmessungen durchgeführt.

## Repository-Struktur

```text
docs/
  Projektdokumentation und Bilder

hardware/
  Bauteilliste, Verkabelung und Hinweise

software/
  Hauptprogramm der Umweltstation

tests/
  Einzeltests für Display, Touch, RTC und BME680

3d-modelle/
  OpenSCAD- und STL-Dateien für das Gehäuse
