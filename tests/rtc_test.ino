#include <Wire.h>
#include "RTClib.h"

#define I2C_SDA 21
#define I2C_SCL 22

RTC_DS3231 rtc;

void setup() {
  Serial.begin(115200);
  delay(1500);

  Wire.begin(I2C_SDA, I2C_SCL);

  Serial.println();
  Serial.println("================================");
  Serial.println("DS3231 RTC Test startet...");
  Serial.println("================================");

  if (!rtc.begin()) {
    Serial.println("RTC NICHT gefunden!");
    Serial.println("Pruefe VCC, GND, SDA und SCL.");
    while (1) {
      delay(1000);
    }
  }

  Serial.println("RTC gefunden!");

  if (rtc.lostPower()) {
    Serial.println("RTC meldet Stromverlust.");
    Serial.println("Setze RTC einmalig auf Kompilierzeit...");
    rtc.adjust(DateTime(F(__DATE__), F(__TIME__)));
  } else {
    Serial.println("RTC meldet keinen Stromverlust.");
  }

  Serial.println();
  Serial.println("Die Uhrzeit muss jetzt jede Sekunde hochzaehlen:");
}

void loop() {
  DateTime now = rtc.now();

  Serial.print("Datum/Uhrzeit: ");

  if (now.day() < 10) Serial.print("0");
  Serial.print(now.day());
  Serial.print(".");

  if (now.month() < 10) Serial.print("0");
  Serial.print(now.month());
  Serial.print(".");

  Serial.print(now.year());
  Serial.print(" ");

  if (now.hour() < 10) Serial.print("0");
  Serial.print(now.hour());
  Serial.print(":");

  if (now.minute() < 10) Serial.print("0");
  Serial.print(now.minute());
  Serial.print(":");

  if (now.second() < 10) Serial.print("0");
  Serial.println(now.second());

  delay(1000);
}
