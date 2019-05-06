import os
import random

IMAGE_DIR = "./images/JPEGImages"
images = os.listdir(IMAGE_DIR)

fw = open("chosen_images.txt", "wb")

for class_name in images:
    class_dir = os.path.join(IMAGE_DIR, class_name)
    class_images = os.listdir(class_dir)
    chosen_images = random.sample(class_images, k=int(len(class_images)/10))
    
    print(chosen_images)

fw.close()