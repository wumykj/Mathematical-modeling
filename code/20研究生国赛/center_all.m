function [p] = center_all(p1,p2,p3,p4,p5,p6,m1,m2,m3,m4,m5,m6)
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
M=m1+m2+m3+m4+m5+m6;
p=(p1*m1+p2*m2+p3*m3+p4*m4+p5*m5+p6*m6)/M;
end