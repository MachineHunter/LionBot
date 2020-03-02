import cv2
import sys
import os


def generateMozaic(imgpath, imgname):
	cascade_file = "./haarcascades/haarcascade_frontalface_alt.xml"

	image = cv2.imread(imgpath)
	image_gs = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

	mozaic_rate = 30

	cascade = cv2.CascadeClassifier(cascade_file)

	face_list = cascade.detectMultiScale(
		image_gs,
		scaleFactor = 1.1,
		minNeighbors = 1,
		minSize = (120, 120)
	)


	if len(face_list) == 0:
		return -1
	

	for(x,y,w,h) in face_list:
		face_img = image[y:y+h, x:x+w]
		face_img = cv2.resize(face_img, (w//mozaic_rate, h//mozaic_rate))
		face_img = cv2.resize(face_img, (w,h), interpolation=cv2.INTER_AREA)
		image[y:y+h, x:x+w] = face_img

	cv2.imwrite("./static/images/"+str(imgname), image)
