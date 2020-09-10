//-------------------------------------------------------------------------
//    Ball.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  12-08-2017                               --
//    Spring 2018 Distribution                                           --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  ball ( input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
               input [7:0]	  keycode,
					input [9:0]   DrawX, DrawY,       // Current pixel coordinates
               output logic  is_ball,             // Whether current pixel belongs to ball or background
					output logic is_board,
					output logic is_h,
					output logic is_v
					//output logic shape_on,
					//output logic sprite_addr
              );
    
    parameter [9:0] Ball_X_Center = 10'd320;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center = 10'd240;  // Center position on the Y axis
    parameter [9:0] Ball_X_Min = 10'd0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max = 10'd639;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min = 10'd0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max = 10'd479;     // Bottommost point on the Y axis
    parameter [9:0] Ball_X_Step = 10'd1;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step = 10'd1;      // Step size on the Y axis
    parameter [9:0] Ball_Size = 10'd4;        // Ball size
    
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion;
    logic [9:0] Ball_X_Pos_in, Ball_X_Motion_in, Ball_Y_Pos_in, Ball_Y_Motion_in;
    
	 logic [7:0] W = 8'h1A;
    logic [7:0] A = 8'h04;
    logic [7:0] S = 8'h16;
    logic [7:0] D = 8'h07;
	 
    //////// Do not modify the always_ff blocks. ////////
    // Detect rising edge of frame_clk
    logic frame_clk_delayed, frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end
    // Update registers
    always_ff @ (posedge Clk)
    begin
        if (Reset)
        begin
            Ball_X_Pos <= Ball_X_Center;
            Ball_Y_Pos <= Ball_Y_Center;
            Ball_X_Motion <= 10'd0;
            Ball_Y_Motion <= Ball_Y_Step;
        end
        else
        begin
            Ball_X_Pos <= Ball_X_Pos_in;
            Ball_Y_Pos <= Ball_Y_Pos_in;
            Ball_X_Motion <= Ball_X_Motion_in;
            Ball_Y_Motion <= Ball_Y_Motion_in;
        end
    end
    //////// Do not modify the always_ff blocks. ////////
    
    // You need to modify always_comb block.
    always_comb
    begin
        // By default, keep motion and position unchanged
        Ball_X_Pos_in = Ball_X_Pos;
        Ball_Y_Pos_in = Ball_Y_Pos;
        Ball_X_Motion_in = Ball_X_Motion;
        Ball_Y_Motion_in = Ball_Y_Motion;
        
        // Update position and motion only at rising edge of frame clock
        if (frame_clk_rising_edge)
        begin
            // Be careful when using comparators with "logic" datatype because compiler treats 
            //   both sides of the operator as UNSIGNED numbers.
            // e.g. Ball_Y_Pos - Ball_Size <= Ball_Y_Min 
            // If Ball_Y_Pos is 0, then Ball_Y_Pos - Ball_Size will not be -4, but rather a large positive number.
            if( Ball_Y_Pos + Ball_Size >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
                Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);  // 2's complement.  
            else if ( Ball_Y_Pos <= Ball_Y_Min + Ball_Size )  // Ball is at the top edge, BOUNCE!
                Ball_Y_Motion_in = Ball_Y_Step;
            // TODO: Add other boundary detections and handle keypress here.
				if( Ball_X_Pos + Ball_Size >= Ball_X_Max )  // Ball is at the right edge, BOUNCE!
                Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);  // 2's complement.  
            else if ( Ball_X_Pos <= Ball_X_Min + Ball_Size )  // Ball is at the left edge, BOUNCE!
                Ball_X_Motion_in = Ball_X_Step;
				
				case (keycode)
					W:
					begin
						Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);
						Ball_X_Motion_in = 10'd0;
						if( Ball_Y_Pos + Ball_Size >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
							Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);  // 2's complement.  
						else if ( Ball_Y_Pos <= Ball_Y_Min + Ball_Size )  // Ball is at the top edge, BOUNCE!
							Ball_Y_Motion_in = Ball_Y_Step;
					// TODO: Add other boundary detections and handle keypress here.
							if( Ball_X_Pos + Ball_Size >= Ball_X_Max )  // Ball is at the right edge, BOUNCE!
                	Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);  // 2's complement.  
							else if ( Ball_X_Pos <= Ball_X_Min + Ball_Size )  // Ball is at the left edge, BOUNCE!
                	Ball_X_Motion_in = Ball_X_Step;
					end
					
					S:
					begin
						Ball_Y_Motion_in = Ball_Y_Step;
						Ball_X_Motion_in = 10'd0;
						if( Ball_Y_Pos + Ball_Size >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
							Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);  // 2's complement.  
						else if ( Ball_Y_Pos <= Ball_Y_Min + Ball_Size )  // Ball is at the top edge, BOUNCE!
							Ball_Y_Motion_in = Ball_Y_Step;
            // TODO: Add other boundary detections and handle keypress here.
						if( Ball_X_Pos + Ball_Size >= Ball_X_Max )  // Ball is at the right edge, BOUNCE!
							Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);  // 2's complement.  
						else if ( Ball_X_Pos <= Ball_X_Min + Ball_Size )  // Ball is at the left edge, BOUNCE!
							Ball_X_Motion_in = Ball_X_Step;
					end
					
					A:
					begin
						Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);
						Ball_Y_Motion_in = 10'd0;
						if( Ball_Y_Pos + Ball_Size >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
							Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);  // 2's complement.  
						else if ( Ball_Y_Pos <= Ball_Y_Min + Ball_Size )  // Ball is at the top edge, BOUNCE!
							Ball_Y_Motion_in = Ball_Y_Step;
					// TODO: Add other boundary detections and handle keypress here.
						if( Ball_X_Pos + Ball_Size >= Ball_X_Max )  // Ball is at the right edge, BOUNCE!
							Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);  // 2's complement.  
						else if ( Ball_X_Pos <= Ball_X_Min + Ball_Size )  // Ball is at the left edge, BOUNCE!
							Ball_X_Motion_in = Ball_X_Step;	
					end
					
					D:
					begin
						Ball_X_Motion_in = Ball_X_Step;
						Ball_Y_Motion_in = 10'd0;
						if( Ball_Y_Pos + Ball_Size >= Ball_Y_Max )  // Ball is at the bottom edge, BOUNCE!
							Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);  // 2's complement.  
						else if ( Ball_Y_Pos <= Ball_Y_Min + Ball_Size )  // Ball is at the top edge, BOUNCE!
							Ball_Y_Motion_in = Ball_Y_Step;
					// TODO: Add other boundary detections and handle keypress here.
						if( Ball_X_Pos + Ball_Size >= Ball_X_Max )  // Ball is at the right edge, BOUNCE!
							Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);  // 2's complement.  
						else if ( Ball_X_Pos <= Ball_X_Min + Ball_Size )  // Ball is at the left edge, BOUNCE!
							Ball_X_Motion_in = Ball_X_Step;
					end
					default:;
				endcase
	
            // Update the ball's position with its motion
            Ball_X_Pos_in = Ball_X_Pos + Ball_X_Motion;
            Ball_Y_Pos_in = Ball_Y_Pos + Ball_Y_Motion;
        end
        
        /**************************************************************************************
            ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
            Hidden Question #2/2:
               Notice that Ball_Y_Pos is updated using Ball_Y_Motion. 
              Will the new value of Ball_Y_Motion be used when Ball_Y_Pos is updated, or the old? 
              What is the difference between writing
                "Ball_Y_Pos_in = Ball_Y_Pos + Ball_Y_Motion;" and 
                "Ball_Y_Pos_in = Ball_Y_Pos + Ball_Y_Motion_in;"?
              How will this impact behavior of the ball during a bounce, and how might that interact with a response to a keypress?
              Give an answer in your Post-Lab.
        **************************************************************************************/
    end
    
    // Compute whether the pixel corresponds to ball or background
    /* Since the multiplicants are required to be signed, we have to first cast them
       from logic to int (signed by default) before they are multiplied. */
    int DistX, DistY, Size;
    assign DistX = DrawX - Ball_X_Pos;
    assign DistY = DrawY - Ball_Y_Pos;
    assign Size = Ball_Size;
    always_comb begin
        if ( ( DistX*DistX + DistY*DistY) <= (Size*Size) ) 
            is_ball = 1'b1;
        else
            is_ball = 1'b0;
        /* The ball's (pixelated) circle is generated using the standard circle formula.  Note that while 
           the single line is quite powerful descriptively, it causes the synthesis tool to use up three
           of the 12 available multipliers on the chip! */
    end
	 int x_, y_;
	 assign x_ = DrawX;
	 assign y_ = DrawY;
	 
	 /* Might be moved into Color_Mapper
    parameter [9:0] Ball_X_Center = 10'd320;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center = 10'd240;  // Center position on the Y axis
    parameter [9:0] Ball_X_Min = 10'd0;       // Leftmost point on the X axis
    parameter [9:0d Ball_X_Max = 10'd639;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min = 10'd0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max = 10'd479;
	 300x300
	 170-470 -> x
	 90-390 -> y
	 */
	 
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
		
/*	Algorithm for numbers to move
	16 states, one for each block
	
	*/	
	
endmodule
