tic
dark = im2double(dark);
% prescan= im2double(prescan);


deg = 2; %phase adjust for scan in degrees

if (deg < 0)
    deg = 360 + deg;
end

aux = zeros(size(scan));
start = round(deg/360 * 720) + 1;
aux(:,:, 1:720-start+1) = scan(:,:, start:720);

if (start > 1)
    aux(:,:, 720-start+2:720) = scan(:,:, 1:start-1);
end

proj = zeros(size(aux));

for j=1:size(scan,3)
    proj(:,:,j) = log(double(prescan(:,:,j)) - dark) - log(double(aux(:,:,j)) - dark); %#ok<SAGROW>
end

proj(proj<0)=0;
% proj = proj - min(min(min(proj)));
proj(isinf(proj))=0;
proj(isnan(proj))=0;
proj(imag(proj) ~= 0) = 0;
proj = single(proj);
toc

imagine(proj);

% fprintf('Salvando imagem... \n');
% save proj_g proj -v7.3