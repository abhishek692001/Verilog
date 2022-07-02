//8 x 16 RAM
// Design Code
module RAM8x16bit(clk,rst,valid,wr_rd,add,writedata,readdata,ready);
  input clk,rst,valid,wr_rd;
  input [3:0]add;
  input [7:0]writedata;
  output reg [7:0]readdata;
  output reg ready;
  reg [7:0]memory[16];
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
  reg clk,rst,valid,wr_rd;
  reg [3:0]add;
  reg [7:0]writedata;
  wire [7:0]readdata;
  wire ready;
  
  RAM8x16bit UUT(clk,rst,valid,wr_rd,add,writedata,readdata,ready);
  
  always #5 clk=~clk;
  
  initial begin
    $monitor("Time=%0t,Writedata=%b,clk=%b,rst=%b,valid=%b,Write_read=%b,addresh=%b,readdata=%b,ready=%b",$time,writedata,clk,rst,valid,wr_rd,add,readdata,ready);
    clk=0; rst=0; valid=1; #10;
    writedata=8'b0000_0010; add=4'b0001; wr_rd=1; #10;
    add=4'b0001; wr_rd=0; #10;
   writedata=8'b0010_0010;  add=4'b0011; wr_rd=1; #10;
    add=4'b0011; wr_rd=0; #10;
    writedata=8'b0000_0010; add=4'b0001; wr_rd=1; #10;
    add=4'b0001; wr_rd=0; #10;
    
    rst=1;
    add=4'b0001; wr_rd=0; #10;
    add=4'b0010; wr_rd=0; #10;
    add=4'b0100; wr_rd=0; #10;
    add=4'b1000; wr_rd=0; #10;
 
    #10; $finish;
  end
  initial begin
    $dumpfile("wave.vcd");
    $dumpvars();
  end
  
endmodule

//Output
# KERNEL: Time=0,Writedata=xxxxxxxx,clk=0,rst=0,valid=1,Write_read=x,addresh=xxxx,readdata=xxxxxxxx,ready=1
# KERNEL: Time=5,Writedata=xxxxxxxx,clk=1,rst=0,valid=1,Write_read=x,addresh=xxxx,readdata=xxxxxxxx,ready=1
# KERNEL: Time=10,Writedata=00000010,clk=0,rst=0,valid=1,Write_read=1,addresh=0001,readdata=xxxxxxxx,ready=1
# KERNEL: Time=15,Writedata=00000010,clk=1,rst=0,valid=1,Write_read=1,addresh=0001,readdata=xxxxxxxx,ready=1
# KERNEL: Time=20,Writedata=00000010,clk=0,rst=0,valid=1,Write_read=0,addresh=0001,readdata=xxxxxxxx,ready=1
# KERNEL: Time=25,Writedata=00000010,clk=1,rst=0,valid=1,Write_read=0,addresh=0001,readdata=00000010,ready=1
# KERNEL: Time=30,Writedata=00100010,clk=0,rst=0,valid=1,Write_read=1,addresh=0011,readdata=00000010,ready=1
# KERNEL: Time=35,Writedata=00100010,clk=1,rst=0,valid=1,Write_read=1,addresh=0011,readdata=00000010,ready=1
# KERNEL: Time=40,Writedata=00100010,clk=0,rst=0,valid=1,Write_read=0,addresh=0011,readdata=00000010,ready=1
# KERNEL: Time=45,Writedata=00100010,clk=1,rst=0,valid=1,Write_read=0,addresh=0011,readdata=00100010,ready=1
# KERNEL: Time=50,Writedata=00000010,clk=0,rst=0,valid=1,Write_read=1,addresh=0001,readdata=00100010,ready=1
# KERNEL: Time=55,Writedata=00000010,clk=1,rst=0,valid=1,Write_read=1,addresh=0001,readdata=00100010,ready=1
# KERNEL: Time=60,Writedata=00000010,clk=0,rst=0,valid=1,Write_read=0,addresh=0001,readdata=00100010,ready=1
# KERNEL: Time=65,Writedata=00000010,clk=1,rst=0,valid=1,Write_read=0,addresh=0001,readdata=00000010,ready=1
# KERNEL: Time=70,Writedata=00000010,clk=0,rst=1,valid=1,Write_read=0,addresh=0001,readdata=00000010,ready=1
# KERNEL: Time=75,Writedata=00000010,clk=1,rst=1,valid=1,Write_read=0,addresh=0001,readdata=00000010,ready=1
# KERNEL: Time=80,Writedata=00000010,clk=0,rst=1,valid=1,Write_read=0,addresh=0010,readdata=00000010,ready=1
# KERNEL: Time=85,Writedata=00000010,clk=1,rst=1,valid=1,Write_read=0,addresh=0010,readdata=00000000,ready=1
# KERNEL: Time=90,Writedata=00000010,clk=0,rst=1,valid=1,Write_read=0,addresh=0100,readdata=00000000,ready=1
# KERNEL: Time=95,Writedata=00000010,clk=1,rst=1,valid=1,Write_read=0,addresh=0100,readdata=00000000,ready=1
# KERNEL: Time=100,Writedata=00000010,clk=0,rst=1,valid=1,Write_read=0,addresh=1000,readdata=00000000,ready=1
# KERNEL: Time=105,Writedata=00000010,clk=1,rst=1,valid=1,Write_read=0,addresh=1000,readdata=00000000,ready=1
# KERNEL: Time=110,Writedata=00000010,clk=0,rst=1,valid=1,Write_read=0,addresh=1000,readdata=00000000,ready=1
# KERNEL: Time=115,Writedata=00000010,clk=1,rst=1,valid=1,Write_read=0,addresh=1000,readdata=00000000,ready=1
# RUNTIME: Info: RUNTIME_0068 testbench.sv (30): $finish called.
# KERNEL: Time: 120 ns,  Iteration: 0,  Instance: /RAM8x16bit_tb,  Process: @INITIAL#14_2@.
# KERNEL: stopped at time: 120 ns
