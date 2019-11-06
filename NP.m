clear;
x = -40;
x_cg = 378.77 ;
x_act = 1012.5 ;
x_acw = 327.5 ;
cl_a = 6.022;
c = 297;
a = -15:0.1:15;
I = ones(1,length(a));
ymarker = 0;
cl_t = 3.883;
e = 0.44;
cl_o = 0.945;
cl_de = cl_t * 0.75;
cd_o = 1.05*10^-2;
k = 0.0515;

for de = -3:1:3
%de =input('de');
de = de*pi/180;
x1_cg = x_cg - (x * 0.252); % Change in CG location of aircraft due to change in wing's location
x_np = ((x1_cg - x_act)/(x_cg - x_act)) * 47.34 + (x_acw - x); % Neutral point of Wing
sm = (x_np - x1_cg)/c; % Static Margin
cm_a = -1*cl_a*(x_np - x1_cg)/c; % Cm_alpha 
cm_o = (-0.242 )+( 0.945*(x1_cg - (x_acw - x))/c) + (0.139 * (x1_cg - x_act)/(x_cg - x_act) );
cm_de = -1.26 * ((x1_cg - x_act)/(x_cg - x_act)) ;
%disp(de);
%k = cm_de * de
cm_f = cm_o + cm_de * de ;
disp(cm_f);
f = cm_f * I + cm_a * a * pi/180;
xmarker = -1*cm_f / cm_a;
disp(f(101));
cl = cl_o * I + cl_de * de *  I + (cl_a + cl_t * (1-e))* a * pi/180;
xmarker = cl_o  + cl_de * de + (cl_a + cl_t * (1-e))* xmarker;
plot(cl,f,'b',xmarker,ymarker,'b*');
hold on;
grid on;
title('C_{m_{cg}} vs Cl for different values of de');
xlabel('Cl');
ylabel('C_{m_{cg}}');
end

figure;

for de = -3:1:3
de = de*pi/180;
cl = cl_o * I + cl_de * de * I+ (cl_a + cl_t * (1-e))* a * pi/180;
cd = cd_o * I + k * cl.*cl;
cm_f = cm_o + cm_de * de ;
xmarker = -1*cm_f / cm_a;
xmarker = cl_o  + cl_de * de + (cl_a + cl_t * (1-e))* xmarker;
ymarker = cd_o + k * xmarker*xmarker;
plot(cl,cd,'b',xmarker,ymarker,'b*');
hold on;
grid on;
title('Cd vs Cl for different values of de');
xlabel('Cl');
ylabel('Cd');
end



