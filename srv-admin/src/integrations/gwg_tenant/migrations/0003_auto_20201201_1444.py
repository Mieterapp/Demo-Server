# Generated by Django 3.1.2 on 2020-12-01 14:44

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('gwg_tenant', '0002_auto_20201120_0844'),
    ]

    operations = [
        migrations.AlterField(
            model_name='tenant',
            name='bukrs',
            field=models.CharField(max_length=4, verbose_name='Buchungskreis'),
        ),
        migrations.AlterField(
            model_name='tenant',
            name='mobile',
            field=models.CharField(blank=True, max_length=11, null=True, verbose_name='Mobilnummer'),
        ),
        migrations.AlterField(
            model_name='tenant',
            name='name_first',
            field=models.CharField(max_length=40, verbose_name='Vorname'),
        ),
        migrations.AlterField(
            model_name='tenant',
            name='name_last',
            field=models.CharField(max_length=40, verbose_name='Nachname'),
        ),
        migrations.AlterField(
            model_name='tenant',
            name='partnerid',
            field=models.CharField(max_length=23, primary_key=True, serialize=False, verbose_name='Partner ID'),
        ),
        migrations.AlterField(
            model_name='tenant',
            name='phone',
            field=models.CharField(blank=True, max_length=11, null=True, verbose_name='Telefonnummer'),
        ),
        migrations.AlterField(
            model_name='tenant',
            name='recnnr',
            field=models.CharField(max_length=13, verbose_name='Mietvertrag'),
        ),
        migrations.AlterField(
            model_name='tenant',
            name='sgenr',
            field=models.CharField(max_length=8, verbose_name='Gebäude'),
        ),
        migrations.AlterField(
            model_name='tenant',
            name='smenr',
            field=models.CharField(max_length=8, verbose_name='Mieteinheit'),
        ),
        migrations.AlterField(
            model_name='tenant',
            name='swenr',
            field=models.CharField(max_length=8, verbose_name='Wirtschaftseinheit'),
        ),
    ]
