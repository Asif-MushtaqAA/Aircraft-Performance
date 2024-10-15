clc;
% Drag Polar
e= 0.8;
AR= 8.351;
CDo= 0.028;
Cl=-1.5:0.1:1.50;
%%
CD=zeros(1,length(Cl));

for numcl=1:length(Cl)
 CL=Cl(numcl);
 CD(numcl)= CDo + CL^2/(pi*e*AR);
end

figure(1)
plot(Cl,CD)
grid on
xlabel('CL')
ylabel('CD')