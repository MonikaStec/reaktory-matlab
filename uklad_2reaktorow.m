function lab4=uklad_2reaktorow


t = 180;
t1 = 80; %z zakresu 10-170min
t2 = t - t1;

S = 0.07; %[0, 0.1]

temp =348; %[298,398] K

warunkipoczatkowe = [0.1 0 0];

time_1 = [0 t1];

opcje=odeset('RelTol',10^-6,'AbsTol',10^-6);

[T, Y]=ode45(@(t, y)model1(t, y, temp),time_1,warunkipoczatkowe,opcje);
A = Y(end,1);
B = Y(end,2);
C = Y(end,3);
figure(1);
plot(T, Y);

time_2 = [0 t2];
warunkipoczatkowe2 = [A B+S*600 C 0 0 0];


[T, Y] = ode45(@(t, x)model2(t, x, temp),time_2,warunkipoczatkowe2,opcje);
D = Y(end,4);

figure(2);
plot(T, Y);
end

function dx=model1(t, x, T) 
k1 = 0.0444*exp(-2500/T);
k2 = 6889*exp(-5000/T);

dx=zeros(3,1);
dx(1) = -2*k1*x(1)^2;
dx(2) = k1*x(1)^2-k2*x(2);
dx(3) = k2*x(2);
end
function dx=model2(t, x, T) 
dx=zeros(3,1);
dx(2)=(-0.07)*x(2)-(8*10^(-5)*x(2)^2);
end

