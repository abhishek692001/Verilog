//8 x 16 RAM
// Design Code
module RAM8x16bit #(parameter databit=8,parameter nooflocation=16,parameter addressbit=4) (clk,rst,valid,wr_rd,add,writedata,readdata,ready);
  
  input clk,rst,valid,wr_rd;
  input [addressbit-1:0]add;
  input [databit-1:0]writedata;
  output reg [databit-1:0]readdata;
  output reg ready;
  reg [databit-1:0]memory[nooflocation];
  assign ready=valid;
  
  always@(posedge clk,negedge rst)
    begin
      if(rst)
        begin
          integer i;
          for(i=0;i<16;i=i+1)
            memory[i]<=8'b0000_0000;
        end
      if(!wr_rd)
    readdata<=memory[add];
    end
  always@(posedge clk) begin
    if(wr_rd)
    memory[add]<=writedata;
    end

endmodule


//TestBench
// Code your testbench here
// or browse Examples
module RAM8x16bit_tb();
  parameter databit=8;
  parameter nooflocation=16;
  parameter addressbit=4;
  reg clk,rst,valid,wr_rd;
  reg [addressbit-1:0]add;
  reg [databit-1:0]writedata;
  wire [databit-1:0]readdata;
  wire ready;
  
  RAM8x16bit UUT(clk,rst,valid,wr_rd,add,writedata,readdata,ready);
  
  always #10 clk=~clk;
  
  initial begin
    $monitor("Time=%0t,Writedata=%b,clk=%b,rst=%b,valid=%b,Write_read=%b,addresh=%b,readdata=%b,ready=%b",$time,writedata,clk,rst,valid,wr_rd,add,readdata,ready);
    clk=0; rst=0; valid=1; #10;
    
    for(integer i=0;i<2**addressbit;i=i+1) begin
      repeat(1) @(posedge clk)add<=i; wr_rd=1;writedata=$random;
    end
    
    for(integer i=0;i<2**addressbit;i=i+1) begin
      repeat(1) @(posedge clk)add<=i; wr_rd=0;
    end
    
    rst=1;
    for(integer i=0;i<2**addressbit;i=i+1) begin
      repeat(1) @(posedge clk)add<=i; wr_rd=0;
    end

    #10; $finish;
  end
  initial begin
    $dumpfile("wave.vcd");
    $dumpvars();
  end
  
endmodule

//Output
# KERNEL: Time=0,Writedata=xxxxxxxx,clk=0,rst=0,valid=1,Write_read=x,addresh=xxxx,readdata=xxxxxxxx,ready=1
# KERNEL: Time=10,Writedata=xxxxxxxx,clk=1,rst=0,valid=1,Write_read=x,addresh=xxxx,readdata=xxxxxxxx,ready=1
# KERNEL: Time=20,Writedata=xxxxxxxx,clk=0,rst=0,valid=1,Write_read=x,addresh=xxxx,readdata=xxxxxxxx,ready=1
# KERNEL: Time=30,Writedata=00100100,clk=1,rst=0,valid=1,Write_read=1,addresh=0000,readdata=xxxxxxxx,ready=1
# KERNEL: Time=40,Writedata=00100100,clk=0,rst=0,valid=1,Write_read=1,addresh=0000,readdata=xxxxxxxx,ready=1
# KERNEL: Time=50,Writedata=10000001,clk=1,rst=0,valid=1,Write_read=1,addresh=0001,readdata=xxxxxxxx,ready=1
# KERNEL: Time=60,Writedata=10000001,clk=0,rst=0,valid=1,Write_read=1,addresh=0001,readdata=xxxxxxxx,ready=1
# KERNEL: Time=70,Writedata=00001001,clk=1,rst=0,valid=1,Write_read=1,addresh=0010,readdata=xxxxxxxx,ready=1
# KERNEL: Time=80,Writedata=00001001,clk=0,rst=0,valid=1,Write_read=1,addresh=0010,readdata=xxxxxxxx,ready=1
# KERNEL: Time=90,Writedata=01100011,clk=1,rst=0,valid=1,Write_read=1,addresh=0011,readdata=xxxxxxxx,ready=1
# KERNEL: Time=100,Writedata=01100011,clk=0,rst=0,valid=1,Write_read=1,addresh=0011,readdata=xxxxxxxx,ready=1
# KERNEL: Time=110,Writedata=00001101,clk=1,rst=0,valid=1,Write_read=1,addresh=0100,readdata=xxxxxxxx,ready=1
# KERNEL: Time=120,Writedata=00001101,clk=0,rst=0,valid=1,Write_read=1,addresh=0100,readdata=xxxxxxxx,ready=1
# KERNEL: Time=130,Writedata=10001101,clk=1,rst=0,valid=1,Write_read=1,addresh=0101,readdata=xxxxxxxx,ready=1
# KERNEL: Time=140,Writedata=10001101,clk=0,rst=0,valid=1,Write_read=1,addresh=0101,readdata=xxxxxxxx,ready=1
# KERNEL: Time=150,Writedata=01100101,clk=1,rst=0,valid=1,Write_read=1,addresh=0110,readdata=xxxxxxxx,ready=1
# KERNEL: Time=160,Writedata=01100101,clk=0,rst=0,valid=1,Write_read=1,addresh=0110,readdata=xxxxxxxx,ready=1
# KERNEL: Time=170,Writedata=00010010,clk=1,rst=0,valid=1,Write_read=1,addresh=0111,readdata=xxxxxxxx,ready=1
# KERNEL: Time=180,Writedata=00010010,clk=0,rst=0,valid=1,Write_read=1,addresh=0111,readdata=xxxxxxxx,ready=1
# KERNEL: Time=190,Writedata=00000001,clk=1,rst=0,valid=1,Write_read=1,addresh=1000,readdata=xxxxxxxx,ready=1
# KERNEL: Time=200,Writedata=00000001,clk=0,rst=0,valid=1,Write_read=1,addresh=1000,readdata=xxxxxxxx,ready=1
# KERNEL: Time=210,Writedata=00001101,clk=1,rst=0,valid=1,Write_read=1,addresh=1001,readdata=xxxxxxxx,ready=1
# KERNEL: Time=220,Writedata=00001101,clk=0,rst=0,valid=1,Write_read=1,addresh=1001,readdata=xxxxxxxx,ready=1
# KERNEL: Time=230,Writedata=01110110,clk=1,rst=0,valid=1,Write_read=1,addresh=1010,readdata=xxxxxxxx,ready=1
# KERNEL: Time=240,Writedata=01110110,clk=0,rst=0,valid=1,Write_read=1,addresh=1010,readdata=xxxxxxxx,ready=1
# KERNEL: Time=250,Writedata=00111101,clk=1,rst=0,valid=1,Write_read=1,addresh=1011,readdata=xxxxxxxx,ready=1
# KERNEL: Time=260,Writedata=00111101,clk=0,rst=0,valid=1,Write_read=1,addresh=1011,readdata=xxxxxxxx,ready=1
# KERNEL: Time=270,Writedata=11101101,clk=1,rst=0,valid=1,Write_read=1,addresh=1100,readdata=xxxxxxxx,ready=1
# KERNEL: Time=280,Writedata=11101101,clk=0,rst=0,valid=1,Write_read=1,addresh=1100,readdata=xxxxxxxx,ready=1
# KERNEL: Time=290,Writedata=10001100,clk=1,rst=0,valid=1,Write_read=1,addresh=1101,readdata=xxxxxxxx,ready=1
# KERNEL: Time=300,Writedata=10001100,clk=0,rst=0,valid=1,Write_read=1,addresh=1101,readdata=xxxxxxxx,ready=1
# KERNEL: Time=310,Writedata=11111001,clk=1,rst=0,valid=1,Write_read=1,addresh=1110,readdata=xxxxxxxx,ready=1
# KERNEL: Time=320,Writedata=11111001,clk=0,rst=0,valid=1,Write_read=1,addresh=1110,readdata=xxxxxxxx,ready=1
# KERNEL: Time=330,Writedata=11000110,clk=1,rst=0,valid=1,Write_read=1,addresh=1111,readdata=xxxxxxxx,ready=1
# KERNEL: Time=340,Writedata=11000110,clk=0,rst=0,valid=1,Write_read=1,addresh=1111,readdata=xxxxxxxx,ready=1
# KERNEL: Time=350,Writedata=11000110,clk=1,rst=0,valid=1,Write_read=0,addresh=0000,readdata=xxxxxxxx,ready=1
# KERNEL: Time=360,Writedata=11000110,clk=0,rst=0,valid=1,Write_read=0,addresh=0000,readdata=xxxxxxxx,ready=1
# KERNEL: Time=370,Writedata=11000110,clk=1,rst=0,valid=1,Write_read=0,addresh=0001,readdata=00100100,ready=1
# KERNEL: Time=380,Writedata=11000110,clk=0,rst=0,valid=1,Write_read=0,addresh=0001,readdata=00100100,ready=1
# KERNEL: Time=390,Writedata=11000110,clk=1,rst=0,valid=1,Write_read=0,addresh=0010,readdata=10000001,ready=1
# KERNEL: Time=400,Writedata=11000110,clk=0,rst=0,valid=1,Write_read=0,addresh=0010,readdata=10000001,ready=1
# KERNEL: Time=410,Writedata=11000110,clk=1,rst=0,valid=1,Write_read=0,addresh=0011,readdata=00001001,ready=1
# KERNEL: Time=420,Writedata=11000110,clk=0,rst=0,valid=1,Write_read=0,addresh=0011,readdata=00001001,ready=1
# KERNEL: Time=430,Writedata=11000110,clk=1,rst=0,valid=1,Write_read=0,addresh=0100,readdata=01100011,ready=1
# KERNEL: Time=440,Writedata=11000110,clk=0,rst=0,valid=1,Write_read=0,addresh=0100,readdata=01100011,ready=1
# KERNEL: Time=450,Writedata=11000110,clk=1,rst=0,valid=1,Write_read=0,addresh=0101,readdata=00001101,ready=1
# KERNEL: Time=460,Writedata=11000110,clk=0,rst=0,valid=1,Write_read=0,addresh=0101,readdata=00001101,ready=1
# KERNEL: Time=470,Writedata=11000110,clk=1,rst=0,valid=1,Write_read=0,addresh=0110,readdata=10001101,ready=1
# KERNEL: Time=480,Writedata=11000110,clk=0,rst=0,valid=1,Write_read=0,addresh=0110,readdata=10001101,ready=1
# KERNEL: Time=490,Writedata=11000110,clk=1,rst=0,valid=1,Write_read=0,addresh=0111,readdata=01100101,ready=1
# KERNEL: Time=500,Writedata=11000110,clk=0,rst=0,valid=1,Write_read=0,addresh=0111,readdata=01100101,ready=1
# KERNEL: Time=510,Writedata=11000110,clk=1,rst=0,valid=1,Write_read=0,addresh=1000,readdata=00010010,ready=1
# KERNEL: Time=520,Writedata=11000110,clk=0,rst=0,valid=1,Write_read=0,addresh=1000,readdata=00010010,ready=1
# KERNEL: Time=530,Writedata=11000110,clk=1,rst=0,valid=1,Write_read=0,addresh=1001,readdata=00000001,ready=1
# KERNEL: Time=540,Writedata=11000110,clk=0,rst=0,valid=1,Write_read=0,addresh=1001,readdata=00000001,ready=1
# KERNEL: Time=550,Writedata=11000110,clk=1,rst=0,valid=1,Write_read=0,addresh=1010,readdata=00001101,ready=1
# KERNEL: Time=560,Writedata=11000110,clk=0,rst=0,valid=1,Write_read=0,addresh=1010,readdata=00001101,ready=1
# KERNEL: Time=570,Writedata=11000110,clk=1,rst=0,valid=1,Write_read=0,addresh=1011,readdata=01110110,ready=1
# KERNEL: Time=580,Writedata=11000110,clk=0,rst=0,valid=1,Write_read=0,addresh=1011,readdata=01110110,ready=1
# KERNEL: Time=590,Writedata=11000110,clk=1,rst=0,valid=1,Write_read=0,addresh=1100,readdata=00111101,ready=1
# KERNEL: Time=600,Writedata=11000110,clk=0,rst=0,valid=1,Write_read=0,addresh=1100,readdata=00111101,ready=1
# KERNEL: Time=610,Writedata=11000110,clk=1,rst=0,valid=1,Write_read=0,addresh=1101,readdata=11101101,ready=1
# KERNEL: Time=620,Writedata=11000110,clk=0,rst=0,valid=1,Write_read=0,addresh=1101,readdata=11101101,ready=1
# KERNEL: Time=630,Writedata=11000110,clk=1,rst=0,valid=1,Write_read=0,addresh=1110,readdata=10001100,ready=1
# KERNEL: Time=640,Writedata=11000110,clk=0,rst=0,valid=1,Write_read=0,addresh=1110,readdata=10001100,ready=1
# KERNEL: Time=650,Writedata=11000110,clk=1,rst=1,valid=1,Write_read=0,addresh=1111,readdata=11111001,ready=1
# KERNEL: Time=660,Writedata=11000110,clk=0,rst=1,valid=1,Write_read=0,addresh=1111,readdata=11111001,ready=1
# KERNEL: Time=670,Writedata=11000110,clk=1,rst=1,valid=1,Write_read=0,addresh=0000,readdata=11000110,ready=1
# KERNEL: Time=680,Writedata=11000110,clk=0,rst=1,valid=1,Write_read=0,addresh=0000,readdata=11000110,ready=1
# KERNEL: Time=690,Writedata=11000110,clk=1,rst=1,valid=1,Write_read=0,addresh=0001,readdata=00000000,ready=1
# KERNEL: Time=700,Writedata=11000110,clk=0,rst=1,valid=1,Write_read=0,addresh=0001,readdata=00000000,ready=1
# KERNEL: Time=710,Writedata=11000110,clk=1,rst=1,valid=1,Write_read=0,addresh=0010,readdata=00000000,ready=1
# KERNEL: Time=720,Writedata=11000110,clk=0,rst=1,valid=1,Write_read=0,addresh=0010,readdata=00000000,ready=1
# KERNEL: Time=730,Writedata=11000110,clk=1,rst=1,valid=1,Write_read=0,addresh=0011,readdata=00000000,ready=1
# KERNEL: Time=740,Writedata=11000110,clk=0,rst=1,valid=1,Write_read=0,addresh=0011,readdata=00000000,ready=1
# KERNEL: Time=750,Writedata=11000110,clk=1,rst=1,valid=1,Write_read=0,addresh=0100,readdata=00000000,ready=1
# KERNEL: Time=760,Writedata=11000110,clk=0,rst=1,valid=1,Write_read=0,addresh=0100,readdata=00000000,ready=1
# KERNEL: Time=770,Writedata=11000110,clk=1,rst=1,valid=1,Write_read=0,addresh=0101,readdata=00000000,ready=1
# KERNEL: Time=780,Writedata=11000110,clk=0,rst=1,valid=1,Write_read=0,addresh=0101,readdata=00000000,ready=1
# KERNEL: Time=790,Writedata=11000110,clk=1,rst=1,valid=1,Write_read=0,addresh=0110,readdata=00000000,ready=1
# KERNEL: Time=800,Writedata=11000110,clk=0,rst=1,valid=1,Write_read=0,addresh=0110,readdata=00000000,ready=1
# KERNEL: Time=810,Writedata=11000110,clk=1,rst=1,valid=1,Write_read=0,addresh=0111,readdata=00000000,ready=1
# KERNEL: Time=820,Writedata=11000110,clk=0,rst=1,valid=1,Write_read=0,addresh=0111,readdata=00000000,ready=1
# KERNEL: Time=830,Writedata=11000110,clk=1,rst=1,valid=1,Write_read=0,addresh=1000,readdata=00000000,ready=1
# KERNEL: Time=840,Writedata=11000110,clk=0,rst=1,valid=1,Write_read=0,addresh=1000,readdata=00000000,ready=1
# KERNEL: Time=850,Writedata=11000110,clk=1,rst=1,valid=1,Write_read=0,addresh=1001,readdata=00000000,ready=1
# KERNEL: Time=860,Writedata=11000110,clk=0,rst=1,valid=1,Write_read=0,addresh=1001,readdata=00000000,ready=1
# KERNEL: Time=870,Writedata=11000110,clk=1,rst=1,valid=1,Write_read=0,addresh=1010,readdata=00000000,ready=1
# KERNEL: Time=880,Writedata=11000110,clk=0,rst=1,valid=1,Write_read=0,addresh=1010,readdata=00000000,ready=1
# KERNEL: Time=890,Writedata=11000110,clk=1,rst=1,valid=1,Write_read=0,addresh=1011,readdata=00000000,ready=1
# KERNEL: Time=900,Writedata=11000110,clk=0,rst=1,valid=1,Write_read=0,addresh=1011,readdata=00000000,ready=1
# KERNEL: Time=910,Writedata=11000110,clk=1,rst=1,valid=1,Write_read=0,addresh=1100,readdata=00000000,ready=1
# KERNEL: Time=920,Writedata=11000110,clk=0,rst=1,valid=1,Write_read=0,addresh=1100,readdata=00000000,ready=1
# KERNEL: Time=930,Writedata=11000110,clk=1,rst=1,valid=1,Write_read=0,addresh=1101,readdata=00000000,ready=1
# KERNEL: Time=940,Writedata=11000110,clk=0,rst=1,valid=1,Write_read=0,addresh=1101,readdata=00000000,ready=1
# KERNEL: Time=950,Writedata=11000110,clk=1,rst=1,valid=1,Write_read=0,addresh=1110,readdata=00000000,ready=1
# KERNEL: Time=960,Writedata=11000110,clk=0,rst=1,valid=1,Write_read=0,addresh=1110,readdata=00000000,ready=1
# KERNEL: Time=970,Writedata=11000110,clk=1,rst=1,valid=1,Write_read=0,addresh=1111,readdata=00000000,ready=1
# RUNTIME: Info: RUNTIME_0068 testbench.sv (41): $finish called.
# KERNEL: Time: 980 ns,  Iteration: 0,  Instance: /RAM8x16bit_tb,  Process: @INITIAL#17_2@.
# KERNEL: stopped at time: 980 ns
