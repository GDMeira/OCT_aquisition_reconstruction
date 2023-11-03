tic
imgFDK=FDK(proj,geo,angles,'filter','hann');
imgFDK( imgFDK<0)=0;
toc
imagine(imgFDK)

reset(gpuDevice);