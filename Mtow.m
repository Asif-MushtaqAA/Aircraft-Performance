clc
Cp1= 336; %g/kW-hr
Cp= Cp1*((9.81)/(1000*1000*3600)); %1/m
eta= 0.8;
P= 746*1100*2; %W
W0= 8600*9.81;
Pc= P*(1.02368/1.225)^0.7; %Pa= Pa0*(rho/rho0)^0.7

%% engine start, warmup, & taxi
V= 115;  %m/s
C= (Cp*V)/eta ; %1/s
T= 0.2*((P*eta)/V); %N   % 20% idle thrust

Wf1= C*T*15*60; 
W1= W0-Wf1;
W1_W0= 1-(C*15*60*(T/W1));
%% takeoff
V= 56.58;  %m/s
C= (Cp*V)/eta ; %1/s
T= (P*eta)/V; %N

Wf2= C*T*1*60;
W2= W1-Wf2;
W2_W1= 1-(C*1*60*(T/W2));
%% climb
V= 85;  %m/s
C= (Cp*V)/eta ; %1/s
T= (P*eta)/V; %N
D= .5*1.225*(V^2)*38.8*(0.03+((1/(pi*0.8*8.351)*((W2/(.5*1.225*V^2*38.8))^2))));

Wf3= C*T*25*60;
W3= W2-Wf3;
he= 19248+(((V)^(2))/(2*9.81));
W3_W2= exp((-C*he)/(V*(1-(D/T))));
%% cruise
V= 115;  %m/s
C= (Cp*V)/eta ; %1/s
T= 0.75*(P*eta)/V; %N
R= 222240; %m
%D= .5*1.02368*(V^2)*38.8*(0.03+((1/(pi*0.8*8.351)*((W3/(.5*1.02368*V^2*38.8))^2))));
L_D= 11.5;

Wf4= C*T*33*60;
W4= W3-Wf4;
W4_W3= exp((-R*C)/(V*(L_D)));
%% descend
W5_W4= 0.992;
%% loiter
V= 70;  %m/s
C= (Cp*V)/eta ; %1/s
T= 0.6*(P*eta)/V; %N
E= 30*60; %s
L_D= 9.959;

Wf6= C*T*30*60;
W6= W4-Wf6;
W6_W5= exp((-E*C)/(L_D));
%% descend
W7_W6= 0.992;
%% drop
V= 125;  %m/s
C= (Cp*V)/eta ; %1/s
T= 0.4*(P*eta)/V; %N
R= 1000; %m
%D= .5*1.225*(V^2)*38.8*(0.03+((1/(pi*0.8*8.351)*((W6/(.5*1.225*V^2*38.8))^2))));
Wd= 2400*9.81;
L_D= 11.5;

Wf8= C*T*33*60;
W8= W6-Wf8-Wd;
W8_W7= exp((-R*C)/(V*(L_D)));
%% climb2
V= 85;  %m/s
C= (Cp*V)/eta ; %1/s
T= (P*eta)/V; %N
D= .5*1.225*(V^2)*38.8*(0.03+((1/(pi*0.8*8.351)*((W2/(.5*1.225*V^2*38.8))^2))));

Wf9= C*T*25*60;
W9= W2-Wf9;
he= 19248+(((V)^(2))/(2*9.81));
W9_W8= exp((-C*he)/(V*(1-(D/T))));
%% cruise2
V= 115;  %m/s
C= (Cp*V)/eta ; %1/s
T= 0.75*(P*eta)/V; %N
R= 222240; %m
%D= .5*1.02368*(V^2)*38.8*(0.03+((1/(pi*0.8*8.351)*((W3/(.5*1.02368*V^2*38.8))^2))));
L_D= 11.5;

Wf10= C*T*33*60;
W10= W9-Wf10;
W10_W9= exp((-R*C)/(V*(L_D)));
%% descend2
W11_W10= 0.992;
%% hold
V= 70;  %m/s
C= (Cp*V)/eta ; %1/s
T= 0.6*(P*eta)/V; %N
E= 30*60; %s
L_D= 9.959;

Wf12= C*T*30*60;
W12= W10-Wf12;
W12_W11= exp((-E*C)/(L_D));
%% descend
W13_W12= 0.992;
%% landing
W14_W13= 0.995;
%% MTOW estimation
Wf_W0= 1.06*(1-(W14_W13*W13_W12*W12_W11*W11_W10*W10_W9*W9_W8*W8_W7*W7_W6*W6_W5*W5_W4*W4_W3*W3_W2*W2_W1*W1_W0));
Wf= Wf1+Wf2+Wf3+Wf4+Wf6+Wf8+Wf9+Wf10+Wf12; %N
W0
We= 4800*9.81 %from statistical weight estimation
Wcr= 300*9.81;
Wpay= 2400*9.81;
Wnew0= (Wcr+Wpay)/(1-(Wf_W0)-(We/W0))
Wnew0kg= Wnew0/9.81
Wenew= We*((Wnew0/W0)^0.957)
