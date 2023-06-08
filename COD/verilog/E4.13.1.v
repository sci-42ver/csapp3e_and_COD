module RISCVCPU (
    clock
);
  // Instruct i on opcodes
  parameter LD= 7'b000_0011 , SD= 7'b010_0011 , BEO = 7'b110_0011 , NOP= 32'h0000_0013 , ALUop = 7'b001_0011 ;
  input clock;
  reg [63 : 0] PC, Regs[0 : 31], IDEXA, IDEXB, EXMEMB, EXMEMALUOut, MEMWBValue;
  reg [31 : 0]
      IMemory[0 : 1023],
      DMemory[0 : 1023],  // separate memori es
      IFIDIR,
      IDEXIR,
      EXMEMIR,
      MEMWBIR;  // pi pe l ine reg i sters
  wire [4:0] IFIDrsl, IFIDrs2, MEMWBrd;  // Access register fiel ds
  wire [6 : 0] IDEXop, EXMEMop, MEMWBop;  // Access opcodes
  wire [63 : 0] Ain, Bin;  // the ALU inputs
  // These assignments define fie l ds from the pipel ine registers
  assign IFIDrsl = IFIDIR[19:15];  // rsl field
  assign IFIDrs2 = IFIDIR[24 : 20];  // rs2 field
  assign IDEXop = IDEXIR[6 : 0];
  // the opcode
  assign EXMEMop = EXMEMIR[6 : 0];
  // the opcode
  assign MEMWBop = MEMWBIR[6 : 0];
  // the opcode
  assign MEMWBrd = MEMWBIR[11 : 7];  // rd field
  // Inputs to the ALU come di rectly from the ID/EX pipeline registers
  assign Ain = IDEXA;
  assign Bin = IDEXB;
  integer i;  // used to initialize registers
  initial begin
    PC = 0;
    IFIDIR = NOP;
    IDEXIR = NOP;
    EXMEMIR = NOP;
    MEMWBIR = NOP;  // put NOPs in pipeline registers
    for (i = 0; i <= 31; i = i + 1)
      Regs[i] = i;  // initialize reg i sters -- ]ust so they aren ' t cares
  end
  // Remember that A11 these actions happen every pipe stage and with the use of<= they happen in para1Iel!
  always @(posedge clock) begin
    // first instruction i n the pipeli ne is being fetched
    // Fetch & increment PC
    IFIDIR <= IMemory[PC>>2];
    PC <= PC + 4;
    // second instruction in pipeline is fetching reg i sters
    IDEXA <= Regs[IFIDrsl];
    IDEXB <= Regs[IFIDrs2];  // get two registers
    IDEXIR <= IFIDIR; // pass along IR--can happen anywhere , since this aff ects next stage on l y!
    // third instruction is doing address calculation or ALU operation
    if (IDEXop == LD) EXMEMALUOut <= IDEXA + {{53{IDEXIR[31]}}, IDEXIR[30 : 20]};
    else if (IDEXop == SD)
      EXMEMALUOut <= IDEXA + {{53{IDEXIR[31]}}, IDEXIR[30 : 25], IDEXIR[11 : 7]};
    else if (IDEXop == ALUop)
      case (IDEXIR[31 : 25])  // case for the various R- type instructions
        0: EXMEMALUOut <= Ain + Bin;  // add operation 658
        default: ;  // other R-type operations : subtract , SLT, etc ,
      endcase
    EXMEMIR <= IDEXIR;
    EXMEMB  <= IDEXB;  // pass along the IR & B register
    // Mem stage of pipeline
    if (EXMEMop == ALUop) MEMWBValue <= EXMEMALUOut;  // pass along ALU result
    else if (EXMEMop == LD) MEMWBValue <= DMemory[EXMEMALUOut>>2];
    else if (EXMEMop == SD) DMemory[EXMEMALUOut>>2] <= EXMEMB;  //store
    MEMWBIR <= EXMEMIR;  // pass along IR
    // WB stage
    if (((MEMWBop == LD) || (MEMWBop == ALUop)) && (MEMWBrd != 0)) // update registers if load/ALU operation and destination not 0
      Regs[MEMWBrd] <= MEMWBValue;
  end
endmodule