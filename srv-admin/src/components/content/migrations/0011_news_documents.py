# Generated by Django 3.1.5 on 2021-03-03 08:56

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('content', '0010_auto_20210302_1233'),
    ]

    operations = [
        migrations.AddField(
            model_name='news',
            name='documents',
            field=models.CharField(blank=True, max_length=350, null=True, verbose_name='Document_URL_App'),
        ),
    ]
