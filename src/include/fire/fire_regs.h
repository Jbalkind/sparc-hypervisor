/*
 * Copyright 2005 Sun Microsystems, Inc.  All rights reserved.
 * Use is subject to license terms.
 */

#ifndef _FIRE_REGS_H
#define	_FIRE_REGS_H

#pragma ident	"@(#)fire_regs.h	1.1	05/03/01 SMI"

#ifdef __cplusplus
extern "C" {
#endif

/* BEGIN CSTYLED */
#define	FIRE_JBUS_DEVICE_ID	0x00000000
#define	FIRE_EBUS_OFFSET_BASE	0x00400020
#define	FIRE_EBUS_OFFSET_MASK	0x00400028
#define	FIRE_PCIE_A_MEM32_OFFSET_BASE	0x00400040
#define	FIRE_PCIE_A_MEM32_OFFSET_MASK	0x00400048
#define	FIRE_PCIE_A_IOCON_OFFSET_BASE	0x00400050
#define	FIRE_PCIE_A_IOCON_OFFSET_MASK	0x00400058
#define	FIRE_PCIE_B_MEM32_OFFSET_BASE	0x00400060
#define	FIRE_PCIE_B_MEM32_OFFSET_MASK	0x00400068
#define	FIRE_PCIE_B_IOCON_OFFSET_BASE	0x00400070
#define	FIRE_PCIE_B_IOCON_OFFSET_MASK	0x00400078
#define	FIRE_PCIE_A_MEM64_OFFSET_BASE	0x00400080
#define	FIRE_PCIE_A_MEM64_OFFSET_MASK	0x00400088
#define	FIRE_PCIE_B_MEM64_OFFSET_BASE	0x00400090
#define	FIRE_PCIE_B_MEM64_OFFSET_MASK	0x00400098
#define	FIRE_FIRE_CONTROL_STATUS	0x00410000
#define	FIRE_JBUS_PLL	0x00410050
#define	FIRE_RESET_GENERATION	0x00417010
#define	FIRE_RESET_SOURCE	0x00417018
#define	FIRE_GPIO_0_DATA_0	0x00460000
#define	FIRE_GPIO_0_DATA_1	0x00460008
#define	FIRE_GPIO_0_DATA_2	0x00460010
#define	FIRE_GPIO_0_DATA_3	0x00460018
#define	FIRE_GPIO_0_DATA	0x00460020
#define	FIRE_GPIO_0_CONTROL	0x00460028
#define	FIRE_GPIO_1_DATA_0	0x00462000
#define	FIRE_GPIO_1_DATA_1	0x00462008
#define	FIRE_GPIO_1_DATA_2	0x00462010
#define	FIRE_GPIO_1_DATA_3	0x00462018
#define	FIRE_GPIO_1_DATA	0x00462020
#define	FIRE_GPIO_1_CONTROL	0x00462028
#define	FIRE_EBUS_EPROM_TIMING	0x00464000
#define	FIRE_EBUS_CS1_TIMING	0x00464008
#define	FIRE_EBUS_CS2_TIMING	0x00464010
#define	FIRE_EBUS_CS3_TIMING	0x00464018
#define	FIRE_I2C0_MONITOR_REGISTER	0x00466000
#define	FIRE_I2C0_DATA_DRIVE_REGISTER	0x00466008
#define	FIRE_I2C0_CLK_DRIVE_REGISTER	0x00466010
#define	FIRE_I2C1_MONITOR_REGISTER	0x00468000
#define	FIRE_I2C1_DATA_DRIVE_REGISTER	0x00468008
#define	FIRE_I2C1_CLK_DRIVE_REGISTER	0x00468010
#define	FIRE_A_RING_SLOW_ONLY	0x00470000
#define	FIRE_B_RING_SLOW_ONLY	0x00470008
#define	FIRE_JBUS_PAR_CTL	0x00470010
#define	FIRE_JBUS_SCRATCH_1	0x00470018
#define	FIRE_JBUS_SCRATCH_2	0x00470020
#define	FIRE_JBUS_J_ERR_EN	0x00470028
#define	FIRE_JBC_ERROR_LOG_EN_REG	0x00471000
#define	FIRE_JBC_ERROR_INT_EN_REG	0x00471008
#define	FIRE_JBC_ENABLED_ERROR_STATUS_REG	0x00471010
#define	FIRE_JBC_LOGGED_ERROR_STATUS_REG_RW1C_ALIAS	0x00471018
#define	FIRE_JBC_LOGGED_ERROR_STATUS_REG_RW1S_ALIAS	0x00471020
#define	FIRE_JBC_FATAL_RESET_ENABLE_REG	0x00471028
#define	FIRE_JBCINT_IN_TRAN_ERROR_LOG_REG	0x00471030
#define	FIRE_JBCINT_IN_STATE_ERROR_LOG_REG	0x00471038
#define	FIRE_JBCINT_OUT_TRAN_ERROR_LOG_REG	0x00471040
#define	FIRE_JBCINT_OUT_STATE_ERROR_LOG_REG	0x00471048
#define	FIRE_FATAL_ERROR_LOG_REG_1	0x00471050
#define	FIRE_FATAL_STATE_ERROR_LOG_REG	0x00471058
#define	FIRE_MERGE_TRAN_ERROR_LOG_REG	0x00471060
#define	FIRE_DMCINT_ODCD_ERROR_LOG_REG	0x00471068
#define	FIRE_DMCINT_IDC_ERROR_LOG_REG	0x00471070
#define	FIRE_CSR_ERROR_LOG_REG	0x00471078
#define	FIRE_JBC_INTERRUPT_MASK_REG	0x00471800
#define	FIRE_JBC_INTERRUPT_STATUS_REG	0x00471808
#define	FIRE_JBC_PERF_CNTRL	0x00472000
#define	FIRE_JBC_PERF_CNT0	0x00472008
#define	FIRE_JBC_PERF_CNT1	0x00472010
#define	FIRE_JBC_DBG_SEL_A_REG	0x00473000
#define	FIRE_JBC_DBG_SEL_B_REG	0x00473008
#define	FIRE_JBUS_DEVICE_ID_RESET_VALUE	0xfc00000000390000
#define	FIRE_EBUS_OFFSET_BASE_RESET_VALUE	0x8000000ff0000000
#define	FIRE_EBUS_OFFSET_MASK_RESET_VALUE	0x000007fff8000000
#define	FIRE_PCIE_A_MEM32_OFFSET_BASE_RESET_VALUE	0x0000000000000000
#define	FIRE_PCIE_A_MEM32_OFFSET_MASK_RESET_VALUE	0x000007f000000000
#define	FIRE_PCIE_A_IOCON_OFFSET_BASE_RESET_VALUE	0x0000000000000000
#define	FIRE_PCIE_A_IOCON_OFFSET_MASK_RESET_VALUE	0x000007f000000000
#define	FIRE_PCIE_B_MEM32_OFFSET_BASE_RESET_VALUE	0x0000000000000000
#define	FIRE_PCIE_B_MEM32_OFFSET_MASK_RESET_VALUE	0x000007f000000000
#define	FIRE_PCIE_B_IOCON_OFFSET_BASE_RESET_VALUE	0x0000000000000000
#define	FIRE_PCIE_B_IOCON_OFFSET_MASK_RESET_VALUE	0x000007f000000000
#define	FIRE_PCIE_A_MEM64_OFFSET_BASE_RESET_VALUE	0x0000000000000000
#define	FIRE_PCIE_A_MEM64_OFFSET_MASK_RESET_VALUE	0x000007f000000000
#define	FIRE_PCIE_B_MEM64_OFFSET_BASE_RESET_VALUE	0x0000000000000000
#define	FIRE_PCIE_B_MEM64_OFFSET_MASK_RESET_VALUE	0x000007f000000000
#define	FIRE_FIRE_CONTROL_STATUS_RESET_VALUE	0x000007f0038d6000
#define	FIRE_JBUS_PLL_RESET_VALUE	0x0000000000000006
#define	FIRE_RESET_GENERATION_RESET_VALUE	0x0000000000000000
#define	FIRE_RESET_SOURCE_RESET_VALUE	0x0000000000000000
#define	FIRE_GPIO_0_DATA_0_RESET_VALUE	0x0000000000000000
#define	FIRE_GPIO_0_DATA_1_RESET_VALUE	0x0000000000000000
#define	FIRE_GPIO_0_DATA_2_RESET_VALUE	0x0000000000000000
#define	FIRE_GPIO_0_DATA_3_RESET_VALUE	0x0000000000000000
#define	FIRE_GPIO_0_DATA_RESET_VALUE	0x0000000000000000
#define	FIRE_GPIO_0_CONTROL_RESET_VALUE	0x0000000000000000
#define	FIRE_GPIO_1_DATA_0_RESET_VALUE	0x0000000000000000
#define	FIRE_GPIO_1_DATA_1_RESET_VALUE	0x0000000000000000
#define	FIRE_GPIO_1_DATA_2_RESET_VALUE	0x0000000000000000
#define	FIRE_GPIO_1_DATA_3_RESET_VALUE	0x0000000000000000
#define	FIRE_GPIO_1_DATA_RESET_VALUE	0x0000000000000000
#define	FIRE_GPIO_1_CONTROL_RESET_VALUE	0x0000000000000000
#define	FIRE_EBUS_EPROM_TIMING_RESET_VALUE	0x000000fad5abf5f7
#define	FIRE_EBUS_CS1_TIMING_RESET_VALUE	0x000000fad5abf5f7
#define	FIRE_EBUS_CS2_TIMING_RESET_VALUE	0x000000fad5abf5f7
#define	FIRE_EBUS_CS3_TIMING_RESET_VALUE	0x000000fad5abf5f7
#define	FIRE_I2C0_MONITOR_REGISTER_RESET_VALUE	0x0000000000000000
#define	FIRE_I2C0_DATA_DRIVE_REGISTER_RESET_VALUE	0x0000000000000001
#define	FIRE_I2C0_CLK_DRIVE_REGISTER_RESET_VALUE	0x0000000000000001
#define	FIRE_I2C1_MONITOR_REGISTER_RESET_VALUE	0x0000000000000000
#define	FIRE_I2C1_DATA_DRIVE_REGISTER_RESET_VALUE	0x0000000000000001
#define	FIRE_I2C1_CLK_DRIVE_REGISTER_RESET_VALUE	0x0000000000000001
#define	FIRE_A_RING_SLOW_ONLY_RESET_VALUE	0x0000000000000000
#define	FIRE_B_RING_SLOW_ONLY_RESET_VALUE	0x0000000000000000
#define	FIRE_JBUS_PAR_CTL_RESET_VALUE	0x0000000000000000
#define	FIRE_JBUS_SCRATCH_1_RESET_VALUE	0x0000000000000000
#define	FIRE_JBUS_SCRATCH_2_RESET_VALUE	0x0000000000000000
#define	FIRE_JBUS_J_ERR_EN_RESET_VALUE	0x3fffffff1fffffff
#define	FIRE_JBC_ERROR_LOG_EN_REG_RESET_VALUE	0x000000003fffffff
#define	FIRE_JBC_ERROR_INT_EN_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_JBC_ENABLED_ERROR_STATUS_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_JBC_LOGGED_ERROR_STATUS_REG_RW1C_ALIAS_RESET_VALUE	0x0000000000000000
#define	FIRE_JBC_LOGGED_ERROR_STATUS_REG_RW1S_ALIAS_RESET_VALUE	0x0000000000000000
#define	FIRE_JBC_FATAL_RESET_ENABLE_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_JBCINT_IN_TRAN_ERROR_LOG_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_JBCINT_IN_STATE_ERROR_LOG_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_JBCINT_OUT_TRAN_ERROR_LOG_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_JBCINT_OUT_STATE_ERROR_LOG_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_FATAL_ERROR_LOG_REG_1_RESET_VALUE	0x0000000000000000
#define	FIRE_FATAL_STATE_ERROR_LOG_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_MERGE_TRAN_ERROR_LOG_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_DMCINT_ODCD_ERROR_LOG_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_DMCINT_IDC_ERROR_LOG_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_CSR_ERROR_LOG_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_JBC_INTERRUPT_MASK_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_JBC_INTERRUPT_STATUS_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_JBC_PERF_CNTRL_RESET_VALUE	0x0000000000000000
#define	FIRE_JBC_PERF_CNT0_RESET_VALUE	0x0000000000000000
#define	FIRE_JBC_PERF_CNT1_RESET_VALUE	0x0000000000000000
#define	FIRE_JBC_DBG_SEL_A_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_JBC_DBG_SEL_B_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_ISS_INTERRUPT_MAPPING(n)					(0x00001000+(8*n))
#define	FIRE_DLC_IMU_ISS_CLR_INT_REG(n)						(0x00001400+(8*n))
#define	FIRE_DLC_IMU_ISS_INTERRUPT_RETRY_TIMER	0x00001a00
#define	FIRE_DLC_IMU_ISS_INTERRUPT_STATE_STATUS_1	0x00001a10
#define	FIRE_DLC_IMU_ISS_INTERRUPT_STATE_STATUS_2	0x00001a18
#define	FIRE_DLC_IMU_RDS_INTX_INTX_STATUS_REG	0x0000b000
#define	FIRE_DLC_IMU_RDS_INTX_INT_A_INT_CLR_REG	0x0000b008
#define	FIRE_DLC_IMU_RDS_INTX_INT_B_INT_CLR_REG	0x0000b010
#define	FIRE_DLC_IMU_RDS_INTX_INT_C_INT_CLR_REG	0x0000b018
#define	FIRE_DLC_IMU_RDS_INTX_INT_D_INT_CLR_REG	0x0000b020
#define	FIRE_DLC_IMU_EQS_EQ_BASE_ADDRESS	0x00010000
#define	FIRE_DLC_IMU_EQS_EQ_CTRL_SET(n)	(0x00011000+(8*n))
#define	FIRE_DLC_IMU_EQS_EQ_CTRL_CLR(n)	(0x00011200+(8*n))
#define	FIRE_DLC_IMU_EQS_EQ_STATE(n)	(0x00011400+(8*n))
#define	FIRE_DLC_IMU_EQS_EQ_TAIL(n)	(0x00011600+(8*n))
#define	FIRE_DLC_IMU_EQS_EQ_HEAD(n)	(0x00011800+(8*n))
#define	FIRE_DLC_IMU_RDS_MSI_MSI_MAPPING(n) (0x00020000+(8*n))
#define	FIRE_DLC_IMU_RDS_MSI_MSI_CLEAR_REG(n) (0x00028000+(8*n))
#define	FIRE_DLC_IMU_RDS_MSI_INT_MONDO_DATA_0_REG	0x0002c000
#define	FIRE_DLC_IMU_RDS_MSI_INT_MONDO_DATA_1_REG	0x0002c008
#define	FIRE_DLC_IMU_RDS_MESS_ERR_COR_MAPPING	0x00030000
#define	FIRE_DLC_IMU_RDS_MESS_ERR_NONFATAL_MAPPING	0x00030008
#define	FIRE_DLC_IMU_RDS_MESS_ERR_FATAL_MAPPING	0x00030010
#define	FIRE_DLC_IMU_RDS_MESS_PM_PME_MAPPING	0x00030018
#define	FIRE_DLC_IMU_RDS_MESS_PME_TO_ACK_MAPPING	0x00030020
#define	FIRE_DLC_IMU_ICS_IMU_ERROR_LOG_EN_REG	0x00031000
#define	FIRE_DLC_IMU_ICS_IMU_INT_EN_REG	0x00031008
#define	FIRE_DLC_IMU_ICS_IMU_ENABLED_ERROR_STATUS_REG	0x00031010
#define	FIRE_DLC_IMU_ICS_IMU_LOGGED_ERROR_STATUS_REG_RW1C_ALIAS	0x00031018
#define	FIRE_DLC_IMU_ICS_IMU_LOGGED_ERROR_STATUS_REG_RW1S_ALIAS	0x00031020
#define	FIRE_DLC_IMU_ICS_IMU_RDS_ERROR_LOG_REG	0x00031028
#define	FIRE_DLC_IMU_ICS_IMU_SCS_ERROR_LOG_REG	0x00031030
#define	FIRE_DLC_IMU_ICS_IMU_EQS_ERROR_LOG_REG	0x00031038
#define	FIRE_DLC_IMU_ICS_DMC_INTERRUPT_MASK_REG	0x00031800
#define	FIRE_DLC_IMU_ICS_DMC_INTERRUPT_STATUS_REG	0x00031808
#define	FIRE_DLC_IMU_ICS_MULTI_CORE_ERROR_STATUS_REG	0x00031810
#define	FIRE_DLC_IMU_ICS_IMU_PERF_CNTRL	0x00032000
#define	FIRE_DLC_IMU_ICS_IMU_PERF_CNT0	0x00032008
#define	FIRE_DLC_IMU_ICS_IMU_PERF_CNT1	0x00032010
#define	FIRE_DLC_IMU_ICS_MSI_32_ADDR_REG	0x00034000
#define	FIRE_DLC_IMU_ICS_MSI_64_ADDR_REG	0x00034008
#define	FIRE_DLC_IMU_ICS_MEM_64_PCIE_OFFSET_REG	0x00034018
#define	FIRE_DLC_MMU_CTL	0x00040000
#define	FIRE_DLC_MMU_TSB	0x00040008
#define	FIRE_DLC_MMU_FSH	0x00040100
#define	FIRE_DLC_MMU_INV	0x00040108
#define	FIRE_DLC_MMU_LOG	0x00041000
#define	FIRE_DLC_MMU_INT_EN	0x00041008
#define	FIRE_DLC_MMU_EN_ERR	0x00041010
#define	FIRE_DLC_MMU_ERR_RW1C_ALIAS	0x00041018
#define	FIRE_DLC_MMU_ERR_RW1S_ALIAS	0x00041020
#define	FIRE_DLC_MMU_FLTA	0x00041028
#define	FIRE_DLC_MMU_FLTS	0x00041030
#define	FIRE_DLC_MMU_PRFC	0x00042000
#define	FIRE_DLC_MMU_PRF0	0x00042008
#define	FIRE_DLC_MMU_PRF1	0x00042010
#define	FIRE_DLC_MMU_VTB(n)	(0x00046000+(8*n))
#define	FIRE_DLC_MMU_PTB(n)	(0x00047000+(8*n))
#define	FIRE_DLC_MMU_TDB(n)	(0x00048000+(8*n))
#define	FIRE_DLC_ILU_CIB_ILU_LOG_EN	0x00051000
#define	FIRE_DLC_ILU_CIB_ILU_INT_EN	0x00051008
#define	FIRE_DLC_ILU_CIB_ILU_EN_ERR	0x00051010
#define	FIRE_DLC_ILU_CIB_ILU_LOG_ERR_RW1C_ALIAS	0x00051018
#define	FIRE_DLC_ILU_CIB_ILU_LOG_ERR_RW1S_ALIAS	0x00051020
#define	FIRE_DLC_ILU_CIB_PEC_INT_EN	0x00051800
#define	FIRE_DLC_ILU_CIB_PEC_EN_ERR	0x00051808
#define	FIRE_DLC_CRU_DMC_DBG_SEL_A_REG	0x00053000
#define	FIRE_DLC_CRU_DMC_DBG_SEL_B_REG	0x00053008
#define	FIRE_DLC_CRU_DMC_PCIE_CFG	0x00053100
#define	FIRE_DLC_PSB_PSB_DMA(n)		(0x00060000+(8*n))
#define	FIRE_DLC_PSB_PSB_PIO(n)		(0x00064000+(8*n))
#define	FIRE_DLC_TSB_TSB_DMA(n)		(0x00070000+(8*n))
#define	FIRE_PLC_TLU_CTB_TLR_TLU_CTL	0x00080000
#define	FIRE_PLC_TLU_CTB_TLR_TLU_STS	0x00080008
#define	FIRE_PLC_TLU_CTB_TLR_TRN_OFF	0x00080010
#define	FIRE_PLC_TLU_CTB_TLR_TLU_ICI	0x00080018
#define	FIRE_PLC_TLU_CTB_TLR_TLU_DIAG	0x00080100
#define	FIRE_PLC_TLU_CTB_TLR_TLU_ECC	0x00080200
#define	FIRE_PLC_TLU_CTB_TLR_TLU_ECL	0x00080208
#define	FIRE_PLC_TLU_CTB_TLR_TLU_ERB	0x00080210
#define	FIRE_PLC_TLU_CTB_TLR_TLU_ICA	0x00080218
#define	FIRE_PLC_TLU_CTB_TLR_TLU_ICR	0x00080220
#define	FIRE_PLC_TLU_CTB_TLR_OE_LOG	0x00081000
#define	FIRE_PLC_TLU_CTB_TLR_OE_INT_EN	0x00081008
#define	FIRE_PLC_TLU_CTB_TLR_OE_EN_ERR	0x00081010
#define	FIRE_PLC_TLU_CTB_TLR_OE_ERR_RW1C_ALIAS	0x00081018
#define	FIRE_PLC_TLU_CTB_TLR_OE_ERR_RW1S_ALIAS	0x00081020
#define	FIRE_PLC_TLU_CTB_TLR_ROE_HDR1	0x00081028
#define	FIRE_PLC_TLU_CTB_TLR_ROE_HDR2	0x00081030
#define	FIRE_PLC_TLU_CTB_TLR_TOE_HDR1	0x00081038
#define	FIRE_PLC_TLU_CTB_TLR_TOE_HDR2	0x00081040
#define	FIRE_PLC_TLU_CTB_TLR_TLU_PRFC	0x00082000
#define	FIRE_PLC_TLU_CTB_TLR_TLU_PRF0	0x00082008
#define	FIRE_PLC_TLU_CTB_TLR_TLU_PRF1	0x00082010
#define	FIRE_PLC_TLU_CTB_TLR_TLU_PRF2	0x00082018
#define	FIRE_PLC_TLU_CTB_TLR_TLU_DBG_SEL_A	0x00083000
#define	FIRE_PLC_TLU_CTB_TLR_TLU_DBG_SEL_B	0x00083008
#define	FIRE_PLC_TLU_CTB_TLR_DEV_CAP	0x00090000
#define	FIRE_PLC_TLU_CTB_TLR_DEV_CTL	0x00090008
#define	FIRE_PLC_TLU_CTB_TLR_DEV_STS	0x00090010
#define	FIRE_PLC_TLU_CTB_TLR_LNK_CAP	0x00090018
#define	FIRE_PLC_TLU_CTB_TLR_LNK_CTL	0x00090020
#define	FIRE_PLC_TLU_CTB_TLR_LNK_STS	0x00090028
#define	FIRE_PLC_TLU_CTB_TLR_SLT_CAP	0x00090030
#define	FIRE_PLC_TLU_CTB_TLR_UE_LOG	0x00091000
#define	FIRE_PLC_TLU_CTB_TLR_UE_INT_EN	0x00091008
#define	FIRE_PLC_TLU_CTB_TLR_UE_EN_ERR	0x00091010
#define	FIRE_PLC_TLU_CTB_TLR_UE_ERR_RW1C_ALIAS	0x00091018
#define	FIRE_PLC_TLU_CTB_TLR_UE_ERR_RW1S_ALIAS	0x00091020
#define	FIRE_PLC_TLU_CTB_TLR_RUE_HDR1	0x00091028
#define	FIRE_PLC_TLU_CTB_TLR_RUE_HDR2	0x00091030
#define	FIRE_PLC_TLU_CTB_TLR_TUE_HDR1	0x00091038
#define	FIRE_PLC_TLU_CTB_TLR_TUE_HDR2	0x00091040
#define	FIRE_PLC_TLU_CTB_TLR_CE_LOG	0x000a1000
#define	FIRE_PLC_TLU_CTB_TLR_CE_INT_EN	0x000a1008
#define	FIRE_PLC_TLU_CTB_TLR_CE_EN_ERR	0x000a1010
#define	FIRE_PLC_TLU_CTB_TLR_CE_ERR_RW1C_ALIAS	0x000a1018
#define	FIRE_PLC_TLU_CTB_TLR_CE_ERR_RW1S_ALIAS	0x000a1020
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_ID	0x000e2000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_RST	0x000e2008
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_DBG_STAT	0x000e2010
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_DBG_CONFIG	0x000e2018
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LTSSM_CNTL	0x000e2020
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LINK_STATUS	0x000e2028
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_INTERRUPT_STATUS	0x000e2040
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_INTERRUPT_MASK	0x000e2048
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LINK_PERF_CNTR1_SEL	0x000e2100
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LINK_PERF_CNTR_CTL	0x000e2110
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LINK_PERF_CNTR1	0x000e2120
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LINK_PERF_CNTR1_TEST	0x000e2128
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LINK_PERF_CNTR2	0x000e2130
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LINK_PERF_CNTR2_TEST	0x000e2138
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LL_CONFIG	0x000e2200
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LL_STAT	0x000e2208
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LL_ERR_INT	0x000e2210
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LL_ERR_TST	0x000e2218
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LL_ERR_MSK	0x000e2220
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_FC_UP_CNTL	0x000e2240
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_FC_UP_TO_VAL	0x000e2260
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_VCO_FC_CNTL_UP_TMR0	0x000e2268
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_VCO_FC_CNTL_UP_TMR1	0x000e2270
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_ACKNAK_LATENCY	0x000e2400
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_ACKNAK_LATENCY_TMR	0x000e2408
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_RPLAY_TMR_THHOLD	0x000e2410
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_RPLAY_TMR	0x000e2418
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_RPLAY_NUM_STAT	0x000e2420
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_RTRY_BUFF_MAX_ADDR	0x000e2428
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_RTRY_FIFO_PTR	0x000e2430
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_RTRY_FIFO_RW_PTR	0x000e2438
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_RTRY_FIFO_CRDT	0x000e2440
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_SEQ_CNTR	0x000e2448
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_ACK_SND_SEQ_NUM	0x000e2450
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_SEQ_CNT_FIFO_MAX_ADDR	0x000e2458
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_SEQ_CNT_FIFO_PTR	0x000e2460
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_SEQ_CNT_RW_PTR	0x000e2468
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_TX_TST_CNTL	0x000e2470
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_MEM_ADDR_CNTL	0x000e2480
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_MEM_LD0	0x000e2488
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_MEM_LD1	0x000e2490
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_MEM_LD2	0x000e2498
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_MEM_LD3	0x000e24a0
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_MEM_LD4	0x000e24a8
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_RTRY_CNT	0x000e24c0
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_SEQ_BUFF_CNT	0x000e24c8
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_SEQ_BUFF_BTM	0x000e24d0
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_NXT_RCV_SEQ_CNTR	0x000e2500
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_DLLP_RCVD	0x000e2508
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_RX_LINK_TEST_CNTL	0x000e2510
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_PHY_CNFG	0x000e2600
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_PHY_STAT	0x000e2608
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_PHY_ERR_INT	0x000e2610
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_PHY_ERR_TST	0x000e2618
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_PHY_ERR_MSK	0x000e2620
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_RX_PHY_CNFG	0x000e2680
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_RX_PHY_STAT1	0x000e2688
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_RX_PHY_STAT2	0x000e2690
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_RX_PHY_STAT3	0x000e2698
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_RX_PHY_INT	0x000e26a0
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_RX_PHY_TST	0x000e26a8
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_RX_PHY_MSK	0x000e26b0
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_TX_PHY_CONFIG	0x000e2700
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_TX_PHY_STAT	0x000e2708
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_TX_PHY_INT	0x000e2710
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_TX_PHY_TST	0x000e2718
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_TX_PHY_MSK	0x000e2720
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_TX_PHY_STS_2	0x000e2728
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LTSSM_CONFIG1	0x000e2780
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LTSSM_CONFIG2	0x000e2788
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LTSSM_CONFIG3	0x000e2790
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LTSSM_CONFIG4	0x000e2798
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LTSSM_CONFIG5	0x000e27a0
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LTSSM_STAT1	0x000e27a8
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LTSSM_STAT2	0x000e27b0
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LTSSM_INT	0x000e27b8
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LTSSM_TST	0x000e27c0
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LTSSM_MSK	0x000e27c8
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LTSSM_STAT_WR_EN	0x000e27d0
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_GB_GL_CONFIG1	0x000e2800
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_GB_GL_CONFIG2	0x000e2808
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_GB_GL_CONFIG3	0x000e2810
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_GB_GL_CONFIG4	0x000e2818
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_GB_GL_STAT	0x000e2820
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_GB_GL_INT	0x000e2828
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_GB_GL_TST	0x000e2830
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_GB_GL_MSK	0x000e2838
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_GB_GL_PDWN1	0x000e2840
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_GB_GL_PDWN2	0x000e2848
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_GB_GL_CONFIG5	0x000e2850
#define	FIRE_DLC_IMU_ISS_INTERRUPT_MAPPING_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_ISS_CLR_INT_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_ISS_INTERRUPT_RETRY_TIMER_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_ISS_INTERRUPT_STATE_STATUS_1_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_ISS_INTERRUPT_STATE_STATUS_2_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_RDS_INTX_INTX_STATUS_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_RDS_INTX_INT_A_INT_CLR_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_RDS_INTX_INT_B_INT_CLR_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_RDS_INTX_INT_C_INT_CLR_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_RDS_INTX_INT_D_INT_CLR_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_EQS_EQ_BASE_ADDRESS_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_EQS_EQ_CTRL_SET_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_EQS_EQ_CTRL_CLR_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_EQS_EQ_STATE_RESET_VALUE	0x0000000000000001
#define	FIRE_DLC_IMU_EQS_EQ_TAIL_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_EQS_EQ_HEAD_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_RDS_MSI_MSI_MAPPING_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_RDS_MSI_MSI_CLEAR_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_RDS_MSI_INT_MONDO_DATA_0_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_RDS_MSI_INT_MONDO_DATA_1_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_RDS_MESS_ERR_COR_MAPPING_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_RDS_MESS_ERR_NONFATAL_MAPPING_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_RDS_MESS_ERR_FATAL_MAPPING_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_RDS_MESS_PM_PME_MAPPING_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_RDS_MESS_PME_TO_ACK_MAPPING_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_ICS_IMU_ERROR_LOG_EN_REG_RESET_VALUE	0x00000000000007ff
#define	FIRE_DLC_IMU_ICS_IMU_INT_EN_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_ICS_IMU_ENABLED_ERROR_STATUS_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_ICS_IMU_LOGGED_ERROR_STATUS_REG_RW1C_ALIAS_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_ICS_IMU_LOGGED_ERROR_STATUS_REG_RW1S_ALIAS_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_ICS_IMU_RDS_ERROR_LOG_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_ICS_IMU_SCS_ERROR_LOG_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_ICS_IMU_EQS_ERROR_LOG_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_ICS_DMC_INTERRUPT_MASK_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_ICS_DMC_INTERRUPT_STATUS_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_ICS_MULTI_CORE_ERROR_STATUS_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_ICS_IMU_PERF_CNTRL_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_ICS_IMU_PERF_CNT0_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_ICS_IMU_PERF_CNT1_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_ICS_MSI_32_ADDR_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_ICS_MSI_64_ADDR_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_IMU_ICS_MEM_64_PCIE_OFFSET_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_MMU_CTL_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_MMU_TSB_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_MMU_FSH_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_MMU_INV_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_MMU_LOG_RESET_VALUE	0x000000000000ffff
#define	FIRE_DLC_MMU_INT_EN_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_MMU_EN_ERR_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_MMU_ERR_RW1C_ALIAS_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_MMU_ERR_RW1S_ALIAS_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_MMU_FLTA_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_MMU_FLTS_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_MMU_PRFC_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_MMU_PRF0_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_MMU_PRF1_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_MMU_VTB_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_MMU_PTB_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_MMU_TDB_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_ILU_CIB_ILU_LOG_EN_RESET_VALUE	0x00000000000000f0
#define	FIRE_DLC_ILU_CIB_ILU_INT_EN_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_ILU_CIB_ILU_EN_ERR_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_ILU_CIB_ILU_LOG_ERR_RW1C_ALIAS_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_ILU_CIB_ILU_LOG_ERR_RW1S_ALIAS_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_ILU_CIB_PEC_INT_EN_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_ILU_CIB_PEC_EN_ERR_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_CRU_DMC_DBG_SEL_A_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_CRU_DMC_DBG_SEL_B_REG_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_CRU_DMC_PCIE_CFG_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_PSB_PSB_DMA_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_PSB_PSB_PIO_RESET_VALUE	0x0000000000000000
#define	FIRE_DLC_TSB_TSB_DMA_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_TLU_CTL_RESET_VALUE	0x0000000000000001
#define	FIRE_PLC_TLU_CTB_TLR_TLU_STS_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_TRN_OFF_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_TLU_ICI_RESET_VALUE	0x00000010000200c0
#define	FIRE_PLC_TLU_CTB_TLR_TLU_DIAG_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_TLU_ECC_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_TLU_ECL_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_TLU_ERB_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_TLU_ICA_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_TLU_ICR_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_OE_LOG_RESET_VALUE	0x0000000000ffffff
#define	FIRE_PLC_TLU_CTB_TLR_OE_INT_EN_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_OE_EN_ERR_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_OE_ERR_RW1C_ALIAS_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_OE_ERR_RW1S_ALIAS_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_ROE_HDR1_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_ROE_HDR2_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_TOE_HDR1_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_TOE_HDR2_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_TLU_PRFC_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_TLU_PRF0_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_TLU_PRF1_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_TLU_PRF2_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_TLU_DBG_SEL_A_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_TLU_DBG_SEL_B_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_DEV_CAP_RESET_VALUE	0x0000000000000fc2
#define	FIRE_PLC_TLU_CTB_TLR_DEV_CTL_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_DEV_STS_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_LNK_CAP_RESET_VALUE	0x0000000000015c81
#define	FIRE_PLC_TLU_CTB_TLR_LNK_CTL_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_LNK_STS_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_SLT_CAP_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_UE_LOG_RESET_VALUE	0x000000000017f011
#define	FIRE_PLC_TLU_CTB_TLR_UE_INT_EN_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_UE_EN_ERR_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_UE_ERR_RW1C_ALIAS_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_UE_ERR_RW1S_ALIAS_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_RUE_HDR1_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_RUE_HDR2_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_TUE_HDR1_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_TUE_HDR2_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_CE_LOG_RESET_VALUE	0x00000000000011c1
#define	FIRE_PLC_TLU_CTB_TLR_CE_INT_EN_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_CE_EN_ERR_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_CE_ERR_RW1C_ALIAS_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_TLR_CE_ERR_RW1S_ALIAS_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_ID_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_RST_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_DBG_STAT_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_DBG_CONFIG_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LTSSM_CNTL_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LINK_STATUS_RESET_VALUE	0x0000000000000101
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_INTERRUPT_STATUS_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_INTERRUPT_MASK_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LINK_PERF_CNTR1_SEL_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LINK_PERF_CNTR_CTL_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LINK_PERF_CNTR1_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LINK_PERF_CNTR1_TEST_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LINK_PERF_CNTR2_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LINK_PERF_CNTR2_TEST_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LL_CONFIG_RESET_VALUE	0x0000000000000100
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LL_STAT_RESET_VALUE	0x0000000000000001
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LL_ERR_INT_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LL_ERR_TST_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LL_ERR_MSK_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_FC_UP_CNTL_RESET_VALUE	0x0000000000000003
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_FC_UP_TO_VAL_RESET_VALUE	0x0000000000001d4c
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_VCO_FC_CNTL_UP_TMR0_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_VCO_FC_CNTL_UP_TMR1_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_ACKNAK_LATENCY_RESET_VALUE	0x0000000000000030
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_ACKNAK_LATENCY_TMR_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_RPLAY_TMR_THHOLD_RESET_VALUE	0x0000000000000090
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_RPLAY_TMR_RESET_VALUE	0x0000000000000090
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_RPLAY_NUM_STAT_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_RTRY_BUFF_MAX_ADDR_RESET_VALUE	0x000000000000157f
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_RTRY_FIFO_PTR_RESET_VALUE	0x00000000ffff0000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_RTRY_FIFO_RW_PTR_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_RTRY_FIFO_CRDT_RESET_VALUE	0x0000000000001580
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_SEQ_CNTR_RESET_VALUE	0x000000000fff0000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_ACK_SND_SEQ_NUM_RESET_VALUE	0x0000000000000fff
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_SEQ_CNT_FIFO_MAX_ADDR_RESET_VALUE	0x0000000000000157
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_SEQ_CNT_FIFO_PTR_RESET_VALUE	0x000000000fff0000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_SEQ_CNT_RW_PTR_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_TX_TST_CNTL_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_MEM_ADDR_CNTL_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_MEM_LD0_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_MEM_LD1_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_MEM_LD2_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_MEM_LD3_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_MEM_LD4_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_RTRY_CNT_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_SEQ_BUFF_CNT_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_SEQ_BUFF_BTM_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_NXT_RCV_SEQ_CNTR_RESET_VALUE	0x0000000000000001
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_DLLP_RCVD_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_RX_LINK_TEST_CNTL_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_PHY_CNFG_RESET_VALUE	0x0000000000000010
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_PHY_STAT_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_PHY_ERR_INT_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_PHY_ERR_TST_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_PHY_ERR_MSK_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_RX_PHY_CNFG_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_RX_PHY_STAT1_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_RX_PHY_STAT2_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_RX_PHY_STAT3_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_RX_PHY_INT_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_RX_PHY_TST_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_RX_PHY_MSK_RESET_VALUE	0x000000008000000f
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_TX_PHY_CONFIG_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_TX_PHY_STAT_RESET_VALUE	0x0000000073000010
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_TX_PHY_INT_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_TX_PHY_TST_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_TX_PHY_MSK_RESET_VALUE	0x0000000080000fff
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_TX_PHY_STS_2_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LTSSM_CONFIG1_RESET_VALUE	0x0000000000001905
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LTSSM_CONFIG2_RESET_VALUE	0x00000000002dc6c0
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LTSSM_CONFIG3_RESET_VALUE	0x000000000007a120
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LTSSM_CONFIG4_RESET_VALUE	0x0000000000028c00
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LTSSM_CONFIG5_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LTSSM_STAT1_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LTSSM_STAT2_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LTSSM_INT_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LTSSM_TST_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LTSSM_MSK_RESET_VALUE	0x000000008000ffff
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_LTSSM_STAT_WR_EN_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_GB_GL_CONFIG1_RESET_VALUE	0x0000000000089019
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_GB_GL_CONFIG2_RESET_VALUE	0x00000000a1a3e175
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_GB_GL_CONFIG3_RESET_VALUE	0x00000000004401f4
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_GB_GL_CONFIG4_RESET_VALUE	0x000000000001e848
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_GB_GL_STAT_RESET_VALUE	0x00000000ffff0000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_GB_GL_INT_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_GB_GL_TST_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_GB_GL_MSK_RESET_VALUE	0x0000000080ffffff
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_GB_GL_PDWN1_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_GB_GL_PDWN2_RESET_VALUE	0x0000000000000000
#define	FIRE_PLC_TLU_CTB_LPR_PCIE_LPU_GB_GL_CONFIG5_RESET_VALUE	0x0000000000000000
/* END CSTYLED */

#ifdef __cplusplus
}
#endif

#endif /* _FIRE_REGS_H */
