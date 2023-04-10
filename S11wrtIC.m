% Rushi Vyas  
% s  
%--------------------------------------------------------------------------
% This part of the code takes S11 wrt 50 ohms and plots it wrt to RFID IC Imepdance
% Loaded file should be in real and imaginary format
%--------------------------------------------------------------------------
close all

A=load('6June08_P_Air_30mm.txt');  % Load antenna S-para measurements from VNA. 
SdB=A(:,2);
Srad=A(:,3);
freq=A(:,1);
Smag=10.^(SdB/20);  
Sre=Smag.*cos(Srad);     % Convert polar format of S-para measurements to real and imagninary
Sim=Smag.*sin(Srad);
S=Sre+i*Sim;
%plot(freq/10^6,20*log10(abs(S)),'ro');
hold
plot(freq/10^6,SdB,'k-');

Zant=50*(1+S)./(1-S);  % Determine Antenna Impedance Zant

fic=900*10^6;
Zic=24-j*222;  % RFID IC impedance from RFID datasheet
%Zic=conj(Zic)

Sic = (Zic-conj(Zant))./(Zant+Zic); % Antenna S-parameters wrt non-50 ohm RFID IC Impedance
SicMag=abs(Sic);
SicDB = 20*log10(SicMag);

plot(freq/10^6,SdB,'k-');   % Plot Antenna S-para wrt to IC impedance. Valid only over 860-930 MHz ISM band 
hold on
plot(freq/10^6,SicDB,'r-');
title('Give plot title');
figure
plot(freq/10^6,real(Zant),'r-');
figure
plot(freq/10^6,imag(Zant),'b-');


