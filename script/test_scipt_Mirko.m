%addpath 'C:\Users\mirko\AppData\Roaming\MathWorks\MATLAB Add-Ons\Collections\FieldTrip'
ft_defaults

cd('C:\Users\mirko\OneDrive\Desktop\')%Scaniverse_2022_05_17_171358.obj'
head_surface = ft_read_headshape('Scaniverse_2022_05_17_171358.obj')
disp(head_surface)

head_surface = ft_convert_units(head_surface, 'mm');

ft_plot_mesh(head_surface)

