addpath('C:\Users\User\Documents\MATLAB\toolboxes\fieldtrip-20201023')
ft_defaults

head_surface = ft_read_headshape('textured_output.obj')
disp(head_surface)

head_surface = ft_convert_units(head_surface, 'mm');

ft_plot_mesh(head_surface)

cfg = [];
cfg.method = 'headshape';
fiducials = ft_electrodeplacement(cfg, head_surface);

cfg = [];
cfg.method        = 'fiducial';
cfg.coordsys      = 'ctf';
cfg.fiducial.nas  = fiducials.elecpos(1,:); %position of NAS
cfg.fiducial.lpa  = fiducials.elecpos(2,:); %position of LPA
cfg.fiducial.rpa  = fiducials.elecpos(3,:); %position of RPA
head_surface = ft_meshrealign(cfg, head_surface);

ft_plot_axes(head_surface)
ft_plot_mesh(head_surface)

cfg = [];
cfg.method = 'headshape';
elec = ft_electrodeplacement(cfg, head_surface);

ft_plot_mesh(head_surface)
ft_plot_sens(elec)

cfg = [];
cfg.method     = 'moveinward';
cfg.moveinward = 12;
cfg.elec       = elec;
elec = ft_electroderealign(cfg);