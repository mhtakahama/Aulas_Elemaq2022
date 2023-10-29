clear all; echo off; close all force; clc; format long; %clear another variables
%% Ex9
%Torque de aceleração?
w_motor=1750*2*pi/60; %rad/s
t=1.5; %s
aceleracao=w_motor/t;
rho=7850; %kg/m3
% Momento de inercia 
%Engrenagem A
R_eng_A=100/2000; 
Vol_eng_A=pi*(R_eng_A)^2*(76.2/1000); %m3
massa_eng_A=Vol_eng_A*rho %kg
mk2_eng_A=massa_eng_A*R_eng_A^2/2

%Engrenagem B
R_eng_B=381/2000; 
Vol_eng_B=pi*(R_eng_B)^2*(76.2/1000); %m3
massa_eng_B=Vol_eng_B*rho %kg
mk2_eng_B=massa_eng_B*R_eng_B^2/2

%Eixo
R_eixo=63.5/2000;
Vol_eixo=pi*(R_eixo)^2*(1372/1000); %m3
massa_eixo=Vol_eixo*rho %kg
mk2_eixo=massa_eixo*R_eixo^2/2

%Tambor cilindro oco
R_tambor1=457.2/2000;
r_tambor1=(457.2/2-38.1)/1000;
Vol_tambor1=pi*((R_tambor1)^2-(r_tambor1)^2)*(812.8/1000-2*25.4/1000); %m3
massa_tambor1=Vol_tambor1*rho %kg
mk2_tambor1=massa_tambor1*(R_tambor1^2+r_tambor1^2)/2

%Tambor 2discos juntos
R_tambor2=457.2/2000;
r_tambor2=(457.2/2-38.1)/1000;
Vol_tambor2=pi*((R_tambor2)^2-(r_tambor2)^2)*(2*25.4/1000); %m3
massa_tambor2=Vol_tambor2*rho %kg
mk2_tambor2=massa_tambor2*(R_tambor2^2+r_tambor2^2)/2

%Tambor
massa_tambor=massa_tambor1+massa_tambor2
mk2_tambor=mk2_tambor1+mk2_tambor2

% relação de transmissão da engrenagem
relacao=R_eng_A/R_eng_B

% Rotacao do eixo e tambor
rotacao_eixo_tambor_engB=relacao*w_motor

%Correçao da inercia pela velocidade de rotacao
% MK2=mk2(N/n)
Nn=(rotacao_eixo_tambor_engB/w_motor)^2
mk2_tambor_corrigido=mk2_tambor*Nn
mk2_eng_B_corrigido=mk2_eng_B*Nn
mk2_eixo_corrigido=mk2_eixo*Nn

mk2_total=mk2_tambor_corrigido+mk2_eng_B_corrigido+mk2_eixo_corrigido+mk2_eng_A
torque=mk2_total*aceleracao


%% Caso a embreagem esteja entre a engrenagem B e o tambor
Nn2=(w_motor/rotacao_eixo_tambor_engB)^2 % agora a embreagem está no eixo com menor rotacao
mk2_eng_A_corrigido2=mk2_eng_A*Nn2

mk2_total2=mk2_eng_A_corrigido2+mk2_eng_A+mk2_eng_B+mk2_tambor
torque2=mk2_total2*rotacao_eixo_tambor_engB/t
