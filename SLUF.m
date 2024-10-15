
clc;
% Thrust, Power Required
W= 8600 * 9.81; %MTOW
S= 38.8; 
e= 0.8; %raymer
AR= 8.351;
CDo= 0.028; % CFD
eta=0.86;
etamech= 0.95;
Vel=20:5:180;
Pa= 2*1160*745*eta*etamech; %eta*Pes
Pa2= Pa*(1.02368/1.225)^0.7; %Pa= Pa0*(rho/rho0)^0.7
%%
CL=zeros(1,length(Vel));
CD=zeros(1,length(Vel));
Tr=zeros(1,length(Vel)); Pr=zeros(1,length(Vel));
Ta=zeros(1,length(Vel));
Roc=zeros(1,length(Vel));
CL2=zeros(1,length(Vel));
CD2=zeros(1,length(Vel));
Tr2=zeros(1,length(Vel));Pr2=zeros(1,length(Vel));
Ta2=zeros(1,length(Vel));
Roc2=zeros(1,length(Vel));
PA=zeros(1,length(Vel));
PA2=zeros(1,length(Vel));

for numVel=1:length(Vel)
 V=Vel(numVel);
 CL(numVel)= W/(.5*1.225*V^2*S);
 CD(numVel)= CDo + CL(numVel)^2/(pi*e*AR);
 Tr(numVel)= W/(CL(numVel)/CD(numVel));
 Ta(numVel)= Pa/V;
 Pr(numVel)= Tr(numVel)*V;
 Roc(numVel)= (Pa-Pr(numVel))/W;
 PA(numVel)= Pa;
 if (Roc(numVel)>=0)
     Roc(numVel)== Roc(numVel);
 else
      Roc(numVel)= 0;
 end
end
%at 6000ft
for numVel=1:length(Vel)
 V=Vel(numVel);
 CL2(numVel)= W/(.5*1.02368*V^2*S);
 CD2(numVel)= CDo + CL2(numVel)^2/(pi*e*AR);
 Tr2(numVel)= W/(CL2(numVel)/CD2(numVel));
 Ta2(numVel)= Pa2/V;
 Pr2(numVel)= Tr2(numVel)*V;
 Roc2(numVel)= (Pa2-Pr2(numVel))/W;
 PA2(numVel)= Pa2;
 if (Roc2(numVel)>=0)
     Roc2(numVel)== Roc2(numVel);
 else
      Roc2(numVel)= 0;
 end
end
figure(1)
plot(Vel,Tr,Vel,Tr2,Vel,Ta,Vel,Ta2)
grid on
xlabel('Velocity (m/s)')
ylabel('Tr (N)')
legend('sea level thrust','cruise thrust','Thrust available@sea','Thrust available@6000ft')
figure(2)
plot(Vel,Pr,Vel,Pr2,Vel,PA,Vel,PA2)
grid on
xlabel('Velocity (m/s)')
ylabel('Pr (W)')
legend('sea level power','cruise power','Power available@sea','Power available@6000ft')
figure(3)
plot(Vel,Roc,Vel,Roc2)
grid on
xlabel('Velocity (m/s)')
ylabel('RoC (m/s)')
legend('sea level','cruise')

