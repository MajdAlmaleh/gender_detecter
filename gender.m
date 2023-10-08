% Set the recording parameters
duration = 5;  % Recording duration in seconds
sample_rate = 44100;  % Sample rate (Hz)

% Create an audio recorder object
recorder = audiorecorder(sample_rate, 16, 1);

% Start recording
disp('Start recording...');
recordblocking(recorder, duration);
disp('Recording complete.');

% Get the recorded audio data
audio = getaudiodata(recorder);

% Store the audio data in memory
saved_audio = audio;

% Play the recorded audio
disp('Playing recorded audio...');
sound(saved_audio, sample_rate);

% Extract sound features from the recorded audio
base_frequency = calculateBaseFrequency(audio, sample_rate);
wavelength = calculateWavelength(base_frequency);
sound_intensity = calculateSoundIntensity(audio);

% Define the sound features for male and female training data
male_data = [
    110, 0.3, 70;   % Base Frequency, Wavelength, Sound Intensity
    120, 0.25, 75;
    115, 0.28, 72;
    130, 0.22, 78;
    105, 0.32, 68;
    100, 0.33, 65;
    125, 0.26, 70;
    135, 0.21, 75;
    140, 0.2, 72;
    145, 0.19, 70;
    150, 0.18, 68;
    155, 0.17, 66;
    160, 0.16, 64;
    165, 0.15, 62;
    170, 0.14, 60;
    180, 0.27, 73;
    155, 0.31, 68;
    145, 0.36, 65;
    165, 0.29, 70;
    175, 0.25, 75;
    125, 0.33, 62;
    195, 0.21, 78;
    135, 0.28, 68;
    164, 0.0061, 0.1081;
    153.65, 0.0065, 0.1060
];

female_data = [
    200, 0.4, 65;   % Base Frequency, Wavelength, Sound Intensity
    180, 0.45, 63;
    190, 0.42, 68;
    210, 0.38, 70;
    195, 0.41, 67;
    205, 0.39, 66;
    185, 0.44, 64;
    195, 0.43, 67;
    220, 0.37, 63;
    215, 0.36, 65;
    225, 0.35, 62;
    230, 0.34, 64;
    205, 0.39, 65;
    195, 0.42, 66;
    200, 0.4, 67;
    210, 0.38, 68;
    185, 0.39, 66;
    165, 0.43, 63;
    155, 0.47, 61;
    175, 0.41, 68;
    165, 0.45, 65;
    145, 0.51, 59;
    195, 0.37, 70;
    135, 0.55, 57;
  
];

% Define the sound features of the person to classify
new_sound_data = [
    base_frequency, wavelength, sound_intensity;   % Base Frequency, Wavelength, Sound Intensity
];

% Calculate the Euclidean distance between the new sound data and male data
male_distances = sqrt(sum((male_data - repmat(new_sound_data, size(male_data, 1), 1)).^2, 2));

% Calculate the Euclidean distance between the new sound data and female data
female_distances = sqrt(sum((female_data - repmat(new_sound_data, size(female_data, 1), 1)).^2, 2));

% Determine the gender based on the minimum distance
[min_male_distance, male_index] = min(male_distances);
[min_female_distance, female_index] = min(female_distances);

if min_male_distance < min_female_distance
    disp('Gender: Male');
else
    disp('Gender: Female');
end

%noising
% Add noise to the audio
noise_level = 0.1;  
noisy_audio = audio + noise_level * randn(size(audio));

% Store the noisy audio data in memory
saved_audio = noisy_audio;

% Play the noisy audio
disp('Playing recorded audio with noise...');
sound(saved_audio, sample_rate);

%encode
% Encode the audio by converting it to a different data type
encoded_audio = int16(audio * 3000);

% Decode the audio by converting it back to the original data type
decoded_audio = double(encoded_audio) / 3000;

% Store the decoded audio data in memory
saved_audio = decoded_audio;

% Play the decoded audio
disp('Playing decoded audio...');
sound(saved_audio, sample_rate);

%crop
% Crop the audio into two pieces
crop_point = round(length(audio) / 2);
first_piece = audio(1:crop_point);
second_piece = audio(crop_point+1:end);

% Concatenate the first piece twice
repeated_piece = [first_piece; first_piece];

% Play the repeated first piece
disp('Playing the first piece twice...');
sound(repeated_piece, sample_rate);

%amplify
% Amplify the audio by a factor
amplification_factor = 3; 
amplified_audio = audio * amplification_factor;

% Play the amplified audio
disp('Playing amplified audio...');
sound(amplified_audio, sample_rate);
%plotting
hold on;
% Plot the recorded audio
subplot(6,1,1);
plot(audio);
xlabel('Time');
ylabel('Amplitude');
title('Recorded Audio');

% Plot the noised audio
subplot(6,1,2);
plot(noisy_audio);
xlabel('Time');
ylabel('Amplitude');
title('Noisy Audio');

% Plot the encoded audio
subplot(6,1,3);
plot(encoded_audio);
xlabel('Time');
ylabel('Amplitude');
title('Encoded Audio');

% Plot the encoded audio
subplot(6,1,4);
plot(decoded_audio);
xlabel('Time');
ylabel('Amplitude');
title('Decoded Audio');

% Plot the encoded audio
subplot(6,1,5);
plot(repeated_piece);
xlabel('Time');
ylabel('Amplitude');
title('Repeated Audio');

% Plot the amplified audio
subplot(6,1,6);
plot(amplified_audio);
xlabel('Time');
ylabel('Amplitude');
title('Amplified Audio');