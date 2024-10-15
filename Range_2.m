clc;
% Range
W= 8600 * 9.81;
W1= 7400 * 9.81;
S= 38.8;
e= 0.8;
AR= 8.351;
CDo= 0.028; % CFD
Vel=20:5:180;
c=9.156*10^(-7); %1/m
eta=0.86;
%%
CL=zeros(1,length(Vel));
CD=zeros(1,length(Vel));
LD=zeros(1,length(Vel));
Roc=zeros(1,length(Vel));
CL2=zeros(1,length(Vel));
CD2=zeros(1,length(Vel));
LD2=zeros(1,length(Vel));
R=zeros(1,length(Vel));
R2=zeros(1,length(Vel));


for numVel=1:length(Vel)
 V=Vel(numVel);
 CL(numVel)= W/(.5*1.225*V^2*S);
 CD(numVel)= CDo + CL(numVel)^2/(pi*e*AR);
 LD(numVel)= (CL(numVel)/CD(numVel));
 R(numVel)= (eta/c)*LD(numVel)*log(W/W1);
end
%at 6000ft 1.02368
for numVel=1:length(Vel)
 V=Vel(numVel);
 CL2(numVel)= W/(.5*1.02368*V^2*S);
 CD2(numVel)= CDo + CL2(numVel)^2/(pi*e*AR);
 LD2(numVel)= (CL2(numVel)/CD2(numVel));
 R2(numVel)= (eta/c)*LD2(numVel)*log(W/W1);
end
figure(2)
plot(Vel,R,Vel,R2)
xlabel('Velocity (m/s)')
ylabel('Range (m)')
legend('sea level','cruise')