clc;
%% Terminology and units refer Raymer Chapter 15 pg 576
%enter in SI Units
Sw= 10.764* 38.8         %m2
Wfw= 2.205* 1120         %kg
A= 8.351
Clambda= 0
q= 0.020885* 6769.084        %N/m2
lambda = 0.714
t_c= 0.12
Nz= 1.5* 2.66            %limit load factor
Wdg= 2.205* 8600         %kg
Sht= 10.764* 10.4        %m2
Clambda_ht= 0
lambda_h= 1
Ht= 3.281* 0          %m
Hv= 3.281* 2.039          %m
Svt= 10.764* 5.2        %m2
Clambda_vt= 0
lambda_vt= 0.33
Sf= 10.764* 200         %m2
Lt= 3.281* 7.721          %m
L_D= 12.42
Vpr= 35.315* 0 ; Pdelta= 8 ;     %Vpr- m3, Pdelta- 8psi general
Wpress= 11.9*((Vpr*Pdelta)^(0.271))
Nl= 1.5* 2            %1.5*Ngear
Wl= 2.205* 8100         %kg
Lm= 39.37* 0.825          %m
Ln= 39.37* 0.825          %m
Wen= 2.205* 188         %kg
Nen= 2               %no. of engines
Vt= 264.2* 1.4          %m3
Vi= 264.2* 1.4         %m3
Nt= 4                 %no. of fuel tanks
L= 3.281* 13.6           %m
Bw= 3.281* 18          %m
Kh= 0.11             %medium subsonic with hydraulics for flaps
M= 0.33                  %design Mach number maximum
Wuav= 800           %typically 800-1400 lb
Np= 3                %no. of crew+pax

fprintf('RESULTS in KG\n')
%% equations (British Units (old), Now Results in KG (units))

Wwing= 0.036*(Sw^(0.758))*(Wfw^(0.0035))*((A/(cos(Clambda)*cos(Clambda)))^(0.6))*(q^(0.006))*(lambda^(0.04))*(((100*t_c)/(cos(Clambda)))^(-0.3))*((Nz*Wdg)^(0.49)) *0.45359237

WhorizontalTail= 0.016*((Nz*Wdg)^(0.414))*((q)^(0.168))*((Sht)^(0.896))*(((100*t_c)/(cos(Clambda)))^(-0.12))*((A/(cos(Clambda_ht)*cos(Clambda_ht)))^(0.043))*((lambda_h)^(-0.02)) *0.45359237

WverticalTail= 0.073*(1+(0.2*(Ht/Hv)))*((Nz*Wdg)^(0.376))*((q)^(0.122))*((Svt)^(0.873))*(((100*t_c)/(cos(Clambda_vt)))^(-0.49))*((A/(cos(Clambda_vt)*cos(Clambda_vt)))^(0.357))*((lambda_vt)^(0.039)) *0.45359237

Wfuselage=( (0.052*((Sf)^(1.086))*((Nz*Wdg)^(0.177))*((Lt)^(-0.051))*((L_D)^(-0.072))*((q)^(0.241))) + Wpress ) *0.45359237

WmainLandingGear= 0.095*((Nl*Wl)^(0.768))*((Lm/12)^(0.409)) *0.45359237

WnoseLandingGear= 0.125*((Nl*Wl)^(0.566))*((Ln/12)^(0.845)) *0.45359237

Winstalledengine_total= 2.575*((Wen)^(0.922))*Nen *0.45359237

WfuelSystem= 2.49*((Vt)^(0.726))*((1/(1+(Vi/Vt)))^(0.363))*((Nt)^(0.242))*((Nen)^(0.157)) *0.45359237

WflightControls= 0.053*((L)^(1.536))*((Bw)^(0.371))*((Nz*Wdg*(10^(-4)))^(0.8)) *0.45359237

Whydraulics= Kh*((Wdg)^(0.8))*((M)^(0.5)) *0.45359237

Wavionics= 2.117*((Wuav)^(0.933)) *0.45359237

Welectrical=( 12.57*(((WfuelSystem/0.45359237)+(Wavionics/0.45359237))^(0.51)) )*0.45359237

WairCond_antiIce= 0.265*((Wdg)^(0.52))*((Np)^(0.68))*((Wavionics/0.45359237)^(0.17))*((M)^(0.08)) *0.45359237

Wfurnishing=( (0.0582*Wdg) - 65 )*0.45359237

We= Wwing+WhorizontalTail+WverticalTail+Wfuselage+WmainLandingGear+WnoseLandingGear+Winstalledengine_total+WfuelSystem+WflightControls+Whydraulics+Wavionics+Welectrical+WairCond_antiIce+Wfurnishing
