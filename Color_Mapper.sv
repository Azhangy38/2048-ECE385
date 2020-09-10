//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  10-06-2017                               --
//                                                                       --
//    Fall 2017 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------

// color_mapper: Decide which color to be output to VGA for each pixel.
module  color_mapper ( input					is_board,                                       //   or background (computed in ball.sv)
							  input					is_h,
							  input 					is_v,
							  input        [9:0] DrawX, DrawY,       // Current pixel coordinates
							  input	logic	[11:0]cell_1,cell_2,cell_3,cell_4,cell_5,cell_6,cell_7,cell_8,cell_9,cell_10,cell_11,cell_12,cell_13,cell_14,cell_15,cell_16,
							  input 	logic [16:0]score,
                       output logic [7:0] VGA_R, VGA_G, VGA_B // VGA RGB output
                     );
		/*
		1) Finish score
		2) Randomize 2 blocks for initial state
		3) game logic (keycodes, merge logic, end state)
		4)
		*/
    
	 
    logic [7:0] Red, Green, Blue;
    
	 /* the numbers in hex from sprite table
		x30 - 0
		x31 - 1
		x32 - 2
		x33 - 3
		x34 - 4
		x35 - 5
		x36 - 6
		x37 - 7
		x38 - 8
		x39 - 9

		x53 - S
		x43 - C
		x4f - O
		x52 - R
		x45 - E
	 */

	 int x_, y_;
	 
	 assign x_ = DrawX;
	 assign y_ = DrawY;
	 
		
	 logic shape1_on;
	 logic shape2_on;
	 logic shape3_on;
	 logic shape4_on;
	 
	 
	 
	 logic[10:0] shape1_x = 301;
	 logic[10:0] shape2_x = 311;
	 logic[10:0] shape3_x = 321;
	 logic[10:0] shape4_x = 331; //301, 311, 321, 331  is the center, we would the previous number to start 311
	 
	 logic[10:0] shape_y = 50;
	 logic[10:0] shape_size_x = 8;
	 logic[10:0] shape_size_y = 16;	

	//SCOREBOARD: 500-600, 100-150; "score": 530,540,550,560,570;80

	 logic score1_on;
	 logic score2_on;
	 logic score3_on;
	 logic score4_on;
	 logic score5_on;

	 logic[10:0] score1_x = 530;
	 logic[10:0] score2_x = 540;
	 logic[10:0] score3_x = 550;
	 logic[10:0] score4_x = 560;
	 logic[10:0] score5_x = 570;
	 logic[10:0] score_y = 80;

	 logic scorenum1_on;
	 logic scorenum2_on;
	 logic scorenum3_on;
	 logic scorenum4_on;
	 logic scorenum5_on;
	 logic[10:0] scorenum_y = 125;

	 logic [10:0] sprite_addr;
	 logic [7:0] sprite_data;

	 // 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048
	 
	 font_rom (.addr(sprite_addr), .data(sprite_data));
	 
	 // game board
	 logic[11:0] temp;
	 logic tile1a, tile1b, tile1c, tile1d;
	 logic tile2a, tile2b, tile2c, tile2d;
	 logic tile3a, tile3b, tile3c, tile3d;
	 logic tile4a, tile4b, tile4c, tile4d;
	 logic tile5a,tile5b, tile5c, tile5d;
	 logic tile6a, tile6b, tile6c, tile6d;
	 logic tile7a, tile7b, tile7c, tile7d;
	 logic tile8a, tile8b, tile8c, tile8d;
	 logic tile9a, tile9b, tile9c, tile9d;
	 logic tile10a, tile10b, tile10c, tile10d;
	 logic tile11a, tile11b, tile11c, tile11d;
	 logic tile12a, tile12b, tile12c, tile12d;
	 logic tile13a, tile13b, tile13c, tile13d;
	 logic tile14a, tile14b, tile14c, tile14d;
	 logic tile15a, tile15b, tile15c, tile15d;
	 logic tile16a, tile16b, tile16c, tile16d;
	/* 
	 logic [3:0][3:0] board;		// contains the current state of the board
	 logic [3:0] location_x;	// coordinates for the VGA monitor
	 logic [3:0] location_y;*/
	// board <= 1'b0;
	 
	 // x1: 185, 260, 335, 410
	 // x2: 195, 270, 345, 420
	 // x3: 205, 280, 355, 430  
	 // x4: 215, 290, 365, 440
	 
	 // y: 124, 199, 274, 349 
	 // cases: 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048
// locations of each tile
		// draws the board
	 
	 
	 always_comb
	 begin
		if(x_ >= 185 && x_ < 185 + shape_size_x  && // 1a
			y_ >= 124 && y_ < 124 + shape_size_y && cell_1 >1000) 
			begin
				tile1a = 1'b1;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
	
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = (cell_1/1000)%10;
				sprite_addr = (y_-124 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 195 && x_ < 195 + shape_size_x  &&	// 1b
			y_ >= 124 && y_ < 124 + shape_size_y && cell_1 > 100) 
			begin
				tile1a = 1'b0;
				tile1b = 1'b1;
				tile1c = 1'b0;
				tile1d = 1'b0;
	
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;
				
				temp = (cell_1/100)%10;
				sprite_addr = (y_-124 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 205 && x_ < 205 + shape_size_x  &&	// 1c
			y_ >= 124 && y_ < 124 + shape_size_y && cell_1 > 10)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b1;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				 scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;
				
				temp = (cell_1/10)%10;
				sprite_addr = (y_-124 + 16*('h30+temp));	//0
			end
		
		 else if(x_ >= 215 && x_ < 215 + shape_size_x  &&		// 1d
			y_ >= 124 && y_ < 124 + shape_size_y && cell_1 != 0)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b1;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				 scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;
				
				temp = cell_1%10;
				sprite_addr = (y_-124 + 16*('h30+temp));	//0
			end
			
		else if(x_ >= 185 && x_ < 185 + shape_size_x  && // 5a
			y_ >= 199 && y_ < 199 + shape_size_y && cell_5 >1000) 
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
	
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b1;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				 scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = (cell_5/1000)%10;
				sprite_addr = (y_-199 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 195 && x_ < 195 + shape_size_x  &&	// 5b
			y_ >= 199 && y_ < 199 + shape_size_y && cell_5 > 100) 
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
	
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b1;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				 scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;
				
				temp = (cell_5/100)%10;
				sprite_addr = (y_-199 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 205 && x_ < 205 + shape_size_x  &&	// 5c
			y_ >= 199 && y_ < 199 + shape_size_y && cell_5 > 10)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b1;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				 scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = (cell_5/10)%10;
				sprite_addr = (y_-199 + 16*('h30+temp));	//0
			end
		
		 else if(x_ >= 215 && x_ < 215 + shape_size_x  &&		// 5d
			y_ >= 199 && y_ < 199 + shape_size_y && cell_5 != 0)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b1;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				 scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = cell_5%10;
				sprite_addr = (y_-199 + 16*('h30+temp));	//0
			end

			else if(x_ >= 185 && x_ < 185 + shape_size_x  && // 9a)
			y_ >= 274 && y_ < 274 + shape_size_y && cell_9 >1000) 
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
	
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b1;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				 scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = (cell_9/1000)%10;
				sprite_addr = (y_-274 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 195 && x_ < 195 + shape_size_x  &&	// 9b
			y_ >= 274 && y_ < 274 + shape_size_y && cell_9 > 100) 
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
	
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b1;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				 scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;
				
				temp = (cell_9/100)%10;
				sprite_addr = (y_-274 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 205 && x_ < 205 + shape_size_x  &&	// 9c
			y_ >= 274 && y_ < 274 + shape_size_y && cell_9 > 10)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b1;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;
				temp = (cell_9/10)%10;
				
				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				 scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;
				sprite_addr = (y_-274 + 16*('h30+temp));	//0
			end
		
		 else if(x_ >= 215 && x_ < 215 + shape_size_x  &&		// 9d
			y_ >= 274 && y_ <274 + shape_size_y && cell_9 != 0)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b1;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;
				temp = cell_9%10;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				 scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;


				sprite_addr = (y_-274 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 185 && x_ < 185 + shape_size_x  && // 13a
			y_ >= 349 && y_ < 349 + shape_size_y && cell_13 >1000) 
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
	
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b1;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				 scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = (cell_13/1000)%10;
				sprite_addr = (y_-349 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 195 && x_ < 195 + shape_size_x  &&	// 13b
			y_ >= 349 && y_ < 349 + shape_size_y && cell_13 > 100) 
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
	
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b1;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				 scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;
				
				temp = (cell_13/100)%10;
				sprite_addr = (y_-349 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 205 && x_ < 205 + shape_size_x  &&	// 13c
			y_ >= 349 && y_ < 349 + shape_size_y && cell_13 > 10)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b1;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;
				temp = (cell_13/10)%10;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				 scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;
				sprite_addr = (y_-349 + 16*('h30+temp));	//0
			end
		
		 else if(x_ >= 215 && x_ < 215 + shape_size_x  &&		// 13d
			y_ >= 349 && y_ < 349 + shape_size_y && cell_13 != 0)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b1;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;
				temp = cell_13%10;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				 scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;
				sprite_addr = (y_-349 + 16*('h30+temp));	//0
			end


			else if(x_ >= 260 && x_ < 260 + shape_size_x  && // 2a
			y_ >= 124 && y_ < 124 + shape_size_y && cell_2 >1000) 
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
	
				tile2a = 1'b1;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				 scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = (cell_2/1000)%10;
				sprite_addr = (y_-124 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 270 && x_ < 270 + shape_size_x  &&	// 2b
			y_ >= 124 && y_ < 124 + shape_size_y && cell_2 > 100) 
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
	
				tile2a = 1'b0;
				tile2b = 1'b1;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				 scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;
				
				temp = (cell_2/100)%10;
				sprite_addr = (y_-124 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 280 && x_ < 280 + shape_size_x  &&	// 2c
			y_ >= 124 && y_ < 124 + shape_size_y && cell_2 >=  10)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b1;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				 scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = (cell_2/10)%10;
				sprite_addr = (y_-124 + 16*('h30+temp));	//0
			end
		
		 else if(x_ >= 290 && x_ < 290 + shape_size_x  &&		// 2d
			y_ >= 124 && y_ < 124 + shape_size_y && cell_2 != 0)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b1;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;
				temp = (cell_2)%10;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				 scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				sprite_addr = (y_-124 + 16*('h30+temp));	//0
			end

			else if(x_ >= 260 && x_ < 260 + shape_size_x  && // 6a
			y_ >= 199 && y_ < 199 + shape_size_y && cell_6 >1000) 
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
	
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b1;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				 scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = (cell_6/1000)%10;
				sprite_addr = (y_-199 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 270 && x_ < 270 + shape_size_x  &&	// 6b
			y_ >= 199 && y_ < 199 + shape_size_y && cell_6 > 100) 
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
	
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b1;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				 scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;
				
				temp = (cell_6/100)%10;
				sprite_addr = (y_-199 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 280 && x_ < 280 + shape_size_x  &&	// 6c
			y_ >= 199 && y_ < 199 + shape_size_y && cell_6 > 10)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b1;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				 scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;
				temp = (cell_6/10)%10;
				sprite_addr = (y_-199 + 16*('h30+temp));	//0
			end
		
		 else if(x_ >= 290 && x_ < 290 + shape_size_x  &&		// 6d
			y_ >= 199 && y_ < 199 + shape_size_y && cell_6 != 0)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b1;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;
				temp = cell_6%10;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				 scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;
				sprite_addr = (y_-199 + 16*('h30+temp));	//0
			end

			
			else if(x_ >= 260 && x_ < 260 + shape_size_x  && // 10a
			y_ >= 274 && y_ < 274 + shape_size_y && cell_10 >1000) 
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
	
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b1;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				 scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = (cell_10/1000)%10;
				sprite_addr = (y_-274 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 270 && x_ < 270 + shape_size_x  &&	// 10b
			y_ >= 274 && y_ < 274 + shape_size_y && cell_10 > 100) 
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
	
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b1;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				 scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;
				
				temp = (cell_10/100)%10;
				sprite_addr = (y_-274 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 280 && x_ < 280 + shape_size_x  &&	// 10c
			y_ >= 274 && y_ < 274 + shape_size_y && cell_10 > 10)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b1;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				 scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;
				temp = (cell_10/10)%10;
				sprite_addr = (y_-274 + 16*('h30+temp));	//0
			end
		
		 else if(x_ >= 290 && x_ < 290 + shape_size_x  &&		// 10d
			y_ >= 274 && y_ < 274 + shape_size_y && cell_10 != 0)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b1;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;
				temp = (cell_10)%10;
				sprite_addr = (y_-274 + 16*('h30+temp));	//0
			end

			else if(x_ >= 260 && x_ < 260 + shape_size_x  && // 14a
			y_ >= 349 && y_ < 349 + shape_size_y && cell_14 >1000) 
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
	
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b1;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				 scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = (cell_14/1000)%10;
				sprite_addr = (y_-349 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 270 && x_ < 270 + shape_size_x  &&	// 14b
			y_ >= 349 && y_ < 349 + shape_size_y && cell_14 > 100) 
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
	
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b1;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				 scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;
				
				temp = (cell_14/100)%10;
				sprite_addr = (y_-349 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 280 && x_ < 280 + shape_size_x  &&	// 14c
			y_ >= 349 && y_ < 349 + shape_size_y && cell_14 > 10)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b1;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				 scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = (cell_14/10)%10;
				sprite_addr = (y_-349 + 16*('h30+temp));	//0
			end
		
		 else if(x_ >= 290 && x_ < 290 + shape_size_x  &&		// 14d
			y_ >= 349 && y_ < 349 + shape_size_y && cell_14 != 0)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b1;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				 scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = (cell_14)%10;
				sprite_addr = (y_-349 + 16*('h30+temp));	//0
			end

			else if(x_ >= 335 && x_ < 335 + shape_size_x  && // 3
			y_ >= 124 && y_ < 124 + shape_size_y && cell_3 >1000) 
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
	
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b1;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				 scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = (cell_3/1000)%10;
				sprite_addr = (y_-124 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 345 && x_ < 345 + shape_size_x  &&	// 3b
			y_ >= 124 && y_ < 124 + shape_size_y && cell_3 > 100) 
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
	
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b1;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				 scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;
				
				temp = (cell_3/100)%10;
				sprite_addr = (y_-124 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 355 && x_ < 355 + shape_size_x  &&	// 3c
			y_ >= 124 && y_ < 124 + shape_size_y && cell_3 >10)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b1;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				 scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = (cell_3/10)%10;
				sprite_addr = (y_-124 + 16*('h30+temp));	//0
			end
		
		 else if(x_ >= 365 && x_ < 365 + shape_size_x  &&		// 3d
			y_ >= 124 && y_ < 124 + shape_size_y && cell_3 != 0)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b1;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				 


				temp = (cell_3)%10;
				sprite_addr = (y_-124 + 16*('h30+temp));	//0
			end

			
		else	if(x_ >= 335 && x_ < 335 + shape_size_x  && // 7
			y_ >= 199 && y_ < 199 + shape_size_y && cell_7 >1000) 
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
	
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b1;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = (cell_7/1000)%10;
				sprite_addr = (y_-199 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 345 && x_ < 345 + shape_size_x  &&	// 7b
			y_ >= 199 && y_ < 199 + shape_size_y && cell_7 > 100) 
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
	
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b1;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				
				temp = (cell_7/100)%10;
				sprite_addr = (y_-199 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 355 && x_ < 355 + shape_size_x  &&	// 7c
			y_ >= 199 && y_ < 199 + shape_size_y && cell_7 >10)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b1;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				
				temp = (cell_7/10)%10;
				sprite_addr = (y_-199 + 16*('h30+temp));	//0
			end
		
		 else if(x_ >= 365 && x_ < 365 + shape_size_x  &&		// 7d
			y_ >= 199 && y_ < 199 + shape_size_y && cell_7 != 0)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b1;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				
				temp = (cell_7)%10;
				sprite_addr = (y_-199 + 16*('h30+temp));	//0
			end

			else if(x_ >= 335 && x_ < 335 + shape_size_x  && // 11a
			y_ >= 274 && y_ < 274 + shape_size_y && cell_11 > 1000) 
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
	
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b1;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;


				temp = (cell_11/1000)%10;
				sprite_addr = (y_-274 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 345 && x_ < 345 + shape_size_x  &&	// 11b
			y_ >= 274 && y_ < 274 + shape_size_y && cell_11 > 100) 
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
	
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b1;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				
				temp = (cell_11/100)%10;
				sprite_addr = (y_-274 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 355 && x_ < 355 + shape_size_x  &&	// 11c
			y_ >= 274 && y_ < 274 + shape_size_y && cell_11 >10)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b1;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				
				temp = (cell_11/10)%10;
				sprite_addr = (y_-274 + 16*('h30+temp));	//0
			end
		
		 else if(x_ >= 365 && x_ < 365 + shape_size_x  &&		// 11d
			y_ >= 274 && y_ < 274 + shape_size_y && cell_11 != 0)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b1;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				
				temp = (cell_11)%10;
				sprite_addr = (y_-274 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 335 && x_ < 335 + shape_size_x  && // 15a
			y_ >= 349 && y_ < 349 + shape_size_y && cell_15 >1000) 
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
	
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b1;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;


				temp = (cell_15/1000)%10;
				sprite_addr = (y_-349 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 345 && x_ < 345 + shape_size_x  &&	// 15b
			y_ >= 349 && y_ < 349 + shape_size_y && cell_15 > 100) 
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
	
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b1;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				
				temp = (cell_15/100)%10;
				sprite_addr = (y_-349 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 355 && x_ < 355 + shape_size_x  &&	// 15c
			y_ >= 349 && y_ < 349 + shape_size_y && cell_15 > 10)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b1;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = (cell_15/10)%10;
				sprite_addr = (y_-349 + 16*('h30+temp));	//0
			end
		
		 else if(x_ >= 365 && x_ < 365 + shape_size_x  &&		// 15d
			y_ >= 349 && y_ < 349 + shape_size_y && cell_15 != 0)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b1;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = (cell_15)%10;
				sprite_addr = (y_-349 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 410 && x_ < 410 + shape_size_x  && // 4
			y_ >= 124 && y_ < 124 + shape_size_y && cell_4 >1000) 
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
	
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b1;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;


				temp = (cell_4/1000)%10;
				sprite_addr = (y_-124 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 420 && x_ < 420 + shape_size_x  &&	// 4b
			y_ >= 124 && y_ < 124 + shape_size_y && cell_4 > 100) 
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
	
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b1;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				
				temp = (cell_4/100)%10;
				sprite_addr = (y_-124 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 430 && x_ < 430 + shape_size_x  &&	// 4c
			y_ >= 124 && y_ < 124 + shape_size_y && cell_4 > 10)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b1;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = (cell_4/10)%10;
				sprite_addr = (y_-124 + 16*('h30+temp));	//0
			end
		
		 else if(x_ >= 440 && x_ < 440 + shape_size_x  &&		// 4d
			y_ >= 124 && y_ < 124 + shape_size_y && cell_4 != 0)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b1;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = (cell_4)%10;
				sprite_addr = (y_-124 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 410 && x_ < 410 + shape_size_x  && // 8
			y_ >= 199 && y_ < 199 + shape_size_y && cell_8 >1000) 
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
	
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b1;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;


				temp = (cell_8/1000)%10;
				sprite_addr = (y_-199 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 420 && x_ < 420 + shape_size_x  &&	// 8b
			y_ >= 199 && y_ < 199 + shape_size_y && cell_8 > 100) 
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
	
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b1;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				
				temp = (cell_8/100)%10;
				sprite_addr = (y_-199 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 430 && x_ < 430 + shape_size_x  &&	// 8c
			y_ >= 199 && y_ < 199 + shape_size_y && cell_8 > 10)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b1;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = (cell_8/10)%10;
				sprite_addr = (y_-199 + 16*('h30+temp));	//0
			end
		
		 else if(x_ >= 440 && x_ < 440 + shape_size_x  &&		// 8d
			y_ >= 199 && y_ < 199 + shape_size_y && cell_8 != 0)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b1;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = (cell_8)%10;
				sprite_addr = (y_-199 + 16*('h30+temp));	//0
			end

			else if(x_ >= 410 && x_ < 410 + shape_size_x  && // 12
			y_ >= 274 && y_ < 274 + shape_size_y && cell_12 >1000) 
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
	
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b1;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;


				temp = (cell_12/1000)%10;
				sprite_addr = (y_-274 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 420 && x_ < 420 + shape_size_x  &&	// 12b
			y_ >= 274 && y_ < 274 + shape_size_y && cell_12 > 100) 
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
	
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b1;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				
				temp = (cell_12/100)%10;
				sprite_addr = (y_-274 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 430 && x_ < 430 + shape_size_x  &&	// 12c
			y_ >= 274 && y_ < 274 + shape_size_y && cell_12 > 10)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b1;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = (cell_12/10)%10;
				sprite_addr = (y_-274 + 16*('h30+temp));	//0
			end
		
		 else if(x_ >= 440 && x_ < 440 + shape_size_x  &&		// 12d
			y_ >= 274 && y_ < 274 + shape_size_y && cell_12 != 0)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b1;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = (cell_12)%10;
				sprite_addr = (y_-274 + 16*('h30+temp));	//0
			end

			else if(x_ >= 410 && x_ < 410 + shape_size_x  && // 16
			y_ >= 349 && y_ < 349 + shape_size_y && cell_16 >1000) 
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
	
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b1;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;


				temp = (cell_16/1000)%10;
				sprite_addr = (y_-349 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 420 && x_ < 420 + shape_size_x  &&	// 16b
			y_ >= 349 && y_ < 349 + shape_size_y && cell_16 > 100) 
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
	
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b1;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				
				temp = (cell_16/100)%10;
				sprite_addr = (y_-349 + 16*('h30+temp));	//0
			end
			
			else if(x_ >= 430 && x_ < 430 + shape_size_x  &&	// 16c
			y_ >= 349 && y_ < 349 + shape_size_y && cell_16 > 10)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b1;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = (cell_16/10)%10;
				sprite_addr = (y_-349 + 16*('h30+temp));	//0
			end
		
		 else if(x_ >= 440 && x_ < 440 + shape_size_x  &&		// 16d
			y_ >= 349 && y_ < 349 + shape_size_y && cell_16 != 0)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b1;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = (cell_16)%10;
				sprite_addr = (y_-349 + 16*('h30+temp));	//0
			end	
// TITLE SEQUENCE
		else if(x_ >= shape1_x && x_ < shape1_x + shape_size_x  &&
			y_ >= shape_y && y_ < shape_y + shape_size_y)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;
				shape1_on = 1'b1;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = cell_1;
				sprite_addr = (y_-shape_y + 16*'h32);	// 2
			end
		
		else if(x_ >= shape2_x && x_ < shape2_x + shape_size_x  &&
			y_ >= shape_y && y_ < shape_y + shape_size_y)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b1;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = cell_1%1000;
				sprite_addr = (y_-shape_y + 16*'h30);	// 0
				
			end
		else if(x_ >= shape3_x && x_ < shape3_x + shape_size_x  &&
			y_ >= shape_y && y_ < shape_y + shape_size_y)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b1;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = cell_1%1000;
				sprite_addr = (y_-shape_y + 16*'h34);	//4
			end
		else if(x_ >= shape4_x && x_ < shape4_x + shape_size_x  &&
			y_ >= shape_y && y_ < shape_y + shape_size_y)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b1;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = cell_1%1000;
				sprite_addr = (y_-shape_y + 16*'h38);	// 8
			end
			
		// SCORE
		else if(x_ >= score1_x && x_ < score1_x + shape_size_x  &&
			y_ >= score_y && y_ < score_y + shape_size_y)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;
				
				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b1;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = cell_1%1000;
				sprite_addr = (y_-score_y + 16*'h53);	// S
			end
		
		else if(x_ >= score2_x && x_ < score2_x + shape_size_x  &&
			y_ >= score_y && y_ < score_y + shape_size_y)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b1;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = cell_1%1000;
				sprite_addr = (y_-score_y + 16*'h43);	// C
				
			end
		else if(x_ >= score3_x && x_ < score3_x + shape_size_x  &&
			y_ >= score_y && y_ < score_y + shape_size_y)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b1;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = cell_1%1000;
				sprite_addr = (y_-score_y + 16*'h4f);	//O
			end
			
		else if(x_ >= score4_x && x_ < score4_x + shape_size_x  &&
			y_ >= score_y && y_ < score_y + shape_size_y)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b1;
			 	score5_on = 1'b0;

				scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = cell_1%1000;
				sprite_addr = (y_-score_y + 16*'h52);	// R
			end	
		
		else if(x_ >= score5_x && x_ < score5_x + shape_size_x  &&
			y_ >= score_y && y_ < score_y + shape_size_y)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b1;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = cell_1%1000;
				sprite_addr = (y_-score_y + 16*'h45);	// E
			end
// SCORE NUM
		else if(x_ >= score1_x && x_ < score1_x + shape_size_x  &&
			y_ >= scorenum_y && y_ < scorenum_y + shape_size_y && score>=10000)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;
				
				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				scorenum1_on = 1'b1;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = (score/10000)%10;
				sprite_addr = (y_-scorenum_y + 16*('h30+temp));	// First Digit
			end
		
		else if(x_ >= score2_x && x_ < score2_x + shape_size_x  &&
			y_ >= scorenum_y && y_ < scorenum_y + shape_size_y && score>=1000)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b1;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = (score/1000)%10;
				sprite_addr = (y_-scorenum_y + 16*('h30+temp));	// second digit
				
			end
		else if(x_ >= score3_x && x_ < score3_x + shape_size_x  &&
			y_ >= scorenum_y && y_ < scorenum_y + shape_size_y&& score>=100)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b1;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = (score/100)%10;
				sprite_addr = (y_-scorenum_y + 16*('h30+temp));	//Third Digit
			end
			
		else if(x_ >= score4_x && x_ < score4_x + shape_size_x  &&
			y_ >= scorenum_y && y_ < scorenum_y + shape_size_y && score>=10)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b1;
	 			scorenum5_on = 1'b0;

				temp = (score/10)%10;
				sprite_addr = (y_-scorenum_y + 16*('h30+temp));	// Fourth DigitS
			end	
		
		else if(x_ >= score5_x && x_ < score5_x + shape_size_x  &&
			y_ >= scorenum_y && y_ < scorenum_y + shape_size_y&& score>=0)
			begin
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b1;

				temp = (score)%10;
				sprite_addr = (y_-scorenum_y + 16*('h30+temp));	// Fifth Digit
			end		
			
		else
			begin
				shape1_on = 1'b0;
				shape2_on = 1'b0;
				shape3_on = 1'b0;
				shape4_on = 1'b0;
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				tile1a = 1'b0;
				tile1b = 1'b0;
				tile1c = 1'b0;
				tile1d = 1'b0;
				
				tile2a = 1'b0;
				tile2b = 1'b0;
				tile2c = 1'b0;
				tile2d = 1'b0;
				
				tile3a = 1'b0;
				tile3b = 1'b0;
				tile3c = 1'b0;
				tile3d = 1'b0;
				
				tile4a = 1'b0;
				tile4b = 1'b0;
				tile4c = 1'b0;
				tile4d = 1'b0;
				
				tile5a = 1'b0;
				tile5b = 1'b0;
				tile5c = 1'b0;
				tile5d = 1'b0;
				
				tile6a = 1'b0;
				tile6b = 1'b0;
				tile6c = 1'b0;
				tile6d = 1'b0;
				
				tile7a = 1'b0;
				tile7b = 1'b0;
				tile7c = 1'b0;
				tile7d = 1'b0;
				
				tile8a = 1'b0;
				tile8b = 1'b0;
				tile8c = 1'b0;
				tile8d = 1'b0;
				
				tile9a = 1'b0;
				tile9b = 1'b0;
				tile9c = 1'b0;
				tile9d = 1'b0;
				
				tile10a = 1'b0;
				tile10b = 1'b0;
				tile10c = 1'b0;
				tile10d = 1'b0;
				
				tile11a = 1'b0;
				tile11b = 1'b0;
				tile11c = 1'b0;
				tile11d = 1'b0;
				
				tile12a = 1'b0;
				tile12b = 1'b0;
				tile12c = 1'b0;
				tile12d = 1'b0;
				
				tile13a = 1'b0;
				tile13b = 1'b0;
				tile13c = 1'b0;
				tile13d = 1'b0;

				tile14a = 1'b0;
				tile14b = 1'b0;
				tile14c = 1'b0;
				tile14d = 1'b0;
				
				tile15a = 1'b0;
				tile15b = 1'b0;
				tile15c = 1'b0;
				tile15d = 1'b0;
				
				tile16a = 1'b0;
				tile16b = 1'b0;
				tile16c = 1'b0;
				tile16d = 1'b0;

				score1_on = 1'b0;
			 	score2_on = 1'b0;
			 	score3_on = 1'b0;
			 	score4_on = 1'b0;
			 	score5_on = 1'b0;

				  scorenum1_on = 1'b0;
	 			scorenum2_on = 1'b0;
	 			scorenum3_on = 1'b0;
	 			scorenum4_on = 1'b0;
	 			scorenum5_on = 1'b0;

				temp = cell_1%1000;
				sprite_addr = 10'b0;
			end
	end
	 
    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;
    
    // Assign color based on is_ball signal
    always_comb
    begin
        
		  // TITLE
		  if(((shape1_on == 1'b1) && (sprite_data[shape1_x-DrawX]==1'b1)) ||
						((shape2_on == 1'b1) && (sprite_data[shape2_x-DrawX]==1'b1))||
						((shape3_on == 1'b1) && (sprite_data[shape3_x-DrawX]==1'b1))||
						((shape4_on == 1'b1) && (sprite_data[shape4_x-DrawX]==1'b1)))
				begin
				Red = 8'h00;
				Green = 8'hff;
				Blue = 8'hff;
			end
			// SCORE
		  else if(	(((score1_on == 1'b1) || (scorenum1_on == 1'b1)) && (sprite_data[score1_x-DrawX]==1'b1)) ||
						(((score2_on == 1'b1) || (scorenum2_on == 1'b1)) && (sprite_data[score2_x-DrawX]==1'b1)) ||
						(((score3_on == 1'b1) || (scorenum3_on == 1'b1)) && (sprite_data[score3_x-DrawX]==1'b1)) ||
						(((score4_on == 1'b1) || (scorenum4_on == 1'b1)) && (sprite_data[score4_x-DrawX]==1'b1)) ||
						(((score5_on == 1'b1) || (scorenum5_on == 1'b1)) && (sprite_data[score5_x-DrawX]==1'b1)))
				begin
				Red = 8'h00;
				Green = 8'hff;
				Blue = 8'hff;
			end
		  
		  // number
		  else if(
				(((tile1a == 1'b1)||(tile5a == 1'b1)||(tile9a == 1'b1)||(tile13a == 1'b1)) && (sprite_data[185-DrawX]==1'b1)) ||
				(((tile1b == 1'b1)||(tile5b == 1'b1)||(tile9b == 1'b1)||(tile13b == 1'b1)) && (sprite_data[195-DrawX]==1'b1)) ||
				(((tile1c == 1'b1)||(tile5c == 1'b1)||(tile9c == 1'b1)||(tile13c == 1'b1)) && (sprite_data[205-DrawX]==1'b1)) ||
				(((tile1d == 1'b1)||(tile5d == 1'b1)||(tile9d == 1'b1)||(tile13d == 1'b1)) && (sprite_data[215-DrawX]==1'b1)) || 
				
				(((tile2a == 1'b1)||(tile6a == 1'b1)||(tile10a == 1'b1)||(tile14a == 1'b1)) && (sprite_data[260-DrawX]==1'b1)) ||
				(((tile2b == 1'b1)||(tile6b == 1'b1)||(tile10b == 1'b1)||(tile14b == 1'b1)) && (sprite_data[270-DrawX]==1'b1)) ||
				(((tile2c == 1'b1)||(tile6c == 1'b1)||(tile10c == 1'b1)||(tile14c == 1'b1)) && (sprite_data[280-DrawX]==1'b1)) ||
				(((tile2d == 1'b1)||(tile6d == 1'b1)||(tile10d == 1'b1)||(tile14d == 1'b1)) && (sprite_data[290-DrawX]==1'b1)) ||

				(((tile3a == 1'b1)||(tile7a == 1'b1)||(tile11a == 1'b1)||(tile15a == 1'b1)) && (sprite_data[335-DrawX]==1'b1)) ||
				(((tile3b == 1'b1)||(tile7b == 1'b1)||(tile11b == 1'b1)||(tile15b == 1'b1)) && (sprite_data[345-DrawX]==1'b1)) ||
				(((tile3c == 1'b1)||(tile7c == 1'b1)||(tile11c == 1'b1)||(tile15c == 1'b1)) && (sprite_data[355-DrawX]==1'b1)) ||
				(((tile3d == 1'b1)||(tile7d == 1'b1)||(tile11d == 1'b1)||(tile15d == 1'b1)) && (sprite_data[365-DrawX]==1'b1)) ||

				(((tile4a == 1'b1)||(tile8a == 1'b1)||(tile12a == 1'b1)||(tile16a == 1'b1)) && (sprite_data[410-DrawX]==1'b1)) ||
				(((tile4b == 1'b1)||(tile8b == 1'b1)||(tile12b == 1'b1)||(tile16b == 1'b1)) && (sprite_data[420-DrawX]==1'b1)) ||
				(((tile4c == 1'b1)||(tile8c == 1'b1)||(tile12c == 1'b1)||(tile16c == 1'b1)) && (sprite_data[430-DrawX]==1'b1)) ||
				(((tile4d == 1'b1)||(tile8d == 1'b1)||(tile12d == 1'b1)||(tile16d == 1'b1)) && (sprite_data[440-DrawX]==1'b1)))
				begin
					Red = 8'h00;
					Green = 8'hff;
					Blue = 8'hff;
			end
			
			
		// horizontal and vertical  
		  else if (is_h == 1'b1 || is_v == 1'b1)
				begin
					Red = 8'h00;
					Green = 8'h00;
					Blue = 8'h00;
				end
		  
		  else if (is_board == 1'b1)
			begin
				Red = 8'h70;
				Green = 8'h70;
				Blue = 8'h70;
			end
        
		  else 
        begin
            // Background with nice color gradient
            /*
				Red = 8'hff; 
            Green = 8'hff;
            Blue = 8'hff;//h7f - {1'b0, DrawX[9:3]};
				*/
				Red = 8'h4f - DrawX[9:3];
				Green = 8'h00;
				Blue = 8'h44;
		  end
    end 
	 
	
	

	
endmodule
