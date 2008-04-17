/*
 * Copyright 2005 Sun Microsystems, Inc.  All rights reserved.
 * Use is subject to license terms.
 */

	.ident	"@(#)traptable.s	1.28	05/05/18 SMI"

	.file	"traptable.s"

/*
 * Niagara hypervisor trap table
 */

#include <sys/asm_linkage.h>
#include <hypervisor.h>
#include <niagara/hprivregs.h>
#include <niagara/asi.h>
#include <niagara/mmu.h>
#include <sun4v/traps.h>
#include <sun4v/mmu.h>

#include "guest.h"
#include "offsets.h"
#include "traptrace.h"
#include "debug.h"

#define	TRAP_ALIGN_SIZE		32
#define	TRAP_ALIGN		.align TRAP_ALIGN_SIZE
#define	TRAP_ALIGN_BIG		.align (TRAP_ALIGN_SIZE * 4)

#define	TRAP(ttnum, action) \
	.global	ttnum		;\
	ttnum:			;\
	action			;\
	TRAP_ALIGN

#define	BIGTRAP(ttnum, action) \
	.global	ttnum		;\
	ttnum:			;\
	action			;\
	TRAP_ALIGN_BIG

#define	GOTO(label)		\
	.global	label		;\
	ba,a	label		;\
	.empty

#define NOT	GOTO(trap)
#define	NOT_BIG	NOT NOT NOT NOT
#define	RED	NOT

#define	HCALL_BAD			\
	mov	EBADTRAP, %o0		;\
	done

/*
 * MMU traps
 *
 * XXX - hack for now until the trap table entry gets rewritten
 * on-the-fly when the guest takes over the mmu
 */
#define	IMMU_MISS						\
	rdpr	%gl, %g1					;\
	cmp	%g1, MAXPGL					;\
	bgu,pn	%xcc, watchdog_guest				;\
	mov	HSCRATCH0, %g1					;\
	ba,pt	%xcc, immu_miss					;\
	ldxa	[%g1]ASI_HSCRATCHPAD, %g1

#define	DMMU_MISS						\
	rdpr	%gl, %g1					;\
	cmp	%g1, MAXPGL					;\
	bgu,pn	%xcc, watchdog_guest				;\
	mov	HSCRATCH0, %g1					;\
	ba,pt	%xcc, dmmu_miss					;\
	ldxa	[%g1]ASI_HSCRATCHPAD, %g1

#define	DMMU_PROT						\
	rdpr	%gl, %g1					;\
	cmp	%g1, MAXPGL					;\
	bgu,pn	%xcc, watchdog_guest				;\
	mov	HSCRATCH0, %g1					;\
	ldxa	[%g1]ASI_HSCRATCHPAD, %g1			;\
	ldx	[%g1 + CPU_MMU_AREA], %g2			;\
	ba,a,pt	%xcc, dmmu_prot					;\
	.empty

#define	RDMMU_MISS						\
	mov	HSCRATCH0, %g1					;\
	ldxa	[%g1]ASI_HSCRATCHPAD, %g1			;\
	ba,a,pt	%xcc, rdmmu_miss				;\
	.empty

#define	RIMMU_MISS						\
	mov	HSCRATCH0, %g1					;\
	ldxa	[%g1]ASI_HSCRATCHPAD, %g1			;\
	ba,a,pt	%xcc, rimmu_miss				;\
	.empty

/*
 * Interrupt traps
 */
#define	VECINTR							\
	mov	HSCRATCH0, %g1					;\
	ldxa	[%g1]ASI_HSCRATCHPAD, %g1			;\
	ba,a	vecintr						;\
	.empty
/*
 * Basic register window handling
 */
#define	CLEAN_WINDOW                                            \
        rdpr %cleanwin, %l0; inc %l0; wrpr %l0, %cleanwin       ;\
        clr %l0; clr %l1; clr %l2; clr %l3                      ;\
        clr %l4; clr %l5; clr %l6; clr %l7                      ;\
        clr %o0; clr %o1; clr %o2; clr %o3                      ;\
        clr %o4; clr %o5; clr %o6; clr %o7                      ;\
        retry

#define	POR							\
	.global	start_master					;\
	ba,a	start_master					;\
	nop; nop; nop						;\
	.global	start_slave					;\
	ba,a	start_slave					;\
	.empty
	
/*
 * CE Error traps
 */
#define	CE_ERR							\
	ba,a,pt	%xcc, ce_err					;\
	.empty

/*
 * UE Error traps
 */
#define	UE_ERR							\
	ba,a,pt	%xcc, ue_err					;\
	.empty

/*
 * Disrupting UE Error traps
 */
#define	DIS_UE_ERR						\
	ba,a,pt	%xcc, dis_ue_err				;\
	.empty

/*
 * Hstick_match hypervisor interrupt handler
 */
#define	HSTICK_INTR						\
	ba,a,pt	%xcc, hstick_intr				;\
	.empty

/*
 * The basic hypervisor trap table
 *
 * We use the linker to place this at the beginning of the hypervisor
 * binary which gets loaded at an appropriate alignment by Reset/Config.
 */

	ENTRY(htraptable)
	/*
	 * hardware traps
	 */
	TRAP(tt0_000, NOT)		/* reserved */
	TRAP(tt0_001, POR)		/* power-on reset */
	TRAP(tt0_002, GOTO(watchdog))	/* watchdog reset */
	TRAP(tt0_003, GOTO(xir))	/* externally initiated reset */
	TRAP(tt0_004, NOT)		/* software initiated reset */
	TRAP(tt0_005, NOT)		/* red mode exception */
	TRAP(tt0_006, NOT)		/* reserved */
	TRAP(tt0_007, NOT)		/* reserved */
	TRAP(tt0_008, GOTO(immu_err))	/* instruction access exception */
	TRAP(tt0_009, NOT)		/* instruction access mmu miss */
	TRAP(tt0_00a, UE_ERR)		/* instruction access error */
	TRAP(tt0_00b, NOT)		/* reserved */
	TRAP(tt0_00c, NOT)		/* reserved */
	TRAP(tt0_00d, NOT)		/* reserved */
	TRAP(tt0_00e, NOT)		/* reserved */
	TRAP(tt0_00f, NOT)		/* reserved */
	TRAP(tt0_010, GOTO(revector))	/* illegal instruction */
	TRAP(tt0_011, GOTO(revector))	/* privileged opcode */
	TRAP(tt0_012, GOTO(revector))	/* unimplemented LDD */
	TRAP(tt0_013, GOTO(revector))	/* unimplemented STD */
	TRAP(tt0_014, NOT)		/* reserved */
	TRAP(tt0_015, NOT)		/* reserved */
	TRAP(tt0_016, NOT)		/* reserved */
	TRAP(tt0_017, NOT)		/* reserved */
	TRAP(tt0_018, NOT)		/* reserved */
	TRAP(tt0_019, NOT)		/* reserved */
	TRAP(tt0_01a, NOT)		/* reserved */
	TRAP(tt0_01b, NOT)		/* reserved */
	TRAP(tt0_01c, NOT)		/* reserved */
	TRAP(tt0_01d, NOT)		/* reserved */
	TRAP(tt0_01e, NOT)		/* reserved */
	TRAP(tt0_01f, NOT)		/* reserved */
	TRAP(tt0_020, NOT)		/* fp disabled */
	TRAP(tt0_021, NOT)		/* fp exception ieee 754 */
	TRAP(tt0_022, NOT)		/* fp exception other */
	TRAP(tt0_023, NOT)		/* tag overflow */
	BIGTRAP(tt0_024, CLEAN_WINDOW)	/* clean window */
	TRAP(tt0_028, NOT)		/* division by zero */
	TRAP(tt0_029, UE_ERR)		/* internal processor error */
	TRAP(tt0_02a, NOT)		/* reserved */
	TRAP(tt0_02b, NOT)		/* reserved */
	TRAP(tt0_02c, NOT)		/* reserved */
	TRAP(tt0_02d, NOT)		/* reserved */
	TRAP(tt0_02e, NOT)		/* reserved */
	TRAP(tt0_02f, NOT)		/* reserved */
	TRAP(tt0_030, GOTO(dmmu_err))	/* data access exception */
	TRAP(tt0_031, NOT)		/* data access mmu miss */
	TRAP(tt0_032, UE_ERR)		/* data access error */
	TRAP(tt0_033, UE_ERR)		/* data access protection */
	TRAP(tt0_034, GOTO(dmmu_err))	/* mem address not aligned */
	TRAP(tt0_035, GOTO(dmmu_err))	/* lddf mem address not aligned */
	TRAP(tt0_036, GOTO(dmmu_err))	/* stdf mem address not aligned */
	TRAP(tt0_037, GOTO(dmmu_err))	/* privileged action */
	TRAP(tt0_038, GOTO(dmmu_err))	/* ldqf mem address not aligned */
	TRAP(tt0_039, GOTO(dmmu_err))	/* stqf mem address not aligned */
	TRAP(tt0_03a, NOT)		/* reserved */
	TRAP(tt0_03b, NOT)		/* reserved */
	TRAP(tt0_03c, NOT)		/* reserved */
	TRAP(tt0_03d, NOT)		/* reserved */
	TRAP(tt0_03e, RIMMU_MISS)	/* HV: real immu miss */
	TRAP(tt0_03f, RDMMU_MISS)	/* HV: real dmmu miss */
	TRAP(tt0_040, NOT)		/* async data error */
	TRAP(tt0_041, NOT)		/* interrupt level 1 */
	TRAP(tt0_042, NOT)		/* interrupt level 2 */
	TRAP(tt0_043, NOT)		/* interrupt level 3 */
	TRAP(tt0_044, NOT)		/* interrupt level 4 */
	TRAP(tt0_045, NOT)		/* interrupt level 5 */
	TRAP(tt0_046, NOT)		/* interrupt level 6 */
	TRAP(tt0_047, NOT)		/* interrupt level 7 */
	TRAP(tt0_048, NOT)		/* interrupt level 8 */
	TRAP(tt0_049, NOT)		/* interrupt level 9 */
	TRAP(tt0_04a, NOT)		/* interrupt level a */
	TRAP(tt0_04b, NOT)		/* interrupt level b */
	TRAP(tt0_04c, NOT)		/* interrupt level c */
	TRAP(tt0_04d, NOT)		/* interrupt level d */
	TRAP(tt0_04e, NOT)		/* interrupt level e */
	TRAP(tt0_04f, NOT)		/* interrupt level f */
	TRAP(tt0_050, NOT)		/* reserved */
	TRAP(tt0_051, NOT)		/* reserved */
	TRAP(tt0_052, NOT)		/* reserved */
	TRAP(tt0_053, NOT)		/* reserved */
	TRAP(tt0_054, NOT)		/* reserved */
	TRAP(tt0_055, NOT)		/* reserved */
	TRAP(tt0_056, NOT)		/* reserved */
	TRAP(tt0_057, NOT)		/* reserved */
	TRAP(tt0_058, NOT)		/* reserved */
	TRAP(tt0_059, NOT)		/* reserved */
	TRAP(tt0_05a, NOT)		/* reserved */
	TRAP(tt0_05b, NOT)		/* reserved */
	TRAP(tt0_05c, NOT)		/* reserved */
	TRAP(tt0_05d, NOT)		/* reserved */
	TRAP(tt0_05e, HSTICK_INTR)	/* HV: hstick match */
	TRAP(tt0_05f, NOT)		/* reserved */
	TRAP(tt0_060, VECINTR)		/* interrupt vector */
	TRAP(tt0_061, NOT)		/* RA watchpoint */
	TRAP(tt0_062, NOT)		/* VA watchpoint */
	TRAP(tt0_063, CE_ERR)		/* corrected ECC error XXX */
	BIGTRAP(tt0_064, IMMU_MISS)	/* fast instruction access MMU miss */
	BIGTRAP(tt0_068, DMMU_MISS)	/* fast data access MMU miss */
	BIGTRAP(tt0_06C, DMMU_PROT)	/* fast data access protection */
	TRAP(tt0_070, NOT)		/* reserved */
	TRAP(tt0_071, NOT)		/* reserved */
	TRAP(tt0_072, NOT)		/* reserved */
	TRAP(tt0_073, NOT)		/* reserved */
	TRAP(tt0_074, NOT)		/* reserved */
	TRAP(tt0_075, NOT)		/* reserved */
	TRAP(tt0_076, NOT)		/* reserved */
	TRAP(tt0_077, NOT)		/* reserved */
	TRAP(tt0_078, DIS_UE_ERR)	/* data error (disrupting) */
	TRAP(tt0_079, NOT)		/* reserved */
	TRAP(tt0_07a, NOT)		/* reserved */
	TRAP(tt0_07b, NOT)		/* reserved */
	TRAP(tt0_07c, NOT)		/* HV: cpu mondo */
	TRAP(tt0_07d, NOT)		/* HV: dev mondo */
	TRAP(tt0_07e, NOT)		/* HV: resumable error */
	TRAP(tt0_07f, NOT)		/* HV: non-resumable error */
	BIGTRAP(tt0_080, NOT)		/* spill 0 normal */
	BIGTRAP(tt0_084, NOT)		/* spill 1 normal */
	BIGTRAP(tt0_088, NOT)		/* spill 2 normal */
	BIGTRAP(tt0_08c, NOT)		/* spill 3 normal */
	BIGTRAP(tt0_090, NOT)		/* spill 4 normal */
	BIGTRAP(tt0_094, NOT)		/* spill 5 normal */
	BIGTRAP(tt0_098, NOT)		/* spill 6 normal */
	BIGTRAP(tt0_09c, NOT)		/* spill 7 normal */
	BIGTRAP(tt0_0a0, NOT)		/* spill 0 other */
	BIGTRAP(tt0_0a4, NOT)		/* spill 1 other */
	BIGTRAP(tt0_0a8, NOT)		/* spill 2 other */
	BIGTRAP(tt0_0ac, NOT)		/* spill 3 other */
	BIGTRAP(tt0_0b0, NOT)		/* spill 4 other */
	BIGTRAP(tt0_0b4, NOT)		/* spill 5 other */
	BIGTRAP(tt0_0b8, NOT)		/* spill 6 other */
	BIGTRAP(tt0_0bc, NOT)		/* spill 7 other */
	BIGTRAP(tt0_0c0, NOT)		/* fill 0 normal */
	BIGTRAP(tt0_0c4, NOT)		/* fill 1 normal */
	BIGTRAP(tt0_0c8, NOT)		/* fill 2 normal */
	BIGTRAP(tt0_0cc, NOT)		/* fill 3 normal */
	BIGTRAP(tt0_0d0, NOT)		/* fill 4 normal */
	BIGTRAP(tt0_0d4, NOT)		/* fill 5 normal */
	BIGTRAP(tt0_0d8, NOT)		/* fill 6 normal */
	BIGTRAP(tt0_0dc, NOT)		/* fill 7 normal */
	BIGTRAP(tt0_0e0, NOT)		/* fill 0 other */
	BIGTRAP(tt0_0e4, NOT)		/* fill 1 other */
	BIGTRAP(tt0_0e8, NOT)		/* fill 2 other */
	BIGTRAP(tt0_0ec, NOT)		/* fill 3 other */
	BIGTRAP(tt0_0f0, NOT)		/* fill 4 other */
	BIGTRAP(tt0_0f4, NOT)		/* fill 5 other */
	BIGTRAP(tt0_0f8, NOT)		/* fill 6 other */
	BIGTRAP(tt0_0fc, NOT)		/* fill 7 other */
	/*
	 * Software traps
	 */
	TRAP(tt0_100, NOT)		/* software trap */
	TRAP(tt0_101, NOT)		/* software trap */
	TRAP(tt0_102, NOT)		/* software trap */
	TRAP(tt0_103, NOT)		/* software trap */
	TRAP(tt0_104, NOT)		/* software trap */
	TRAP(tt0_105, NOT)		/* software trap */
	TRAP(tt0_106, NOT)		/* software trap */
	TRAP(tt0_107, NOT)		/* software trap */
	TRAP(tt0_108, NOT)		/* software trap */
	TRAP(tt0_109, NOT)		/* software trap */
	TRAP(tt0_10a, NOT)		/* software trap */
	TRAP(tt0_10b, NOT)		/* software trap */
	TRAP(tt0_10c, NOT)		/* software trap */
	TRAP(tt0_10d, NOT)		/* software trap */
	TRAP(tt0_10e, NOT)		/* software trap */
	TRAP(tt0_10f, NOT)		/* software trap */
	TRAP(tt0_110, NOT)		/* software trap */
	TRAP(tt0_111, NOT)		/* software trap */
	TRAP(tt0_112, NOT)		/* software trap */
	TRAP(tt0_113, NOT)		/* software trap */
	TRAP(tt0_114, NOT)		/* software trap */
	TRAP(tt0_115, NOT)		/* software trap */
	TRAP(tt0_116, NOT)		/* software trap */
	TRAP(tt0_117, NOT)		/* software trap */
	TRAP(tt0_118, NOT)		/* software trap */
	TRAP(tt0_119, NOT)		/* software trap */
	TRAP(tt0_11a, NOT)		/* software trap */
	TRAP(tt0_11b, NOT)		/* software trap */
	TRAP(tt0_11c, NOT)		/* software trap */
	TRAP(tt0_11d, NOT)		/* software trap */
	TRAP(tt0_11e, NOT)		/* software trap */
	TRAP(tt0_11f, NOT)		/* software trap */
	TRAP(tt0_120, NOT)		/* software trap */
	TRAP(tt0_121, NOT)		/* software trap */
	TRAP(tt0_122, NOT)		/* software trap */
	TRAP(tt0_123, NOT)		/* software trap */
	TRAP(tt0_124, NOT)		/* software trap */
	TRAP(tt0_125, NOT)		/* software trap */
	TRAP(tt0_126, NOT)		/* software trap */
	TRAP(tt0_127, NOT)		/* software trap */
	TRAP(tt0_128, NOT)		/* software trap */
	TRAP(tt0_129, NOT)		/* software trap */
	TRAP(tt0_12a, NOT)		/* software trap */
	TRAP(tt0_12b, NOT)		/* software trap */
	TRAP(tt0_12c, NOT)		/* software trap */
	TRAP(tt0_12d, NOT)		/* software trap */
	TRAP(tt0_12e, NOT)		/* software trap */
	TRAP(tt0_12f, NOT)		/* software trap */
	TRAP(tt0_130, NOT)		/* software trap */
	TRAP(tt0_131, NOT)		/* software trap */
	TRAP(tt0_132, NOT)		/* software trap */
	TRAP(tt0_133, NOT)		/* software trap */
	TRAP(tt0_134, NOT)		/* software trap */
	TRAP(tt0_135, NOT)		/* software trap */
	TRAP(tt0_136, NOT)		/* software trap */
	TRAP(tt0_137, NOT)		/* software trap */
	TRAP(tt0_138, NOT)		/* software trap */
	TRAP(tt0_139, NOT)		/* software trap */
	TRAP(tt0_13a, NOT)		/* software trap */
	TRAP(tt0_13b, NOT)		/* software trap */
	TRAP(tt0_13c, NOT)		/* software trap */
	TRAP(tt0_13d, NOT)		/* software trap */
	TRAP(tt0_13e, NOT)		/* software trap */
	TRAP(tt0_13f, NOT)		/* software trap */
	TRAP(tt0_140, NOT)		/* software trap */
	TRAP(tt0_141, NOT)		/* software trap */
	TRAP(tt0_142, NOT)		/* software trap */
	TRAP(tt0_143, NOT)		/* software trap */
	TRAP(tt0_144, NOT)		/* software trap */
	TRAP(tt0_145, NOT)		/* software trap */
	TRAP(tt0_146, NOT)		/* software trap */
	TRAP(tt0_147, NOT)		/* software trap */
	TRAP(tt0_148, NOT)		/* software trap */
	TRAP(tt0_149, NOT)		/* software trap */
	TRAP(tt0_14a, NOT)		/* software trap */
	TRAP(tt0_14b, NOT)		/* software trap */
	TRAP(tt0_14c, NOT)		/* software trap */
	TRAP(tt0_14d, NOT)		/* software trap */
	TRAP(tt0_14e, NOT)		/* software trap */
	TRAP(tt0_14f, NOT)		/* software trap */
	TRAP(tt0_150, NOT)		/* software trap */
	TRAP(tt0_151, NOT)		/* software trap */
	TRAP(tt0_152, NOT)		/* software trap */
	TRAP(tt0_153, NOT)		/* software trap */
	TRAP(tt0_154, NOT)		/* software trap */
	TRAP(tt0_155, NOT)		/* software trap */
	TRAP(tt0_156, NOT)		/* software trap */
	TRAP(tt0_157, NOT)		/* software trap */
	TRAP(tt0_158, NOT)		/* software trap */
	TRAP(tt0_159, NOT)		/* software trap */
	TRAP(tt0_15a, NOT)		/* software trap */
	TRAP(tt0_15b, NOT)		/* software trap */
	TRAP(tt0_15c, NOT)		/* software trap */
	TRAP(tt0_15d, NOT)		/* software trap */
	TRAP(tt0_15e, NOT)		/* software trap */
	TRAP(tt0_15f, NOT)		/* software trap */
	TRAP(tt0_160, NOT)		/* software trap */
	TRAP(tt0_161, NOT)		/* software trap */
	TRAP(tt0_162, NOT)		/* software trap */
	TRAP(tt0_163, NOT)		/* software trap */
	TRAP(tt0_164, NOT)		/* software trap */
	TRAP(tt0_165, NOT)		/* software trap */
	TRAP(tt0_166, NOT)		/* software trap */
	TRAP(tt0_167, NOT)		/* software trap */
	TRAP(tt0_168, NOT)		/* software trap */
	TRAP(tt0_169, NOT)		/* software trap */
	TRAP(tt0_16a, NOT)		/* software trap */
	TRAP(tt0_16b, NOT)		/* software trap */
	TRAP(tt0_16c, NOT)		/* software trap */
	TRAP(tt0_16d, NOT)		/* software trap */
	TRAP(tt0_16e, NOT)		/* software trap */
	TRAP(tt0_16f, NOT)		/* software trap */
	TRAP(tt0_170, NOT)		/* software trap */
	TRAP(tt0_171, NOT)		/* software trap */
	TRAP(tt0_172, NOT)		/* software trap */
	TRAP(tt0_173, NOT)		/* software trap */
	TRAP(tt0_174, NOT)		/* software trap */
	TRAP(tt0_175, NOT)		/* software trap */
	TRAP(tt0_176, NOT)		/* software trap */
	TRAP(tt0_177, NOT)		/* software trap */
	TRAP(tt0_178, NOT)		/* software trap */
	TRAP(tt0_179, NOT)		/* software trap */
	TRAP(tt0_17a, NOT)		/* software trap */
	TRAP(tt0_17b, NOT)		/* software trap */
	TRAP(tt0_17c, NOT)		/* software trap */
	TRAP(tt0_17d, NOT)		/* software trap */
	TRAP(tt0_17e, NOT)		/* software trap */
	TRAP(tt0_17f, NOT)		/* software trap */
	TRAP(tt0_180, GOTO(hcall))	/* hypervisor software trap */
	TRAP(tt0_181, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_182, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_183, GOTO(hcall_mmu_map_addr)) /* hyp software trap */
	TRAP(tt0_184, GOTO(hcall_mmu_unmap_addr)) /* hyp software trap */
	TRAP(tt0_185, GOTO(hcall_ttrace_addentry)) /* hyp software trap */
	TRAP(tt0_186, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_187, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_188, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_189, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_18a, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_18b, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_18c, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_18d, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_18e, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_18f, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_190, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_191, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_192, HCALL_BAD)	/* hypervisor software trap */
#ifdef DEBUG
	TRAP(tt0_193, GOTO(hprint))	/* print string */
	TRAP(tt0_194, GOTO(hprintx))	/* print hex 64-bit */
	TRAP(tt0_195, GOTO(hprintw))	/* print hex 32-bit */
#else
	TRAP(tt0_193, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_194, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_195, HCALL_BAD)	/* hypervisor software trap */
#endif
	TRAP(tt0_196, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_197, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_198, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_199, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_19a, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_19b, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_19c, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_19d, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_19e, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_19f, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1a0, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1a1, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1a2, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1a3, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1a4, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1a5, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1a6, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1a7, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1a8, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1a9, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1aa, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1ab, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1ac, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1ad, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1ae, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1af, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1b0, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1b1, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1b2, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1b3, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1b4, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1b5, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1b6, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1b7, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1b8, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1b9, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1ba, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1bb, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1bc, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1bd, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1be, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1bf, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1c0, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1c1, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1c2, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1c3, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1c4, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1c5, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1c6, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1c7, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1c8, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1c9, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1ca, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1cb, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1cc, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1cd, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1ce, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1cf, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1d0, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1d1, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1d2, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1d3, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1d4, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1d5, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1d6, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1d7, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1d8, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1d9, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1da, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1db, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1dc, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1dd, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1de, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1df, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1e0, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1e1, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1e2, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1e3, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1e4, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1e5, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1e6, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1e7, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1e8, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1e9, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1ea, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1eb, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1ec, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1ed, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1ee, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1ef, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1f0, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1f1, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1f2, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1f3, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1f4, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1f5, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1f6, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1f7, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1f8, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1f9, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1fa, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1fb, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1fc, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1fd, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1fe, HCALL_BAD)	/* hypervisor software trap */
	TRAP(tt0_1ff, GOTO(hcall_core))	/* hypervisor software trap */
ehtraptable:
	SET_SIZE(htraptable)

/*
 * Trap-trace layer trap table.
 */

#define LINK(sym)			 \
	rd	%pc, %g7		;\
	ba,a	sym			;\
	 nop

#define NOTRACE				 		 \
	ba,a	(htraptable+(.-htraptracetable))	;\
	 nop
	
#define	TTRACE(unused, action)		 \
	action				;\
	TRAP_ALIGN

#define	BIG_TTRACE(unused, action)	 \
	action				;\
	TRAP_ALIGN_BIG

/*
 * Sparc V9 TBA registers require that bits 14 through 0 must be zero.
 * Ensure the trap tracing table is aligned on a TRAPTABLE_SIZE boundry. 
 * For additional information, refer to:
 * "The SPARC Architecture Manual", Version 9,
 * 	Section 5.2.8 "Trap Base Address (TBA)"
 *
 * There should be nothing in the .text segment between ehtraptable
 * and htraptracetable.
 */
	ENTRY(htraptracetable)
	/*
	 * Hardware traps
	 */
	TTRACE(tt0_000, NOTRACE)		/* reserved */
	TTRACE(tt0_001, NOTRACE)		/* power-on reset */
	TTRACE(tt0_002, NOTRACE)		/* watchdog reset */
	TTRACE(tt0_003, NOTRACE)		/* externally initiated reset */
	TTRACE(tt0_004, LINK(ttrace_generic))	/* software initiated reset */
	TTRACE(tt0_005, NOTRACE)		/* red mode exception */
	TTRACE(tt0_006, NOTRACE)		/* reserved */
	TTRACE(tt0_007, NOTRACE)		/* reserved */
	TTRACE(tt0_008, LINK(ttrace_immu))	/* instr access exception */
	TTRACE(tt0_009, LINK(ttrace_generic))	/* instr access mmu miss */
	TTRACE(tt0_00a, NOTRACE)		/* instruction access error */
	TTRACE(tt0_00b, NOTRACE)		/* reserved */
	TTRACE(tt0_00c, NOTRACE)		/* reserved */
	TTRACE(tt0_00d, NOTRACE)		/* reserved */
	TTRACE(tt0_00e, NOTRACE)		/* reserved */
	TTRACE(tt0_00f, NOTRACE)		/* reserved */
	TTRACE(tt0_010, NOTRACE)		/* illegal instruction */
	TTRACE(tt0_011, NOTRACE)		/* privileged opcode */
	TTRACE(tt0_012, NOTRACE)		/* unimplemented LDD */
	TTRACE(tt0_013, NOTRACE)		/* unimplemented STD */
	TTRACE(tt0_014, NOTRACE)		/* reserved */
	TTRACE(tt0_015, NOTRACE)		/* reserved */
	TTRACE(tt0_016, NOTRACE)		/* reserved */
	TTRACE(tt0_017, NOTRACE)		/* reserved */
	TTRACE(tt0_018, NOTRACE)		/* reserved */
	TTRACE(tt0_019, NOTRACE)		/* reserved */
	TTRACE(tt0_01a, NOTRACE)		/* reserved */
	TTRACE(tt0_01b, NOTRACE)		/* reserved */
	TTRACE(tt0_01c, NOTRACE)		/* reserved */
	TTRACE(tt0_01d, NOTRACE)		/* reserved */
	TTRACE(tt0_01e, NOTRACE)		/* reserved */
	TTRACE(tt0_01f, NOTRACE)		/* reserved */
	TTRACE(tt0_020, NOTRACE)		/* fp disabled */
	TTRACE(tt0_021, NOTRACE)		/* fp exception ieee 754 */
	TTRACE(tt0_022, NOTRACE)		/* fp exception other */
	TTRACE(tt0_023, NOTRACE)		/* tag overflow */
	BIG_TTRACE(tt0_024, NOTRACE)		/* TRC?? clean window */
	TTRACE(tt0_028, NOTRACE)		/* division by zero */
	TTRACE(tt0_029, NOTRACE)		/* internal processor error */
	TTRACE(tt0_02a, NOTRACE)		/* reserved */
	TTRACE(tt0_02b, NOTRACE)		/* reserved */
	TTRACE(tt0_02c, NOTRACE)		/* reserved */
	TTRACE(tt0_02d, NOTRACE)		/* reserved */
	TTRACE(tt0_02e, NOTRACE)		/* reserved */
	TTRACE(tt0_02f, NOTRACE)		/* reserved */
	TTRACE(tt0_030, LINK(ttrace_dmmu))	/* data access exception */
	TTRACE(tt0_031, NOTRACE)		/* data access mmu miss */
	TTRACE(tt0_032, NOTRACE)		/* data access error */
	TTRACE(tt0_033, NOTRACE)		/* data access protection */
	TTRACE(tt0_034, LINK(ttrace_dmmu))	/* mem address not aligned */
	TTRACE(tt0_035, LINK(ttrace_dmmu))	/* lddf mem addr not aligned */
	TTRACE(tt0_036, LINK(ttrace_dmmu))	/* stdf mem addr not aligned */
	TTRACE(tt0_037, LINK(ttrace_dmmu))	/* privileged action */
	TTRACE(tt0_038, LINK(ttrace_dmmu))	/* ldqf mem addr not aligned */
	TTRACE(tt0_039, LINK(ttrace_dmmu))	/* stqf mem addr not aligned */
	TTRACE(tt0_03a, NOTRACE)		/* reserved */
	TTRACE(tt0_03b, NOTRACE)		/* reserved */
	TTRACE(tt0_03c, NOTRACE)		/* reserved */
	TTRACE(tt0_03d, NOTRACE)		/* reserved */
	TTRACE(tt0_03e, NOTRACE)		/* HV: real immu miss */
	TTRACE(tt0_03f, NOTRACE)		/* HV: real dmmu miss */
	TTRACE(tt0_040, NOTRACE)		/* async data error */
	TTRACE(tt0_041, NOTRACE)		/* interrupt level 1 */
	TTRACE(tt0_042, NOTRACE)		/* interrupt level 2 */
	TTRACE(tt0_043, NOTRACE)		/* interrupt level 3 */
	TTRACE(tt0_044, NOTRACE)		/* interrupt level 4 */
	TTRACE(tt0_045, NOTRACE)		/* interrupt level 5 */
	TTRACE(tt0_046, NOTRACE)		/* interrupt level 6 */
	TTRACE(tt0_047, NOTRACE)		/* interrupt level 7 */
	TTRACE(tt0_048, NOTRACE)		/* interrupt level 8 */
	TTRACE(tt0_049, NOTRACE)		/* interrupt level 9 */
	TTRACE(tt0_04a, NOTRACE)		/* interrupt level a */
	TTRACE(tt0_04b, NOTRACE)		/* interrupt level b */
	TTRACE(tt0_04c, NOTRACE)		/* interrupt level c */
	TTRACE(tt0_04d, NOTRACE)		/* interrupt level d */
	TTRACE(tt0_04e, NOTRACE)		/* interrupt level e */
	TTRACE(tt0_04f, NOTRACE)		/* interrupt level f */
	TTRACE(tt0_050, NOTRACE)		/* reserved */
	TTRACE(tt0_051, NOTRACE)		/* reserved */
	TTRACE(tt0_052, NOTRACE)		/* reserved */
	TTRACE(tt0_053, NOTRACE)		/* reserved */
	TTRACE(tt0_054, NOTRACE)		/* reserved */
	TTRACE(tt0_055, NOTRACE)		/* reserved */
	TTRACE(tt0_056, NOTRACE)		/* reserved */
	TTRACE(tt0_057, NOTRACE)		/* reserved */
	TTRACE(tt0_058, NOTRACE)		/* reserved */
	TTRACE(tt0_059, NOTRACE)		/* reserved */
	TTRACE(tt0_05a, NOTRACE)		/* reserved */
	TTRACE(tt0_05b, NOTRACE)		/* reserved */
	TTRACE(tt0_05c, NOTRACE)		/* reserved */
	TTRACE(tt0_05d, NOTRACE)		/* reserved */
	TTRACE(tt0_05e, NOTRACE)		/* HV: hstick match */
	TTRACE(tt0_05f, NOTRACE)		/* reserved */
	TTRACE(tt0_060, NOTRACE)		/* interrupt vector */
	TTRACE(tt0_061, NOTRACE)		/* RA watchpoint */
	TTRACE(tt0_062, NOTRACE)		/* VA watchpoint */
	TTRACE(tt0_063, NOTRACE)		/* corrected ECC error XXX */
	BIG_TTRACE(tt0_064, NOTRACE)		/* fast instr access MMU miss */
	BIG_TTRACE(tt0_068, NOTRACE)		/* fast data access MMU miss */
	BIG_TTRACE(tt0_06C, NOTRACE)		/* fast data access prot */
	TTRACE(tt0_070, NOTRACE)		/* reserved */
	TTRACE(tt0_071, NOTRACE)		/* reserved */
	TTRACE(tt0_072, NOTRACE)		/* reserved */
	TTRACE(tt0_073, NOTRACE)		/* reserved */
	TTRACE(tt0_074, NOTRACE)		/* reserved */
	TTRACE(tt0_075, NOTRACE)		/* reserved */
	TTRACE(tt0_076, NOTRACE)		/* reserved */
	TTRACE(tt0_077, NOTRACE)		/* reserved */
	TTRACE(tt0_078, NOTRACE)		/* data error (disrupting) */
	TTRACE(tt0_079, NOTRACE)		/* reserved */
	TTRACE(tt0_07a, NOTRACE)		/* reserved */
	TTRACE(tt0_07b, NOTRACE)		/* reserved */
	TTRACE(tt0_07c, NOTRACE)		/* HV: cpu mondo */
	TTRACE(tt0_07d, NOTRACE)		/* HV: dev mondo */
	TTRACE(tt0_07e, NOTRACE)		/* HV: resumable error */
	TTRACE(tt0_07f, NOTRACE)		/* HV: non-resumable error */
	BIG_TTRACE(tt0_080, NOTRACE)		/* spill 0 normal */
	BIG_TTRACE(tt0_084, NOTRACE)		/* spill 1 normal */
	BIG_TTRACE(tt0_088, NOTRACE)		/* spill 2 normal */
	BIG_TTRACE(tt0_08c, NOTRACE)		/* spill 3 normal */
	BIG_TTRACE(tt0_090, NOTRACE)		/* spill 4 normal */
	BIG_TTRACE(tt0_094, NOTRACE)		/* spill 5 normal */
	BIG_TTRACE(tt0_098, NOTRACE)		/* spill 6 normal */
	BIG_TTRACE(tt0_09c, NOTRACE)		/* spill 7 normal */
	BIG_TTRACE(tt0_0a0, NOTRACE)		/* spill 0 other */
	BIG_TTRACE(tt0_0a4, NOTRACE)		/* spill 1 other */
	BIG_TTRACE(tt0_0a8, NOTRACE)		/* spill 2 other */
	BIG_TTRACE(tt0_0ac, NOTRACE)		/* spill 3 other */
	BIG_TTRACE(tt0_0b0, NOTRACE)		/* spill 4 other */
	BIG_TTRACE(tt0_0b4, NOTRACE)		/* spill 5 other */
	BIG_TTRACE(tt0_0b8, NOTRACE)		/* spill 6 other */
	BIG_TTRACE(tt0_0bc, NOTRACE)		/* spill 7 other */
	BIG_TTRACE(tt0_0c0, NOTRACE)		/* fill 0 normal */
	BIG_TTRACE(tt0_0c4, NOTRACE)		/* fill 1 normal */
	BIG_TTRACE(tt0_0c8, NOTRACE)		/* fill 2 normal */
	BIG_TTRACE(tt0_0cc, NOTRACE)		/* fill 3 normal */
	BIG_TTRACE(tt0_0d0, NOTRACE)		/* fill 4 normal */
	BIG_TTRACE(tt0_0d4, NOTRACE)		/* fill 5 normal */
	BIG_TTRACE(tt0_0d8, NOTRACE)		/* fill 6 normal */
	BIG_TTRACE(tt0_0dc, NOTRACE)		/* fill 7 normal */
	BIG_TTRACE(tt0_0e0, NOTRACE)		/* fill 0 other */
	BIG_TTRACE(tt0_0e4, NOTRACE)		/* fill 1 other */
	BIG_TTRACE(tt0_0e8, NOTRACE)		/* fill 2 other */
	BIG_TTRACE(tt0_0ec, NOTRACE)		/* fill 3 other */
	BIG_TTRACE(tt0_0f0, NOTRACE)		/* fill 4 other */
	BIG_TTRACE(tt0_0f4, NOTRACE)		/* fill 5 other */
	BIG_TTRACE(tt0_0f8, NOTRACE)		/* fill 6 other */
	BIG_TTRACE(tt0_0fc, NOTRACE)		/* fill 7 other */
	/*
	 * Software traps
	 */
	TTRACE(tt0_100, NOTRACE)		/* software trap */
	TTRACE(tt0_101, NOTRACE)		/* software trap */
	TTRACE(tt0_102, NOTRACE)		/* software trap */
	TTRACE(tt0_103, NOTRACE)		/* software trap */
	TTRACE(tt0_104, NOTRACE)		/* software trap */
	TTRACE(tt0_105, NOTRACE)		/* software trap */
	TTRACE(tt0_106, NOTRACE)		/* software trap */
	TTRACE(tt0_107, NOTRACE)		/* software trap */
	TTRACE(tt0_108, NOTRACE)		/* software trap */
	TTRACE(tt0_109, NOTRACE)		/* software trap */
	TTRACE(tt0_10a, NOTRACE)		/* software trap */
	TTRACE(tt0_10b, NOTRACE)		/* software trap */
	TTRACE(tt0_10c, NOTRACE)		/* software trap */
	TTRACE(tt0_10d, NOTRACE)		/* software trap */
	TTRACE(tt0_10e, NOTRACE)		/* software trap */
	TTRACE(tt0_10f, NOTRACE)		/* software trap */
	TTRACE(tt0_110, NOTRACE)		/* software trap */
	TTRACE(tt0_111, NOTRACE)		/* software trap */
	TTRACE(tt0_112, NOTRACE)		/* software trap */
	TTRACE(tt0_113, NOTRACE)		/* software trap */
	TTRACE(tt0_114, NOTRACE)		/* software trap */
	TTRACE(tt0_115, NOTRACE)		/* software trap */
	TTRACE(tt0_116, NOTRACE)		/* software trap */
	TTRACE(tt0_117, NOTRACE)		/* software trap */
	TTRACE(tt0_118, NOTRACE)		/* software trap */
	TTRACE(tt0_119, NOTRACE)		/* software trap */
	TTRACE(tt0_11a, NOTRACE)		/* software trap */
	TTRACE(tt0_11b, NOTRACE)		/* software trap */
	TTRACE(tt0_11c, NOTRACE)		/* software trap */
	TTRACE(tt0_11d, NOTRACE)		/* software trap */
	TTRACE(tt0_11e, NOTRACE)		/* software trap */
	TTRACE(tt0_11f, NOTRACE)		/* software trap */
	TTRACE(tt0_120, NOTRACE)		/* software trap */
	TTRACE(tt0_121, NOTRACE)		/* software trap */
	TTRACE(tt0_122, NOTRACE)		/* software trap */
	TTRACE(tt0_123, NOTRACE)		/* software trap */
	TTRACE(tt0_124, NOTRACE)		/* software trap */
	TTRACE(tt0_125, NOTRACE)		/* software trap */
	TTRACE(tt0_126, NOTRACE)		/* software trap */
	TTRACE(tt0_127, NOTRACE)		/* software trap */
	TTRACE(tt0_128, NOTRACE)		/* software trap */
	TTRACE(tt0_129, NOTRACE)		/* software trap */
	TTRACE(tt0_12a, NOTRACE)		/* software trap */
	TTRACE(tt0_12b, NOTRACE)		/* software trap */
	TTRACE(tt0_12c, NOTRACE)		/* software trap */
	TTRACE(tt0_12d, NOTRACE)		/* software trap */
	TTRACE(tt0_12e, NOTRACE)		/* software trap */
	TTRACE(tt0_12f, NOTRACE)		/* software trap */
	TTRACE(tt0_130, NOTRACE)		/* software trap */
	TTRACE(tt0_131, NOTRACE)		/* software trap */
	TTRACE(tt0_132, NOTRACE)		/* software trap */
	TTRACE(tt0_133, NOTRACE)		/* software trap */
	TTRACE(tt0_134, NOTRACE)		/* software trap */
	TTRACE(tt0_135, NOTRACE)		/* software trap */
	TTRACE(tt0_136, NOTRACE)		/* software trap */
	TTRACE(tt0_137, NOTRACE)		/* software trap */
	TTRACE(tt0_138, NOTRACE)		/* software trap */
	TTRACE(tt0_139, NOTRACE)		/* software trap */
	TTRACE(tt0_13a, NOTRACE)		/* software trap */
	TTRACE(tt0_13b, NOTRACE)		/* software trap */
	TTRACE(tt0_13c, NOTRACE)		/* software trap */
	TTRACE(tt0_13d, NOTRACE)		/* software trap */
	TTRACE(tt0_13e, NOTRACE)		/* software trap */
	TTRACE(tt0_13f, NOTRACE)		/* software trap */
	TTRACE(tt0_140, NOTRACE)		/* software trap */
	TTRACE(tt0_141, NOTRACE)		/* software trap */
	TTRACE(tt0_142, NOTRACE)		/* software trap */
	TTRACE(tt0_143, NOTRACE)		/* software trap */
	TTRACE(tt0_144, NOTRACE)		/* software trap */
	TTRACE(tt0_145, NOTRACE)		/* software trap */
	TTRACE(tt0_146, NOTRACE)		/* software trap */
	TTRACE(tt0_147, NOTRACE)		/* software trap */
	TTRACE(tt0_148, NOTRACE)		/* software trap */
	TTRACE(tt0_149, NOTRACE)		/* software trap */
	TTRACE(tt0_14a, NOTRACE)		/* software trap */
	TTRACE(tt0_14b, NOTRACE)		/* software trap */
	TTRACE(tt0_14c, NOTRACE)		/* software trap */
	TTRACE(tt0_14d, NOTRACE)		/* software trap */
	TTRACE(tt0_14e, NOTRACE)		/* software trap */
	TTRACE(tt0_14f, NOTRACE)		/* software trap */
	TTRACE(tt0_150, NOTRACE)		/* software trap */
	TTRACE(tt0_151, NOTRACE)		/* software trap */
	TTRACE(tt0_152, NOTRACE)		/* software trap */
	TTRACE(tt0_153, NOTRACE)		/* software trap */
	TTRACE(tt0_154, NOTRACE)		/* software trap */
	TTRACE(tt0_155, NOTRACE)		/* software trap */
	TTRACE(tt0_156, NOTRACE)		/* software trap */
	TTRACE(tt0_157, NOTRACE)		/* software trap */
	TTRACE(tt0_158, NOTRACE)		/* software trap */
	TTRACE(tt0_159, NOTRACE)		/* software trap */
	TTRACE(tt0_15a, NOTRACE)		/* software trap */
	TTRACE(tt0_15b, NOTRACE)		/* software trap */
	TTRACE(tt0_15c, NOTRACE)		/* software trap */
	TTRACE(tt0_15d, NOTRACE)		/* software trap */
	TTRACE(tt0_15e, NOTRACE)		/* software trap */
	TTRACE(tt0_15f, NOTRACE)		/* software trap */
	TTRACE(tt0_160, NOTRACE)		/* software trap */
	TTRACE(tt0_161, NOTRACE)		/* software trap */
	TTRACE(tt0_162, NOTRACE)		/* software trap */
	TTRACE(tt0_163, NOTRACE)		/* software trap */
	TTRACE(tt0_164, NOTRACE)		/* software trap */
	TTRACE(tt0_165, NOTRACE)		/* software trap */
	TTRACE(tt0_166, NOTRACE)		/* software trap */
	TTRACE(tt0_167, NOTRACE)		/* software trap */
	TTRACE(tt0_168, NOTRACE)		/* software trap */
	TTRACE(tt0_169, NOTRACE)		/* software trap */
	TTRACE(tt0_16a, NOTRACE)		/* software trap */
	TTRACE(tt0_16b, NOTRACE)		/* software trap */
	TTRACE(tt0_16c, NOTRACE)		/* software trap */
	TTRACE(tt0_16d, NOTRACE)		/* software trap */
	TTRACE(tt0_16e, NOTRACE)		/* software trap */
	TTRACE(tt0_16f, NOTRACE)		/* software trap */
	TTRACE(tt0_170, NOTRACE)		/* software trap */
	TTRACE(tt0_171, NOTRACE)		/* software trap */
	TTRACE(tt0_172, NOTRACE)		/* software trap */
	TTRACE(tt0_173, NOTRACE)		/* software trap */
	TTRACE(tt0_174, NOTRACE)		/* software trap */
	TTRACE(tt0_175, NOTRACE)		/* software trap */
	TTRACE(tt0_176, NOTRACE)		/* software trap */
	TTRACE(tt0_177, NOTRACE)		/* software trap */
	TTRACE(tt0_178, NOTRACE)		/* software trap */
	TTRACE(tt0_179, NOTRACE)		/* software trap */
	TTRACE(tt0_17a, NOTRACE)		/* software trap */
	TTRACE(tt0_17b, NOTRACE)		/* software trap */
	TTRACE(tt0_17c, NOTRACE)		/* software trap */
	TTRACE(tt0_17d, NOTRACE)		/* software trap */
	TTRACE(tt0_17e, NOTRACE)		/* software trap */
	TTRACE(tt0_17f, NOTRACE)		/* software trap */
	TTRACE(tt0_180, LINK(ttrace_hcall))	/* hypervisor software trap */
	TTRACE(tt0_181, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_182, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_183, LINK(ttrace_mmu_map))	/* hyp software trap */
	TTRACE(tt0_184, LINK(ttrace_mmu_unmap)) /* hyp software trap */
	TTRACE(tt0_185, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_186, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_187, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_188, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_189, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_18a, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_18b, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_18c, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_18d, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_18e, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_18f, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_190, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_191, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_192, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_193, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_194, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_195, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_196, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_197, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_198, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_199, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_19a, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_19b, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_19c, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_19d, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_19e, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_19f, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1a0, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1a1, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1a2, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1a3, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1a4, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1a5, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1a6, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1a7, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1a8, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1a9, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1aa, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1ab, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1ac, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1ad, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1ae, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1af, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1b0, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1b1, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1b2, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1b3, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1b4, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1b5, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1b6, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1b7, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1b8, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1b9, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1ba, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1bb, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1bc, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1bd, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1be, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1bf, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1c0, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1c1, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1c2, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1c3, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1c4, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1c5, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1c6, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1c7, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1c8, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1c9, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1ca, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1cb, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1cc, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1cd, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1ce, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1cf, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1d0, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1d1, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1d2, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1d3, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1d4, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1d5, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1d6, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1d7, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1d8, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1d9, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1da, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1db, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1dc, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1dd, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1de, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1df, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1e0, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1e1, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1e2, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1e3, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1e4, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1e5, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1e6, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1e7, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1e8, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1e9, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1ea, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1eb, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1ec, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1ed, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1ee, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1ef, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1f0, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1f1, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1f2, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1f3, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1f4, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1f5, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1f6, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1f7, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1f8, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1f9, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1fa, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1fb, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1fc, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1fd, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1fe, NOTRACE)		/* hypervisor software trap */
	TTRACE(tt0_1ff, LINK(ttrace_hcall))	/* hypervisor software trap */
ehtraptracetable:
	SET_SIZE(htraptracetable)



	ENTRY_NP(watchdog)
	LEGION_GOT_HERE
	rdhpr	%htstate, %g1
	btst	HTSTATE_HPRIV, %g1
	bz	1f
	nop

	/* XXX hypervisor_fatal */

1:
	! Disable MMU
	ldxa	[%g0]ASI_LSUCR, %g1
	set	(LSUCR_DM | LSUCR_IM), %g2
	andn	%g1, %g2, %g1	! disable MMU
	stxa	%g1, [%g0]ASI_LSUCR

	! Get real-mode trap table base address
	mov	HSCRATCH0, %g1
	ldxa	[%g1]ASI_HSCRATCHPAD, %g1
	ldx	[%g1 + CPU_RTBA], %g1
	add	%g1, (WATCHDOG_TT << TT_OFFSET_SHIFT), %g1
	wrpr	%g1, %tnpc
	done
	SET_SIZE(watchdog)

	/* XXX for now just go to the guest since that tends
	 * to be what we are debugging */

	ENTRY_NP(xir)
	wrpr	%g0, 1, %tl
	rdhpr	%hpstate, %g7
	wrhpr	%g7, HPSTATE_RED, %hpstate
	LEGION_GOT_HERE

	! Disable MMU
	ldxa	[%g0]ASI_LSUCR, %g1
	set	(LSUCR_DM | LSUCR_IM), %g2
	andn	%g1, %g2, %g1	! disable MMU
	stxa	%g1, [%g0]ASI_LSUCR

	! Get real-mode trap table base address
	mov	HSCRATCH0, %g1
	ldxa	[%g1]ASI_HSCRATCHPAD, %g1
	ldx	[%g1 + CPU_RTBA], %g1
	wrpr	%g1, %tba
	add	%g1, (XIR_TT << TT_OFFSET_SHIFT), %g1
	wrpr	%g1, %tnpc
	done
	SET_SIZE(xir)

	ENTRY_NP(revector)
	rdhpr	%htstate, %g1
	btst	HTSTATE_HPRIV, %g1
	bnz,pn	%xcc, trap
	rdpr	%pstate, %g1
	or	%g1, PSTATE_PRIV, %g1
	wrpr	%g1, %pstate
	rdpr	%tba, %g1
	rdpr	%tt, %g2
	sllx	%g2, 5, %g2
	add	%g1, %g2, %g1
	rdpr	%tl, %g3
	cmp	%g3, MAXPTL
	bgu,pn	%xcc, watchdog_guest
	clr	%g2
	cmp	%g3, 1
	movne	%xcc, 1, %g2
	sllx	%g2, 14, %g2
	mov	HPSTATE_GUEST, %g3
	jmp	%g1 + %g2
	wrhpr	%g3, %hpstate	! keep ENB bit
	SET_SIZE(revector)


	ENTRY_NP(trap)
	LEGION_GOT_HERE

	PRINT_NOTRAP("UNEXPECTED TRAP:  tt: ")
	rdpr	%tt, %g1
	PRINTW_NOTRAP(%g1)

	PRINT_NOTRAP(" tl: ")
	rdpr	%tl, %g1
	PRINTW_NOTRAP(%g1)

	PRINT_NOTRAP(" gl: ")
	rdpr	%gl, %g1
	PRINTW_NOTRAP(%g1)

	PRINT_NOTRAP(" tpc: ")
	rdpr	%tpc, %g1
	PRINTX_NOTRAP(%g1)
	PRINT_NOTRAP("\r\n")
#ifdef DEBUG
	LEGION_EXIT(2)
1:	ba,a	1b
	done
#else
	rdpr	%tba, %g3
	rdpr	%tt, %g4	!  XXX change tt to something else?
	sllx	%g4, 5, %g4
	add	%g3, %g4, %g3
	rdpr	%tl, %g4
	cmp	%g4, 1
	bleu,pn	%xcc, 1f
	nop
	set	TRAPTABLE_SIZE, %g2
	or	%g3, %g2, %g3
1:
	mov	HPSTATE_GUEST, %g5
	jmp	%g3
	wrhpr	%g5, %hpstate	! keep ENB bit
#endif
	SET_SIZE(trap)

	ENTRY_NP(watchdog_guest)
#ifdef DEBUG /* { */
	LEGION_GOT_HERE
	mov	HSCRATCH0, %g1
	ldxa	[%g1]ASI_HSCRATCHPAD, %g1

	! Save some locals so we can use them while moving around
	! the trap levels
	stx	%l0, [%g1 + CPU_SCR0]
	stx	%l1, [%g1 + CPU_SCR1]
	stx	%l2, [%g1 + CPU_SCR2]
	stx	%l3, [%g1 + CPU_SCR3]
	mov	%g1, %l0

	! Save current %tl and %gl
	rdpr	%tl, %l2
	set	CPU_FAIL_TL, %l1
	stx	%l2, [%l0 + %l1]
	rdpr	%gl, %l2
	set	CPU_FAIL_GL, %l1
	stx	%l2, [%l0 + %l1]

	! for each %tl 1..%tl
	set	CPU_FAIL_TRAPSTATE, %l1
	add	%l0, %l1, %l1
	rdpr	%tl, %l2
	sub	%l2, 1, %l3		! tl - 1
	mulx	%l3, TRAPSTATE_SIZE, %l3
	add	%l1, %l3, %l1	! %l1 pointer to current trapstate
1:	wrpr	%l2, %tl	! %l2 current tl
	rdhpr	%htstate, %l3
	stx	%l3, [%l1 + TRAPSTATE_HTSTATE]
	rdpr	%tstate, %l3
	stx	%l3, [%l1 + TRAPSTATE_TSTATE]
	rdpr	%tt, %l3
	stx	%l3, [%l1 + TRAPSTATE_TT]
	rdpr	%tpc, %l3
	stx	%l3, [%l1 + TRAPSTATE_TPC]
	rdpr	%tnpc, %l3
	stx	%l3, [%l1 + TRAPSTATE_TNPC]
	deccc	%l2
	bnz,pt	%xcc, 1b
	dec	TRAPSTATE_SIZE, %l1

	! for each %gl 0..%gl-1
	set	CPU_FAIL_TRAPGLOBALS, %l1
	add	%l0, %l1, %l1
	rdpr	%gl, %l2
	dec	%l2		! gl - 1
	mulx	%l2, TRAPGLOBALS_SIZE, %l3
	add	%l1, %l3, %l1	! %l1 pointer to current trapglobals
1:	wrpr	%l2, %gl	! %l2 current gl
	stx	%g0, [%l1 + 0x00]
	stx	%g1, [%l1 + 0x08]
	stx	%g2, [%l1 + 0x10]
	stx	%g3, [%l1 + 0x18]
	stx	%g4, [%l1 + 0x20]
	stx	%g5, [%l1 + 0x28]
	stx	%g6, [%l1 + 0x30]
	stx	%g7, [%l1 + 0x38]
	deccc	%l2
	bge,pt	%xcc, 1b
	dec	TRAPGLOBALS_SIZE, %l1

	! Restore state
	set	CPU_FAIL_TL, %l1
	ldx	[%l0 + %l1], %l2
	wrpr	%l2, %tl
	set	CPU_FAIL_GL, %l1
	ldx	[%l0 + %l1], %l2
	wrpr	%l2, %gl

	DEBUG_SPINLOCK_ENTER(%g1, %g2, %g3)

	PRINT_NOTRAP("WATCHDOG: pcpu: ")
	ldub	[%l0 + CPU_PID], %g1
	PRINTW_NOTRAP(%g1)

	PRINT_NOTRAP(" tl: ")
	rdpr	%tl, %g1
	PRINTW_NOTRAP(%g1)

	PRINT_NOTRAP(" tt: ")
	rdpr	%tt, %g1
	PRINTW_NOTRAP(%g1)

	PRINT_NOTRAP(" gl: ")
	rdpr	%gl, %g1
	PRINTW_NOTRAP(%g1)
	PRINT_NOTRAP("\r\n")

	PRINT_NOTRAP(" trap state:\r\n");
	set	CPU_FAIL_TRAPSTATE, %l1
	add	%l0, %l1, %l1
	rdpr	%tl, %l2
	mov	1, %l3
1:	
	PRINT_NOTRAP("  tl: ");
	mov	%l3, %g1
	PRINTW_NOTRAP(%g1)

	PRINT_NOTRAP(" tt: ");
	ldx	[%l1 + TRAPSTATE_TT], %g1
	PRINTW_NOTRAP(%g1)

	PRINT_NOTRAP(" htstate: ");
	ldx	[%l1 + TRAPSTATE_HTSTATE], %g1
	PRINTW(%g1)

	PRINT_NOTRAP(" tstate: ");
	ldx	[%l1 + TRAPSTATE_TSTATE], %g1
	PRINTX_NOTRAP(%g1)

	PRINT_NOTRAP("\r\n   tpc: ");
	ldx	[%l1 + TRAPSTATE_TPC], %g1
	PRINTX_NOTRAP(%g1)

	PRINT_NOTRAP(" tnpc: ");
	ldx	[%l1 + TRAPSTATE_TNPC], %g1
	PRINTX_NOTRAP(%g1)
	PRINT_NOTRAP("\r\n");
	inc	%l3
	cmp	%l3, %l2
	bleu,pt	%xcc, 1b
	inc	TRAPSTATE_SIZE, %l1
	
	PRINT_NOTRAP(" trap globals:\r\n");
	set	CPU_FAIL_TRAPGLOBALS, %l1
	add	%l0, %l1, %l1
	rdpr	%gl, %l2
	mov	0, %l3
1:	
	PRINT_NOTRAP("  gl: ");
	PRINTW_NOTRAP(%l3)

	PRINT_NOTRAP("\r\n");
	PRINT_NOTRAP("   %g0-%g3: ");
	ldx	[%l1 + 0x00], %g1
	PRINTX_NOTRAP(%g1)
	PRINT_NOTRAP(" ");
	ldx	[%l1 + 0x08], %g1
	PRINTX_NOTRAP(%g1)
	PRINT_NOTRAP(" ");
	ldx	[%l1 + 0x10], %g1
	PRINTX_NOTRAP(%g1)
	PRINT_NOTRAP(" ");
	ldx	[%l1 + 0x18], %g1
	PRINTX_NOTRAP(%g1)
	PRINT_NOTRAP("\r\n");
	PRINT_NOTRAP("   %g4-%g7: ");
	ldx	[%l1 + 0x20], %g1
	PRINTX_NOTRAP(%g1)
	PRINT_NOTRAP(" ");
	ldx	[%l1 + 0x28], %g1
	PRINTX_NOTRAP(%g1)
	PRINT_NOTRAP(" ");
	ldx	[%l1 + 0x30], %g1
	PRINTX_NOTRAP(%g1)
	PRINT_NOTRAP(" ");
	ldx	[%l1 + 0x38], %g1
	PRINTX_NOTRAP(%g1)
	PRINT_NOTRAP("\r\n");
	inc	%l3
	cmp	%l3, %l2
	blu,pt	%xcc, 1b
	inc	TRAPGLOBALS_SIZE, %l1

	PRINT_NOTRAP("rtba: ")
	mov	HSCRATCH0, %g1
	ldxa	[%g1]ASI_HSCRATCHPAD, %g1
	ldx	[%g1 + CPU_RTBA], %g1
	PRINTX_NOTRAP(%g1)
	PRINT_NOTRAP("\r\n");

	ldx	[%l0 + CPU_ROOT], %g1
	add	%g1, CONFIG_DEBUG_SPINLOCK, %g1
	DEBUG_SPINLOCK_EXIT(%g1)

	! Restore saved locals
	ldx	[%l0 + CPU_SCR3], %l3
	ldx	[%l0 + CPU_SCR2], %l2
	ldx	[%l0 + CPU_SCR1], %l1
	ldx	[%l0 + CPU_SCR0], %l0
#endif /* } DEBUG */
	! Disable MMU
	ldxa	[%g0]ASI_LSUCR, %g1
	set	(LSUCR_DM | LSUCR_IM), %g2
	andn	%g1, %g2, %g1	! disable MMU
	stxa	%g1, [%g0]ASI_LSUCR

	! Get real-mode trap table base address
	mov	HSCRATCH0, %g3
	ldxa	[%g3]ASI_HSCRATCHPAD, %g3
	ldx	[%g3 + CPU_RTBA], %g3
	add	%g3, (WATCHDOG_TT << TT_OFFSET_SHIFT), %g3
	rdpr	%tt, %g5
	wrpr	%g0, MAXPTL, %tl
	wrpr	%g5, %tt
	mov	%g3, %o0	! XXX clobbering %o0
	wrpr	%g0, MAXPGL, %gl
	mov	HPSTATE_GUEST, %g1 ! XXX clobbering %g1
	jmp	%o0
	wrhpr	%g1, %hpstate	! set ENB bit
	SET_SIZE(watchdog_guest)

#define TTRACE_EXIT					 \
	set	(htraptracetable - htraptable), %g1	;\
	neg	%g1					;\
	jmp	%g7 + %g1				;\
	 nop

	! ttrace_generic
	! General purpose trap trace routine.
	!
	! Records state. (See traptrace.h for details.)
	! Variable Fields:
	!	All fields are zeroed.
	!
	! Expects: %g7 to contain PC of trap table entry
	!
	ENTRY_NP(ttrace_generic)
	TTRACE_PTR(%g1, %g2, 1f, 1f)
	TTRACE_STATE(%g2, TTRACE_TYPE_HV, %g3, %g4)
	sth	%g0, [%g2 + TTRACE_ENTRY_TAG]
	stx	%g0, [%g2 + TTRACE_ENTRY_F1]
	stx	%g0, [%g2 + TTRACE_ENTRY_F2]
	stx	%g0, [%g2 + TTRACE_ENTRY_F3]
	stx	%g0, [%g2 + TTRACE_ENTRY_F4]
	TTRACE_NEXT(%g2, %g3, %g4, %g5)
1:	TTRACE_EXIT
	SET_SIZE(ttrace_generic)

	! ttrace_immu
	! Traces instruction access exceptions.
	!
	! Records state. (See traptrace.h for details.)
	! Variable Fields:
	!	F1 = IMMU SFSR
	!
	! Expects: %g7 to contain PC of trap table entry
	!
	ENTRY_NP(ttrace_immu)
	TTRACE_PTR(%g1, %g2, 1f, 1f)
	TTRACE_STATE(%g2, TTRACE_TYPE_HV, %g3, %g4)
	sth	%g0, [%g2 + TTRACE_ENTRY_TAG]
	mov	MMU_SFSR, %g4
	ldxa	[%g4]ASI_IMMU, %g4
	stx	%g4, [%g2 + TTRACE_ENTRY_F1]
	stx	%g0, [%g2 + TTRACE_ENTRY_F2]
	stx	%g0, [%g2 + TTRACE_ENTRY_F3]
	stx	%g0, [%g2 + TTRACE_ENTRY_F4]
	TTRACE_NEXT(%g2, %g3, %g4, %g5)
1:	TTRACE_EXIT
	SET_SIZE(ttrace_immu)

	! ttrace_dmmu
	! Traces data mmu exceptions.
	!
	! Records state. (See traptrace.h for details.)
	! Variable Fields:
	!	F1 = DMMU SFSR
	!	F2 = DMMU SFAR
	!   
	! Expects: %g7 to contain PC of trap table entry
	!
	ENTRY_NP(ttrace_dmmu)
	TTRACE_PTR(%g1, %g2, 1f, 1f)
	TTRACE_STATE(%g2, TTRACE_TYPE_HV, %g3, %g4)
	sth	%g0, [%g2 + TTRACE_ENTRY_TAG]
	mov	MMU_SFSR, %g4
	ldxa	[%g4]ASI_DMMU, %g4
	stx	%g4, [%g2 + TTRACE_ENTRY_F1]
	mov	MMU_SFAR, %g4
	ldxa	[%g4]ASI_DMMU, %g4
	stx	%g4, [%g2 + TTRACE_ENTRY_F2]
	stx	%g0, [%g2 + TTRACE_ENTRY_F3]
	stx	%g0, [%g2 + TTRACE_ENTRY_F4]
	TTRACE_NEXT(%g2, %g3, %g4, %g5)
1:	TTRACE_EXIT
	SET_SIZE(ttrace_dmmu)

	! ttrace_hcall
	! Traces hypervisor call traps.
	!
	! Records state. (See traptrace.h for details.)
	! Variable Fields:
	!	TAG = %o5, Hypervisor Call Number
	!	F1  = %o0, Argument 0
	!	F2  = %o1, Argument 1
	!	F3  = %o2, Argument 2
	!	F4  = %o3, Argument 3
	!
	! Expects: %g7 to contain PC of trap table entry
	!
	ENTRY_NP(ttrace_hcall)
	TTRACE_PTR(%g1, %g2, 1f, 1f)
	TTRACE_STATE(%g2, TTRACE_TYPE_HV, %g3, %g4)
	sth	%o5, [%g2 + TTRACE_ENTRY_TAG]
	stx	%o0, [%g2 + TTRACE_ENTRY_F1]
	stx	%o1, [%g2 + TTRACE_ENTRY_F2]
	stx	%o2, [%g2 + TTRACE_ENTRY_F3]
	stx	%o3, [%g2 + TTRACE_ENTRY_F4]
	TTRACE_NEXT(%g2, %g3, %g4, %g5)
1:	TTRACE_EXIT
	SET_SIZE(ttrace_hcall)

	! ttrace_mmu_map
	! Traces mmu map traps.
	!
	! Records state. (See traptrace.h for details.)
	! Variable Fields:
	!	F1 = vaddr
	!	F2 = ctx
	!	F3 = TTE
	!	F4 = flags
	!
	! Expects: %g7 to contain PC of trap table entry
	!
	ENTRY_NP(ttrace_mmu_map)
	TTRACE_PTR(%g1, %g2, 1f, 1f)
	TTRACE_STATE(%g2, TTRACE_TYPE_HV, %g3, %g4)
	sth	%g0, [%g2 + TTRACE_ENTRY_TAG]
	stx	%o0, [%g2 + TTRACE_ENTRY_F1]
	stx	%o1, [%g2 + TTRACE_ENTRY_F2]
	stx	%o2, [%g2 + TTRACE_ENTRY_F3]
	stx	%o3, [%g2 + TTRACE_ENTRY_F4]
	TTRACE_NEXT(%g2, %g3, %g4, %g5)
1:	TTRACE_EXIT
	SET_SIZE(ttrace_mmu_map)

	! ttrace_mmu_unmap
	! Traces MMU Unmap traps.
	!
	! Records state. (See traptrace.h for details.)
	! Variable Fields:
	!	F1 = vaddr
	!	F2 = ctx
	!	F3 = flags
	!
	! Expects: %g7 to contain PC of trap table entry
	!
	ENTRY_NP(ttrace_mmu_unmap)
	TTRACE_PTR(%g1, %g2, 1f, 1f)
	TTRACE_STATE(%g2, TTRACE_TYPE_HV, %g3, %g4)
	sth	%g0, [%g2 + TTRACE_ENTRY_TAG]
	stx	%o0, [%g2 + TTRACE_ENTRY_F1]
	stx	%o1, [%g2 + TTRACE_ENTRY_F2]
	stx	%o2, [%g2 + TTRACE_ENTRY_F3]
	stx	%g0, [%g2 + TTRACE_ENTRY_F4]
	TTRACE_NEXT(%g2, %g3, %g4, %g5)
1:	TTRACE_EXIT
	SET_SIZE(ttrace_mmu_unmap)
