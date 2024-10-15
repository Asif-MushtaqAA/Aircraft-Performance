clc;
% L/D
W= 8600*9.81;
S= 38.8;
e= 0.8;
AR= 8.351;
CDo= 0.028;
Vel=20:5:180;
%%
CL=zeros(1,length(Vel));
CD=zeros(1,length(Vel));
LD=zeros(1,length(Vel));

CL2=zeros(1,length(Vel));
CD2=zeros(1,length(Vel));
LD2=zeros(1,length(Vel));

for numVel=1:length(Vel)
 V=Vel(numVel);
 CL(numVel)= W/(.5*1.225*V^2*S);
 CD(numVel)= CDo + CL(numVel)^2/(pi*e*AR);
 LD(numVel)= (CL(numVel)/CD(numVel));
end
%at 6000ft 1.02368
for numVel=1:length(Vel)
 V=Vel(numVel);
 CL2(numVel)= W/(.5*1.02368*V^2*S);
 CD2(numVel)= CDo + CL2(numVel)^2/(pi*e*AR);
 LD2(numVel)= (CL2(numVel)/CD2(numVel));
end
figure(11)
plot(Vel,LD,Vel,LD2)
grid on
xlabel('Velocity (m/s)')
ylabel('L/D')
legend('sea level','cruise')