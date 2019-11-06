%----------------------------------------------------------------------
% Better Weight Estimate
%----------------------------------------------------------------------
% Following equations given in Anderson Chapter 8, Section 8.7, Pg 449
% ALL UNITS IN SI

clear;
clc;

W0_initial = 215730 * 9.81;           % Our first weight estimate
W_Payload = 15000 * 9.81;             % Payload weight (including W_crew)
W_f = 0.5055* W0_initial;             % Fuel weight

%----------------------------------------------------------------------
%Computing total empty weight
%----------------------------------------------------------------------
% Area of wing inside fuselage
C_root = 26.76;
D_max = 3.4;
Delta_angle = 24.2; %(90-Lambda_LE = 90-65.8 deg)
h = 1.7/tan(24.2*pi/180);
S_WinFuse= 0.5*D_max*h + 3.4*(C_root-h);

S_w = 322.28;   % Gross wing planform area
S_exposed_w = S_w - S_WinFuse;    % Exposed wing planform

S_canard = 23.49;           % Canard area
S_exposed_ht = S_canard;    % Aircraft is tailless. Canard is used for stability
S_exposed_vt = 45.69;       % vertical tail

S_wet_tot = 1226.23;        % Total wetted area, From Fusion 360 3D drawing of aircraft 

W_Engines = 3175*4 * 9.81;  %Engine weights

CF=(3.28^2)/(4.448);%convertion factor for pound force to Newton and square foot to square metre

W_w = CF* 2.5 * S_exposed_w;    % Wing weight
W_ht = CF* 2.0 * S_exposed_ht;  % Horizontal tail weight
W_vt = CF* 2.0 * S_exposed_vt;  % Vertical tail weiht
W_Fuse = CF* 1.4 * S_wet_tot;   % Fueselage weight
W_Eng = 1.4* W_Engines;         % Installed engine weight

W0 = W0_initial; 
W_LG = CF* 0.057 * W0;          %Landing gear weight
W_em = CF* 0.1 * W0;            % All else empty wieght

%Consider
W_e_part = W_w+ W_ht+ W_vt+ W_Fuse+ W_Eng;
W0_part = W_Payload + W_f;

W_ei = W_e_part+ W_LG+ W_em; %Total empty weight first estimate
%----------------------------------------------------------------------
% Iterative proceduce to converge to better gross weight estimate
%----------------------------------------------------------------------
W0_new = W0_part + W_ei;

error = W0 - W0_new;
%
while(abs(error)> 0.1) % Tollerance in Convergence criteria
    W0 = W0_new;
    W_LG = CF* 0.057 * W0;          %Landing gear weight
    W_em = CF* 0.1 * W0;            % All else empty wieght

    W_e = W_e_part+ W_LG+ W_em;     %Total empty weight
    W0_new = W0_part + W_e;
    error = W0 - W0_new;
end

W0_final = W0_new / (9.81*10^3) % Better Gross Weight estimate in tonnes
                                % 1 ton = 1000 kg
Wf_W0 = W_f/W0_new   % Fuel weight fraction
We_W0 = W_e/W0_new   % Empty weight fraction