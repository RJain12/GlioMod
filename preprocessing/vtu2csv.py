# run this on the linux machine to turn each timestep into a csv file
import meshio
import numpy
import os
input_directory = "procData"

# Iterate through every file in every subdirectory of every subdirectory of a directory
for root, subdirectories, files in os.walk(input_directory):
    for patient in subdirectories:
        for root2, subdirectories2, files2 in os.walk(os.path.join(input_directory, patient)):
            for simulation in subdirectories2:
                for root3, subdirectories3, files3 in os.walk(os.path.join(input_directory, patient, simulation)):
                    for file in files3:
                        if file.endswith(".vtu"):
                            # Do not run if the file's name is Data_0011.vtu
                            if file.startswith("Data_0011"):
                                # Delete the file
                                os.remove(os.path.join(
                                    input_directory, patient, simulation, file))
                                continue
                            if file.startswith("Data_0000"):
                                # Delete the file
                                os.remove(os.path.join(
                                    input_directory, patient, simulation, file))
                                continue
                            # Get the four digit number from the file name: Data_0000.vtu
                            number = int(file.split("_")[1].split(".")[0]) * 50

                            # Load the mesh
                            mesh = meshio.read(os.path.join(
                                input_directory, patient, simulation, file))

                            # Get the data from the mesh
                            points = mesh.points
                            density = numpy.expand_dims(
                                mesh.point_data["channel1"], axis=1)

                            # horizontally stack to become a 4 column matrix
                            stack = numpy.hstack((points, density))
                            stack = numpy.delete(stack,numpy.where(stack[:,3] == 0),axis=0)

                            # Write the data to a csv file
                            numpy.savetxt(os.path.join(input_directory, patient, simulation, str(
                                number) + ".csv"), stack, delimiter=",", fmt="%f")
                            print("Saved " + os.path.join(input_directory,
                                  patient, simulation, str(number) + ".csv"))
                            # output: x,y,z,density

                            # Delete the vtu file
                            # run this on the linux machine to turn each timestep into a csv file
                            os.remove(os.path.join(input_directory,
                                      patient, simulation, file))
