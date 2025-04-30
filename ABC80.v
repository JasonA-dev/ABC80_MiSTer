// video circuit
reg   [3:0] cnt_h5;
reg   [5:0] hcnt; // k6
reg   [8:0] vcnt; // k3-k4
reg   [3:0] blink_cnt;
wire        blink_on = blink_cnt[3];

// ... existing code ...

always @(posedge CLK12) begin
	reg cnt_clr_d;

	if (cen6) begin
		cnt_h5 <= cnt_h5 + 1'd1;
		if (cnt_h5 == 15) begin
			cnt_h5 <= 0;
			hcnt <= hcnt + 1'd1;
			if (hcnt == 63) begin
				hcnt <= 0;
				vcnt <= vcnt + 1'd1;
				if (vcnt == 287) vcnt <= 0;
			end
		end
		if (cnt_clr) begin
			hcnt <= 0;
			vcnt <= 0;
			cnt_h5 <= 0;
		end
	end
	
	cnt_clr_d <= cnt_clr;
	if (~cnt_clr_d & cnt_clr) blink_cnt <= blink_cnt + 1'd1;
end 