# Generated by Django 3.1.2 on 2020-11-20 08:44

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('gwg_tenant', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='tenant',
            name='mobile',
            field=models.CharField(blank=True, max_length=11, null=True),
        ),
        migrations.AddField(
            model_name='tenant',
            name='phone',
            field=models.CharField(blank=True, max_length=11, null=True),
        ),
    ]
