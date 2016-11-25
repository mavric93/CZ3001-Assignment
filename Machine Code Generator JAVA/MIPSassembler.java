/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package javaapplication1;

/**
 *
 * @author mavr0001
 */
public class MIPSassembler {

    public static void main(String[] args) {

        String instructions[] = {
            "NOP",
            "ADDI $2, $0, 10", // set $2 to 5
            "ADD $1, $0, $0", // set $1 to zero
            "NOP", // NOP
            "SW $2, 0($0)", // set value at DM address 0x0000 to 5
            "BEQ $2, $1, 10", // (if $2 == $1) NPC+= 11. Will not be taken
            "LW $1, 0($0)", // set $1 with DM address 0x0000. Set $1 to 5
            "NOP",
            "NOP",
            "BEQ $2, $1, 10" // (if $2 == $1) NPC+=11. Will be taken
        };
        int counter = 0;
        for (String s : instructions) {
            System.out.println(String.format("%8s", Integer.toHexString(counter++)).replace(" ", "0") + " "
                    + binaryToHex(asmToMachineCode((s))) + "\t// " + s);
        }

    }

    public static String asmToMachineCode(String inst) {

        String machineCode = "";

        inst = inst.replace(",", "");
        inst = inst.replace("$", "");
        String opcode = inst.split(" ")[0];
        String temp[] = {};
        String RD;
        String RS;
        String RT;
        String imm;
        String offset;

        switch (opcode) {
            case "NOP":
                return "00000000000000000000000000000000";
            //R type instructions
            case "ADD":
                machineCode = "000000";
                temp = inst.split(" ");
                RD = returnRegisterAddress(temp[1]);
                RT = returnRegisterAddress(temp[2]);
                RS = returnRegisterAddress(temp[3]);
                machineCode = machineCode + RS + RT + RD;
                break;
            case "SUB":
                machineCode = "000001";
                temp = inst.split(" ");
                RD = returnRegisterAddress(temp[1]);
                RT = returnRegisterAddress(temp[2]);
                RS = returnRegisterAddress(temp[3]);
                machineCode = machineCode + RS + RT + RD;
                break;
            case "AND":
                machineCode = "000010";
                temp = inst.split(" ");
                RD = returnRegisterAddress(temp[1]);
                RT = returnRegisterAddress(temp[2]);
                RS = returnRegisterAddress(temp[3]);
                machineCode = machineCode + RS + RT + RD;
                break;
            case "OR":
                machineCode = "000011";
                temp = inst.split(" ");
                RD = returnRegisterAddress(temp[1]);
                RT = returnRegisterAddress(temp[2]);
                RS = returnRegisterAddress(temp[3]);
                machineCode = machineCode + RS + RT + RD;
                break;
            case "XOR":
                machineCode = "000100";
                temp = inst.split(" ");
                RD = returnRegisterAddress(temp[1]);
                RT = returnRegisterAddress(temp[2]);
                RS = returnRegisterAddress(temp[3]);
                machineCode = machineCode + RS + RT + RD;
                break;
            case "MUL":
                machineCode = "000101";
                temp = inst.split(" ");
                RD = returnRegisterAddress(temp[1]);
                RT = returnRegisterAddress(temp[2]);
                RS = returnRegisterAddress(temp[3]);
                machineCode = machineCode + RS + RT + RD;
                break;
            case "NOT":
                machineCode = "000110";
                temp = inst.split(" ");
                RD = returnRegisterAddress(temp[1]);
                RT = returnRegisterAddress(temp[2]);
                RS = returnRegisterAddress(temp[3]);
                machineCode = machineCode + RS + RT + RD;
                break;
            case "COM":
                machineCode = "000111";
                temp = inst.split(" ");
                RD = returnRegisterAddress(temp[1]);
                RT = returnRegisterAddress(temp[2]);
                RS = returnRegisterAddress(temp[3]);
                machineCode = machineCode + RS + RT + RD;
                break;
            case "BEQ":
                machineCode = "111111";
                temp = inst.split(" ");
                RS = returnRegisterAddress(temp[1]);
                RT = returnRegisterAddress(temp[2]);
                imm = returnIMMBIN(temp[3]);
                machineCode = machineCode + RS + RT + imm;
                break;
            case "JR":
                machineCode = "001000";
                temp = inst.split(" ");
                RS = returnRegisterAddress(temp[1]);
                machineCode = machineCode + RS;
                break;

            //i format instructions
            case "ADDI":
                machineCode = "100000";
                temp = inst.split(" ");
                RS = returnRegisterAddress(temp[1]);
                RT = returnRegisterAddress(temp[2]);
                imm = returnIMMBIN(temp[3]);
                machineCode = machineCode + RT + RS + imm;
                break;
            case "SUBI":
                machineCode = "100001";
                temp = inst.split(" ");
                RS = returnRegisterAddress(temp[1]);
                RT = returnRegisterAddress(temp[2]);
                imm = returnIMMBIN(temp[3]);
                machineCode = machineCode + RT + RS + imm;
                break;
            case "ANDI":
                machineCode = "100010";
                temp = inst.split(" ");
                RS = returnRegisterAddress(temp[1]);
                RT = returnRegisterAddress(temp[2]);
                imm = returnIMMBIN(temp[3]);
                machineCode = machineCode + RT + RS + imm;
                break;
            case "ORI":
                machineCode = "100011";
                temp = inst.split(" ");
                RS = returnRegisterAddress(temp[1]);
                RT = returnRegisterAddress(temp[2]);
                imm = returnIMMBIN(temp[3]);
                machineCode = machineCode + RT + RS + imm;
                break;
            case "XORI":
                machineCode = "100100";
                temp = inst.split(" ");
                RS = returnRegisterAddress(temp[1]);
                RT = returnRegisterAddress(temp[2]);
                imm = returnIMMBIN(temp[3]);
                machineCode = machineCode + RT + RS + imm;
                break;
            case "LW":
                machineCode = "111000";
                temp = inst.split(" ");
                RT = returnRegisterAddress(temp[1]);
                imm = returnIMMBIN(temp[2].split("\\(")[0]);
                RS = returnRegisterAddress((temp[2].split("\\(")[1]).replace(")", ""));
                machineCode = machineCode + RS + RT + imm;
                break;
            case "SW":
                machineCode = "110000";
                temp = inst.split(" ");
                RT = returnRegisterAddress(temp[1]);
                imm = returnIMMBIN(temp[2].split("\\(")[0]);
                RS = returnRegisterAddress((temp[2].split("\\(")[1]).replace(")", ""));
                machineCode = machineCode + RS + RT + imm;
                break;

            //J type instruction
            case "JMP":
                machineCode = "010000";
                temp = inst.split(" ");
                offset = String.format("%26s", Integer.toBinaryString(Integer.parseInt(temp[1]))).replace(" ", "0");
                machineCode = machineCode + offset;
                break;
            case "JAL":
                machineCode = "010001";
                temp = inst.split(" ");
                RS = temp[1];
                offset = String.format("%26s", Integer.toBinaryString(Integer.parseInt(temp[1]))).replace(" ", "0");
                machineCode = machineCode + offset;
                break;
            default:
                System.out.println(opcode + " not supported.");
                break;

        }

        return String.format("%-32s", machineCode).replace(" ", "0");
    }

    public static String binaryToHex(String bin) {
        return String.format("%08X", Long.parseLong(bin, 2));
    }

    public static String returnRegisterAddress(String register) {
        int registerInt = Integer.parseInt(register);
        return String.format("%5s", Integer.toBinaryString(registerInt)).replace(" ", "0");
    }

    public static String returnIMMBIN(String imm) {
        int immInt = Integer.parseInt(imm);
        return String.format("%16s", Integer.toBinaryString(immInt)).replace(" ", "0");

    }
}
