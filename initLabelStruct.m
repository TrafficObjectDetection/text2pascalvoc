function labelS=initLabelStruct()
    % initial which class to translate VOC
    S = struct();
    labelnames={...
        'c60'
        'c70'
        'car_people'
        'center_ring'
        'cross_hatch'
        'diamond'
        'forward_left'
        'forward_right'
        'forward'
        'left'
        'right'
        'u_turn'
        'zebra_crossing'};
    for i=1:length(labelnames)
        S.(labelnames{i})=1;
    end
    labelS=S;
end