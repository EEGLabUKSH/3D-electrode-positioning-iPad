%% Lokalisierung von Elektroden mit einem 3D-Scanner

%% Grundlagen
close all
clear all
clc

restoredefaultpath
addpath 'C:\Users\mirko\AppData\Roaming\MathWorks\MATLAB Add-Ons\Collections\FieldTrip'
addpath 'C:\Users\mirko\AppData\Roaming\MathWorks\MATLAB Add-Ons\Collections\FieldTrip\external\stats'
addpath 'C:\Users\mirko\AppData\Roaming\MathWorks\MATLAB Add-Ons\Collections\FieldTrip\external\wavefront'
ft_defaults


%% Einlesen der Daten

cd 'C:\Users\mirko\OneDrive\Desktop\HiWi-Projekte\Lokalisierung von Elektroden mit einem 3D-Scanner\Scans\Beilspielmessung_Fieldtrip_Tutorium\3D-Scan\Model'
head_surface = ft_read_headshape('Model.obj') % ('Model/Model.obj') nur bei Beispielmessung von Fieldtrip
disp(head_surface)
% ft_read_headshape liest die Fiducials und/oder die gemessene Kopfform aus einer Vielzahl von
% von Dateien (wie CTF und Polhemus).

head_surface = ft_convert_units(head_surface, 'mm'); % ändert die geometrische Dimension in die angegebene SI-Einheit.

ft_plot_mesh(head_surface)

%% Netz in CTF-Koordinaten umwandeln.

cfg = [];
cfg.method = 'headshape';
fiducials = ft_electrodeplacement(cfg, head_surface); % ermöglicht die manuelle Platzierung von Elektroden auf einem MRI-Scan, CT-Scan
                                                      % oder auf einer triangulierten Oberfläche des Kopfes.

%% 
 
cfg = [];
cfg.method        = 'fiducial';
cfg.coordsys      = 'ctf';
cfg.fiducial.nas  = fiducials.elecpos(1,:); %position of NAS
cfg.fiducial.lpa  = fiducials.elecpos(2,:); %position of LPA
cfg.fiducial.rpa  = fiducials.elecpos(3,:); %position of RPA
head_surface = ft_meshrealign(cfg, head_surface); % rotiert, verschiebt und skaliert optional eine Oberflächenbeschreibung von des Kopfes oder des Kortex.                                                     

%% 

ft_plot_axes(head_surface)
ft_plot_mesh(head_surface)

%% Elektrodenstandorte identifizieren

cfg = [];
cfg.method = 'headshape';
% cfg.channal = 
elec = ft_electrodeplacement(cfg, head_surface);

elec.label(61:65) = { ...
    'GND'
    'REF'
    'NAS'
    'LPA'
    'RPA'
};

ft_plot_mesh(head_surface)
ft_plot_sens(elec)

%% 

cfg = [];
cfg.method     = 'moveinward';
cfg.moveinward = 12;
cfg.elec       = elec;
elec = ft_electroderealign(cfg);


%%

