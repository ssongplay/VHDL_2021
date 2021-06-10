# State Machine


State machine(상태 머신)이란, 순차 회로를 정의하는 디지털 시스템이다.  
State Machine은 Mearly Machine과 Moore Machine 으로 나뉜다. 
 - *Mearly Machine* : 출력이 현재 상태 및 현재 입력에 따라 결정됨
 - *Moore Machine* : 출력이 현재 상태만으로 결정됨  
 상태를 천이시키는 순차논리 회로와 출력을 결정하는 조합논리 회로로 구성된다. 목표로 하는 회로의 운용/동작 순서를 정의하여 효율적인 동작을 할 수 있도록 구성하는데 효과적인 설계
방식이다.
**Case** 구문을 이용해 상태 머신을 설계할 수 있다.
 <br>
 
 ## [BCD Counter](https://github.com/ssongplay/VHDL_2021/blob/4a2cf5682adcdf88224a0839177810340c9a70fc/week10/BCD_counter.vhd) 설계  
 ![image](https://user-images.githubusercontent.com/72501562/121523617-5e588580-ca31-11eb-98cd-9571aedda609.png)  
BCD Counter는 Binary-Coded Decimal Counter의 약자로, Counter가 아닌 상태 머신에 의한 이진화 십진 카운터의 설계를 하도록 한다. 
 
**시뮬레이션 결과**   

![image](https://user-images.githubusercontent.com/72501562/121525781-b6908700-ca33-11eb-9f7f-81674ac3e560.png)

<br>

## [Gray Code Counter](https://github.com/ssongplay/VHDL_2021/blob/4a2cf5682adcdf88224a0839177810340c9a70fc/week10/GrayCode_counter.vhd) 설계  
두 개 이상의 비트가 동시에 변할 경우, 글리치(미세한 값의 튐 현상)이 발생한다.  
이러한 현상을 방지하기 위해, Gray Code Counter를 사용할 수 있다.   

![image](https://user-images.githubusercontent.com/72501562/121530279-3ddff980-ca38-11eb-9513-fdb38df95578.png)  

Gray Code Counter는 카운터 비트열 중 하나의 비트만 변화한다. 
BCD Counter와 비슷하게 코드를 작성하여 구현할 수 있다. state가 zero~seven 까지만 있다는 점과, 각 state마다 q로 출력되는 값이 한 비트만 변한다는 점만 다르다.  

**시뮬레이션 결과**  

![image](https://user-images.githubusercontent.com/72501562/121530677-9d3e0980-ca38-11eb-9950-0b0b25f4540d.png)  

출력 q에서 각 비트가 하나씩만 변하는 것을 볼 수 있다.

<br>

## [Dual Counter](https://github.com/ssongplay/VHDL_2021/blob/4a2cf5682adcdf88224a0839177810340c9a70fc/week10/Dual_counter.vhd) 설계  

![image](https://user-images.githubusercontent.com/72501562/121530827-c9f22100-ca38-11eb-9c88-3d4f84999512.png)  

하나의 출력 포트로 0\~9 (10진), 0\~15(16진) 값을 출력하는 Dual Counter를 설계한다.  
sw_a = ‘1’ 이 입력되면 0\~9를 출력하고, sw_b = ‘1’ 이 입력되면 0\~15를 출력한다.  

**코드 설명**

- line 23\~25
  + nRst = ‘0’ 일 때에는 IDLE 상태 (sw_a나 sw_b를 기다림)
- line 28\~36  ➡ IDLE
  + sw_a 가 ‘1’이 되면 SATE_A가 된다. (if문이 먼저 쓰였으므로 우선순위는 sw_a가 더 높음)
  + sw_a 가 ‘1’이 아니고, sw_b가 ‘1’이 되면 STATE_B가 된다. 
  + sw_a, sw_b 모두 ‘1’이 아니면 IDLE 상태를 유지한다. 
- line 37\~44  ➡ STATE_A 
  + cnt가 9이면 0으로 초기화 하고 IDLE 상태로 돌아간다
  + cnt가 9가 아니면 cnt값을 1 증가시키고 계속 STATE_A를 유지한다.
- line 45\~52  ➡ STATE_B
  + cnt가 15이면 0으로 초기화 하고 IDLE 상태로 돌아간다
  + cnt가 15가 아니면 cnt값을 1 증가시키고 계속 STATE_B를 유지한다.
- line 53\~54 
  + others인 경우에는 IDLE이다.


**시뮬레이션 결과**  

![image](https://user-images.githubusercontent.com/72501562/121531476-64526480-ca39-11eb-8bfb-d5ae354affca.png)  

sw_a가 1인 경우 cnt 값이 0\~9 까지 변한다. (STATE_A)  
sw_b가 1인 경우 cnt 값이 0\~15까지 변한다. (STATE_B)

![image](https://user-images.githubusercontent.com/72501562/121532401-42a5ad00-ca3a-11eb-97e8-fbaf5f323a69.png)  

sw_a와 sw_b가 동시에 1인 경우, line 28\~36에서 작성했듯이 STATE_A가 됨을 확인할 수 있다.

![image](https://user-images.githubusercontent.com/72501562/121532498-5b15c780-ca3a-11eb-8140-f0e047ce429c.png)  

sw_b가 1이 되어 STATE_B인 도중에 sw_a가 1이 되어도 계속 STATE_B 를 유지하는 것을 확인할 수 있다.  
line 45\~52 에서 STATE_B일 때 sw_a에 대한 조건 코드는 작성하지 않았으므로 무시하는 것이다.  

<br>

## [횡단보도 제어기](https://github.com/ssongplay/VHDL_2021/blob/4a2cf5682adcdf88224a0839177810340c9a70fc/week10/CrossWalk_controller.vhd) 설계  

![image](https://user-images.githubusercontent.com/72501562/121533127-f0b15700-ca3a-11eb-9c46-96c50a4d69cd.png)  

위에서 다룬 것들을 바탕으로 횡단보도 제어기를 설계해보도록 한다. 횡단보도 제어 시스템은  
1️⃣ **사람 통행 30초 후 점멸 10초**  
2️⃣ **차량 통행 60초 후 황색등 5초**  
총 105초 동작 후 반복하도록 설계한다.  
이때, 외부에서 1초시그널이 들어온다고 가정하고 작성한다. (cnt가 1 증가할 때마다 1초 증가한 것이라고 가정)   


**시뮬레이션 결과**  

1) 전체  

![image](https://user-images.githubusercontent.com/72501562/121533282-1b031480-ca3b-11eb-94c0-32481f5da685.png)  

MAN_GO, MAN_STOP, CAR_GO, CAR_STOP 이 계속 반복되는 것을 확인할 수 있다.  

2) MAN_GO, MAN_STOP 부분 확대  
 
![image](https://user-images.githubusercontent.com/72501562/121533424-3a9a3d00-ca3b-11eb-8683-f9abd202f71a.png)  

3) CAR_GO, CAR_STOP 부분 확대  
  
![image](https://user-images.githubusercontent.com/72501562/121533485-4b4ab300-ca3b-11eb-9698-bb9664e0dd8b.png)  

<br>

## [ADC 제어기](https://github.com/ssongplay/VHDL_2021/blob/4a2cf5682adcdf88224a0839177810340c9a70fc/week10/ADC_controller.vhd) 설계  

ADC(Analog -> Digital Converter) 제어기  

![image](https://user-images.githubusercontent.com/72501562/121533856-a54b7880-ca3b-11eb-942c-5ebc6a7f602a.png)  

![image](https://user-images.githubusercontent.com/72501562/121533782-9369d580-ca3b-11eb-826b-c1eb81878315.png)  


1️⃣ MCU에서 *trigger* 발생 → 제어기에서 ADC로 *Start-convert* 신호 전송 → ADC는 샘플링 시작  
2️⃣ 샘플링이 끝난 ADC는 *Data-Ready* 신호를 제어기로 전송  
3️⃣ Data-Ready 신호를 받은 제어기는 *Output Enable* 신호를 ADC로 보내 ADC가 Data를 MCU로 전송하도록 제어   

**시뮬레이션 결과**  

![image](https://user-images.githubusercontent.com/72501562/121534116-e2176f80-ca3b-11eb-90a8-bdb6641541d6.png)  

<br>

> **실습 소감**  
>  이번 실습을 통해 상태 머신을 공부한 후 스스로 구현해볼 수 있었고, case문을 이해할 수 있었다. 특히 Dual Counter 코드를 응용하여 횡단보도 제어기를 직접 설계해 보면서, 논리적으로 생각하는 능력을 기를 수 있었던 것 같다. 처음에 MAN_STOP state에서 M_G을 BLINK 하는 것을 어떻게 구현할 지 고민을 많이 했는데, clk를 출력함으로써 해결할 수 있었다. 또한 ADC 제어기에 대한 개념도 새롭게 알게 되었고 vhdl 코드로 구현해 보는 좋은 기회가 되었다.  




