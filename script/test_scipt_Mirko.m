addpath 'C:\Users\mirko\AppData\Roaming\MathWorks\MATLAB Add-Ons\Collections\FieldTrip'
ft_defaults

addpath('C:\Users\mirko\OneDrive\Dokumente\GitHub\3D-electrode-positioning-iPad\data\fieldtrip_example.obj')
head_surface = ft_read_headshape('Model.obj')
disp(head_surface)

head_surface = ft_convert_units(head_surface, 'mm');