# This is a generated script based on design: pfSenseZ
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
#
# To test this script, run the following commands from Vivado Tcl console:
# source pfSenseZ_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:
#    create_project project_1 myproj -part xc7vx485tffg1157-1 -force

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design pfSenseZ

# Creating design if needed
if { [get_files *.bd] eq "" } {
   puts "INFO: Currently there are no designs in project, so creating one..."
   create_bd_design pfSenseZ
}


# Hierarchical cell: Zynq_AXI_Interfacing
proc create_hier_cell_Zynq_AXI_Interfacing { parentCell nameHier } {

  if { $parentCell eq "" || $nameHier eq "" } {
     puts "ERROR: create_hier_cell_Zynq_AXI_Interfacing() - Empty argument(s)!"
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M01_AXI

  # Create pins
  create_bd_pin -dir I -type clk S00_ACLK
  create_bd_pin -dir O -from 0 -to 0 -type rst S00_ARESETN
  create_bd_pin -dir I -type rst ext_reset_in

  # Create instance: proc_sys_reset, and set properties
  set proc_sys_reset [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset ]

  # Create instance: processing_system7_1_axi_periph, and set properties
  set processing_system7_1_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.0 processing_system7_1_axi_periph ]
  set_property -dict [ list CONFIG.NUM_MI {2}  ] $processing_system7_1_axi_periph

  # Create interface connections
  connect_bd_intf_net -intf_net processing_system7_1_m_axi_gp0 [get_bd_intf_pins S00_AXI] [get_bd_intf_pins processing_system7_1_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net processing_system7_1_axi_periph_m00_axi [get_bd_intf_pins M00_AXI] [get_bd_intf_pins processing_system7_1_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net processing_system7_1_axi_periph_m01_axi [get_bd_intf_pins M01_AXI] [get_bd_intf_pins processing_system7_1_axi_periph/M01_AXI]

  # Create port connections
  connect_bd_net -net proc_sys_reset_interconnect_aresetn [get_bd_pins proc_sys_reset/interconnect_aresetn] [get_bd_pins processing_system7_1_axi_periph/ARESETN]
  connect_bd_net -net processing_system7_1_fclk_clk0 [get_bd_pins S00_ACLK] [get_bd_pins processing_system7_1_axi_periph/S00_ACLK] [get_bd_pins processing_system7_1_axi_periph/ACLK] [get_bd_pins processing_system7_1_axi_periph/M00_ACLK] [get_bd_pins processing_system7_1_axi_periph/M01_ACLK] [get_bd_pins proc_sys_reset/slowest_sync_clk]
  connect_bd_net -net proc_sys_reset_peripheral_aresetn [get_bd_pins S00_ARESETN] [get_bd_pins proc_sys_reset/peripheral_aresetn] [get_bd_pins processing_system7_1_axi_periph/S00_ARESETN] [get_bd_pins processing_system7_1_axi_periph/M00_ARESETN] [get_bd_pins processing_system7_1_axi_periph/M01_ARESETN]
  connect_bd_net -net processing_system7_1_fclk_reset0_n [get_bd_pins ext_reset_in] [get_bd_pins proc_sys_reset/ext_reset_in]
  
  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: Ethernet_SW_Control
proc create_hier_cell_Ethernet_SW_Control { parentCell nameHier } {

  if { $parentCell eq "" || $nameHier eq "" } {
     puts "ERROR: create_hier_cell_Ethernet_SW_Control() - Empty argument(s)!"
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 gpio

  # Create pins
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -from 0 -to 0 -type rst s_axi_aresetn

  # Create instance: axi_gpio_2, and set properties
  set axi_gpio_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_2 ]
  set_property -dict [ list CONFIG.USE_BOARD_FLOW {true} CONFIG.GPIO_BOARD_INTERFACE {btns_5bits}  ] $axi_gpio_2

  # Create interface connections
  connect_bd_intf_net -intf_net processing_system7_1_axi_periph_m01_axi [get_bd_intf_pins s_axi] [get_bd_intf_pins axi_gpio_2/s_axi]
  connect_bd_intf_net -intf_net axi_gpio_2_gpio [get_bd_intf_pins gpio] [get_bd_intf_pins axi_gpio_2/gpio]

  # Create port connections
  connect_bd_net -net processing_system7_1_fclk_clk0 [get_bd_pins s_axi_aclk] [get_bd_pins axi_gpio_2/s_axi_aclk]
  connect_bd_net -net proc_sys_reset_peripheral_aresetn [get_bd_pins s_axi_aresetn] [get_bd_pins axi_gpio_2/s_axi_aresetn]
  
  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: Ethernet_Status
proc create_hier_cell_Ethernet_Status { parentCell nameHier } {

  if { $parentCell eq "" || $nameHier eq "" } {
     puts "ERROR: create_hier_cell_Ethernet_Status() - Empty argument(s)!"
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 gpio

  # Create pins
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -from 0 -to 0 -type rst s_axi_aresetn

  # Create instance: axi_gpio_1, and set properties
  set axi_gpio_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_1 ]
  set_property -dict [ list CONFIG.USE_BOARD_FLOW {true} CONFIG.GPIO_BOARD_INTERFACE {leds_8bits}  ] $axi_gpio_1

  # Create interface connections
  connect_bd_intf_net -intf_net processing_system7_1_axi_periph_m00_axi [get_bd_intf_pins s_axi] [get_bd_intf_pins axi_gpio_1/s_axi]
  connect_bd_intf_net -intf_net axi_gpio_1_gpio [get_bd_intf_pins gpio] [get_bd_intf_pins axi_gpio_1/gpio]

  # Create port connections
  connect_bd_net -net processing_system7_1_fclk_clk0 [get_bd_pins s_axi_aclk] [get_bd_pins axi_gpio_1/s_axi_aclk]
  connect_bd_net -net proc_sys_reset_peripheral_aresetn [get_bd_pins s_axi_aresetn] [get_bd_pins axi_gpio_1/s_axi_aresetn]
  
  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR ]
  set FIXED_IO [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO ]
  set GMII_ETHERNET_1 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gmii_rtl:1.0 GMII_ETHERNET_1 ]
  set leds_8bits [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 leds_8bits ]
  set btns_5bits [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 btns_5bits ]

  # Create ports

  # Create instance: processing_system7_1, and set properties
  set processing_system7_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.2 processing_system7_1 ]
  set_property -dict [ list CONFIG.PCW_ENET1_PERIPHERAL_ENABLE {1}  ] $processing_system7_1

  # Create instance: Ethernet_Status
  create_hier_cell_Ethernet_Status [current_bd_instance .] Ethernet_Status

  # Create instance: Ethernet_SW_Control
  create_hier_cell_Ethernet_SW_Control [current_bd_instance .] Ethernet_SW_Control

  # Create instance: Zynq_AXI_Interfacing
  create_hier_cell_Zynq_AXI_Interfacing [current_bd_instance .] Zynq_AXI_Interfacing

  # Create interface connections
  connect_bd_intf_net -intf_net processing_system7_1_ddr [get_bd_intf_ports DDR] [get_bd_intf_pins processing_system7_1/DDR]
  connect_bd_intf_net -intf_net processing_system7_1_fixed_io [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins processing_system7_1/FIXED_IO]
  connect_bd_intf_net -intf_net processing_system7_1_gmii_ethernet_1 [get_bd_intf_ports GMII_ETHERNET_1] [get_bd_intf_pins processing_system7_1/GMII_ETHERNET_1]
  connect_bd_intf_net -intf_net axi_gpio_1_gpio [get_bd_intf_ports leds_8bits] [get_bd_intf_pins Ethernet_Status/gpio]
  connect_bd_intf_net -intf_net axi_gpio_2_gpio [get_bd_intf_ports btns_5bits] [get_bd_intf_pins Ethernet_SW_Control/gpio]
  connect_bd_intf_net -intf_net processing_system7_1_m_axi_gp0 [get_bd_intf_pins processing_system7_1/M_AXI_GP0] [get_bd_intf_pins Zynq_AXI_Interfacing/S00_AXI]
  connect_bd_intf_net -intf_net processing_system7_1_axi_periph_m00_axi [get_bd_intf_pins Zynq_AXI_Interfacing/M00_AXI] [get_bd_intf_pins Ethernet_Status/s_axi]
  connect_bd_intf_net -intf_net processing_system7_1_axi_periph_m01_axi [get_bd_intf_pins Zynq_AXI_Interfacing/M01_AXI] [get_bd_intf_pins Ethernet_SW_Control/s_axi]

  # Create port connections
  connect_bd_net -net processing_system7_1_fclk_clk0 [get_bd_pins processing_system7_1/FCLK_CLK0] [get_bd_pins processing_system7_1/M_AXI_GP0_ACLK] [get_bd_pins Ethernet_Status/s_axi_aclk] [get_bd_pins Ethernet_SW_Control/s_axi_aclk] [get_bd_pins Zynq_AXI_Interfacing/S00_ACLK]
  connect_bd_net -net processing_system7_1_fclk_reset0_n [get_bd_pins processing_system7_1/FCLK_RESET0_N] [get_bd_pins Zynq_AXI_Interfacing/ext_reset_in]
  connect_bd_net -net proc_sys_reset_peripheral_aresetn [get_bd_pins Zynq_AXI_Interfacing/S00_ARESETN] [get_bd_pins Ethernet_Status/s_axi_aresetn] [get_bd_pins Ethernet_SW_Control/s_axi_aresetn]

  # Create address segments
  create_bd_addr_seg -range 0x10000 -offset 0x41200000 [get_bd_addr_spaces processing_system7_1/Data] [get_bd_addr_segs Ethernet_Status/axi_gpio_1/s_axi/Reg] SEG1
  create_bd_addr_seg -range 0x10000 -offset 0x41210000 [get_bd_addr_spaces processing_system7_1/Data] [get_bd_addr_segs Ethernet_SW_Control/axi_gpio_2/s_axi/Reg] SEG2
  

  # Restore current instance
  current_bd_instance $oldCurInst
}


#####################################################
# Main Flow
#####################################################

create_root_design ""
