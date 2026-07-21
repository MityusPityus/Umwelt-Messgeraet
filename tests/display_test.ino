#include <SPI.h>
#include <Adafruit_GFX.h>
#include <Adafruit_ST7796S.h>

#define TFT_CS   5
#define TFT_DC   2
#define TFT_RST  4

Adafruit_ST7796S display(TFT_CS, TFT_DC, TFT_RST);

void setup() {
  Serial.begin(115200);
  delay(1000);

  Serial.println("ST7796S Display Test startet...");

  display.init(320, 480, 0, 0, ST7796S_RGB);
  display.setRotation(1);

  display.fillScreen(0x0000);

  display.drawRect(0, 0, 480, 320, 0xFFFF);

  display.setTextSize(3);
  display.setTextColor(0xFFFF);
  display.setCursor(20, 20);
  display.print("Display Test");

  display.setTextSize(2);

  display.setTextColor(0xF800);
  display.setCursor(20, 80);
  display.print("Rot");

  display.setTextColor(0x07E0);
  display.setCursor(20, 110);
  display.print("Gruen");

  display.setTextColor(0x001F);
  display.setCursor(20, 140);
  display.print("Blau");

  display.setTextColor(0xFFE0);
  display.setCursor(20, 180);
  display.print("Ausrichtung korrekt");

  display.setTextColor(0x07FF);
  display.setCursor(20, 230);
  display.print("ST7796S OK");

  Serial.println("Display Test fertig.");
}

void loop() {
}
