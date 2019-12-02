%Written by: Stefano Roque
%Student ID: 15sdr3
%Student #: 20009317

global beam
beam = struct(); % Instantiate the beam structure
global daf_table
global rdf_table
global D_not

D_not = 1;
D_100 = 170;
D_oarmax = 50;
ptv = [30, 0, 15, 15]; %center coordinates first, radius last (all in mm)
oar = [0, 30, 45, 15]; %center coordinates first, radius last (all in mm)
head = [0, 0, 0, 80, 100, 80]; %center coordinates first, elipsoid dimensions last (all in mm)
helmet_rad = 172;
num_beams = 325;

draw_3d_scene(head, ptv, oar)

daf_table = compute_depth_dose(head(1,4), head(1,5), head(1,6))
rdf_table = compute_radial_dose(head(1,4), head(1,5), head(1,6))

compute_beam_directions(ptv, helmet_rad)

compute_skin_entry_points(helmet_rad, ptv, head, num_beams)

compute_beam_safety_flags(oar, ptv, num_beams, head, helmet_rad)

disp("Test for question 10")
radial_dist = compute_radial_distance([45, 0 ,15], 325)

disp("Test for question 11")
depth1 = compute_depth_from_skin([45, 0 ,15], 325)
depth2 = compute_depth_from_skin([30, 0 ,15], 325)

disp("Test for question 12")
point_dose_val = compute_point_dose_from_beam([30, 0 ,15], 325)
%ground truth
dep = compute_depth_from_skin([30, 0 ,15], 325);
ind = round(dep) + 1;
dose = daf_table(ind)

disp("test for question 13")
point_dose_total_val = compute_point_dose_from_all_beams([30, 0 ,15])


voxel_size = 1;
dosimetry_analysis(ptv, oar, voxel_size, D_100, D_oarmax);

compute_surface_dose(ptv, oar)



