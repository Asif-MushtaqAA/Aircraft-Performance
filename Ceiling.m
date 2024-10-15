clc;
% ceiling
W= 8600 * 9.81; %MTOW
S= 38.8; 
e= 0.8; %raymer
AR= 8.351;
K= 1/(pi*e*AR);
CDo= 0.028; % CFD
eta=0.86;
etamech= 0.95;
H= 0:100:11000;
Pa= 2*1160*745*eta*etamech; %eta*Pes
%%
LD=zeros(1,length(H));
Roc=zeros(1,length(H));
rho=zeros(1,length(H));

for numh=1:length(H)
 h=H(numh);
 rho(numh)= 1.225*(1+((-0.0065*h)/288.16))^(-(9.81/(-0.0065*287.1))-1);
 LD(numh)= sqrt(1/(4*CDo*K));
 Roc(numh)= ((Pa*((rho(numh))/1.225)^0.7)/W)-((2/rho(numh))*(sqrt(K/(3*CDo)))*(sqrt(W/S)))*(1.155/LD(numh));
 if (Roc(numh)>=0)
     Roc(numh)== Roc(numh);
 else
      Roc(numh)= 0;
 end

end

figure(1)
plot(Roc,H)
grid on
xlabel('Roc max (m/s)')
ylabel('H (m)')
