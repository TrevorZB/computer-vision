Homework 2
Trevor Zachman-Brockmeyer

Challenge 1a:
    - Using visual inspection on the resulting images, threshold values around the 0.5 range were tested. A threshold of 0.45 was found to result in the most accurate labeled black and white images.

Challenge 1b:
    - I did not add any additional properties to the generated object database. I made this choice because the properties required by the homework were enough for 100% accuracy in the object detection testing in challenge 1c.

Challenge 1c:
    - Of the properties saved in the object database, the only two that would be useful for object detection were the minimum moment of inertia and the roundness. This is because the position and the orientation of the objects could be variable depending on the picture being tested.
    - My recognizeObjects function only needed to use roundness to successfully detect the correct objects. After testing many different thresholds, a differential threshold of 0.05 was used. If a tested object had a roundness that was within (+ or -) 5% of an object in the database, that object was declared as matched. 
    - This method of roundness thresholding at 5% resulted in 100% accuracy when using two_objects.png as the object database store as well as many_objects_1.png as the object database store.
