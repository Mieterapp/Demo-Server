# Generated by Django 3.1.2 on 2020-10-29 10:01

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('authentication_local', '0002_verificationtoken_user'),
    ]

    operations = [
        migrations.CreateModel(
            name='PasswordResetToken',
            fields=[
                ('token', models.CharField(max_length=40, primary_key=True, serialize=False, verbose_name='code')),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'abstract': False,
            },
        ),
    ]
