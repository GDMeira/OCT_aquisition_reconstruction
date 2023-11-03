
%ZWO_CAMERA
vid = videoinput('winvideo', 2, 'RGB8_800x800');
src = getselectedsource(vid);
src.ExposureMode = 'manual';
src.GainMode = 'manual';
src.Gain=0;
preview(vid)
pause(2)
img = getsnapshot(vid);
img(:, 250) = 0;
imshow(img)
a=arduino();%seleciona arduino
