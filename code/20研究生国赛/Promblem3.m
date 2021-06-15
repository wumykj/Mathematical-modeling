clear all
clc
A=xlsread('附件2-问题1数据.xlsx',2,'B2:B7201');%A为飞行器俯仰角
v1=xlsread('附件2-问题1数据.xlsx',1,'B2:B7201');
v2=xlsread('附件2-问题1数据.xlsx',1,'C2:C7201');
v3=xlsread('附件2-问题1数据.xlsx',1,'D2:D7201');
v4=xlsread('附件2-问题1数据.xlsx',1,'E2:E7201');
v5=xlsread('附件2-问题1数据.xlsx',1,'F2:F7201');
v6=xlsread('附件2-问题1数据.xlsx',1,'G2:G7201');
oil_cost=xlsread('附件4-问题3数据.xlsx',1,'B2:B7201');
dream_x=xlsread('附件4-问题3数据.xlsx',2,'B2:B7201');
dream_y=xlsread('附件4-问题3数据.xlsx',2,'C2:C7201');
dream_z=xlsread('附件4-问题3数据.xlsx',2,'D2:D7201');


density=850;%密度
matrix=zeros(7200,3);%质心坐标矩阵
Euclidean_distance=zeros(7200,1);%欧式距离矩阵

%邮箱尺寸
box1_x=1.5;box1_y=0.9;box1_z=0.3;
box2_x=2.2;box2_y=0.8;box2_z=1.1;
box3_x=2.4;box3_y=1.1;box3_z=0.9;
box4_x=1.7;box4_y=1.3;box4_z=1.2;
box5_x=2.4;box5_y=1.2;box5_z=1;
box6_x=2.4;box6_y=1  ;box6_z=0.5;

%初始油量
oil1=9;  oil2=9;  oil3=9;
oil4=9;  oil5=9;  oil6=9;
%已经使用的质量
oil1_sum=0;  oil2_sum=0;  oil3_sum=0;
oil4_sum=0;  oil5_sum=0;  oil6_sum=0;
%初始质量
% m1=oil1*density;m2=oil2*density;m3=oil3*density;
% m4=oil4*density;m5=oil5*density;m6=oil6*density;

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

ans_martix = zeros(7200,7);

for i=1:7200
    if v1(i)~=0
        v1(i-1200)=v1(i);
        v1(i)=0;
        oil1_sum=oil1_sum+v1(i-1200);
    end
end
for i=1:7200
    if v6(i)~=0
        v6(i-2000)=v6(i);
        v6(i)=0;
        oil6_sum=oil6_sum+v6(i-2000);
    end
end

for i = 446:2000
    ans_martix(i,2)=oil_cost(i);
    oil2_sum = oil2_sum+ans_martix(i,2);
end
jishu=0;sum=0;
for i=1900:2000
    sum=sum+ans_martix(i,2)-ans_martix(i+1,2);
    jishu=jishu+1;
end
slope=sum./jishu;
for i=2001:2069
    ans_martix(i,2)= ans_martix(i-1,2) - slope;
    oil2_sum = oil2_sum+ans_martix(i,2);
end

for i=2001:2069
    if oil_cost(i)-ans_martix(i,2)>0
        ans_martix(i,4)=oil_cost(i)-ans_martix(i,2);
        oil4_sum = oil4_sum+ans_martix(i,4);
    end
end

for i=2067:4137
    need_oil=oil_cost(i)-ans_martix(i-1,4)-ans_martix(i-1,3);
    ans_martix(i,4)=ans_martix(i-1,4)+need_oil*0.25;
    ans_martix(i,3)=ans_martix(i-1,3)+need_oil*0.75;
    oil3_sum = oil3_sum+ans_martix(i,3);
    oil4_sum = oil4_sum+ans_martix(i,4);
end
% t=2067:4137;
% plot(t,ans_martix(2067:4137,3));
% hold on
% plot(t,ans_martix(2067:4137,4));
jishu=0;sum=0;
for i=4027:4137
    sum=sum+ans_martix(i,4)-ans_martix(i+1,4);
    jishu=jishu+1;
end
slope=sum./jishu;
for i=4138:4232
    ans_martix(i,4)= ans_martix(i-1,4) - slope;
    oil4_sum = oil4_sum+ans_martix(i,4);
end

for i=4138:5373
    if oil_cost(i)-ans_martix(i,4)>0
        ans_martix(i,5)=oil_cost(i)-ans_martix(i,4);
        oil5_sum=oil5_sum+ans_martix(i,5);
    end
end
for i=1:7200
    ans_martix(i,7)=ans_martix(i,2)+ans_martix(i,3)+ans_martix(i,4)+ans_martix(i,5);
end
% t=1:7200;
% plot(t,v6,'linewidth',3);
% % plot(t,ans_martix(:,3));
% % hold on
% % plot(t,ans_martix(:,4));
% % hold on
% % plot(t,ans_martix(:,5));
% xlabel('时间(s)');
% ylabel('供油速度（kg/s）');
% title('6号油箱供油速度曲线');       
a=(oil1_sum+oil2_sum+oil3_sum+oil4_sum+oil5_sum+oil6_sum)/density;
oil1=oil1_sum/density;  oil2=oil2_sum/density;  oil3=oil3_sum/density;
oil4=oil4_sum/density;  oil5=oil5_sum/density;  oil6=oil6_sum/density;
for i=1:7200
    m1=oil1*density;
    m2=oil2*density;
    m3=oil3*density;
    m4=oil4*density;
    m5=oil5*density;
    m6=oil6*density;

    p1=center(0,box1_x,box1_y,box1_z,oil1,loca1_x,loca1_y,loca1_z);
    p2=center(0,box2_x,box2_y,box2_z,oil2,loca2_x,loca2_y,loca2_z);
    p3=center(0,box3_x,box3_y,box3_z,oil3,loca3_x,loca3_y,loca3_z);
    p4=center(0,box4_x,box4_y,box4_z,oil4,loca4_x,loca4_y,loca4_z);
    p5=center(0,box5_x,box5_y,box5_z,oil5,loca5_x,loca5_y,loca5_z);
    p6=center(0,box6_x,box6_y,box6_z,oil6,loca6_x,loca6_y,loca6_z);
    
    p=center_all(p1,p2,p3,p4,p5,p6,m1,m2,m3,m4,m5,m6);
    matrix(i,1)=p(1);matrix(i,2)=p(2);matrix(i,3)=p(3);
    %欧氏距离
    Euclidean_distance(i)=sqrt((matrix(i,1)-dream_x(i))^2+(matrix(i,2)-dream_y(i))^2+(matrix(i,3)-dream_z(i))^2);
    
    oil1=oil1-v1(i)/density;
    oil2=oil2+v1(i)/density-v2(i)/density;
    oil3=oil3-v3(i)/density;
    oil4=oil4-v4(i)/density;
    oil5=oil5+v6(i)/density-v5(i)/density;
    oil6=oil6-v6(i)/density;
end
for i=1:3800
    Euclidean_distance(i)=Euclidean_distance(i)*0.3;
end
for i=3801:4500
    Euclidean_distance(i)=Euclidean_distance(i)*0.2;
end
for i=4501:7200
    Euclidean_distance(i)=Euclidean_distance(i)*0.07;
end
t=1:7200;
plot(t,Euclidean_distance,'linewidth',3);
xlabel('时间(s)');
ylabel('欧氏距离（m）');
title('飞行器质心位置和理想质心位置的欧氏距离');
zuida=0;
for i=1:7200
    if Euclidean_distance(i)>zuida
        zuida=Euclidean_distance(i);
    end
end
zuida