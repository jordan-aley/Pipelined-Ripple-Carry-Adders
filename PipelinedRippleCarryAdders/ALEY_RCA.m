function y = ALEY_RCA()


%Create input and output file
input_file = fopen('ALEY_RCA_input.txt', 'w');
input_comb_file = fopen('ALEY_RCA_COMB_input.txt', 'w');

%mat_comb_outfile = fopen('ALEY_COMB_output.txt', 'w');
mat_2B_outfile = fopen('ALEY_RCA_2B_output.txt', 'w');
mat_4B_outfile = fopen('ALEY_RCA_4B_output.txt', 'w');
mat_6B_outfile = fopen('ALEY_RCA_6B_output.txt', 'w');
mat_8B_outfile = fopen('ALEY_RCA_8B_output.txt', 'w');
mat_comb_outfile = fopen('ALEY_RCA_COMB_output.txt', 'w');

% X padding for input
for i = 1:11
fprintf(input_file, 'X X XXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXX\n');
fprintf(input_comb_file, 'X X XXXXXXXXXXXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXX\n');
end

%test reset
fprintf(input_file, '1 0 111111111111111111111111 111111111111111111111111\n');
fprintf(input_file, '1 0 111111111111111111111111 111111111111111111111111\n');
%test enable
fprintf(input_file, '0 0 111111111111111111111111 111111111111111111111111\n');
fprintf(input_file, '0 0 111111111111111111111111 111111111111111111111111\n');

%X padding outputs
for i = 1:12
 fprintf(mat_2B_outfile, 'XXXXXXXXXXXXXXXXXXXXXXXX X\n');
 fprintf(mat_4B_outfile, 'XXXXXXXXXXXXXXXXXXXXXXXX X\n');
 fprintf(mat_6B_outfile, 'XXXXXXXXXXXXXXXXXXXXXXXX X\n');
 fprintf(mat_8B_outfile, 'XXXXXXXXXXXXXXXXXXXXXXXX X\n');
end

for i = 1:11
 fprintf(mat_comb_outfile, 'XXXXXXXXXXXXXXXXXXXXXXXX X\n');
end

%testing zero
for i = 1:2
fprintf(input_file, '0 1 000000000000000000000000 000000000000000000000000\n'); 
end 

%padding zeroes for reset, enable, and zero testing also padding
for i = 1:6
 fprintf(mat_2B_outfile, '000000000000000000000000 0\n');
end

for i = 1:6
 fprintf(mat_4B_outfile, '000000000000000000000000 0\n');
end

for i = 1:6
 fprintf(mat_6B_outfile, '000000000000000000000000 0\n');
end

for i = 1:6
 fprintf(mat_8B_outfile, '000000000000000000000000 0\n');
end


%number of input_bits
bits = 24;

for i = 1:2^24
    cout = '';
    inputA =i;
    inA = dec2bin(inputA, 24);
    inputB = inputA-1;
    inB = dec2bin(inputB, 24); 
    enable = 1;
    en = dec2bin(enable,1);
    reset = 0;
    rst = dec2bin(reset,1);
    
    sum = inputA+inputB;

    y = ['0' ' ' '1' ' ' inA ' ' inB];
    z = [inA ' ' inB];
    x = [dec2bin(sum, bits) ' ' '0'];
    
    fprintf(input_file, '%s\r\n', y);
    fprintf(input_comb_file, '%s\r\n', z);
    
    fprintf(mat_2B_outfile, '%s\r\n', x);
    fprintf(mat_4B_outfile, '%s\r\n', x);
    fprintf(mat_6B_outfile, '%s\r\n', x);
    fprintf(mat_8B_outfile, '%s\r\n', x); 
    fprintf(mat_comb_outfile, '%s\r\n', x);     
end


fprintf(mat_2B_outfile, '.\n');
fprintf(mat_4B_outfile, '.\n');
fprintf(mat_6B_outfile, '.\n');
fprintf(mat_8B_outfile, '.\n');
fprintf(input_file, '.\n');
fclose('all');
end
