delay=0.10;
tic
i=0; %contador da foto
prescan = zeros([size(getsnapshot(vid)),720]);
for m = 1:360
    %FOTO
    i=i+1;
    prescan(:,:,i)=getsnapshot(vid);
    %passo1 = + - - -
    writeDigitalPin(a,'D2',1)
    writeDigitalPin(a,'D3',0)
    writeDigitalPin(a,'D4',0)
    writeDigitalPin(a,'D5',0)

    %FOTO

    %passo2 = - + - -
    writeDigitalPin(a,'D2',0)
    writeDigitalPin(a,'D3',1)
    writeDigitalPin(a,'D4',0)
    writeDigitalPin(a,'D5',0)
    pause(delay)
    %FOTO
    i=i+1;
    prescan(:,:,i)=getsnapshot(vid);
    %passo3 = - - + -
    writeDigitalPin(a,'D2',0)
    writeDigitalPin(a,'D3',0)
    writeDigitalPin(a,'D4',1)
    writeDigitalPin(a,'D5',0)

    %FOTO

    %passo4 = - - - +
    writeDigitalPin(a,'D2',0)
    writeDigitalPin(a,'D3',0)
    writeDigitalPin(a,'D4',0)
    writeDigitalPin(a,'D5',1)
    pause(delay)
end
toc

%delisgar_porta
writeDigitalPin(a,'D2',0)
writeDigitalPin(a,'D3',0)
writeDigitalPin(a,'D4',0)
writeDigitalPin(a,'D5',0)

fprintf('Salvando imagem... \n');

save prescan prescan -v7.3;
% 
imagine(prescan)