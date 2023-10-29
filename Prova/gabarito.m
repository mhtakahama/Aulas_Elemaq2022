clear all; echo off; close all force; clc; format long; %clear another variables
%% Prova freios Takahama
%Um pequeno moinho de bolas adaptado para torra de amendoim, 
% conforme apresentado abaixo, é movido por meio de um sistema 
% de transmissão por correias planas. O controle de movimento deste 
% sistema é realizado pelo conjunto motor\embreagem durante a transmissão 
% de movimento para partida e movimento constante e a parada por um freio 
% lento para rápida limpeza e troca de produto:
%% Desenho 
%dados 
w_motor=1760*2*pi/60; %rad/s
Potencia_motor=7500; %Watts
Rendimento=0.91; 
Potencia_util_motor=Potencia_motor*Rendimento;

w_eixo2=550*2*pi/60; %rad/s
rho_aco=7850; %kg/m3
rho_aluminio=2710; %kg/m3

Inercia_embreagem=0.091; %Kg.m²
I_restante=15; %N.m
%% 1A - Torque

fprintf('1.A- Resposta')
Torque=Potencia_util_motor/w_motor %N.m

%% 1B - Propriedades da inercia da polia 2
% 3 cilindros vazados

%interno (cilindro oco)
R_interno=152/2000; 
r_interno=76/2000; 
L_interno=100/1000;
Vol_interno=pi*((R_interno)^2-(r_interno)^2)*(L_interno); %m3
massa_interno=Vol_interno*rho_aluminio; %kg
mk2_interno=massa_interno*(R_interno^2+r_interno^2)/2

%nervura (cilindro oco)
R_nervura=460/2000; 
r_nervura=152/2000; 
L_nervura=19/1000;
Vol_nervura=pi*((R_nervura)^2-(r_nervura)^2)*(L_nervura); %m3
massa_nervura=Vol_nervura*rho_aluminio; %kg
mk2_nervura=massa_nervura*(R_nervura^2+r_nervura^2)/2

%externo (cilindro oco)
R_externo=520/2000; 
r_externo=460/2000; 
L_externo=140/1000;
Vol_externo=pi*((R_externo)^2-(r_externo)^2)*(L_externo); %m3
massa_externo=Vol_externo*rho_aluminio; %kg
mk2_externo=massa_externo*(R_externo^2+r_externo^2)/2


massa_polia2=massa_interno+massa_nervura+massa_externo;
fprintf('1.B- Resposta')
mk2_polia2=mk2_interno+mk2_nervura+mk2_externo
%% 1C - Demais peças
%propriedades da inercia da polia 1 (cilindro oco)
R_polia1=162.5/2000; 
r_polia1=30/2000; 
L_polia1=110/1000;
Vol_polia1=pi*((R_polia1)^2-(r_polia1)^2)*(L_polia1); %m3
Vol_polia1=pi*((R_polia1)^2-(0)^2)*(L_polia1); %m3
massa_polia1=Vol_polia1*rho_aluminio %kg
fprintf('1.C- Resposta')
mk2_polia1=massa_polia1*(R_polia1^2+r_polia1^2)/2

%Eixo1 (cilindro maciço)
R_Eixo1=31.2/2000; 
L_Eixo1=200/1000;
Vol_Eixo1=pi*(R_Eixo1)^2*(L_Eixo1); %m3
massa_Eixo1=Vol_Eixo1*rho_aco %kg
fprintf('1.C- Resposta')
mk2_Eixo1=massa_Eixo1*R_Eixo1^2/2

%Eixo2 (cilindro maciço)
R_Eixo2=76/2000; 
L_Eixo2=200/1000;
Vol_Eixo2=pi*(R_Eixo2)^2*(L_Eixo2); %m3
massa_Eixo2=Vol_Eixo2*rho_aco %kg
fprintf('1.C- Resposta')
mk2_Eixo2=massa_Eixo2*R_Eixo2^2/2

mk2_vdiferente=mk2_Eixo2+mk2_polia2+I_restante;
%% 1D - Calculo da inercia do sistema

%Correçao da inercia pela velocidade de rotacao
% MK2=mk2(N/n)
Nn=(w_eixo2/w_motor)^2;
mk2_vdiferente_corrigido=mk2_vdiferente*Nn
mk2_polia2_corrigido=mk2_polia2*Nn

fprintf('1.D- Resposta')
Inercia_sistema=Inercia_embreagem+mk2_Eixo1+mk2_polia1+mk2_vdiferente_corrigido
% wk2_sistema=Inercia_sistema*9.81

%% 1E - Tempo para atingir a rotação

%Torque=I*alpha -|> Torque=I*w/t-|> t=I*w/Torque
fprintf('1.E- Resposta')
tempo=Inercia_sistema*w_motor/Torque
% tempo2=5.48*w_motor/Torque

%% 2- Dimensionamento da pastilha Modelo desgaste uniforme
z=1;
mi=0.25;
alpha=2*pi;
pmax=1030*10^3;
p_atuante=400*10^3;
K=10;
% 
% syms RI
% eqn = Torque==z*mi*pmax*alpha*RI*(2*RI^2/2) %considerando ri=sqrt(1/3)*re ->re^2=3*ri^3
% raio_interno = solve(eqn)

fprintf('2.C - Resposta')
ri=(Torque*K/(z*mi*pmax*alpha))^(1/3)
re=ri/sqrt(1/3)

fprintf('2.D - Resposta')
ri2=(Torque*K/(z*mi*p_atuante*alpha))^(1/3)
re2=ri2/sqrt(1/3)

%% 3- Dimensionamento Freio sapata longa

%reacoes de apoio
ax=180/1000;
bx=30/1000;
by=40/1000;
b=sqrt(bx^2+by^2);
r=100/1000;
w=30/1000;
% b=90;
% r=100;
% w=30;
theta1=50*2*pi/360;
theta2=140*2*pi/360;
theta_max=90*2*pi/360; %onde ocorre a pressão máxima
mi=0.35;
pmax=1.5e6;

%Força de frenagem
Mn=b*w*r*pmax/sin(theta_max)*[1/2*(theta2-theta1)-1/4*(sin(2*theta2)-sin(2*theta1))]
Mf=mi*w*r*pmax/sin(theta_max)*[-r*(cos(theta2)-cos(theta1))-b/2*((sin(theta2))^2-(sin(theta1))^2)]
M=Mn-Mf; %autodesenergizante
fprintf('3.A - Resposta')
Fa=M/ax


%Torque Máximo de de atrito
fprintf('3.B - Resposta')
Torque_frenagem=mi*w*r^2*pmax/sin(theta_max)*[cos(theta1)-cos(theta2)]

%tempo de frenagem
%Torque=Im*w/t
%tempo=Im*w/Torque
fprintf('3.B - Resposta')
tempo_frenagem=Inercia_sistema*w_motor/Torque_frenagem


%autoenergizante
%bx-c*mi=0 ---|> bx=c*mi 
%c=r-by
%bx=(r-by)*mi 
%30=(100-by)*0.35 

fprintf('3.C - Resposta')
by_autotravante=(30/0.35-100)*-1
