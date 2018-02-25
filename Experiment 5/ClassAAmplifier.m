clear
clc
syms C1 C2

%The Parameters given by User
Rl      = 2200;             % Load Resistor 2.2k Ohm
Rsig    = 470;              % Signal Resistor 470 Ohm
Gain    = -5;               % Vout/Vin;
Fl      = 500;              % Low Frequency Responce
Fh      = 50000;            % High Frequency Responce;

%The Parameters of BJT
hfe     = 200;              % Current gain of BC238
Vt      = 26*10^-3;         % Termal Voltage
Vbe     = 0.7;              % Vbe Voltage;
Cib     = 8*10^-12;         % Cpi Value
Co      = 3.5*10^-12;       

%The Parameters defined by designer
Ic = 2.5*10^-3;                 % Collector Current
Rc = Rl;
Vcc = 12;                   % Power Source Voltage

%Final Circuit Parameters Calculation
gm = Ic/Vt;                 
re = (hfe/(hfe+1))*(Vt/Ic);                                             % Small Signal Emitter Resistor;
Re = ((hfe*pres(Rl,Rc))+(-5*Rsig)+(-5*re)+(-5*hfe*re))/(5*hfe+5);       % Emitter Resistor;
Ib = Ic/hfe;                                                            % Base Current;
Ie = ((hfe)/(hfe+1))*Ic;                                                % Emitter Current; 
Ve = Ie*Re;                                                             % Emitter Voltage;
Vb = 0.7 + Ve;                                                          % Base Voltage;
R1 = (12-Vb)/(10*Ib);                                                   % R1 Resistor;
R2 = (Vb)/(9*Ib);                                                       % R2 Resistor;
Rinb = Re;                                                              % Impedance from Base;
RC1 = Rsig + pres3(R1,R2,Rinb);                                         % Resistance of C1;
RC2 = Rc + Rl;                                                          % Resistance of C2;
%We assume C1 = C2
C1 = 1/((RC1+RC2)*2*pi()*Fl);
C2 = C1;
Ri = pres3(R1,R2,Re)
pres(Ri,Rsig)
disp('%Design Parameters%');
fprintf('Emittor Resistor   : %d \n',Re);
fprintf('Collector Resistor : %d \n',Rc);
fprintf('R1 Resistor        : %d \n',R1);
fprintf('R2 Resistor        : %d \n',R2);
fprintf('C1 Capacitor       : %d \n',C1);
fprintf('C2 Capacitor       : %d \n',C2);
fprintf('Load Resistor      : %d \n',Rl);
fprintf('Signal Resistor    : %d \n',Rsig);
%End