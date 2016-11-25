/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package javaapplication1;

/**
 *
 * @author mavr0001
 */
public class generateDM {

    public static void main(String[] args) {


        for (int i = 0; i < 200; i++) {
            System.out.println(String.format("%8s", Integer.toHexString(i)).replace(" ", "0") + " 00000000");
        }
    }
}
