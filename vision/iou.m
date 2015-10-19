function [overlaps] = iou(boxes1, boxes2)
%IOU calculates the intersection-over-union overlaps between two groups
% of bounding boxes, and returns IOU values of each combination
%
%   [OVERLAPS] = IOU(BOXES1, BOXES2) suppose BOXES1 is n by 4, BOXES2 is m
%       by 4, then OVERLAPS is n by m conterning the IOU values
%
%   Copyright by Kai KANG (myfavouritekk@gmail.com)
%

    % intersection boundaries, widths and heihts
    ix1 = bsxfun(@max, boxes1(:,1), boxes2(:,1)');
    ix2 = bsxfun(@min, boxes1(:,3), boxes2(:,3)');
    iy1 = bsxfun(@max, boxes1(:,2), boxes2(:,2)');
    iy2 = bsxfun(@min, boxes1(:,4), boxes2(:,4)');
    iw = bsxfun(@max, 0, ix2 - ix1 + 1);
    ih = bsxfun(@max, 0, iy2 - iy1 + 1);

    % areas
    areas1 = bsxfun(@times, boxes1(:,3) - boxes1(:,1) + 1, boxes1(:,4) - boxes1(:,2) + 1);
    areas2 = bsxfun(@times, boxes2(:,3) - boxes2(:,1) + 1, boxes2(:,4) - boxes2(:,2) + 1);
    inter = bsxfun(@times, iw, ih);
    overlaps = 1. * inter ./ (bsxfun(@plus, areas1, areas2') - inter);
end