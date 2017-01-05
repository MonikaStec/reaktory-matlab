function wsk_jak = uklad_2_reaktorow

time = 180;
time1 = 74; %z zakresu 10-170min
time2 = time - time1;

S = 0.07; %[0, 0.1]

temp =300; %[298,398] K

warunkipoczatkowe = [0.1 0 0];

wsk_jak = 5.5;

time_1 = [0 time1];

opcje=odeset('RelTol',10^-6,'AbsTol',10^-6);

[T, Y]=ode45(@(t, y)model1(t, y, temp),time_1,warunkipoczatkowe,opcje);
A = Y(end,1);
B = Y(end,2);
C = Y(end,3);
figure(1);
plot(T, Y);

time_2 = [0 time2];
warunkipoczatkowe2 = [A B+S*600 C 0 0 0];


[T, Y] = ode45(@(t, y)model2(t, y, temp),time_2,warunkipoczatkowe2,opcje);
D = Y(end,4);

figure(2);
plot(T, Y);
end


function dy=model1(t, y, T) 
k1 = 0.0444*exp(-2500/T);
k2 = 6889*exp(-5000/T);

dy=zeros(3,1);
dy(1) = -2*k1*y(1)^2;
dy(2) = k1*y(1)^2-k2*y(2);
dy(3) = k2*y(2);
end

function dy=model2(t, y, T) 

dy=zeros(6,1);
dy(1) = 0;
dy(2) = -0.02*y(2)-0.05*y(2)-2*4*10^(-5)*y(2)^2;
dy(3) = 0;
dy(4) = 0.02*y(2);
dy(5) = 0.05*y(2);
dy(6) = 4*10^(-5)*y(2)^2;
end