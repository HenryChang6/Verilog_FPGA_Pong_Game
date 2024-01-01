# set clock 
set_location_assignment PIN_M9 -to clk;
# set reset
set_location_assignment PIN_P22 -to rst;

# set dot matrix column
set_location_assignment PIN_D13 -to dot_column1[7];
set_location_assignment PIN_A13 -to dot_column1[6];
set_location_assignment PIN_B12 -to dot_column1[5];
set_location_assignment PIN_C13 -to dot_column1[4];
set_location_assignment PIN_E14 -to dot_column1[3];
set_location_assignment PIN_A12 -to dot_column1[2];
set_location_assignment PIN_B15 -to dot_column1[1];
set_location_assignment PIN_E15 -to dot_column1[0];

set_location_assignment PIN_L8 -to dot_column2[7];
set_location_assignment PIN_J13 -to dot_column2[6];
set_location_assignment PIN_C15 -to dot_column2[5];
set_location_assignment PIN_B13 -to dot_column2[4];
set_location_assignment PIN_E16 -to dot_column2[3];
set_location_assignment PIN_G17 -to dot_column2[2];
set_location_assignment PIN_J18 -to dot_column2[1];
set_location_assignment PIN_A14 -to dot_column2[0];


# set dot matrix row
set_location_assignment PIN_D13 -to dot_row1[7];
set_location_assignment PIN_A13 -to dot_row2[6];
set_location_assignment PIN_B12 -to dot_row1[5];
set_location_assignment PIN_C13 -to dot_row1[4];
set_location_assignment PIN_E14 -to dot_row1[3];
set_location_assignment PIN_A12 -to dot_row1[2];
set_location_assignment PIN_B15 -to dot_row1[1];
set_location_assignment PIN_E15 -to dot_row1[0];

#set keypad
set_location_assignment PIN_K16     -to kp_col[3];
set_location_assignment PIN_G12     -to kp_col[2];
set_location_assignment PIN_G15     -to kp_col[1];
set_location_assignment PIN_F12     -to kp_col[0];

#set vga
    # SYNC
set_location_assignment PIN_H8 -to Hsync
set_location_assignment PIN_G8 -to Vsync
	# Red
set_location_assignment PIN_A9      -to red[0];
set_location_assignment PIN_B10     -to red[1];
set_location_assignment PIN_C9      -to red[2];
set_location_assignment PIN_A5      -to red[3];
	# Green
set_location_assignment PIN_L7      -to green[0];
set_location_assignment PIN_K7      -to green[1];
set_location_assignment PIN_J7      -to green[2];
set_location_assignment PIN_J8      -to green[3];
	# Blue
set_location_assignment PIN_B6      -to blue[0];
set_location_assignment PIN_B7      -to blue[1];
set_location_assignment PIN_A8      -to blue[2];
set_location_assignment PIN_A7      -to blue[3];

# set dot matrix
    # Digit_0
set_location_assignment PIN_AA22    -to sd_sec_dig1[6];
set_location_assignment PIN_Y21     -to sd_sec_dig1[5];
set_location_assignment PIN_Y22     -to sd_sec_dig1[4];
set_location_assignment PIN_W21     -to sd_sec_dig1[3];
set_location_assignment PIN_W22     -to sd_sec_dig1[2];
set_location_assignment PIN_V21     -to sd_sec_dig1[1];
set_location_assignment PIN_U21     -to sd_sec_dig1[0];
	# Digit_1
set_location_assignment PIN_U22 	-to sd_sec_dig2[6];
set_location_assignment PIN_AA17    -to sd_sec_dig2[5];
set_location_assignment PIN_AB18    -to sd_sec_dig2[4];
set_location_assignment PIN_AA18    -to sd_sec_dig2[3];
set_location_assignment PIN_AA19    -to sd_sec_dig2[2];
set_location_assignment PIN_AB20    -to sd_sec_dig2[1];
set_location_assignment PIN_AA20    -to sd_sec_dig2[0];
	# Digit_2
set_location_assignment PIN_AB21    -to sd_min[6];
set_location_assignment PIN_AB22    -to sd_min[5];
set_location_assignment PIN_V14     -to sd_min[4];
set_location_assignment PIN_Y14     -to sd_min[3];
set_location_assignment PIN_AA10    -to sd_min[2];
set_location_assignment PIN_AB17    -to sd_min[1];
set_location_assignment PIN_Y19     -to sd_min[0];

#set start
set_location_assignment PIN_U7      -to start;
