-- EMACS settings: -*-  tab-width: 2; indent-tabs-mode: t -*-
-- vim: tabstop=2:shiftwidth=2:noexpandtab
-- kate: tab-width 2; replace-tabs off; indent-width 2;
-- 
-- ============================================================================
-- Authors:				 	Patrick Lehmann
--
-- Module:				 	VHDL package for component declarations, types and functions
--									associated to the PoC.xil namespace
-- 
-- Description:
-- ------------------------------------
--		This package declares types and components for
--			- Xilinx ChipScope Pro IPCores (ICON, ILA, VIO)
--			- Xilinx Dynamic Reconfiguration Port (DRP) related types
--			- SystemMonitor for FPGA core temperature measurement and fan control
--				(see PoC.io.FanControl)
--			- Component declarations for Xilinx related modules
--
-- License:
-- ============================================================================
-- Copyright 2007-2015 Technische Universitaet Dresden - Germany
--										 Chair for VLSI-Design, Diagnostics and Architecture
-- 
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
-- 
--		http://www.apache.org/licenses/LICENSE-2.0
-- 
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
-- ============================================================================

library IEEE;
use			IEEE.STD_LOGIC_1164.all;
use			IEEE.NUMERIC_STD.all;

library PoC;
use			PoC.utils.all;
use			PoC.vectors.all;


package xil is
	-- ChipScope
	-- ==========================================================================
	subtype	T_XIL_CHIPSCOPE_CONTROL					is STD_LOGIC_VECTOR(35 downto 0);
	type		T_XIL_CHIPSCOPE_CONTROL_VECTOR	is array (NATURAL range <>) of T_XIL_CHIPSCOPE_CONTROL;

	-- Dynamic Reconfiguration Port (DRP)
	-- ==========================================================================
	subtype T_XIL_DRP_ADDRESS								is T_SLV_16;
	subtype T_XIL_DRP_DATA									is T_SLV_16;

	type		T_XIL_DRP_ADDRESS_VECTOR				is array (NATURAL range <>) of T_XIL_DRP_ADDRESS;
	type		T_XIL_DRP_DATA_VECTOR						is array (NATURAL range <>) of T_XIL_DRP_DATA;

	type T_XIL_DRP_BUS_IN is record
		Clock					: STD_LOGIC;
		Enable				: STD_LOGIC;
		ReadWrite			: STD_LOGIC;
		Address				: T_XIL_DRP_ADDRESS;
		Data					: T_XIL_DRP_DATA;
	end record;

	type T_XIL_DRP_BUS_OUT is record
		Data					: T_XIL_DRP_DATA;
		Ack						: STD_LOGIC;
	end record;

	type T_XIL_DRP_CONFIG is record
		Address														: T_XIL_DRP_ADDRESS;
		Mask															: T_XIL_DRP_DATA;
		Data															: T_XIL_DRP_DATA;
	end record;
	
	-- define array indices
	constant C_XIL_DRP_MAX_CONFIG_COUNT	: POSITIVE	:= 8;
	
	SUBtype T_XIL_DRP_CONFIG_INDEX			IS INTEGER range 0 TO C_XIL_DRP_MAX_CONFIG_COUNT - 1;
	type		T_XIL_DRP_CONFIG_VECTOR			is array (NATURAL range <>) of T_XIL_DRP_CONFIG;
	
	type T_XIL_DRP_CONFIG_SET is record
		Configs														: T_XIL_DRP_CONFIG_VECTOR(T_XIL_DRP_CONFIG_INDEX);
		LastIndex													: T_XIL_DRP_CONFIG_INDEX;
	end record;
	
	type T_XIL_DRP_CONFIG_ROM						is array (NATURAL range <>) of T_XIL_DRP_CONFIG_SET;
	
	constant C_XIL_DRP_CONFIG_EMPTY			: T_XIL_DRP_CONFIG				:= (
		Address =>	(others => '0'),
		Data =>			(others => '0'),
		Mask =>			(others => '0')
	);

	constant C_XIL_DRP_CONFIG_SET_EMPTY	: T_XIL_DRP_CONFIG_SET		:= (
		Configs		=> (others => C_XIL_DRP_CONFIG_EMPTY),
		LastIndex	=> 0
	);

	component xil_ChipScopeICON_1 is
		port (
			control0		: inout	T_XIL_CHIPSCOPE_CONTROL
		);
	end component;

	component xil_ChipScopeICON_2 is
		port (
			control0		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control1		: inout	T_XIL_CHIPSCOPE_CONTROL
		);
	end component;

	component xil_ChipScopeICON_3 is
		port (
			control0		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control1		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control2		: inout	T_XIL_CHIPSCOPE_CONTROL
		);
	end component;

	component xil_ChipScopeICON_4 is
		port (
			control0		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control1		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control2		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control3		: inout	T_XIL_CHIPSCOPE_CONTROL
		);
	end component;

	component xil_ChipScopeICON_5 is
		port (
			control0		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control1		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control2		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control3		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control4		: inout	T_XIL_CHIPSCOPE_CONTROL
		);
	end component;

	component xil_ChipScopeICON_6 is
		port (
			control0		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control1		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control2		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control3		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control4		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control5		: inout	T_XIL_CHIPSCOPE_CONTROL
		);
	end component;

	component xil_ChipScopeICON_7 is
		port (
			control0		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control1		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control2		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control3		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control4		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control5		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control6		: inout	T_XIL_CHIPSCOPE_CONTROL
		);
	end component;

	component xil_ChipScopeICON_8 is
		port (
			control0		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control1		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control2		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control3		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control4		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control5		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control6		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control7		: inout	T_XIL_CHIPSCOPE_CONTROL
		);
	end component;

	component xil_ChipScopeICON_9 is
		port (
			control0		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control1		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control2		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control3		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control4		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control5		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control6		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control7		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control8		: inout	T_XIL_CHIPSCOPE_CONTROL
		);
	end component;

	component xil_ChipScopeICON_10 is
		port (
			control0		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control1		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control2		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control3		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control4		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control5		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control6		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control7		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control8		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control9		: inout	T_XIL_CHIPSCOPE_CONTROL
		);
	end component;

	component xil_ChipScopeICON_11 is
		port (
			control0		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control1		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control2		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control3		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control4		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control5		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control6		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control7		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control8		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control9		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control10		: inout	T_XIL_CHIPSCOPE_CONTROL
		);
	end component;

	component xil_ChipScopeICON_12 is
		port (
			control0		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control1		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control2		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control3		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control4		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control5		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control6		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control7		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control8		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control9		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control10		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control11		: inout	T_XIL_CHIPSCOPE_CONTROL
		);
	end component;

	component xil_ChipScopeICON_13 is
		port (
			control0		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control1		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control2		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control3		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control4		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control5		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control6		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control7		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control8		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control9		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control10		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control11		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control12		: inout	T_XIL_CHIPSCOPE_CONTROL
		);
	end component;

	component xil_ChipScopeICON_14 is
		port (
			control0		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control1		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control2		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control3		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control4		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control5		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control6		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control7		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control8		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control9		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control10		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control11		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control12		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control13		: inout	T_XIL_CHIPSCOPE_CONTROL
		);
	end component;
	
	component xil_ChipScopeICON_15 is
		port (
			control0		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control1		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control2		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control3		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control4		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control5		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control6		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control7		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control8		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control9		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control10		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control11		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control12		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control13		: inout	T_XIL_CHIPSCOPE_CONTROL;
			control14		: inout	T_XIL_CHIPSCOPE_CONTROL
		);
	end component;
	
	component xil_SyncBlock is
		generic (
			BITS						: POSITIVE						:= 1;									-- number of bit to be synchronized
			INIT						: STD_LOGIC_VECTOR		:= x"00000000"				-- initialisation bits
		);
		port (
			Clock						: in	STD_LOGIC;														-- Clock to be synchronized to
			Input						: in	STD_LOGIC_VECTOR(BITS - 1 downto 0);	-- Data to be synchronized
			Output					: out	STD_LOGIC_VECTOR(BITS - 1 downto 0)		-- synchronised data
		);
	end component;
	
	component xil_SystemMonitor_Virtex6 is
		port (
			Reset						: in	STD_LOGIC;				-- Reset signal for the System Monitor control logic
			                
			Alarm_UserTemp	: out	STD_LOGIC;				-- Temperature-sensor alarm output
			Alarm_OverTemp	: out	STD_LOGIC;				-- Over-Temperature alarm output
			Alarm						: out	STD_LOGIC;				-- OR'ed output of all the alarms
			VP							: in	STD_LOGIC;				-- Dedicated analog input pair
			VN							: in	STD_LOGIC
		);
	end component;

	component xil_SystemMonitor_Series7 is
		port (
			Reset						: in	STD_LOGIC;				-- Reset signal for the System Monitor control logic
			                
			Alarm_UserTemp	: out	STD_LOGIC;				-- Temperature-sensor alarm output
			Alarm_OverTemp	: out	STD_LOGIC;				-- Over-Temperature alarm output
			Alarm						: out	STD_LOGIC;				-- OR'ed output of all the alarms
			VP							: in	STD_LOGIC;				-- Dedicated analog input pair
			VN							: in	STD_LOGIC
		);
	end component;
end;


package body xil is

end package body;