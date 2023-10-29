clear all; echo off; close all force; clc; format long; %clear another variables
%% Ex3
%dados
%Torque?
%Potencia?
re=180/2000;
ri=80/2000;
alpha=60*(2*pi/360);
w=1800*(2*pi/60);
K=2;
z=2;
% composto moldado a seco
% mi=0.25-0.35
mi=0.25;
% pmax= 1030-2070
pmax=1030*10^6;
Torque=z*mi*pmax*alpha*(re^3-ri^3)/3
Potencia=Torque*w/K