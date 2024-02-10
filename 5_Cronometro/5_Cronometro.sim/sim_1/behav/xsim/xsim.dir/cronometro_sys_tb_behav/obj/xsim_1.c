/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
extern void execute_80(char*, char *);
extern void execute_81(char*, char *);
extern void execute_13(char*, char *);
extern void execute_15(char*, char *);
extern void execute_16(char*, char *);
extern void execute_18(char*, char *);
extern void execute_19(char*, char *);
extern void execute_43(char*, char *);
extern void execute_44(char*, char *);
extern void execute_46(char*, char *);
extern void execute_48(char*, char *);
extern void execute_49(char*, char *);
extern void execute_51(char*, char *);
extern void execute_52(char*, char *);
extern void execute_53(char*, char *);
extern void execute_59(char*, char *);
extern void execute_60(char*, char *);
extern void execute_61(char*, char *);
extern void execute_63(char*, char *);
extern void execute_69(char*, char *);
extern void execute_71(char*, char *);
extern void execute_72(char*, char *);
extern void execute_77(char*, char *);
extern void execute_79(char*, char *);
extern void transaction_0(char*, char*, unsigned, unsigned, unsigned);
extern void vhdl_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
extern void transaction_13(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_14(char*, char*, unsigned, unsigned, unsigned);
funcp funcTab[28] = {(funcp)execute_80, (funcp)execute_81, (funcp)execute_13, (funcp)execute_15, (funcp)execute_16, (funcp)execute_18, (funcp)execute_19, (funcp)execute_43, (funcp)execute_44, (funcp)execute_46, (funcp)execute_48, (funcp)execute_49, (funcp)execute_51, (funcp)execute_52, (funcp)execute_53, (funcp)execute_59, (funcp)execute_60, (funcp)execute_61, (funcp)execute_63, (funcp)execute_69, (funcp)execute_71, (funcp)execute_72, (funcp)execute_77, (funcp)execute_79, (funcp)transaction_0, (funcp)vhdl_transfunc_eventcallback, (funcp)transaction_13, (funcp)transaction_14};
const int NumRelocateId= 28;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/cronometro_sys_tb_behav/xsim.reloc",  (void **)funcTab, 28);
	iki_vhdl_file_variable_register(dp + 11208);
	iki_vhdl_file_variable_register(dp + 11264);


	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/cronometro_sys_tb_behav/xsim.reloc");
}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/cronometro_sys_tb_behav/xsim.reloc");
	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net
	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern void implicit_HDL_SCinstatiate();

extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/cronometro_sys_tb_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/cronometro_sys_tb_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/cronometro_sys_tb_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
