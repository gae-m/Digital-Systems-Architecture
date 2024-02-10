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
extern void execute_192(char*, char *);
extern void execute_193(char*, char *);
extern void execute_19(char*, char *);
extern void execute_20(char*, char *);
extern void execute_21(char*, char *);
extern void execute_67(char*, char *);
extern void execute_118(char*, char *);
extern void execute_23(char*, char *);
extern void execute_24(char*, char *);
extern void execute_25(char*, char *);
extern void execute_28(char*, char *);
extern void execute_30(char*, char *);
extern void execute_69(char*, char *);
extern void execute_70(char*, char *);
extern void execute_71(char*, char *);
extern void execute_120(char*, char *);
extern void execute_159(char*, char *);
extern void execute_161(char*, char *);
extern void execute_163(char*, char *);
extern void execute_165(char*, char *);
extern void execute_167(char*, char *);
extern void execute_169(char*, char *);
extern void execute_171(char*, char *);
extern void execute_173(char*, char *);
extern void execute_123(char*, char *);
extern void execute_124(char*, char *);
extern void execute_127(char*, char *);
extern void execute_128(char*, char *);
extern void execute_187(char*, char *);
extern void execute_188(char*, char *);
extern void execute_190(char*, char *);
extern void execute_191(char*, char *);
extern void vhdl_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
extern void transaction_4(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_6(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_15(char*, char*, unsigned, unsigned, unsigned);
funcp funcTab[36] = {(funcp)execute_192, (funcp)execute_193, (funcp)execute_19, (funcp)execute_20, (funcp)execute_21, (funcp)execute_67, (funcp)execute_118, (funcp)execute_23, (funcp)execute_24, (funcp)execute_25, (funcp)execute_28, (funcp)execute_30, (funcp)execute_69, (funcp)execute_70, (funcp)execute_71, (funcp)execute_120, (funcp)execute_159, (funcp)execute_161, (funcp)execute_163, (funcp)execute_165, (funcp)execute_167, (funcp)execute_169, (funcp)execute_171, (funcp)execute_173, (funcp)execute_123, (funcp)execute_124, (funcp)execute_127, (funcp)execute_128, (funcp)execute_187, (funcp)execute_188, (funcp)execute_190, (funcp)execute_191, (funcp)vhdl_transfunc_eventcallback, (funcp)transaction_4, (funcp)transaction_6, (funcp)transaction_15};
const int NumRelocateId= 36;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/booth_mult_tb_behav/xsim.reloc",  (void **)funcTab, 36);
	iki_vhdl_file_variable_register(dp + 10408);
	iki_vhdl_file_variable_register(dp + 10464);


	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/booth_mult_tb_behav/xsim.reloc");
}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/booth_mult_tb_behav/xsim.reloc");
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
    iki_set_sv_type_file_path_name("xsim.dir/booth_mult_tb_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/booth_mult_tb_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/booth_mult_tb_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
