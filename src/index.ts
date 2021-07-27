const express = require('express');
import { PrismaClient } from '@prisma/client';
require('dotenv').config();

const prisma = new PrismaClient();
const app = express();

app.get('/schools', async (req, res) => {
  const schools = await prisma.school.findMany({
    include: {
      alerts: true
    }
  });
  return res.json(schools);
});

app.get('/school/:schoolId', async (req, res) => {
  const schools = await prisma.school.findMany({
    where: {
      id: +req.params.schoolId
    },
    include: {
      vendingMachines: true,
      alerts: true
    }
  });

  return res.json(schools);
});

app.get('/school/:schoolId/vendingMachines', async (req, res) => {
  const machines = await prisma.vendingMachine.findMany({
    where: {
      schoolId: +req.params.schoolId
    },
    include: {
      alerts: true,
      temperatures: true,
      humidities: true,
      accelerometers: true,
    }
  })

  return res.json(machines);
})

app.get('/alerts', async (req, res) => {
  const alerts = await prisma.alert.findMany({
    where: {
      isHandled: false,
    }
  });

  return res.json(alerts);
})

app.listen(process.env.API_PORT || 8000);
