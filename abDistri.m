function [ count ] = abDistri( ab )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
count = zeros(255,255);
N = size(ab,1);
for i = 1:N
    count(ab(i,2),ab(i,1)) = count(ab(i,2),ab(i,1)) + 1;
    if mod(i,1000) == 0
        disp(i/N)
    end
end

end

