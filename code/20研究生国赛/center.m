function [p0] = center(angle,x,y,z,oil,loca_x,loca_y,loca_z)
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

V=x*y*z;%�������
%��Խ��ߵ�����
jiaodu = atan(z/x)*180/pi;
%cornor_x=0;cornor_y=0;cornor_z=0;
%���������
cornor_x=loca_x-x/2;
cornor_y=loca_y-y/2;
cornor_z=loca_z-z/2;

%ƽ��
if angle==0
    high=oil/(x*y);
    p=[x/2,y/2,high/2];
end

if angle~=0
    %�Ƕȸպõ��ڶԽ��ߵ����
    if abs(angle)==jiaodu
        crisis_1=x*x/tand(abs(angle))*y*0.5;
        if oil<=crisis_1        %��������
            S=oil/y;
            length_x=sqrt(2*S/tand(abs(angle)));
            length_z=length_x*tand(abs(angle));
            length_y=y/2;
            center_x=length_x/3;
            center_z=length_z/3;
            center_y=length_y;
            p=[center_x,center_y,center_z];
        else                   %��������
            V_empty=x*y*z-oil;
            S_empty=V_empty/y;
            S=x*z-S_empty;
            b=sqrt(2*S_empty/tand(abs(angle)));
            center_y=y/2;
            S1=0.5*z*abs(x-b);
            S3=0.5*x* ( z-b*tand(abs(angle)) );
            center_x1=(x-b)/3;
            center_x2=(2*x-b)/3;
            center_x3=(2*x)/3;
            center_x=S1/S*center_x1+(S-S1-S3)/S*center_x2+S3/S*center_x3;
            center_z1=2*z/3;%(2*z-b*tand(abs(angle)))/3;
            center_z2=(2*z-b*tand(abs(angle)))/3;
            center_z3=( z - b*tand(abs(angle)) )/3;
            center_z=S1/S*center_z1+(S-S1-S3)/S*center_z2+S3/S*center_z3;
            p=[center_x,center_y,center_z];
        end
    end
    %�Ƕȴ��ڶԽ��ߵ����
    if abs(angle)>jiaodu
        crisis_1=x*x/tand(abs(angle))*y*0.5;
        crisis_2=x*y*z-crisis_1;

        if oil<=crisis_1        %��������
          S=oil/y;
          length_x=sqrt(2*S/tand(abs(angle)));
          length_z=length_x*tand(abs(angle));
          length_y=y/2;
          center_x=length_x/3;
          center_z=length_z/3;
          center_y=length_y;
          p=[center_x,center_y,center_z];
        
       else if oil<=crisis_2    %������
          S=oil/y;
          a=S/z-z/tand(abs(angle))/2;
          S1=abs(0.5*a*z);
          center_y=y/2;
          center_x1=a/3;
          center_x2=(2*a+z/tand(abs(angle)))/3;
          center_x=S1/S*center_x1+(S-S1)/S*center_x2;
          center_z1=2*z/3;
          center_z2=z/3;
          center_z=S1/S*center_z1+(S-S1)/S*center_z2;
          p=[center_x,center_y,center_z];
       else if oil<=V           %�������
          V_empty=x*y*z-oil;
          S_empty=V_empty/y;
          S=x*z-S_empty;
          b=sqrt(2*S_empty/tand(abs(angle)));
          center_y=y/2;
          S1=0.5*z*abs(x-b);
          S3=0.5*x* ( z-b*tand(abs(angle)) );
          center_x1=(x-b)/3;
          center_x2=(2*x-b)/3;
          center_x3=(2*x)/3;
          center_x=S1/S*center_x1+(S-S1-S3)/S*center_x2+S3/S*center_x3;
          center_z1=2*z/3;%(2*z-b*tand(abs(angle)))/3;
          center_z2=(2*z-b*tand(abs(angle)))/3;
          center_z3=( z - b*tand(abs(angle)) )/3;
          center_z=S1/S*center_z1+(S-S1-S3)/S*center_z2+S3/S*center_z3;
          p=[center_x,center_y,center_z];
            end
        end
    end
    end
    %����Ƕ�С�ڶԽ��ߵĽǶ�
    if abs(angle)<jiaodu   
    %�����ٽ�
    crisis_1=x*x*tand(abs(angle))*y*0.5;
    crisis_2=x*y*z-crisis_1;

    if oil<=crisis_1        %��������
        S=oil/y;
        length_x=sqrt(2*S/tand(abs(angle)));
        length_z=sqrt(2*S*tand(abs(angle)));
        length_y=y/2;
        center_x=length_x/3;
        center_z=length_z/3;
        center_y=length_y;
        p=[center_x,center_y,center_z];
    else if oil<=crisis_2    %������
            S=oil/y;
            a=S/x-x*tand(abs(angle))/2;
            S1=abs(0.5*a*x);
            center_y=y/2;
            center_x1=2*x/3;
            center_x2=x/3;
            center_x=S1/S*center_x1+(S-S1)/S*center_x2;
            center_z1=a/3;
            center_z2=( 2*a+ x*tand(abs(angle)) )/3;
            center_z=S1/S*center_z1+(S-S1)/S*center_z2;
            p=[center_x,center_y,center_z];
        else if oil<=V           %�������
            V_empty=x*y*z-oil;
            S_empty=V_empty/y;
            S=x*z-S_empty;
            b=sqrt(2*S_empty/tand(abs(angle)));
            center_y=y/2;
            S1=0.5*z*abs(x-b);
            S3=0.5*x* ( z-b*tand(abs(angle)) );
            center_x1=(x-b)/3;
            center_x2=(2*x-b)/3;
            center_x3=(2*x)/3;
            center_x=S1/S*center_x1+(S-S1-S3)/S*center_x2+S3/S*center_x3;
            center_z1=2*z/3;%(2*z-b*tand(abs(angle)))/3;
            center_z2=(2*z-b*tand(abs(angle)))/3;
            center_z3=( z - b*tand(abs(angle)) )/3;
            center_z=S1/S*center_z1+(S-S1-S3)/S*center_z2+S3/S*center_z3;
            p=[center_x,center_y,center_z];
            end
        end
    end
    end
%�жϽǶ�������
     if angle<0
         p=[x-p(1),p(2),p(3)];
     end
end
p0=[p(1)+cornor_x,p(2)+cornor_y,p(3)+cornor_z];
end
