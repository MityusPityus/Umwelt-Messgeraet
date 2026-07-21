#define BUZZER_PIN 26
#define BUTTON_PIN 13

bool buzzerState = false;
bool alarmActive = false;

unsigned long lastButtonPress = 0;
const unsigned long debounceDelay = 250;

void setup() {
  Serial.begin(115200);
  delay(1000);

  pinMode(BUZZER_PIN, OUTPUT);
  digitalWrite(BUZZER_PIN, LOW);

  pinMode(BUTTON_PIN, INPUT_PULLUP);

  Serial.println("Buzzer + Button Test startet...");
  Serial.println("Button druecken: Alarm an/aus");
}

void loop() {
  bool buttonPressed = (digitalRead(BUTTON_PIN) == LOW);

  if (buttonPressed && millis() - lastButtonPress > debounceDelay) {
    lastButtonPress = millis();

    alarmActive = !alarmActive;

    if (alarmActive) {
      Serial.println("Alarm aktiviert.");
    } else {
      Serial.println("Alarm deaktiviert.");
      digitalWrite(BUZZER_PIN, LOW);
      buzzerState = false;
    }
  }

  if (alarmActive) {
    buzzerState = !buzzerState;
    digitalWrite(BUZZER_PIN, buzzerState ? HIGH : LOW);
    delay(300);
  } else {
    digitalWrite(BUZZER_PIN, LOW);
  }
}
