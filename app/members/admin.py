from django.contrib import admin

# Register your models here.
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin

from members.models import User


class UserAdmin(BaseUserAdmin):
    fieldsets = (
        (None,{
            'fields':(
                'username',
                'password',
            ),
        }),
        ('권한',{
            'fields':(
                'is_active',
                'is_staff',
                'is_superuser',
            ),
        }),
        ('프로필 이미지',{
            'fields':(
                'img_profile',
            ),
        }),
    )

admin.site.register(User, UserAdmin)