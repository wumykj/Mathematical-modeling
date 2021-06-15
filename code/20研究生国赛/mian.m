clear all
clc
A=xlsread('附件2-问题1数据.xlsx',2,'B2:B7201');%A为飞行器俯仰角
v1=xlsread('附件2-问题1数据.xlsx',1,'B2:B7201');
v2=xlsread('附件2-问题1数据.xlsx',1,'C2:C7201');
v3=xlsread('附件2-问题1数据.xlsx',1,'D2:D7201');
v4=xlsread('附件2-问题1数据.xlsx',1,'E2:E7201');
v5=xlsread('附件2-问题1数据.xlsx',1,'F2:F7201');
v6=xlsread('附件2-问题1数据.xlsx',1,'G2:G7201');

density=850;%密度
matrix=zeros(7200,3);%质心坐标矩阵

%邮箱尺寸
box1_x=1.5;box1_y=0.9;box1_z=0.3;
box2_x=2.2;box2_y=0.8;box2_z=1.1;
box3_x=2.4;box3_y=1.1;box3_z=0.9;
box4_x=1.7;box4_y=1.3;box4_z=1.2;
box5_x=2.4;box5_y=1.2;box5_z=1;
box6_x=2.4;box6_y=1  ;box6_z=0.5;


%初始油量
oil1=0.3;  oil2=1.5;  oil3=2.1;
oil4=1.9;  oil5=2.6;  oil6=0.8;

plane=3000;%飞行器质量

%输送油量上限（kg/s）
speed1=1.1;speed2=1.8;speed3=1.7;
speed4=1.5;speed5=1.6;speed6=1.1;

%邮箱中心位置
loca1_x=8.91304348;loca1_y=1.20652174;loca1_z=0.61669004;
loca2_x=6.91304348;loca2_y=-1.39347826;loca2_z=0.21669004;
loca3_x=-1.68695652;loca3_y=1.20652174;loca3_z=-0.28330996;
loca4_x=3.11304348;loca4_y=0.60652174;loca4_z=-0.18330996;
loca5_x=-5.28695652;loca5_y=-0.29347826;loca5_z=0.41669004;
loca6_x=-2.08695652;loca6_y=-1.49347826;loca6_z=0.21669004;
for i=1:7200
    m1=oil1*density;
    m2=oil2*density;
    m3=oil3*density;
    m4=oil4*density;
    m5=oil5*density;
    m6=oil6*density;

    p1=center(A(i),box1_x,box1_y,box1_z,oil1,loca1_x,loca1_y,loca1_z);
    p2=center(A(i),box2_x,box2_y,box2_z,oil2,loca2_x,loca2_y,loca2_z);
    p3=center(A(i),box3_x,box3_y,box3_z,oil3,loca3_x,loca3_y,loca3_z);
    p4=center(A(i),box4_x,box4_y,box4_z,oil4,loca4_x,loca4_y,loca4_z);
    p5=center(A(i),box5_x,box5_y,box5_z,oil5,loca5_x,loca5_y,loca5_z);
    p6=center(A(i),box6_x,box6_y,box6_z,oil6,loca6_x,loca6_y,loca6_z);
    
    p=center_all(p1,p2,p3,p4,p5,p6,m1,m2,m3,m4,m5,m6);
    matrix(i,1)=p(1);matrix(i,2)=p(2);matrix(i,3)=p(3);
    oil1=oil1-v1(i)/density;
    oil2=oil2+v1(i)/density-v2(i)/density;
    oil3=oil3-v3(i)/density;
    oil4=oil4-v4(i)/density;
    oil5=oil5+v6(i)/density-v5(i)/density;
    oil6=oil6-v6(i)/density;
end
x=matrix(:,1);y=matrix(:,2);z=matrix(:,3);
t=1:7200;
q=0;
for i=2:7200
    if (y(i)-y(i-1) >0.0003) 
        q=i;
    end   
end
% plot(t,z,'linewidth',3);
% xlabel('时间T/s');
% ylabel('z坐标/m');
% title('质心曲线z轴坐标');
plot3(x,y,z,'linewidth',3);
xlabel('x坐标/m');
ylabel('y坐标/m');
zlabel('z坐标/m')
title('质心曲线');
% tlabel('t(m)');
% ylabel('y(m)');
% title('y随时间的变化曲线图')
% plot3(x,y,z);
