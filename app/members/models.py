from django.contrib.auth.models import AbstractUser
from django.db import models


# Create your models here.
class User(AbstractUser):
    # admin에서 image수정할 수 있도록 설정 -> members/admin.py

    # ec2-deploy/.media/user 폴더에 업로드한 파일이 저장되도록 설정
    #
    img_profile = models.ImageField(upload_to='user', blank=True)

