/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    work_m_00000000001234773414_3832581141_init();
    work_m_00000000002818788480_2381739659_init();
    work_m_00000000001806448734_3037777339_init();
    work_m_00000000002320704264_1621107508_init();
    work_m_00000000001248457443_2355732299_init();
    work_m_00000000001164984742_2725559894_init();
    work_m_00000000002834016589_3440754425_init();
    work_m_00000000003956759006_3213298780_init();
    work_m_00000000004099406016_3522133977_init();
    work_m_00000000001359338270_1949178628_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000001359338270_1949178628");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}
