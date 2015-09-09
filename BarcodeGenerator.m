%Generates barcode images for machine vision detection
%Author: Colin Power

clear all
close all

bits = 2;
steps = bits*2+1; %Will be used to create seperating whitespace

height = 1601;
width = 1601;

image = ones(height, width); %Artifical white image
startStrip = 400;
endStrip = startStrip;

%Use floor to remove non-integer result. This will introduce errors.
period = floor( ((height-1)-startStrip*2) / steps);

%Create black line sements for stop and start
for x=1:startStrip+1
    for y=1:width
        image(x, y) = 0;
        image(height-x, y) = 0;
    end
end

figure
for decimal=0:power(2,bits)-1; %number of unique codes
    output = image;
    bitIndex = 1;
    
    for n=0:steps-1;
        for x=n*period+startStrip:(n+1)*period+startStrip %loop through one full period
            
            if (mod(n, 2) == 1) %every 2nd part of the line code.
                binary = dec2bin(decimal, bits);
                if (binary(bitIndex) == '1') %check if value is 0 or 1 in binary
                    %paint line black every 2nd period and when binary value is 1
                    for y=1:width
                        output(x, y) = 0;
                    end
                end
            end
        end
        
        if (mod(n,2) == 1)
            bitIndex = bitIndex+1;
        end
    end
    subplot(bits, bits, decimal+1), imshow(output), xlabel(binary);
end
