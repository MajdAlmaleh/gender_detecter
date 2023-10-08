function base_frequency = calculateBaseFrequency(audio, sample_rate)
    % Perform autocorrelation on the audio signal
    autocorr_result = xcorr(audio);

    % Remove negative lags and keep only positive lags
    autocorr_result = autocorr_result(length(audio):end);

    % Set a threshold for peak detection
    threshold = max(autocorr_result) * 0.2;

    % Find the first peak above the threshold
    [~, peak_index] = findpeaks(autocorr_result, 'MinPeakHeight', threshold, 'SortStr', 'descend');

    % Calculate the base frequency from the sample rate and peak index
    base_frequency = sample_rate / peak_index(1);
end