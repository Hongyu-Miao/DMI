function [ BgNet ] = MaskSimSP( gsd, extSize, NetSize )
%Generate the mask for simulating the background network.
%   gsd : ground truth network
%   extSize : extra size of background (constrain)
%   NetSize : real size of network
    Sgsd = (extSize/NetSize - 1) * sum(sum(gsd));
    
    seed = importdata('seed.mat');
    rng(seed);

    P = rand( NetSize, NetSize );
    A = randn( NetSize, NetSize );
    A( P > (Sgsd / (NetSize * NetSize) ) ) = 0;
    A( A ~= 0) = 1;
    BgNet = sparse(gsd + A >=1);
    BgNet(eye(NetSize)==1) = 0;
    %BgNet = sparse(BgNet);
%     subplot(2,2,2);
%     imshow(BgNet == 0);

end

