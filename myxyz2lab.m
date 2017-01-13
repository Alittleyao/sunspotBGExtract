function [ lab ] = myxyz2lab( xyz )
%myxyz2lab 将XYZ色彩空间转换为Lab色彩空间
%   此处显示详细说明

X = xyz(1);
Y = xyz(2);
Z = xyz(3);
Xn = 0.95047;
Yn = 1.00000;
Zn = 1.08888;

L = 116*f(Y/Yn) - 16;
a = 500 * (f(X/Xn) - f(Y/Yn));
b = 200 * (f(Y/Yn) - f(Z/Zn));

lab = [L, a, b];

end

function r = f(t)
if t > (6/29)^3
    r = t^(1/3);
else
    r = (1/3) * (29/6)^2 * t + 4/29;
end
end
