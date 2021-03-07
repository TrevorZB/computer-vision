CS 766: Homework 3
Trevor Zachman-Brockmeyer
3/8/21


Challenge 1b: Voting Scheme
Accumulator:
My accumulator 2D array consisted of theta bins marking the columns and rho bins marking the rows. It was initialized to 0 so all bins started at the same point.


Theta:
Since theta was limited to values 0 <= theta < pi, the theta columns each housed theta values (pi / theta_num_bins). Bin column 1 would have values from 1*(pi / theta_num_bins) to 2*(pi / theta_num_bins). Bin column 2 would have values from 2*(pi / theta_num_bins) to 3*(pi / theta_num_bins) and so on.


Rho:
Since the absolute value of rho was limited to the image’s diagonal, rho had a min value of -diagonal and a max value of +diagonal. The distance between the min and max would then be 2*diagonal. Each rho bin housed (2*diagonal)/rho_num_bins. The values would be split similarly to the split explained above with theta.


Voting Scheme:
Each edge pixel calculated rho for each theta in the accumulator’s columns. Once the rho/theta partners were calculated, the corresponding bin in the accumulator as described above had its vote incremented by 1. This continued until all edge pixels in the edge image were accounted for.




Challenge 1c: Peak Finding
Peak Finding:
I iterated through all theta/rho combinations in my accumulator and recorded the pairs that had votes greater than a predefined threshold. Using these picked out pairs, I then was able to draw the resulting lines onto the original image. The threshold used was optimized through trial and error and visual inspection of the resulting image lines.




Challenge 1d: Line Pruning
Edge Image:
The first part of the algorithm required re-creating the edge images.


Accumulator:
I iterated through the accumulator and recorded the bins that had votes > hough_threshold.




Line Pruning Algorithm:
I iterated through all edge pixels in the edge image. If the pixel voted for one of the recorded accumulator bins, we check the y value of the pixel. If that y value is the smallest or largest seen for that bin, we record the x and y value of this pixel. By doing this for all the edge pixels in the image, we will theoretically find the two endpoint pixels that represent each bin that has votes > hough_threshold. The last step of the algorithm was to draw a line connecting the two endpoint pixels of each bin.