#include <EEPROM.h>

//驱动数码管显示的引脚定义，0-13为数字引脚,14-19为模拟引脚
int segmentPins[] = {3, 2, 19, 16, 18, 4, 5, 17};
//用于驱动四个数码管，控制其开关
int displayPins[] = {15,6,14,7};
// 时间序列
int times[] = {5, 10, 15, 20, 30, 45, 100, 130, 200, 230, 300, 400, 500, 600, 700, 800, 900, 1000, 1500, 2000,
               3000
              };
int numTimes = 20;
byte selectedTimeIndex;
int timerMinute;
int timerSecond;
// 蜂鸣器开关
int buzzerPin = 11;
// 旋转编码器三个按钮
int aPin = 12;
int bPin = 13;
int buttonPin = 10;

boolean stopped = true; //初始为stopped
byte digits[10][8] = {
    //a	b	c	d	e	f	g．
    {1, 1, 1, 1, 1, 1, 0, 0}, //0
    {0, 1, 1, 0, 0, 0, 0, 0}, //1
    {1, 1, 0, 1, 1, 0, 1, 0}, //2
    {1, 1, 1, 1, 0, 0, 1, 0}, //3
    {0, 1, 1, 0, 0, 1, 1, 0}, //4
    {1, 0, 1, 1, 0, 1, 1, 0}, //5
    {1, 0, 1, 1, 1, 1, 1, 0}, //6
    {1, 1, 1, 0, 0, 0, 0, 0}, //7

    {1, 1, 1, 1, 1, 1, 1, 0}, //8
    {1, 1, 1, 1, 0, 1, 1, 0}  //9
};

void setup()
{
    for (int i = 0; i < 8; i++)
    {
        pinMode(segmentPins[i], OUTPUT);
    }
    for (int i = 0; i < 4; i++)
    {
        pinMode(displayPins[i], OUTPUT);
    }
    pinMode(buzzerPin, OUTPUT);
    pinMode(buttonPin, INPUT);
    pinMode(aPin, INPUT);
    pinMode(bPin, INPUT);
    selectedTimeIndex = EEPROM.read(0); //读取设置的时间
    timerMinute = times[selectedTimeIndex] / 100; //分
    timerSecond = times[selectedTimeIndex] % 100; //秒
    //Serial.begin(9600);
}

void loop()
{
    if (digitalRead(buttonPin)) //旋转编码器开关按下
    {
        stopped = !stopped; //false
        digitalWrite(buzzerPin, LOW); //蜂鸣器low
        while (digitalRead(buttonPin)){}; //一直写入保留旋转编码器设定的时间，除非编码器按钮按下切换到倒计时模式
        EEPROM.write(0, selectedTimeIndex);
    }
    updateDisplay(); //更新数码管显示的时间
}

void updateDisplay() //mmss
{
    int minsecs = timerMinute * 100 + timerSecond; //总时间
    int v = minsecs; 
    for (int i = 0; i < 4; i++) 
    {
        int digit = v % 10;
        setDigit(i);
        setSegments(digit);
        v = v / 10;
        process();
    }
    
    setDigit(5); // all digits off to prevent uneven illumination
}

void process()
{
    for (int i = 0; i < 50; i++) //tweak this number between flicker and blur
    {
        int change = getEncoderTurn();
        if (stopped)
        {
            changeSetTime(change);
        }
        else
        {
            updateCountingTime();
        }
    }
    if (timerMinute == 0 && timerSecond == 0)
    {
        digitalWrite(buzzerPin, HIGH);
    }
}

void changeSetTime(int change) 
{
    selectedTimeIndex += change;
    if (selectedTimeIndex < 0)
    {
        selectedTimeIndex = numTimes;
    }
    else if (selectedTimeIndex > numTimes)
    {
        selectedTimeIndex = 0;
    }
    timerMinute = times[selectedTimeIndex] / 100;
    timerSecond = times[selectedTimeIndex] % 100;
}

void updateCountingTime()
{
    static unsigned long lastMillis;
    unsigned long m = millis();

    if (m > (lastMillis + 1000) && (timerSecond > 0 || timerMinute > 0))
    {
        digitalWrite(buzzerPin, HIGH);
        delay(10);
        digitalWrite(buzzerPin, LOW);
        if (timerSecond == 0)
        {
            timerSecond = 59;
            timerMinute--;
        }
        else
        {
            timerSecond--;
        }
        lastMillis = m;
    }
}


void setDigit(int digit)
{
    for (int i = 0; i < 4; i++)
    {
        digitalWrite(displayPins[i], (digit != i));  //写入0时数码管导通
    }
}

void setSegments(int n)
{
    for (int i = 0; i < 8; i++)
    {
        digitalWrite(segmentPins[i], !digits[n][i]);
    }
}

//右旋返回为1，左旋为-1,不旋为0
int getEncoderTurn()
{
     // return -1，0，or +1 
     static int oldA=LOW; 
     static int oldB=LOW; 
     int result = 0;
     int newA = digitalRead(aPin);
     //Serial.println(newA);
     int newB = digitalRead(bPin);
     Serial.println(newB);
     if (newA != oldA || newB != oldB)
     {
         // something has changed
           if(oldB == LOW && newB == HIGH){
               result = oldA*2 - 1;
          }
     }
     oldA = newA;
     oldB = newB;
     return result;
}
