# Simple μ_Processor	

이번 실습의 목표는 4개의 연산을 수행하는 간단한 마이크로프로세서를 설계하는 것이다.	

구조는 다음과 같다.	

![image](https://user-images.githubusercontent.com/72501562/121549839-2bba8700-ca49-11eb-9f19-b3a0d666d8d6.png)	

- *Program Counter* : 명령어 인출을 위한 프로그램 카운터	
- *Program Memory* : 명령어를 저장하고 있는 메모리	
- *Instruction Decoder* : 프로그램 중 명령어를 해석하고 필요한 제어신호를 생성하는 명령어 해석기	
- *Register 1\~4* : 소스 데이터 및 연산 결과를 저장하기 위한 레지스터	
- *Arithmetic and Logic Unit (ALU)* : 연산기	
- *Decoder* : Register 입력 선택기	 
- *MUX_A, MUX_B* : ALU 입력 MUX	

 이번 실습에서는 Program Counter, Program Memory, Register, Decoder, MUX, ALU 를 각각 설계하고, Top Entity로 Simple μ_Processor를 설계한다.	
 
<br>

# [Program Counter](https://github.com/ssongplay/VHDL_2021/blob/c00484c08a5d83439d086269beeca28c0a27ea28/week11-12/program_counter.vhd)	

Program Counter (PC)란, 다음에 실행할 명령어의 주소를 기억하고 있는 중앙처리장치(CPU)의 레지스터 중 하나이다. 메모리에 있는 명령어들을 주기에 따라 순차적으로 실행될 수 있게 한다.	
Program ROM의 명령어를 읽어 오기 위한 PC를 설계했다.	
PC의 VHDL 코드는 그동안 만들었던 counter의 코드와 거의 동일하다. nRst가 ‘0’일 때에는 출력이 0이고, 클럭이 상승 엣지일 때에는 cnt 값이 하나씩 증가하며 출력된다.	

**시뮬레이션 결과**	

![image](https://user-images.githubusercontent.com/72501562/121559322-73451100-ca51-11eb-8fa6-284460178808.png)	

 nRst = ‘1’이고 clk가 rising edge일 때 address_bus의 출력 값이 1씩 증가한다.	
 
 <br>
 
 # [Program Memory](https://github.com/ssongplay/VHDL_2021/blob/c00484c08a5d83439d086269beeca28c0a27ea28/week11-12/program_memory.vhd)	
 
 Program Memory에는 Processor의 기능 확인을 위한 명령어가 내장되어 있다. 이때 명령어는 어셈블리어 명령어이다. 이 명령어는 프로그램 메모리의 명령어 구조에 따라서 8비트의 2진수로 구성된다. 이번 실습에서 사용하는 프로그램 메모리의 명령어 구조는 다음과 같다.	
 
 ![image](https://user-images.githubusercontent.com/72501562/121552208-3d9d2980-ca4b-11eb-9548-c7af9cb6d47b.png)	
 

 **시뮬레이션 결과**	
 
 ![image](https://user-images.githubusercontent.com/72501562/121559449-86f07780-ca51-11eb-92fe-6eac8d0ec3c4.png)
 
 작성한 VHDL 코드대로 20개의 명령어가 순서대로 data_bus로 출력된다.	

<br>

# [Register](https://github.com/ssongplay/VHDL_2021/blob/c00484c08a5d83439d086269beeca28c0a27ea28/week11-12/reg_Latch.vhd)	

 레지스터란, 특정 목적으로 외부의 정보를 일시적으로 기억하는 소규모 데이터 기억장치이다. 데이터를 읽고 쓰는 기능이 매우 빠르며, CPU안에 사용된다.	
 이번 실습에서는 입력 Load = ‘1’ 구간에서 클럭의 하강에지에 in_data를 출력 Q로 전달하는 reg_Latch를 설계한다.	
 
 **시뮬레이션 결과**	
 
![image](https://user-images.githubusercontent.com/72501562/121559585-abe4ea80-ca51-11eb-9e11-5465340524d8.png)	
 
 in_data의 입력에 랜덤 값을 주고, load = ‘1’ 인 구간에서 클럭이 하강 에지일 때 q에 in_data의 값이 출력되는 것을 확인할 수 있다.	
 
 <br>
 
 # [Decoder 2x4](https://github.com/ssongplay/VHDL_2021/blob/c00484c08a5d83439d086269beeca28c0a27ea28/week11-12/decoder_2x4.vhd)	
  μ_Processor의 Register 데이터 저장을 위한 2x4 Decoder를 설계한다. 진리표는 다음과 같다.	
	
![image](https://user-images.githubusercontent.com/72501562/121554188-e435fa00-ca4c-11eb-8e14-f1dce2da0e05.png)	

**시뮬레이션 결과**	

![image](https://user-images.githubusercontent.com/72501562/121559081-3bd66480-ca51-11eb-904f-7ea2c2700ed6.png)

SEL이 0, 1, 2, 3 일 때, 각각 A, B, C, D 출력이 1이 되는 것을 볼 수 있다.	

<br>

# [IR Decoder](https://github.com/ssongplay/VHDL_2021/blob/c00484c08a5d83439d086269beeca28c0a27ea28/week11-12/IR_Decoder.vhd)	
**시뮬레이션 결과**	

![image](https://user-images.githubusercontent.com/72501562/121554833-7211e500-ca4d-11eb-8e2b-808f127f747f.png)	

적색 박스 친 부분을 확인해보면, data_bus의 6,7번째 비트가 “11”일 때, ALU_OP이므로 SELA = “00”, SELB = “01”, SELD = “11”, ALU_OP = “11”, BUS_Sel = ‘1’ 이 출력되었다. 작성한 VHDL 코드대로 결과가 잘 나온 것을 확인할 수 있다.	

<br>

# [MUX 4x1](https://github.com/ssongplay/VHDL_2021/blob/c00484c08a5d83439d086269beeca28c0a27ea28/week11-12/mux_4x1.vhd)	

Register 1~4로부터 ALU로 데이터를 전달하기 위한 4x1 MUX를 설계한다.	

![image](https://user-images.githubusercontent.com/72501562/121558418-a20eb780-ca50-11eb-8ddd-5016a1cc5c71.png)	

**시뮬레이션 결과**	

![image](https://user-images.githubusercontent.com/72501562/121558504-b5ba1e00-ca50-11eb-9161-cab3287e983a.png)	

SEL의 값이 0, 1, 2, 3 일 때, 각각 reg1, reg2, reg3, reg4의 값을 Q에 출력한다.	

<br>

# [MUX 2x1](https://github.com/ssongplay/VHDL_2021/blob/c00484c08a5d83439d086269beeca28c0a27ea28/week11-12/mux_2x1.vhd)	

Program Memory와 ALU 연산결과를 Data Bus에 올려놓기 위한 MUX를 설계한다.	

![image](https://user-images.githubusercontent.com/72501562/121559819-e8184b00-ca51-11eb-940f-a173b0337871.png)	

**시뮬레이션 결과**	

![image](https://user-images.githubusercontent.com/72501562/121559896-f9615780-ca51-11eb-83e0-bf2576a9721c.png)	

SEL의 값이 0, 1일 때 각각 A, B 값이 Q로 출력되는 것을 확인할 수 있다.

<br>

# [ALU](https://github.com/ssongplay/VHDL_2021/blob/c00484c08a5d83439d086269beeca28c0a27ea28/week11-12/ALU.vhd)	
ALU(Arithmetic and Logic Unit)는 산술연산, 논리연산, 시프트를 수행하는 CPU 내부의 회로 장치이다. 독립적으로 데이터 처리를 수행하지 못하고 레지스터들과 조합하여 처리한다.	 
이번 실습에서는 ADD, SUB, AND, OR의 4가지 연산을 수행하도록 한다.	

![image](https://user-images.githubusercontent.com/72501562/121560418-7260af00-ca52-11eb-95c9-3282b94560fd.png)	

**시뮬레이션 결과**	

1) ADD, SUB	

![image](https://user-images.githubusercontent.com/72501562/121560629-ad62e280-ca52-11eb-982b-babf953aa451.png)

3) AND, OR	

![image](https://user-images.githubusercontent.com/72501562/121560694-bc499500-ca52-11eb-9402-b94e7af78c49.png)	

<br>

# Simple μ_Processor	아
**Schematic Design**	

![image](https://user-images.githubusercontent.com/72501562/121561040-12b6d380-ca53-11eb-8eaf-7b86c9b30c40.png)	

**시뮬레이션 결과**	

1) 전체 시뮬레이션 결과	

![image](https://user-images.githubusercontent.com/72501562/121561142-2bbf8480-ca53-11eb-92f1-8ad9d4800c21.png)	

2) ADD 연산 시뮬레이션 결과 

![image](https://user-images.githubusercontent.com/72501562/121561926-eb143b00-ca53-11eb-87b1-7f7ec60bbf22.png)	

	명령어, 데이터, ALU_OP 의 값에 따라서 10 + 5 = 15 의 연산이 수행되었다.	

3) SUB 연산 시뮬레이션 결과	

![image](https://user-images.githubusercontent.com/72501562/121561989-fbc4b100-ca53-11eb-85c2-02e036eeea45.png)	

	명령어, 데이터, ALU_OP 의 값에 따라서 13 – 10 = 3 의 연산이 수행되었다.	

4) AND 연산 시뮬레이션 결과	

![image](https://user-images.githubusercontent.com/72501562/121562091-139c3500-ca54-11eb-8ce9-6d532cadd980.png)	

	명령어, 데이터, ALU_OP 의 값에 따라서 00001111 & 00000011 = 00000011 의 연산이 수행되었다.	

5) OR 연산 시뮬레이션 결과	

![image](https://user-images.githubusercontent.com/72501562/121562151-23b41480-ca54-11eb-9e2f-30b23a846155.png)	

	명령어, 데이터, ALU_OP 의 값에 따라서 00000011 | 00001100 = 00001111 의 연산이 수행되었다.		
<br>
>**실습 소감**	
>
>4개의 연산을 수행하는 간단한 마이크로프로세서 설계 실습을 통해 임베디드시스템구조론에서 배웠던 내용들을 복습함과 동시에 VHDL과 연계해볼 수 있었다. 2주차에 걸쳐서 한 실습이었기에 설계할 요소들이 많았고 Top Design을 하는 데에 많은 시간이 소요되었는데, 그만큼 각각의 요소들이 어떤 관계를 이루고 있는지 깊이 이해해보면서 논리적으로 생각하는 힘을 기를 수 있었다.













