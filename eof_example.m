clear; close all; clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% code to compute 15 first modes of EOF from monthly data %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% xi = ncread('input.nc','data');
% lon = ncread('input.nc','longitude');
% lat = ncread('input.nc','latitude');
ncid = netcdf.open('input.nc', 'nc_nowrite');

xi = netcdf.getVar(netcdf.inqNcid(ncid, 'Variables'), netcdf.inqVarID(netcdf.inqNcid(ncid, 'Variables'), 'data'));
lon = netcdf.getVar(netcdf.inqNcid(ncid, 'Variables'), netcdf.inqVarID(netcdf.inqNcid(ncid, 'Variables'), 'longitude'));
lat = netcdf.getVar(netcdf.inqNcid(ncid, 'Variables'), netcdf.inqVarID(netcdf.inqNcid(ncid, 'Variables'), 'latitude'));
time = netcdf.getVar(netcdf.inqNcid(ncid, 'Variables'), netcdf.inqVarID(netcdf.inqNcid(ncid, 'Variables'), 'time'));

netcdf.close(ncid);

xi(xi == -32767) = nan;

[yy, xx] = meshgrid(lat, lon);

time = double(datenum('2000-01-15') + time * 30);

[eof, pc, expvar] = eof(xi, 15);

figure;

subplot(5, 2, [1 3 5 7]);
pcolor(xx, yy, squeeze(eof(:, :, 1)));
shading interp;
colorbar
colormap jet;
caxis([-1 1] * 0.5);

title('1^{st} EOF of data')

subplot(5, 2, 9);
plot(time, pc(1, :));
datetick('x', 'yyyy')

title('1^{st} PC of data')

subplot(5, 2, [2 4 6 8]);
pcolor(xx, yy, squeeze(eof(:, :, 2)));
shading interp;
colorbar
colormap jet;
caxis([-1 1] * 0.5);

title('2^{nd} EOF of data')

subplot(5, 2, 10);
plot(time, pc(2, :));
datetick('x', 'yyyy')

title('2^{nd} PC of data')
size(lon, 1)
floor(rand() * size(lon, 1))

% for i = 1: 252
%     row = floor(rand() * size(lon, 1)) + 1
%     xi(row, :, i) = nan;
% end
%
% figure;
% for idx = 1:252
%     pcolor(xx, yy, squeeze(xi(:, :, idx)));
%     shading interp;
%     colorbar
%     colormap jet;
%     title(idx)
%     pause(0.1)
% end
% caxis([-1 1] * 0.5);
