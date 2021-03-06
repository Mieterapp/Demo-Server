# Generated by Django 3.1.4 on 2020-12-13 20:16

from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('real_estate', '0002_auto_20201127_1333'),
    ]

    operations = [
        migrations.CreateModel(
            name='Contract',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('code', models.CharField(blank=True, max_length=20, null=True)),
                ('number', models.CharField(blank=True, max_length=20, null=True)),
                ('company_code', models.CharField(blank=True, max_length=20, null=True)),
                ('economic_unit', models.CharField(blank=True, max_length=20, null=True)),
                ('building', models.CharField(blank=True, max_length=20, null=True)),
                ('type', models.CharField(blank=True, max_length=20, null=True)),
                ('type_name', models.CharField(blank=True, max_length=20, null=True)),
                ('description', models.CharField(blank=True, max_length=20, null=True)),
                ('city', models.CharField(blank=True, max_length=20, null=True)),
                ('city_district', models.CharField(blank=True, max_length=20, null=True)),
                ('date_from', models.DateField(blank=True, null=True)),
                ('date_to', models.DateField(blank=True, null=True)),
                ('is_active', models.BooleanField(blank=True, null=True)),
                ('rental_contract', models.CharField(blank=True, max_length=20, null=True)),
                ('rental_unit', models.CharField(blank=True, max_length=20, null=True)),
                ('street', models.CharField(blank=True, max_length=20, null=True)),
                ('street_number', models.CharField(blank=True, max_length=20, null=True)),
                ('zip_code', models.CharField(blank=True, max_length=20, null=True)),
                ('contract_partners', models.ManyToManyField(to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'verbose_name': 'Vertrag',
                'verbose_name_plural': 'Vertr??ge',
            },
        ),
    ]
