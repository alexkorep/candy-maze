extends Node

func project_vector(vect):
	# Constants for the slopes of the lines y=x/2 and y=-x/2
	var slope1 = 0.5
	var slope2 = -0.5

	# Calculate projection lengths onto each line
	var length1 = (vect.x + vect.y * slope1) / (1 + slope1 * slope1)
	var length2 = (vect.x + vect.y * slope2) / (1 + slope2 * slope2)

	# Create projection vectors for each line
	var proj1 = Vector2(length1, length1 * slope1)
	var proj2 = Vector2(length2, length2 * slope2)

	# Choose the projection that is closer to the original vector
	if proj1.distance_to(vect) < proj2.distance_to(vect):
		return proj1
	else:
		return proj2
