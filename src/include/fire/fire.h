/*
 * Copyright 2005 Sun Microsystems, Inc.  All rights reserved.
 * Use is subject to license terms.
 */

#ifndef _FIRE_FIRE_H
#define	_FIRE_FIRE_H

#pragma ident	"@(#)fire.h	1.5	05/06/01 SMI"


#ifdef __cplusplus
extern "C" {
#endif

#define	FIRE_A_AID	(0x1e)
#define	FIRE_B_AID	(FIRE_A_AID+1)

#define	FIRE_VINO_MIN	(FIRE_A_AID << FIRE_DEVINO_SHIFT)
#define	FIRE_VINO_MAX	((FIRE_B_AID << FIRE_DEVINO_SHIFT) | FIRE_DEVINO_MASK)

#define	NFIREDEVINO		(64)
#define	FIRE_DEVINO_MASK	(NFIREDEVINO - 1)
#define	FIRE_DEVINO_SHIFT	6

#define	FIRE_EQ2INO(n)	(24+n)
#define	FIRE_NEQS	36

#define	FIRE_MAX_MSIS	256
#define	FIRE_MSI_MASK	(FIRE_MAX_MSIS - 1)

#define	FIRE_MSIEQNUM_MASK	((1 << 6) - 1)

#define	FIRE_EQREC_SHIFT 6
#define	FIRE_EQREC_SIZE (1 << FIRE_EQREC_SHIFT)
#define	FIRE_NEQRECORDS 128

#define	FIRE_EQSIZE	(FIRE_NEQRECORDS * FIRE_EQREC_SIZE)
#define	FIRE_EQMASK	(FIRE_EQSIZE - 1)

#define	NFIREINTRCONTROLLERS 4
#define	FIRE_INTR_CNTLR_MASK	((1 << NFIREINTRCONTROLLERS) - 1)
#define	FIRE_INTR_CNTLR_SHIFT	6

#define	INTRSTATE_MASK	0x1

#define	JPID_MASK	0x1f
#define	JPID_SHIFT	26

#define	PCI_CFG_OFFSET_MASK	((1 << 12) - 1)
#define	PCI_CFG_SIZE_MASK	7
#define	PCI_DEV_MASK		(((1 << 24) - 1)^((1 << 8) -1))
#define	PCI_DEV_SHIFT		4

#define	JBUS_PA_SHIFT		43
#define	FIRE_PAGESIZE_8K_SHIFT	13

#define	FIRE_TSB_1K		0
#define	FIRE_TSB_2K		1
#define	FIRE_TSB_4K		2
#define	FIRE_TSB_8K		3
#define	FIRE_TSB_16K		4
#define	FIRE_TSB_32K		5
#define	FIRE_TSB_64K		6
#define	FIRE_TSB_128K		7
#define	FIRE_TSB_256K		8
#define	FIRE_TSB_512K		9

#define	FIRE_TSB_SIZE		FIRE_TSB_256K

#define	FIRE_IOMMU_SIZE(n)	(1 << ((n) + 10))

#define	IOTTE_SIZE		8
#define	IOTTE_SHIFT		3	/* log2(IOTTE_SIZE) */
#define	IOMMU_PAGESHIFT		13	/* 2K */
#define	IOMMU_PAGESIZE		(1 << IOMMU_PAGESHIFT)

#define	IOMMU_SPACE		(FIRE_IOMMU_SIZE(FIRE_TSB_SIZE) << \
				    IOMMU_PAGESHIFT)
#define	IOTSB_INDEX_MASK	((IOMMU_SPACE/IOMMU_PAGESIZE) - 1)
#define	IOTSB_SIZE		((IOMMU_SPACE/IOMMU_PAGESIZE) * IOTTE_SIZE)

#define	FIRE_IOTTE_V_SHIFT	63
#define	FIRE_INTMR_V_SHIFT	31
#define	FIRE_INTMR_MDO_MODE_SHIFT 63
#define	FIRE_MSIMR_V_SHIFT	63
#define	FIRE_MSIMR_EQWR_N_SHIFT	62
#define	FIRE_MSGMR_V_SHIFT	63
#define	FIRE_EQREC_TYPE_SHIFT	56
#define	FIRE_EQCCR_E2I_SHIFT	47
#define	FIRE_EQCCR_COVERR	57

#define	MSI_EQ_BASE_BYPASS_ADDR	(0xfffc000000000000LL)

#define	FIRE_INTR_IDLE		0
#define	FIRE_INTR_RECEIVED	3


#define	MSIEQ_RID_SHIFT	16
#define	MSIEQ_RID_SIZE_BITS 16

#define	MSIEQ_TID_SHIFT	16
#define	MSIEQ_TID_SIZE_BITS 8

#define	MSIEQ_MSG_RT_CODE_SHIFT 56
#define	MSIEQ_MSG_RT_CODE_SIZE_BITS 3

#define	MSIEQ_DATA_SHIFT	16
#define	MSIEQ_DATA_SIZE_BITS 16

#define	MSIEQ_MSG_CODE_SHIFT	0
#define	MSIEQ_MSG_CODE_SIZE_BITS 8

#define	PCIE_PME_MSG		0x18
#define	PCIE_PME_ACK_MSG	0x1b
#define	PCIE_CORR_MSG		0x30
#define	PCIE_NONFATAL_MSG	0x31
#define	PCIE_FATAL_MSG		0x33

#define	FIRE_CORR_OFF		0x00
#define	FIRE_NONFATAL_OFF	0x08
#define	FIRE_FATAL_OFF		0x10
#define	FIRE_PME_OFF		0x18
#define	FIRE_PME_ACK_OFF	0x20

#define	FIRE_MMU_CSR_TE		(1 << 0)	/* Translation Enable */
#define	FIRE_MMU_CSR_BE		(1 << 1)	/* Bypass Enable */
#define	FIRE_MMU_CSR_CM		(3 << 8)	/* Cache Mode */
#define	FIRE_MMU_CSR_SE		(1 << 10)	/* Snoop Enable */

#define	FIRE_MMU_CSR_VALUE	(FIRE_MMU_CSR_TE |\
				FIRE_MMU_CSR_BE |\
				FIRE_MMU_CSR_CM |\
				FIRE_MMU_CSR_SE)

#define	FIRE_IOMMU_BYPASS_BASE	(0xffffc000000000000LL)
#define	FIRE_JBUS_ID_MR_MASK	0xf
#define	FIRE_REV_1		0x1
#define	FIRE_REV_2		0x3

#ifdef __cplusplus
}
#endif

#endif /* _FIRE_FIRE_H */
