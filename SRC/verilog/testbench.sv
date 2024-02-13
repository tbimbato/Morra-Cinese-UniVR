module MorraCinese_TB;
    reg [1:0] PRIMO;
    reg [1:0] SECONDO;
    reg INIZIA;
    reg [1:0] MANCHE;
    reg [1:0] PARTITA;
    reg clk;

    integer out;
    integer script;

  MorraCinese test14 (
    .PRIMO(PRIMO),
    .SECONDO(SECONDO),
    .INIZIA(INIZIA),
    .clk(clk),
  	.MANCHE(MANCHE),
  	.PARTITA(PARTITA)
  	);

    task Simulate();
      $fdisplay(script, "simulate %b %b %b %b %b", PRIMO[1], PRIMO[0], SECONDO[1], SECONDO[0], INIZIA);
    endtask

    task Output();   
      $fdisplay(out, "Outputs: %b %b %b %b", MANCHE[1],MANCHE[0],PARTITA[1], PARTITA[0]);
      endtask



    always
    #10 clk = ~clk;
  
  initial begin
    
    script = $fopen("testbench.script", "w");
    out = $fopen("output_verilog.txt", "w");

    $dumpfile("tb.vcd");
    $dumpvars(1);
    
    $fdisplay(script,"rl FSMD.blif");
    
    clk = 1'b0;

    INIZIA = 1'b1;  
    PRIMO = 2'b11;
    SECONDO = 2'b01;
    Simulate();			
    #20;
    Output();   //1

    
    INIZIA = 1'b0;
    PRIMO = 2'b11;
    SECONDO = 2'b10;
    Simulate();			
    #20;
    Output();   //2

    PRIMO = 2'b01;
    SECONDO = 2'b01;
    Simulate();		
    #20;
    Output();   //3

    PRIMO = 2'b10;
    SECONDO = 2'b00;
    Simulate();		
    #20;
    Output();   //4
    

    PRIMO = 2'b00;
    SECONDO = 2'b11;
    Simulate();		
    #20;
    Output();   //5
    

    INIZIA = 1'b1;
    PRIMO = 2'b01;
    SECONDO = 2'b10;
    Simulate();			
    #20;
    Output();   //6
    

    INIZIA = 1'b0; 
    PRIMO = 2'b11;
    SECONDO = 2'b00;
    Simulate();		
    #20;
    Output();   //7
    

    PRIMO = 2'b00; 
    SECONDO = 2'b11;
    Simulate(); 
    #20;
    Output();   //8
    

    PRIMO = 2'b10; 
    SECONDO = 2'b01;
    Simulate();	
    #20;
    Output();   //9
    

    PRIMO = 2'b01; 
    SECONDO = 2'b00;
    Simulate();	
    #20;
    Output();   //10
    

    PRIMO = 2'b10;
    SECONDO = 2'b11;
    Simulate();			
    #20;
    Output(); //11
    

    PRIMO = 2'b00;
    SECONDO = 2'b00;
    Simulate();
    #20;
    Output();   //12
    

    INIZIA = 1'b1;  
    PRIMO = 2'b11;
    SECONDO = 2'b01;
    Simulate();
    #20;
    Output();   //13
    

    
    INIZIA = 1'b0;
    
    PRIMO = 2'b11;
    SECONDO = 2'b10;
    Simulate();
    #20;
    Output();   //14
    

    PRIMO = 2'b11;
    SECONDO = 2'b01;
    Simulate();
    #20;
    Output();   //15
    

    PRIMO = 2'b10;
    SECONDO = 2'b00;
    Simulate();
    #20;
    Output();   //16
    

    PRIMO = 2'b00;
    SECONDO = 2'b11;
    Simulate();
    #20;
    Output();   //17
    

    PRIMO = 2'b01;
    SECONDO = 2'b00;
    Simulate();
    #20;
    Output();   //18
    

    PRIMO = 2'b10;
    SECONDO = 2'b11;
    Simulate();
    #20;
    Output();   //19
    

    PRIMO = 2'b00;
    SECONDO = 2'b01;
    Simulate();
    #20;
    Output();   //20
    

    PRIMO = 2'b11;
    SECONDO = 2'b10;
    Simulate();
    #20;
    Output();   //21
    

    PRIMO = 2'b01;
    SECONDO = 2'b11;
    Simulate();
    #20;
    Output();   //22
    

    PRIMO = 2'b10;
    SECONDO = 2'b01;
    Simulate();
    #20;
    Output();   //23
    

    PRIMO = 2'b00;
    SECONDO = 2'b00;
    Simulate();
    #20;
    Output();   //24
    
        
    PRIMO = 2'b01;
    SECONDO = 2'b01;
    Simulate();
    #20;
    Output();   //25

    PRIMO = 2'b10;
    SECONDO = 2'b00;
    Simulate();
    #20;
    Output();   //26

    PRIMO = 2'b00;
    SECONDO = 2'b11;
    Simulate();
    #20;
    Output();   //27

    INIZIA = 1'b1;
    PRIMO = 2'b01;
    SECONDO = 2'b10;
    Simulate();
    #20;
    Output();   //28

    INIZIA = 1'b0;
    PRIMO = 2'b11;
    SECONDO = 2'b00;
    Simulate();
    #20;
    Output();   //29

    PRIMO = 2'b00;
    SECONDO = 2'b11;
    Simulate();
    #20;
    Output();   //30

    PRIMO = 2'b10;
    SECONDO = 2'b01;
    Simulate();
    #20;
    Output();   //31

    PRIMO = 2'b01;
    SECONDO = 2'b00;
    Simulate();
    #20;
    Output();   //32

    PRIMO = 2'b10;
    SECONDO = 2'b11;
    Simulate();
    #20;
    Output();   //33

    PRIMO = 2'b00;
    SECONDO = 2'b01;
    Simulate();
    #20;
    Output();   //34

    PRIMO = 2'b11;
    SECONDO = 2'b10;
    Simulate();
    #20;
    Output();   //35

    PRIMO = 2'b01;
    SECONDO = 2'b11;
    Simulate();
    #20;
    Output();   //36

    PRIMO = 2'b10;
    SECONDO = 2'b01;
    Simulate();
    #20;
    Output();   //37

    PRIMO = 2'b00;
    SECONDO = 2'b00;
    Simulate();
    #20;
    Output();   //38

    INIZIA = 1'b0;
    PRIMO = 2'b01;
    SECONDO = 2'b00;
    Simulate();
    #20;
    Output();   //39

    INIZIA = 1'b0;
    PRIMO = 2'b11;
    SECONDO = 2'b00;
    Simulate();
    #20;
    Output();   //40

    PRIMO = 2'b00;
    SECONDO = 2'b11;
    Simulate();
    #20;
    Output();   //41

    PRIMO = 2'b10;
    SECONDO = 2'b01;
    Simulate();
    #20;
    Output();   //42


    INIZIA = 1'b1;
    PRIMO = 2'b00;
    SECONDO = 2'b00;
    Simulate();
    #20;
    Output();   //43

    INIZIA = 1'b0;
    PRIMO = 2'b00;
    SECONDO = 2'b11;
    Simulate();
    #20;
    Output();   //44

    PRIMO = 2'b01;
    SECONDO = 2'b10;
    Simulate();
    #20;
    Output();   //45

    PRIMO = 2'b11;
    SECONDO = 2'b01;
    Simulate();
    #20;
    Output();   //46


    INIZIA = 1'b0;
    PRIMO = 2'b01;
    SECONDO = 2'b10;
    Simulate();
    #20;
    Output();   //47

    PRIMO = 2'b11;
    SECONDO = 2'b00;
    Simulate();
    #20;
    Output();   //48

    PRIMO = 2'b10;
    SECONDO = 2'b11;
    Simulate();
    #20;
    Output();   //49


    PRIMO = 2'b00;
    SECONDO = 2'b11;
    Simulate();
    #20;
    Output();   //50

    PRIMO = 2'b10;
    SECONDO = 2'b01;
    Simulate();
    #20;
    Output();   //51

    PRIMO = 2'b01;
    SECONDO = 2'b00;
    Simulate();
    #20;
    Output();   //52

    INIZIA = 1'b1;
    PRIMO = 2'b01;
    SECONDO = 2'b10;
    Simulate();
    #20;
    Output();   //53

    INIZIA = 1'b0;
    PRIMO = 2'b11;
    SECONDO = 2'b00;
    Simulate();
    #20;
    Output();   //54

    PRIMO = 2'b00;
    SECONDO = 2'b11;
    Simulate();
    #20;
    Output();   //55

    PRIMO = 2'b10;
    SECONDO = 2'b01;
    Simulate();
    #20;
    Output();   //56

    PRIMO = 2'b01;
    SECONDO = 2'b00;
    Simulate();
    #20;
    Output();   //57

    PRIMO = 2'b10;
    SECONDO = 2'b11;
    Simulate();
    #20;
    Output();   //58

    PRIMO = 2'b00;
    SECONDO = 2'b01;
    Simulate();
    #20;
    Output();   //59

    PRIMO = 2'b11;
    SECONDO = 2'b10;
    Simulate();
    #20;
    Output();   //60

    PRIMO = 2'b01;
    SECONDO = 2'b11;
    Simulate();
    #20;
    Output();   //61

    PRIMO = 2'b10;
    SECONDO = 2'b01;
    Simulate();
    #20;
    Output();   //62

    PRIMO = 2'b00;
    SECONDO = 2'b00;
    Simulate();
    #20;
    Output();   //63


    PRIMO = 2'b10;
    SECONDO = 2'b01;
    Simulate();
    #20;
    Output();   //64

    PRIMO = 2'b00;
    SECONDO = 2'b00;
    Simulate();
    #20;
    Output();   //65


    INIZIA = 1'b1;
    PRIMO = 2'b11;
    SECONDO = 2'b00;
    Simulate();
    #20;
    Output();   //66

    INIZIA = 1'b0;
    PRIMO = 2'b11;
    SECONDO = 2'b00;
    Simulate();
    #20;
    Output();   //67

    PRIMO = 2'b00;
    SECONDO = 2'b11;
    Simulate();
    #20;
    Output();   //68

    PRIMO = 2'b10;
    SECONDO = 2'b01;
    Simulate();
    #20;
    Output();   //69

    PRIMO = 2'b01;
    SECONDO = 2'b00;
    Simulate();
    #20;
    Output();   //70

    PRIMO = 2'b10;
    SECONDO = 2'b11;
    Simulate();
    #20;
    Output();   //71

    PRIMO = 2'b00;
    SECONDO = 2'b01;
    Simulate();
    #20;
    Output();   //72

    INIZIA = 1'b1;
    PRIMO = 2'b01;
    SECONDO = 2'b00;
    Simulate();
    #20;
    Output();   //73

    INIZIA = 1'b0;
    PRIMO = 2'b11;
    SECONDO = 2'b00;
    Simulate();
    #20;
    Output();   //74 1 

    PRIMO = 2'b01;
    SECONDO = 2'b10;
    Simulate();
    #20;
    Output();   //75 2 

    PRIMO = 2'b10;
    SECONDO = 2'b11;
    Simulate();
    #20;
    Output();   //76 3

    PRIMO = 2'b11;
    SECONDO = 2'b10;
    Simulate();
    #20;
    Output();   //77 4

    PRIMO = 2'b01;
    SECONDO = 2'b01;
    Simulate();
    #20;
    Output();   //78 5

    PRIMO = 2'b01;
    SECONDO = 2'b11;
    Simulate();
    #20;
    Output();   //79 6

    PRIMO = 2'b10;
    SECONDO = 2'b11;
    Simulate();
    #20;
    Output();   //80 7


    PRIMO = 2'b01;
    SECONDO = 2'b01;
    Simulate();
    #20;
    Output();   //81 8 

    PRIMO = 2'b01;
    SECONDO = 2'b01;
    Simulate();
    #20;
    Output();   //82 9
   	
    $fdisplay(script, "quit");
    $fclose(script);
    $fclose(out);
    $finish;


  end
endmodule
