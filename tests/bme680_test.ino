#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_BME680.h>

#define I2C_SDA 21
#define I2C_SCL 22

Adafruit_BME680 bme;

void setup() {
  Serial.begin(115200);
  delay(1000);

  Wire.begin(I2C_SDA, I2C_SCL);

  Serial.println();
  Serial.println("==============================");
  Serial.println("BME680 Test startet...");
  Serial.println("==============================");

  if (!bme.begin(0x76)) {
    Serial.println("BME680 nicht bei 0x76 gefunden. Teste 0x77...");

    if (!bme.begin(0x77)) {
      Serial.println("BME680 NICHT gefunden!");
      while (1) {
        delay(1000);
      }
    }
  }

  Serial.println("BME680 gefunden!");

  bme.setTemperatureOversampling(BME680_OS_8X);
  bme.setHumidityOversampling(BME680_OS_2X);
  bme.setPressureOversampling(BME680_OS_4X);
  bme.setIIRFilterSize(BME680_FILTER_SIZE_3);
  bme.setGasHeater(320, 150);
}

void loop() {
  if (!bme.performReading()) {
    Serial.println("Messung fehlgeschlagen!");
    delay(2000);
    return;
  }

  Serial.println("------ BME680 Werte ------");

  Serial.print("Temperatur: ");
  Serial.print(bme.temperature);
  Serial.println(" C");

  Serial.print("Feuchtigkeit: ");
  Serial.print(bme.humidity);
  Serial.println(" %");

  Serial.print("Druck: ");
  Serial.print(bme.pressure / 100.0);
  Serial.println(" hPa");

  Serial.print("Gas: ");
  Serial.print(bme.gas_resistance / 1000.0);
  Serial.println(" KOhm");

  Serial.println("--------------------------");

  delay(2000);
}
