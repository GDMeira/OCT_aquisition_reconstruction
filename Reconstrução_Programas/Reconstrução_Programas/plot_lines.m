sizes = size(imgFDK);

line1 = imgFDK(:, sizes(2)/2, sizes(3)/2);
line2 = SIRT_TV(:, sizes(2)/2, sizes(3)/2);

figure, plot(line1,'LineWidth',4), hold on, plot(line2,'LineWidth',6)
legend('FDK', 'SIRT-TV')