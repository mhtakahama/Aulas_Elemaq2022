clear all; echo off; close all force; clc; format long; %clear another variables
%% Ex4
%dados
%Torque?
%Potencia?
ri=160/2000;
re=220/2000;
alpha=80*(2*pi/360);
w=18*(2*pi/60);
K=1.8;
z=1;
% Fofo a seco
% mi=0.15-0.25
mi=0.15;
% pmax= 690-720
pmax=690*10^3;

%criterio desgaste uniforme
Torque=z*mi*pmax*alpha*ri*(re^2-ri^2)/2
Potencia=Torque*w/K