clear all; close all; clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% code to compute 15 first modes of EOF from monthly data %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ncid = netcdf.open('input.nc', 'nc_nowrite');

xi = netcdf.getVar(netcdf.inqNcid(ncid, 'Variables'), netcdf.inqVarID(netcdf.inqNcid(ncid, 'Variables'), 'data'));
lon = netcdf.getVar(netcdf.inqNcid(ncid, 'Variables'), netcdf.inqVarID(netcdf.inqNcid(ncid, 'Variables'), 'longitude'));
lat = netcdf.getVar(netcdf.inqNcid(ncid, 'Variables'), netcdf.inqVarID(netcdf.inqNcid(ncid, 'Variables'), 'latitude'));
time = netcdf.getVar(netcdf.inqNcid(ncid, 'Variables'), netcdf.inqVarID(netcdf.inqNcid(ncid, 'Variables'), 'time'));

netcdf.close(ncid);

xi(xi == -32767) = nan;

[yy, xx] = meshgrid(lat, lon);

time = double(datenum('2000-01-15') + time * 30);

[camp, cpha, tamp, tpha, expvar] = ceof(xi, 15);

figure;
subplot(5, 2, [1 3 5 7]);
pcolor(xx, yy, squeeze(camp(:, :, 1)));
shading interp;
colormap jet;
caxis([-1 1] * 0.5);
colorbar
title('1^{st} amplitude of CEOF from data')

subplot(5, 2, [2 4 6 8]);
pcolor(xx, yy, squeeze(cpha(:, :, 1)));
shading interp;
colormap jet;
caxis([-1 1] * pi);
colorbar
title('1^{st} phase of CEOF from data')

subplot(5, 2, 9);
plot(time, tamp(1, :));
datetick('x', 'yyyy')
title('1^{st} amplitude of complex PC from data')

subplot(5, 2, 10);
plot(time, tpha(1, :));
datetick('x', 'yyyy')
title('1^{st} phase of complex PC from data')
