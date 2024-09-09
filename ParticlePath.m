% Parameters
numParticles = 50;       % Number of particles
numFrames = 200;         % Number of frames in the animation
channelLength = 20;      % Length of the microfluidic channel
channelWidth = 10;       % Width of the microfluidic channel
channelHeight = 5;       % Height of the microfluidic channel
electrodeWidth = 2;      % Width of the electrodes
electrodeSpacing = 5;    % Spacing between electrodes
electrodeHeight = 0.5;   % Height of electrodes
particleSpeed = 0.1;     % Speed of particle movement

% Initialize particle positions
positions = rand(numParticles, 3) .* [channelLength, channelWidth, channelHeight];

% Create figure for animation
figure;
hold on;
axis equal;
view(3);  % Set 3D view

% Plot the microfluidic channel and electrodes
% Channel boundaries
plot3([0 0], [0 channelWidth], [0 0], 'k', 'LineWidth', 2); % Left
plot3([0 channelLength], [0 0], [0 0], 'k', 'LineWidth', 2); % Bottom
plot3([0 channelLength], [channelWidth channelWidth], [0 0], 'k', 'LineWidth', 2); % Top
plot3([channelLength channelLength], [0 channelWidth], [0 0], 'k', 'LineWidth', 2); % Right
plot3([0 0], [0 0], [0 channelHeight], 'k', 'LineWidth', 2); % Front
plot3([0 channelLength], [0 0], [channelHeight channelHeight], 'k', 'LineWidth', 2); % Back
plot3([0 channelLength], [channelWidth channelWidth], [0 channelHeight], 'k', 'LineWidth', 2); % Top front
plot3([channelLength channelLength], [0 channelWidth], [0 channelHeight], 'k', 'LineWidth', 2); % Top back

% Electrode positioning
for i = 1:floor(channelLength / electrodeSpacing)
    % Bottom electrodes
    fill3([electrodeSpacing * (i-1), electrodeSpacing * (i-1) + electrodeWidth, electrodeSpacing * (i-1) + electrodeWidth, electrodeSpacing * (i-1)], ...
          [0, 0, channelWidth, channelWidth], ...
          [0, 0, 0, 0], ...
          [0.5 0.5 0.5], 'EdgeColor', 'k');
end

% Animation loop
for t = 1:numFrames
    % Update particle positions
    dx = (rand(numParticles, 1) - 0.5) * particleSpeed;
    dy = (rand(numParticles, 1) - 0.5) * particleSpeed;
    dz = (rand(numParticles, 1) - 0.5) * particleSpeed;
    positions = positions + [dx, dy, dz];
    
    % Reflect particles at boundaries
    positions(positions(:,1) < 0, 1) = -positions(positions(:,1) < 0, 1);
    positions(positions(:,1) > channelLength, 1) = 2*channelLength - positions(positions(:,1) > channelLength, 1);
    positions(positions(:,2) < 0, 2) = -positions(positions(:,2) < 0, 2);
    positions(positions(:,2) > channelWidth, 2) = 2*channelWidth - positions(positions(:,2) > channelWidth, 2);
    positions(positions(:,3) < 0, 3) = -positions(positions(:,3) < 0, 3);
    positions(positions(:,3) > channelHeight, 3) = 2*channelHeight - positions(positions(:,3) > channelHeight, 3);
    
    % Clear figure and plot updated positions
    clf;
    hold on;
    axis equal;
    view(3);  % Set 3D view

    % Replot channel and electrodes
    % Channel boundaries
    plot3([0 0], [0 channelWidth], [0 0], 'k', 'LineWidth', 2); % Left
    plot3([0 channelLength], [0 0], [0 0], 'k', 'LineWidth', 2); % Bottom
    plot3([0 channelLength], [channelWidth channelWidth], [0 0], 'k', 'LineWidth', 2); % Top
    plot3([channelLength channelLength], [0 channelWidth], [0 0], 'k', 'LineWidth', 2); % Right
    plot3([0 0], [0 0], [0 channelHeight], 'k', 'LineWidth', 2); % Front
    plot3([0 channelLength], [0 0], [channelHeight channelHeight], 'k', 'LineWidth', 2); % Back
    plot3([0 channelLength], [channelWidth channelWidth], [0 channelHeight], 'k', 'LineWidth', 2); % Top front
    plot3([channelLength channelLength], [0 channelWidth], [0 channelHeight], 'k', 'LineWidth', 2); % Top back
    
    % Replot electrodes
    for i = 1:floor(channelLength / electrodeSpacing)
        fill3([electrodeSpacing * (i-1), electrodeSpacing * (i-1) + electrodeWidth, electrodeSpacing * (i-1) + electrodeWidth, electrodeSpacing * (i-1)], ...
              [0, 0, channelWidth, channelWidth], ...
              [0, 0, 0, 0], ...
              [0.5 0.5 0.5], 'EdgeColor', 'k');
    end
    
    % Plot particles
    scatter3(positions(:, 1), positions(:, 2), positions(:, 3), 'filled');
    
    % Set axis limits
    xlim([0, channelLength]);
    ylim([0, channelWidth]);
    zlim([0, channelHeight]);
    
    % Pause to create animation effect
    pause(0.05);
end

hold off;
