module game (input           Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [7:0]	  keycode,
					input [9:0]   DrawX, DrawY,
					output logic is_board,
					output logic is_h,
					output logic is_v,
					output logic [16:0]score,
					output logic [11:0] cell_1,cell_2,cell_3,cell_4,cell_5,cell_6,cell_7,cell_8,cell_9,cell_10,cell_11,cell_12,cell_13,cell_14,cell_15,cell_16
					);
					
			/* 	BUGS
				Does not generate another random tile at each key press
				
				Changes made
					win condition is 2048 instead of 256
					Sprites and board are all drawn by us
					Scoreboard added
					used usb keyboard instead of buttons
				TODO: 
					fix starting tile
					add a chance for a "4" to spawn
					
			*/		
					
		
			logic [16:0] score_output = 0;

			
			logic [11:0] Matrix[15:0];
			wire [191:0] MatrixCopy;
			
			logic [1:0] counterMove, counterMerge;
			logic [3:0] buttonValue; 
			logic [5:0] state;
			logic flagDone;  
			logic flagstate1,flagstate2,flagGen, flagGenState;
			logic flag;
			
			assign MatrixCopy = {Matrix[15],Matrix[14],Matrix[13],Matrix[12],Matrix[11],Matrix[10],Matrix[9],
			Matrix[8],Matrix[7],Matrix[6],Matrix[5],Matrix[4],Matrix[3],Matrix[2],Matrix[1],Matrix[0]};
			
			// END CONDITIONS
			assign check_over = ((Matrix[0] !== Matrix[1]) && (Matrix[0] !== Matrix[4]) && (Matrix[1] !== Matrix[5]) && (Matrix[1] !== Matrix[2]) &&(Matrix[2] !== Matrix[6]) &&
			(Matrix[2] !== Matrix[3]) && (Matrix[3] !== Matrix[7]) && (Matrix[4] !== Matrix[5]) && (Matrix[4] !== Matrix[8]) && (Matrix[5] !== Matrix[9]) && 
			(Matrix[5] !== Matrix[6]) && (Matrix[6] !== Matrix[7]) && (Matrix[6] !== Matrix[10]) && (Matrix[7] !== Matrix[11]) && (Matrix[8] !== Matrix[9]) && 
			(Matrix[8] !== Matrix[12]) && (Matrix[9] !== Matrix[10]) && (Matrix[9] !== Matrix[13]) && (Matrix[10] !== Matrix[14]) && (Matrix[10] !== Matrix[11]) && 
			(Matrix[11] !== Matrix[15]) && (Matrix[12] !== Matrix[13]) && (Matrix[13] !== Matrix[14]) && (Matrix[14] !== Matrix[15])&&(Matrix[0] !== 0)&&
			(Matrix[1] !== 0)&&(Matrix[2] !== 0)&&(Matrix[3] !== 0)&&(Matrix[4] !== 0)&&(Matrix[5] !== 0)
			&&(Matrix[6] !== 0)&&(Matrix[7] !== 0)&&(Matrix[8] !== 0)&&(Matrix[9] !== 0)&&(Matrix[10] !== 0)
			&&(Matrix[11] !== 0)&&(Matrix[12] !== 0)&&(Matrix[13] !== 0)&&(Matrix[14] !== 0)&&(Matrix[15] !== 0));
			
			// WIN		
			assign checkWin = ((Matrix[0] == 2048) || (Matrix[1] == 2048) || (Matrix[2] == 2048) || (Matrix[3] == 2048) || (Matrix[4] == 2048) || (Matrix[5] == 2048) || (Matrix[6] == 2048) || (Matrix[7] == 2048) || 
			(Matrix[8] == 2048) || (Matrix[9] == 2048) || (Matrix[10] == 2048) || (Matrix[11] == 2048) || (Matrix[12] == 2048) || (Matrix[13] == 2048) || (Matrix[14] == 2048) || (Matrix[15] == 2048));
			
			logic [4:0] randNum1,randNum2;
			
			logic [7:0] W = 8'h1A;
			logic [7:0] A = 8'h04;
			logic [7:0] S = 8'h16;
			logic [7:0] D = 8'h07;
			
			int i,j, k; // used for loop instruction
			
			// states for the FSM
			parameter [5:0] INI_State = 6'b000001;
			parameter [5:0] randFirst = 6'b000010;
			parameter [5:0] randSecond = 6'b000100;
			parameter [5:0] Move = 6'b001000;
			parameter [5:0] Merge = 6'b010000;
			parameter [5:0] Done = 6'b100000;
			
			logic [10:0] randCount;			
			
			always_ff @(posedge Clk)begin
				if (Reset)
					randCount <= 0;
				else if(randCount == 11'b11111111111)
					randCount <= 0;
				else randCount <= randCount + 1;
			end
			
			// FSM
			
			always_ff @(posedge Clk)
			begin
				if (Reset)
					begin
						state <= INI_State;
						for(i=0; i<16; i= i+1) 
							begin
								Matrix[i] <= 0;
							end	
					
					end
				else 
					begin	
						case(state)
							INI_State:
								begin
									state <= randFirst;
									randNum1 <= randCount[3:0];	
									randNum2 <= randCount[7:4];
									
									flagGen <= 1;
									flagGenState <= 0;
									buttonValue <= 0;
									flagDone <= 0;
									
									
									for(i=0; i<16; i= i+1) 
										begin
											Matrix[i] <= 0;
										end	
									
								end
								
							randFirst:
								begin
									state <= randSecond;	
									// add a condition for generating a 4
									Matrix[randNum1] <= 2;
									Matrix[randNum2] <= 2;
								end
								
							randSecond:
								begin
									// add in a checker for Done and other states later on
									if ((check_over || checkWin) && (flagGenState))
										state <= Done;
									if (((check_over==0)&& (flagGenState))||((Matrix[randNum1] == 0) && (flagGenState)))  
										state <= Move;
									
									randNum1 = randCount[3:0];
									
									if ((Matrix[randNum2] == 0) && flagGen)   
										begin
											Matrix[randNum2] <= 2;       
											flagGen <= 0;
										end
										
									// usb_keyboard presses	
									if (keycode == W) buttonValue <= 4'b0001;
									if (keycode == S) buttonValue <= 4'b0010;
									if (keycode == A) buttonValue <= 4'b0100;
									if (keycode == D) buttonValue <= 4'b1000;
									
									if (keycode == W || keycode == S || keycode == A || keycode == D ) flagGenState <=1;
									
									flagstate1 <=0;
									flagstate2 <=0;
								
								end
								
								
							Move:
							// change flagstate2 after each move/merge session
								begin
									if(flagstate2 == 1)
										state <= randSecond;
									
									if (buttonValue == 4'b0001) // slide-up
									begin
										for (j = 0; j < 4; j++)
										begin
											for (i = 0; i < 4; i++)
											begin
												if (Matrix[i*4+j] > 0)
												begin
												 // find first available row that is less than that
													for (k = 0; k < i; k++)
													begin
														if (Matrix[k*4+j] == 0)
														begin
														  flag = 1;
														  Matrix[k*4+j] = Matrix[i*4+j]; //shifts the value up
														  Matrix[i*4+j] = 0; // replaces the old place with a 0
														end
													end
												end
											end
										 end
									
									// Merge up
									for (j = 0; j < 4; j++)
									begin
										for (i = 0; i < 4; i++)
										begin
										  if (Matrix[i*4+j] > 0 && i*4+j-4 > 0)
										  begin
											 // checks if the neighbor on top is the same
											 if (Matrix[i*4+j-4] == Matrix[i*4+j])
											 begin
												flag = 1;
												Matrix[i*4+j-4] = Matrix[i*4+j]*2; // combines them if same
												score_output = Matrix[i*4+j]*2+score_output; //add to score
												Matrix[i*4+j] = 0;
											 end
										  end
										end
									 end
									 // Slide 2
									 for (j = 0; j < 4; j++)
										begin
											for (i = 0; i < 4; i++)
											begin
												if (Matrix[i*4+j] > 0)
												begin
												 // find first available row that is less than that
													for (k = 0; k < i; k++)
													begin
														if (Matrix[k*4+j] == 0)
														begin
														  flag = 1;
														  Matrix[k*4+j] = Matrix[i*4+j]; //shifts the value up
														  Matrix[i*4+j] = 0; // replaces the old place with a 0
														end
													end
												end
											end
										 end
									flagstate1<=1;
									flagstate2 <= 1;	 
								end // end of "w"
								
								if (buttonValue == 4'b0010) // S, down
								begin
									for (j = 3; j >= 0; j--)
									begin
										 for (i = 3; i >= 0; i--)
										 begin
											if (Matrix[i*4+j] > 0)
											begin
											// find first available row that is less than that
											  for (k = 3; k >= i; k--)// changed from 4 to 3
											  begin
												 if (Matrix[k*4+j] == 0)
												 begin
													flag = 1;
													Matrix[k*4+j] = Matrix[i*4+j]; //shifts the value up
													Matrix[i*4+j] = 0; // replaces the old place with a -1
												 end
											  end
											end
										 end
									  end
								  
									 for (j = 3; j >= 0; j--)
									  begin
										 for (i = 3; i >= 0; i--)
										 begin
											if (Matrix[i*4+j] > 0 && i*4+j+4 < 16)
											begin
											  // checks if the neighbor on top is the same
											  if (Matrix[i*4+j+4] == Matrix[i*4+j])
											  begin
												 flag = 1;
												 // combines them if same
												 Matrix[i*4+j+4] = Matrix[i*4+j]*2;
												 score_output = Matrix[i*4+j]*2+score_output;
												 Matrix[i*4+j] = 0;
											end
										 end
									  end
									end
								  
								for (j = 3; j >= 0; j--)
								begin
									 for (i = 3; i >= 0; i--)
									 begin
										if (Matrix[i*4+j] > 0)
										begin
										// find first available row that is less than that
										  for (k = 3; k >= i; k--)
										  begin
											 if (Matrix[k*4+j] == 0)
											 begin
												flag = 1;
												Matrix[k*4+j] = Matrix[i*4+j]; //shifts the value up
												Matrix[i*4+j] = 0; // replaces the old place with a -1
											 end
										  end
										end
									 end
								  end
								  flagstate1<=1;
								  flagstate2 <= 1;	  
								end
								
								// Slide LEft, A
								if (buttonValue == 4'b0100)
								begin
									for (i = 0; i < 4; i++)
									begin
										for (j = 0; j < 4; j++)
										begin
										  if (Matrix[i*4+j] > 0)
										  begin // check for empty values
										  // find first available row that is less than that
											 for (k = 0; k < j; k++)
											 begin // checks previous row
												if (Matrix[i*4+k] == 0)
												begin // if empty
												  flag = 1;
												  Matrix[i*4+k] = Matrix[i*4+j];
												  Matrix[i*4+j] = 0;
												end
											 end
										  end
										end
									 end
									 
									 for (i = 0; i < 4; i++)
									 begin
										for (j = 0; j < 3; j++)
										begin// bounds is different b/c the last column doesn't have a neighbor :(
										  if (Matrix[i*4+j] > 0)
										  begin
												if (Matrix[i*4+j+1] == Matrix[i*4+j])
												begin  // checks if the neighbor on the right is the same
												  flag = 1;
												  Matrix[i*4+j] = Matrix[i*4+j]*2; // combines them if same
												  score_output = Matrix[i*4+j]*2+score_output;
												  Matrix[i*4+j+1] = 0;
												end
										  end
										end
									 end
									 
									for (i = 0; i < 4; i++)
									begin
										for (j = 0; j < 4; j++)
										begin
										  if (Matrix[i*4+j] > 0)
										  begin // check for empty values
										  // find first available row that is less than that
											 for (k = 0; k < j; k++)
											 begin // checks previous row
												if (Matrix[i*4+k] == 0)
												begin // if empty
												  flag = 1;
												  Matrix[i*4+k] = Matrix[i*4+j];
												  Matrix[i*4+j] = 0;
												end
											 end
										  end
										end
									 end
									 flagstate1<=1;
									flagstate2 <= 1; 
								end
								// SLIDE RIGHT, D
								if (buttonValue == 4'b1000)
								begin
									for (i = 3; i >= 0; i--)
									begin
									  for (j = 3; j >= 0; j--)
									  begin
										 if (Matrix[i*4+j] > 0)
										 begin
										 // find first available row that is less than that
											for (k = 3; k > j; k--)
											begin
											  if (Matrix[i*4+k] == 0)
											  begin
												 flag = 1;
												 Matrix[i*4+k] = Matrix[i*4+j];
												 Matrix[i*4+j] = 0;
											end
										 end
									  end
									end
								 end
								 
								 for (i = 3; i >= 0; i--)
								 begin
									// bounds is different b/c the last column doesn't have a neighbor :(
									for (j = 3; j > 0 ;j--)
									begin
									  if (Matrix[i*4+j] > 0)
									  begin
										 // checks if the neighbor on the left is the same
										 if (Matrix[i*4+j-1] == Matrix[i*4+j])
										 begin
											flag = 1;
											Matrix[i*4+j] = Matrix[i*4+j]*2; // combines them if same
											score_output = Matrix[i*4+j]*2+score_output;
											Matrix[i*4+j-1] = 0;
										 end
									  end
									end
								 end
								 flagstate1<=1;
								flagstate2 <= 1;
							end
									flagstate2 <= 1;
									flagGen <= 1;
									buttonValue <= 0;
									flagGenState <=0;
								end	
									
								Done:
									begin
										// clears board
										state <=	INI_State;
										
										for(i=0; i<16; i= i+1) 
										begin
											Matrix[i] <= 0;
										end	
										score_output <= 0;
										flagDone <= 1;
									end
						endcase
					end
			end
			
			
			// if we have time, add another counter from 1 to 10 to signify the chance of a 4		
			
			
			always_comb
			begin
			cell_1 = Matrix[0];  
			cell_2 = Matrix[1];  
			cell_3 = Matrix[2];  
			cell_4 = Matrix[3];  
			cell_5 = Matrix[4];  
			cell_6 = Matrix[5];  
			cell_7 = Matrix[6];  
			cell_8 = Matrix[7];  
			cell_9 = Matrix[8];  
			cell_10 = Matrix[9]; 
			cell_11 = Matrix[10];
			cell_12 = Matrix[11];
			cell_13 = Matrix[12];
			cell_14 = Matrix[13];
			cell_15 = Matrix[14];
			cell_16 = Matrix[15];
			score = score_output;
			end
			
		
		//SCOREBOARD: 500-600, 100-150; "score": 530,540,550,560,570;80
		int x_, y_;
			
		assign x_ = DrawX;
		assign y_ = DrawY;
				
		always_comb begin		
		// board and scoreboard	 
			if (((x_ <= 10'd470) && (x_ >= 10'd170) && (y_ <= 10'd390) && (y_ >= 10'd90)) || 
				((x_ <= 10'd600) && (x_ >= 10'd500) && (y_<= 10'd150) && (y_>= 10'd100))) 
				is_board = 1'b1;				
			
			else
				is_board = 1'b0;
		end
    
	 always_comb begin
	 // vertical lines
		if (((y_ >= 10'd90) && (y_ <= 10'd390)) && (((x_ >= 10'd170) && (x_ <= 10'd174)) || 
			((x_ >= 10'd244) && (x_ <= 10'd248)) || ((x_ >= 10'd318) && (x_ <= 10'd322)) || 
			((x_ >= 10'd392) && (x_ <= 10'd396)) || ((x_ >= 10'd466) && (x_ <= 10'd470))) || 
			((y_ >= 10'd96) && (y_ <= 10'd154)) && (((x_ >= 10'd496) && (x_ <= 10'd500)) || 
			(x_ >= 10'd600) && (x_ <= 10'd604)))	
				is_h = 1'b1;
		else
				is_h = 1'b0;
			end
	 always_comb begin
		// horizontal lines
		if (((x_ >= 10'd170) && (x_ <= 10'd470)) && (((y_ >= 10'd90) && (y_ <= 10'd94)) || 
			((y_ >= 10'd164) && (y_ <= 10'd168)) || ((y_ >= 10'd238) && (y_ <= 10'd242)) || 
			((y_ >= 10'd312) && (y_ <= 10'd316))|| ((y_ >= 10'd386) && (y_ <= 10'd390))) ||
			((x_ >= 10'd500) && (x_ <= 10'd600) && ((y_ >= 10'd150) && (y_ <= 10'd154) || 
			(y_ >= 10'd96) && (y_ <= 10'd100))))					
				is_v = 1'b1;
		else
				is_v = 1'b0;
							
		end
endmodule
