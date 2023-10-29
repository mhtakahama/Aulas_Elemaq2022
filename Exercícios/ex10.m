clear all; echo off; close all force; clc; format long; %clear another variables
%% Ex10
%Pmax?
%P?

w_motor=1000*2*pi/60; %rad/s
w_restante=200*2*pi/60; %rad/s
inercia_restante=2.04; %Kg.m2
t=2; %s
aceleracao=w_motor/t;
rho=7850; %kg/m3

%acomplamento (cilindro oco)
R_acoplamento=76.2/2000; 
r_acoplamento=31.2/2000; 
Vol_acoplamento=pi*((R_acoplamento)^2-(r_acoplamento)^2)*(57.2/1000); %m3
massa_acoplamento=Vol_acoplamento*rho %kg
mk2_acoplamento=massa_acoplamento*(R_acoplamento^2+r_acoplamento^2)/2

%rolamento (cilindro oco)
R_rolamento=50.8/2000; 
r_rolamento=31.2/2000; 
Vol_rolamento=pi*((R_rolamento)^2-(r_rolamento)^2)*(45/1000); %m3
massa_rolamento=Vol_rolamento*rho %kg
mk2_rolamento=massa_rolamento*(R_rolamento^2+r_rolamento^2)/2

%Engrenagem (cilindro oco)
R_engrenagem=304.8/2000; 
r_engrenagem=31.2/2000; 
Vol_engrenagem=pi*((R_engrenagem)^2-(r_engrenagem)^2)*(76.2/1000); %m3
massa_engrenagem=Vol_engrenagem*rho %kg
mk2_engrenagem=massa_engrenagem*(R_engrenagem^2+r_engrenagem^2)/2

%Eixo (cilindro maciço)
R_Eixo=31.2/2000; 
Vol_Eixo=pi*(R_Eixo)^2*(431.8/1000); %m3
massa_Eixo=Vol_Eixo*rho %kg
mk2_Eixo=massa_Eixo*R_Eixo^2/2

%Disco do freio
R_disco=100/1000;
Vol_disco=pi*(R_disco)^2*(5/1000); %m3
massa_disco=Vol_disco*rho %kg
mk2_disco=massa_disco*R_disco^2/2


%% Parte 2
mk2_total=mk2_acoplamento+mk2_rolamento+mk2_engrenagem+mk2_Eixo+mk2_disco
Torque_pecas=mk2_total*aceleracao

%Correçao da inercia pela velocidade de rotacao
% MK2=mk2(N/n)^2
Nn=(w_restante/w_motor)^2
inercia_restante_corrigido=inercia_restante*Nn
Torque_restante=inercia_restante_corrigido*aceleracao


Torque_total=Torque_pecas+Torque_restante+60 %+engrenagem
Potencia=Torque_total*w_motor

%% dimensionamento da pastilha Modelo pressao uniforme
z=3;
mi=0.3;
alpha=60*(pi/180);
re=95/1000;
ri=50/1000;
% pmedia=(1030+2070)/2*10^6;
pmax=3*Torque_total/(z*mi*alpha*(re^3-ri^3))