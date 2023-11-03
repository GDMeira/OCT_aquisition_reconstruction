%% corte proj
% n = 250;
% proj = proj(n:800-n-1, n:800-n-1, :);


%% Define Geometry
% 
sizeProj = size(proj);
% VARIABLE                                                      DESCRIPTION                    UNITS
%--------------------------------------------------------------------------------------------------------
geo.DSD = 900;                                                   % Distance Source Detector      (mm)
geo.DSO = 500;                                                   % Distance Source Origin         (mm)
% Detector parameters
geo.nDetector=[sizeProj(1); sizeProj(2)];				                    	% number of pixels              (px)
geo.dDetector=[0.3; 0.3]; 				                     	% size of each pixel              (mm)
geo.sDetector=geo.nDetector.*geo.dDetector;        % total size of the detector    (mm)
% Image parameters
voxelNumbers = 512;
geo.nVoxel=[voxelNumbers;voxelNumbers;voxelNumbers];                                    % number of voxels                 (vx)
geo.sVoxel=[128;128;128];                                     % total size of the image          (mm)
geo.dVoxel=geo.sVoxel./geo.nVoxel;                     % size of each voxel                (mm)
% Offsets
geo.offOrigin =[0;0;0];                                           % Offset of image from origin   (mm)              
geo.offDetector=[0; 0];                                          % Offset of Detector                 (mm)
% Auxiliary 
geo.accuracy=0.5;                                                 % Accuracy of FWD proj          (vx/sample)

%% Load data and generate projections 
% see previous demo for explanation
angles=linspace(0, -2*pi, sizeProj(3));


Reconstruir_FDK