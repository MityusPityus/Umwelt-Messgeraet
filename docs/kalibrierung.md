# Kalibrierung und Plausibilitätsprüfung

## Vergleichsmessung Temperatur und Luftfeuchtigkeit

Zur Plausibilitätsprüfung wurden die Werte der Umweltmessstation mit einem externen Hygrometer verglichen.

Nach ca. 5 bis 6 Stunden Laufzeit ergaben sich folgende Werte:

| Messgröße | Umweltstation | Hygrometer | Abweichung |
|---|---:|---:|---:|
| Temperatur | 29,2 °C | 25,6 °C | +3,6 °C |
| Luftfeuchtigkeit | 32,6 % | 36,0 % | -3,4 % |

Die Temperaturabweichung ist plausibel, da der BME680 im Gehäuse verbaut ist und Wärme durch ESP32, Display und Sensorheizung beeinflusst wird.

Im Code wurde daher ein Temperatur-Offset von `-3.6 °C` eingebaut.

```cpp
const float TEMP_OFFSET = -3.6;
