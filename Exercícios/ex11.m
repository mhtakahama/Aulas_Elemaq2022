clear all; echo off; close all force; clc; format long; %clear another variables
%% Ex11
% Figura do lado esquerdo Inercia e torque
% Lado direito dimensionamento do freio
carga=257; %Kg
V_const=0.25; %m/s

%a) Torque de frenagem t=0.25
t=0.25; %Tempo para frenagem
%b) Força de Frenagem F
%c) A largura da sapata (w)

%Sapatas de ocmposto contato a seco
mi=0.25; %coef atrito
Pmax=1.035*10^6; %Pa
alpha=25*2*pi/360; %rad
a=80/1000; %m
b=200/1000; %m
c=30/1000; %m
rho=7850; %Kg/m3
R_freio=150/1000; %m
%%

%Eixo (Cilindro maciço)
R_eixo=38/2000;
L_eixo=610/1000;
Vol_eixo=pi*(R_eixo)^2*(L_eixo); %m3
massa_eixo=Vol_eixo*rho %kg
mk2_eixo=massa_eixo*R_eixo^2/2

%Tambor cilindro oco
R_tambor1=203.2/2000;
r_tambor1=(152.4)/2000;
L_tambor1=330.2/1000;
Vol_tambor1=pi*((R_tambor1)^2-(r_tambor1)^2)*(L_tambor1); %m3
massa_tambor1=Vol_tambor1*rho %kg
mk2_tambor1=massa_tambor1*(R_tambor1^2+r_tambor1^2)/2

%Tambor 2discos juntos
R_tambor2=203.2/2000;
r_tambor2=(38)/2000;
L_tambor2=(406.4-330.2)/1000;
Vol_tambor2=pi*((R_tambor2)^2-(r_tambor2)^2)*(L_tambor2); %m3
massa_tambor2=Vol_tambor2*rho %kg
mk2_tambor2=massa_tambor2*(R_tambor2^2+r_tambor2^2)/2

%Tambor total
massa_tambor=massa_tambor1+massa_tambor2
mk2_tambor=mk2_tambor1+mk2_tambor2


%Inercia da carga
%V=w.R : w=V/R
rps=V_const/(2*pi*R_tambor1)
rpm=rps/60
%Inercia equivalente translacao
%Mk2=m*(V/2pi*f)^2
mk2_carga=carga*(V_const/(2*pi*rps))^2


% Total
mk2_total=mk2_eixo+mk2_tambor+mk2_carga
Torque_inercia=mk2_total*rps*2*pi/t
Torque_peso=carga*9.81*R_tambor1

Torque_total=Torque_inercia+Torque_peso


% Força de frenagem
%M_total=M1+M2
%M=F1,a*mi*R*a/(b+-c*mi)
Fa=Torque_total/(mi*R_freio*b)*1/(1/(a-c*mi)+1/(a+c*mi)) % No desenho b está invertido com a 

%Fa=Fn*(b+-c*mi)/a; 
Fn=Fa/((a-c*mi)/b)

%Fn=pmax*r*alpha*w
w=Fn/(Pmax*R_freio*alpha)