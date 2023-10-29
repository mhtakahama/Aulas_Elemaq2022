clear all; echo off; close all force; clc; format long; %clear another variables
%% Ex12
%Inercia equivalente do sistema

%Mk2=m(V/2pi*f)^2
V=0.4; %m/s
P=625; %N
m=P/9.8; %kg
r=254/2000; %m
rps=V/(2*pi*r)
f=1/rps
rpm=rps*60;

mk2=m*(V/(2*pi*f))^2
inercia_carg=mk2*9.8

