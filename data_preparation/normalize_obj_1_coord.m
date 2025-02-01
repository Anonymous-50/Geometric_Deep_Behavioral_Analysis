function normalize_obj_1_coord(Project_Path)

% This function will normalize obj_1 coords based on the open-field
% coordinates

% Load the project_info structure
load([Project_Path,filesep,'Project_info']);

% Find Index of Videos with frames non_extracted
Idx2use = [];
Idx2use = find(Project.Project_List.is_frame == 1 & Project.Project_List.is_OF_coord == 1 ...
            & Project.Project_List.is_old_obj_coord == 1 & Project.Project_List.is_new_obj_coord == 1 ...
            & Project.Project_List.is_norm == 1 & Project.Project_List.is_norm_old_obj_coord ==0);
Idx2use = Idx2use';

%Loop normalization
for v = Idx2use

    % Set the start of the timer
    t_start = []; t_stop = [];
    t_start = tic;
    
    load([Project.Path.old_obj_Coordinates, filesep, Project.Project_List.Video_List{v}]);
    old_obj_coords = old_obj_coordinates.Coord; 

    % Load the coordinates from arena_coordinates
    load([Project.Path.Arena_Coordinates, filesep, Project.Project_List.Video_List{v}]);

    % Normalize the data for each frames

    % Initialize the progress bar
    fprintf([Project.Project_List.Video_List{v},' Normalization progress:   0%%']);
     
    x = [];
    y = [];

    for i = 1:size(old_obj_coords,2)
        x = [x, old_obj_coords(1,i)];
        y = [y, old_obj_coords(2,i)];           
    end

    BodyP_coord = [x; y];

    % First we realign the coordinate from the camera referential to
    % the Open Field Referential
    Realign_coord = []; New_origin = [];
    New_origin = BodyP_coord + Arena_Coordinates.Norm_var.OA_OC;
    Realign_coord = Arena_Coordinates.Norm_var.RM*New_origin;

    old_norm_coord = [];

    % Normalize data taking X & Y length in account
    old_norm_coord(1,:) = Realign_coord(1,:)./Arena_Coordinates.Norm_var.norm_unit_X;
    old_norm_coord(2,:) = Realign_coord(2,:)./Arena_Coordinates.Norm_var.norm_unit_Y;
            

    % Calculate the current progress percentage
    progress = [];
    progress = (size(old_obj_coords,2)) / (size(old_obj_coords,2)) * 100;

    % Update the progress bar in the command window
    fprintf('\b\b\b\b%3d%%', round(progress));


    % Update project
    Project.Project_List.is_norm_old_obj_coord(v) = 1;

    %Save the normalized new object coordinates
    save([Project.Path.norm_old_obj_Coords,filesep,Project.Project_List.Video_List{v}], 'old_norm_coord', '-v7.3');

    t_stop = toc(t_start);
    disp([' done in ', num2str(t_stop/60), ' min']);

    fprintf('\n'); % Print a newline to move to the next line after the loop
end

fclose('all');

% Save updated project
save([Project_Path,filesep,'Project_info'], 'Project', '-v7.3');