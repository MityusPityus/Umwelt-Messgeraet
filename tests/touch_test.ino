#include <SPI.h>
#include <Adafruit_GFX.h>
#include <Adafruit_ST7796S.h>
#include <XPT2046_Touchscreen.h>

#define TFT_CS   5
#define TFT_DC   2
#define TFT_RST  4

#define TOUCH_CS   27
#define TOUCH_IRQ  14

Adafruit_ST7796S display(TFT_CS, TFT_DC, TFT_RST);
XPT2046_Touchscreen touch(TOUCH_CS, TOUCH_IRQ);

#define BLACK   0x0000
#define WHITE   0xFFFF
#define RED     0xF800
#define GREEN   0x07E0
#define CYAN    0x07FF
#define YELLOW  0xFFE0
#define NAVY    0x0010

const int SCREEN_W = 480;
const int SCREEN_H = 320;

int TOUCH_MIN_X = 200;
int TOUCH_MAX_X = 3800;
int TOUCH_MIN_Y = 200;
int TOUCH_MAX_Y = 3800;

bool TOUCH_SWAP_XY = false;
bool TOUCH_INVERT_X = true;
bool TOUCH_INVERT_Y = true;

int TOUCH_OFFSET_X = 12;
int TOUCH_OFFSET_Y = 0;

void mapTouchToScreen(int rawX, int rawY, int &screenX, int &screenY) {
  int x = rawX;
  int y = rawY;

  if (TOUCH_SWAP_XY) {
    int temp = x;
    x = y;
    y = temp;
  }

  screenX = map(x, TOUCH_MIN_X, TOUCH_MAX_X, 0, SCREEN_W - 1);
  screenY = map(y, TOUCH_MIN_Y, TOUCH_MAX_Y, 0, SCREEN_H - 1);

  if (TOUCH_INVERT_X) {
    screenX = (SCREEN_W - 1) - screenX;
  }

  if (TOUCH_INVERT_Y) {
    screenY = (SCREEN_H - 1) - screenY;
  }

  screenX = screenX + TOUCH_OFFSET_X;
  screenY = screenY + TOUCH_OFFSET_Y;

  screenX = constrain(screenX, 0, SCREEN_W - 1);
  screenY = constrain(screenY, 0, SCREEN_H - 1);
}

void setup() {
  Serial.begin(115200);
  delay(1000);

  SPI.begin(18, 19, 23);

  display.init(320, 480, 0, 0, ST7796S_RGB);
  display.setRotation(1);

  touch.begin();
  touch.setRotation(1);

  display.fillScreen(BLACK);
  display.drawRect(0, 0, SCREEN_W, SCREEN_H, WHITE);

  display.setTextSize(3);
  display.setTextColor(WHITE, BLACK);
  display.setCursor(20, 20);
  display.print("Touch Test");

  display.setTextSize(2);
  display.setCursor(20, 70);
  display.print("Tippe auf Display");

  display.fillRoundRect(130, 210, 220, 55, 10, NAVY);
  display.drawRoundRect(130, 210, 220, 55, 10, WHITE);

  display.setTextColor(YELLOW, NAVY);
  display.setCursor(175, 228);
  display.print("STATISTIK");

  Serial.println("Touch Test bereit.");
}

void loop() {
  if (touch.touched()) {
    TS_Point p = touch.getPoint();

    int screenX;
    int screenY;

    mapTouchToScreen(p.x, p.y, screenX, screenY);

    Serial.print("RAW X: ");
    Serial.print(p.x);

    Serial.print(" RAW Y: ");
    Serial.print(p.y);

    Serial.print(" Z: ");
    Serial.print(p.z);

    Serial.print(" SCREEN X: ");
    Serial.print(screenX);

    Serial.print(" SCREEN Y: ");
    Serial.println(screenY);

    display.fillCircle(screenX, screenY, 5, RED);

    display.fillRect(10, 280, 460, 35, BLACK);
    display.setTextSize(2);
    display.setTextColor(CYAN, BLACK);
    display.setCursor(15, 290);
    display.print("X:");
    display.print(screenX);
    display.print(" Y:");
    display.print(screenY);

    delay(100);
  }
}
