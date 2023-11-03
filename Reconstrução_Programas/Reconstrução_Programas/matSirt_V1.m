% % load('imgFDK2.mat')% ou imgFDK
% imgPreProcess = imgFDK;
% tic
% theta = double((linspace(0, 2*pi, 720).*360)/6.28);
% so =1 ; %initial slice
% sf = size(imgPreProcess); % final slice
% sl=0;
% for im = so : sf
%     sl=sl+1; %contador
%     F =medfilt2(imgPreProcess(:,:,im));  % Load the reconstructed FDK image
%     S1 = sum(sum(F)); %calculate pixels sum on F
%     R = radon(F,theta); %apply Radon 
%     At = iradon(R,theta,'linear', 'none', 1,length(F)); %reconstruct noisy alien.
%     S2 = sum(sum(At)); %calculate pixels sum on At
%     At = (At/S2)*S1; %normalize At so that pixel counts match.
%     n = 25; %iterations. 
%     Fk = gpuArray(At);%Matrix Fk is our solution at the k-th step, now it is our initial guess
%     % Fku=gpuArray(Fk);
%     % Fk=Fku;
%     for  k=1:n
%         t = iradon(radon(Fk,theta),theta, 'linear', 'none', 1, length(F));% reconstruct alien using Fk unfiltered sinogram. Maybe use FBP if you want here
%         %normalize. Again, as per your needs
%         St = sum(sum(t));
%         t = (t/St)*S1;
%         %update using (At g - At A f_k) 
%         %new Fk = Fk + difference between reconstructed aliens At_starting - t_previuous_step
%         Fk = Fk + At - t;
% 	    %remember that our alien is normalized between 0 and 1. Might not be your case!
%         %delete values <0 aka not real! Might not be your case!
%         index = Fk<0;
%         Fk(index)=0;
%         %delete values >1  Might not be your case!
%         index = find(Fk>1);
%         Fk(index)=1;
%         %show reconstruction progress every 10 steps
%         % if(mod(k,10)== 0)
%         %  figure,imshow(Fk,[]),title('Fk');
%         %  end
%         %calculate step improvement between steps. Tune as per your needs
%     %     Arrerr(k) = sum(sum((F - Fk).^2));
%     %     %stop when there is no more improvement. Tune as per your needs
%     %     if((k>2) &&(Arrerr(k)>Arrerr(k-1)))
%     %        break;
%     %     end
%     end
%     %imgSIRT(:,:,sl)=gather(Fk); %#ok<SAGROW>
%     PASSOS_V1
%     %DATA
% end
% reset(gpuDevice);
% toc

% %% teste
% 
% % load('imgFDK2.mat')% ou imgFDK
% imgPreProcess = gpuArray(imgFDK);
% SIRT_TV = gpuArray(zeros(size(imgPreProcess)));
% tic
% theta = double((linspace(0, 2*pi, 720).*360)/6.28);
% so =1 ; %initial slice
% sf = size(imgPreProcess); % final slice
% sl=0;
% for im = so : sf
%     sl=sl+1; %contador
%     F =medfilt2(imgPreProcess(:,:,im));  % Load the reconstructed FDK image
%     S1 = sum(sum(F)); %calculate pixels sum on F
%     R = radon(F,theta); %apply Radon 
%     At = iradon(R,theta,'linear', 'none', 1,length(F)); %reconstruct noisy alien.
%     S2 = sum(sum(At)); %calculate pixels sum on At
%     At = (At/S2)*S1; %normalize At so that pixel counts match.
%     n = 25; %iterations. 
%     Fk = At;%Matrix Fk is our solution at the k-th step, now it is our initial guess
%     % Fku=gpuArray(Fk);
%     % Fk=Fku;
%     for  k=1:n
%         t = iradon(radon(Fk,theta),theta, 'linear', 'none', 1, length(F));% reconstruct alien using Fk unfiltered sinogram. Maybe use FBP if you want here
%         %normalize. Again, as per your needs
%         St = sum(sum(t));
%         t = (t/St)*S1;
%         %update using (At g - At A f_k) 
%         %new Fk = Fk + difference between reconstructed aliens At_starting - t_previuous_step
%         Fk = Fk + At - t;
% 	    %remember that our alien is normalized between 0 and 1. Might not be your case!
%         %delete values <0 aka not real! Might not be your case!
%         Fk(Fk<0)=0;
%         %delete values >1  Might not be your case!
%         Fk(Fk>1)=1;
%         %show reconstruction progress every 10 steps
%         % if(mod(k,10)== 0)
%         %  figure,imshow(Fk,[]),title('Fk');
%         %  end
%         %calculate step improvement between steps. Tune as per your needs
%     %     Arrerr(k) = sum(sum((F - Fk).^2));
%     %     %stop when there is no more improvement. Tune as per your needs
%     %     if((k>2) &&(Arrerr(k)>Arrerr(k-1)))
%     %        break;
%     %     end
%     end
%     %imgSIRT(:,:,sl)=gather(Fk); %#ok<SAGROW>
%     PASSOS_V1
%     %DATA
% end
% SIRT_TV = gather(SIRT_TV);
% reset(gpuDevice);
% toc

%% teste 2

% load('imgFDK2.mat')% ou imgFDK
imgPreProcess = gpuArray(imgFDK);
SIRT_TV = gpuArray(zeros(size(imgPreProcess)));
tic
theta = double((linspace(0, 2*pi, 720).*360)/(2*pi));
so =1 ; %initial slice
sf = size(imgPreProcess, 3); % final slice
for im = so : sf
    im %contador
    F =medfilt2(imgPreProcess(:,:,im));  % Load the reconstructed FDK image
    % F = imgPreProcess(:,:,im);  % Load the reconstructed FDK image
    S1 = sum(sum(F)); %calculate pixels sum on F
    R = radon(F,theta); %apply Radon 
    At = iradon(R,theta,'linear', 'none', 1,length(F)); %reconstruct noisy alien.
    S2 = sum(sum(At)); %calculate pixels sum on At
    At = (At/S2)*S1; %normalize At so that pixel counts match.
    n = 25; %iterations. 
    Fk = At;%Matrix Fk is our solution at the k-th step, now it is our initial guess
    % Fku=gpuArray(Fk);
    % Fk=Fku;
    for  k=1:n
        y = radon(Fk,theta);
        t = iradon(y,theta, 'linear', 'none', 1, length(F));% reconstruct alien using Fk unfiltered sinogram. Maybe use FBP if you want here
        %normalize. Again, as per your needs
        St = sum(sum(t));
        t = (t/St)*S1;
        %update using (At g - At A f_k) 
        %new Fk = Fk + difference between reconstructed aliens At_starting - t_previuous_step
        Fk = Fk + At - t;
	    %remember that our alien is normalized between 0 and 1. Might not be your case!
        %delete values <0 aka not real! Might not be your case!
        Fk(Fk<0)=0;
        %delete values >1  Might not be your case!
        Fk(Fk>1)=1;
        %show reconstruction progress every 10 steps
        % if(mod(k,10)== 0)
        %  figure,imshow(Fk,[]),title('Fk');
        %  end
        %calculate step improvement between steps. Tune as per your needs
    %     Arrerr(k) = sum(sum((F - Fk).^2));
    %     %stop when there is no more improvement. Tune as per your needs
    %     if((k>2) &&(Arrerr(k)>Arrerr(k-1)))
    %        break;
    %     end

        if k == n
            lambda = 0.02;
            K = @(x)grad(x);
            KS = @(x)-div(x);

            Amplitude = @(u)sqrt(sum(u.^2,3));
            F = @(u)lambda*sum(sum(Amplitude(u)));
            G = @(x)1/2*norm(y-x,'fro')^2;

            Normalize = @(u)u./repmat( max(Amplitude(u),1e-10), [1 1 2] );
            ProxF = @(u,tau)repmat( perform_soft_thresholding(Amplitude(u),lambda*tau), [1 1 2]).*Normalize(u);
            ProxFS = compute_dual_prox(ProxF);

            ProxG = @(x,tau)(x+tau*y)/(1+tau);

            options.report = @(x)G(x) + F(K(x));

            options.niter = 300;
            [xAdmm,EAdmm] = perform_admm(y, K,  KS, ProxFS, ProxG, options);
             s = size(imgPreProcess);
             P=iradon(xAdmm,theta,'nearest','Hann',1,s(1));
             % P = gather(P);
             P(P<0)=0;
             SIRT_TV(:,:,im)= P;
        end
    end
    %imgSIRT(:,:,sl)=gather(Fk); %#ok<SAGROW>
    %DATA
end
SIRT_TV = gather(SIRT_TV);
reset(gpuDevice);
toc

  fprintf('Salvando imagem... \n');
  
  save SIRT_TV SIRT_TV -v7.3