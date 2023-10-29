clear all; echo off; close all force; clc; format long; %clear another variables
%% Ex2
%dados
z=3;
T=500;
w=1000*(2*pi/60);
re=95/1000;
ri=50/1000;
mi=0.3;
alpha=70*(2*pi/360);


Pmax=3*T/(z*mi*alpha*(re^3-ri^3))  
Potencia=T*w