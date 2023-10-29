clear all; echo off; close all force; clc; format long; %clear another variables
%% Ex1
%dados
P=10*1e3;
rpm=1500;
K=2;
alpha=2*pi;

%material
% mi=0.35;
mi=0.25;
% Pmax=517.5*1e3;
Pmax=345*1e3;

Torque=P*K/(rpm*2*pi/60)

ri3=Torque/(mi*Pmax*alpha)
ri=ri3^(1/3)
re=ri/sqrt(1/3)

%Força Normal para p=cte
Fn=Pmax*ri*alpha*(re-ri)
Fn1=Torque/(mi*(re+ri))