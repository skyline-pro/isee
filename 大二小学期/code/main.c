#include <reg52.h>
#include <STC12C.h>
#include <intrins.h> 
#include <stdio.h>   
#include <math.h>


//变量类型标识的宏定义
#define Uchar unsigned char
#define Uint unsigned int
#define uchar unsigned char
#define uint unsigned int

#define gain 4.57718
#define DataPort P2		// 数据端口
#define Busy    0x80

//接口定义
sbit	Led1 = P1^0;
sbit	Led2 = P1^1;
sbit	Led3 = P1^2;

sbit	Key1 = P1^5;
sbit	Key2 = P1^4;
sbit	Key3 = P1^3;

// 控制引脚定义，不同的连接必须修改的部分
sbit RS=P3^2;
sbit RW=P3^3; 
sbit EN=P3^4;  

#define rs RS
#define	rw RW
#define en EN

//ADC相关变量
#define ADC_POWER   0x80            //ADC power control bit
#define ADC_FLAG    0x10            //ADC complete flag
#define ADC_START   0x08            //ADC start control bit
#define ADC_SPEEDLL 0x00            //420 clocks

/*按键相关变量*/
bit	Key1_press_flag;	//Key1按下标志
bit	Key2_press_flag;	//Key2按下标志
bit	Key3_press_flag;	//Key3按下标志

bit	Key1_back;		//按键的上一状态
bit	Key2_back;
bit	Key3_back;

//电流预设值修改显示相关
int result;
int Set[4] = {0,0,0,0};//电流预设值
int target; //选择修改位

//ADC输出控制PWM变量
Uint PWM_Ctrl = 0;
Uint Now_Current = 0;

//LCD显存
uchar	Dsp_buf[16];
uchar	Dsp_buf2[16];

//定时计数器
uint Timer_Count;	

void InitADC();
void ADC_Scan();
void Key_Scan();
void Key_treat();
void LcdWriteData( char dataW );
void LcdWriteCommand( Uchar CMD );
void Lcd_init( void );
void Disp_XY( char posx,char posy);
void DispOneChar(Uchar x,Uchar y,Uchar Wdata);
void Display (void);
void Pwm_init(void);
void Pwm_treat();
void system_init(void);
void timer0_int (void);
void Delay(uint y);

/********************延时函数************************/
//延时y ms
void	Delay(uint y)
{
	uint x;
	while (y--)
	{
		x = 1000;
		while (x--);
	}
}

/******************系统初始化**************************/
void system_init(void)
{
	//定义端口输入输出,p1^0-P1^2为推挽输出，p1^3-P1^7为输入，设置PxM0，PxM1，
	P1M0 = 0xf8;		//#11111000b
	P1M1 = 0x07;		//#00000111b
	
	//T0,模式设定
    TR0 = 0;        //停止计数
    ET0 = 1;        //允许中断
    PT0 = 1;        //高优先级中断
    TMOD = 0x01;  	//#00000,0001,16位定时模式

    TH0 = 0;
    TL0 = 0;
    TR0 = 1;    	//开始运行
	
	P1 &= ~0x07;	//清除LED
}

void timer0_int (void) interrupt 1
{
	TH0 = 0xfc;
	TL0 = 0x67;			//1ms定时中断

	Key_Scan();

	++Timer_Count;

	if ((Timer_Count & 0x3f) == 1){
		ADC_Scan();
	}

	if (Timer_Count > 500)
	{
		Timer_Count = 0;
		Pwm_treat();
	}
}


//按键相关函数

/********************* 键盘扫描函数************************/
void	Key_Scan()
{
	if (!Key1)			//开机键扫描，检测下降沿
	{
		if(Key1_back)
		{
			Key1_press_flag = 1;
		}
	}

	if (!Key2)			//开机键扫描
	{
		if(Key2_back)
		{
			Key2_press_flag = 1;
		}
	}

	if (!Key3)			//开机键扫描
	{
		if(Key3_back)
		{
			Key3_press_flag = 1;
		}
	}

	Key1_back = Key1;
	Key2_back = Key2;
	Key3_back = Key2;

}

/******************** 按键处理 **************************/
void	Key_treat()
{
	if (Key3_press_flag)
	{
		//将预设值传入PWM
		result = Set[3]*1000 + Set[2]*100 + Set[1]*10 + Set[0];
		//将按键输入结果转化为PWM控制值
		result = 255 - result/gain;
		Key3_press_flag = 0;
	}

	if (Key2_press_flag)
	{
		switch (target)
		{	
		case 0: Set[3-target] = (Set[3-target] + 1)%2;
			break;
		
		default: Set[3-target] = (Set[3-target] + 1)%10;
			break;
		}
		Key2_press_flag = 0;
	}

	if (Key1_press_flag)
	{
		target = (target+1)%4;
		Key1_press_flag = 0;
	}

}

//初始化ADC寄存器
void InitADC(){
    ADC_DATA = 0; //将ADC结果寄存器清零
    ADC_CONTR = ADC_POWER | ADC_SPEEDLL;
    Delay(2);
}

void ADC_Scan(){
    //开启ADC，通道六扫描
    ADC_CONTR = ADC_POWER | ADC_SPEEDLL | 6 | ADC_START;
	_nop_();                        //Must wait before inquiry
	_nop_();
    _nop_();
	_nop_();
	while (!(ADC_CONTR & ADC_FLAG));//Wait complete flag
	ADC_CONTR &= ~ADC_FLAG;         //Close ADC
    //将10位转换结果存入Adc_resuit变量
	Now_Current = ADC_DATA*4+(ADC_LOW2 && 0x03);

    //将电流转换为实际电流值
    Now_Current = Now_Current/0.65;
    
}

/*=======================================================
显示光标定位
=======================================================*/
void Disp_XY( char posx,char posy) 
{
uchar temp;

    temp = posx %0x40;// & 0x07;
    posy &= 0x01;
    if ( posy==1)  {temp |= 0x40;}
    temp |= 0x80;
    LcdWriteCommand(temp);
}

/*=======================================================
按指定位置显示数出一个字符
=======================================================*/
void DispOneChar(Uchar x,Uchar y,Uchar Wdata) {

    Disp_XY( x, y );                // 定位显示地址
    LcdWriteData( Wdata );            // 写字符
}

/*=======================================================
初始化程序, 必须按照产品资料介绍的初始化过程进行
=======================================================*/
void Lcd_init( void ) 
{
    LcdWriteCommand(0x38);            // 显示模式设置(以后均检测忙信号)
	Delay(2);
    LcdWriteCommand(0x0f);            // 开显示屏，管光标，光标不闪烁
	Delay(2);
    LcdWriteCommand(0x06);            // 显示地址递增
	Delay(2);
    LcdWriteCommand(0x01);            // 显示清屏
	Delay(2);
	LcdWriteCommand(0x02);	//光标
}

/*=======================================================
写控制字符子程序: E=1 RS=0 RW=0
=======================================================*/
void LcdWriteCommand(Uchar CMD)
{
    rs=0;			//选命令寄存器
    rw=0;           //写
    DataPort=CMD;	//写命令
    Delay(1);		//延时，让1602准备数据
    en=1;           //使能信号变化，写入数据
    en=0;
}

/*=======================================================
当前位置写字符子程序: E =1 RS=1 RW=0
=======================================================*/
void LcdWriteData( Uchar Data )
{
    rs=1;			//选数据寄存器
    rw=0;           //写
    DataPort=Data;	//写命令
    Delay(1);		//延时，让1602准备数据
    en=1;           //使能信号变化，写入数据
    en=0;
}

/********************显示函数**************************/
void	Display (void)
{
	int n,m =0;
    //将设定值输入显存
    sprintf(Dsp_buf,"S_Currute:%1d%1d%1d%1dmA" , Set[3] , Set[2] , Set[1] ,Set[0]);
    //将AD采样值输入显存
    sprintf(Dsp_buf2,"N_Currute:%04dmA" ,Now_Current);
	LcdWriteCommand(0x80); 
    for(m=0;m<16;m++) 
    {
		LcdWriteData(Dsp_buf[m]);
    }
    LcdWriteCommand(0x80+0x40);
    for(n=0;n<16;n++)
    {    
		LcdWriteData(Dsp_buf2[n]);
    }
}

void Pwm_init(void)
{
	CCON = 0;                       //Initial PCA control register
                                    //PCA timer stop running
                                    //Clear CF flag
                                    //Clear all module interrupt flag
    CL = 0;                         //Reset PCA base timer
    CH = 0;
    CMOD = 0x02;	//#00000010B    //Set PCA timer clock source as Fosc/2
                                    //Disable PCA timer overflow interrupt

    CCAP1H = CCAP1L = result;         //PWM1 port output 0% duty cycle square wave
    CCAPM1 = 0x42;                  //PCA module-1 work in 8-bit PWM mode and no PCA interrupt

    CR = 1;                         //PCA timer start run
}

void Pwm_treat()
{
    CCAP1H = CCAP1L = result+2;
	
}

/********************主函数**************************/
void main(void)
{
	system_init();
	Delay(100);
	Lcd_init();
	InitADC();
    Pwm_init();
	
    EA = 1;

    while (1)
    {
		Key_treat();
		Delay(50);
        Display();
		Disp_XY(target+10,0);
    }
}