import {InfluxDB, FluxTableMetaData } from '@influxdata/influxdb-client';
import {Cancellable} from '@influxdata/influxdb-client/dist';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();
require('dotenv').config();


const url: string = process.env.INFLUX_URL || 'http://137.116.195.65:8086';
const token: string = process.env.INFLUX_TOKEN || '';
const orga: string = process.env.INFLUX_ORG || '';

const queryApi = new InfluxDB({url, token}).getQueryApi(orga);
const fluxQuery = 'from(bucket: "mqtt")\n' +
    '  |> range(start: -5m)\n' +
    '  |> filter(fn: (r) => r["_measurement"] == "Humidité" or r["_measurement"] == "Accéléromètre" or r["_measurement"] == "Température")\n' +
    '  |> filter(fn: (r) => r["_field"] == "data_value")\n' +
    '  |> filter(fn: (r) => r["nodeID"] == "Distributeur 4" or r["nodeID"] == "Distributeur 1" or r["nodeID"] == "Distributeur 10" or r["nodeID"] == "Distributeur 11" or r["nodeID"] == "Distributeur 12" or r["nodeID"] == "Distributeur 13" or r["nodeID"] == "Distributeur 15" or r["nodeID"] == "Distributeur 14" or r["nodeID"] == "Distributeur 2" or r["nodeID"] == "Distributeur 3" or r["nodeID"] == "Distributeur 5" or r["nodeID"] == "Distributeur 6" or r["nodeID"] == "Distributeur 7" or r["nodeID"] == "Distributeur 8" or r["nodeID"] == "Distributeur 9")\n' +
    '  |> yield(name: "mean")';

queryApi.queryRows(fluxQuery, {
  async next(row: string[], tableMeta: FluxTableMetaData) {
    const o = tableMeta.toObject(row);
    const { nodeID, _value, _time, _measurement } = o;

    const machine = await prisma.vendingMachine.findFirst({
      where: {
        nodeName: nodeID
      }
    });

    if (_measurement === 'Température') {
      const temperature = await prisma.temperature.create({
        data: {
          temperature: _value,
          createdAt: _time,
          vendingMachine: {
            connect: {
              id: machine.id
            }
          }
        }
      });

      console.log(`Created temperature row ${temperature.id} for ${machine.nodeName} with value ${temperature.temperature} !`);

      if (_value > 24) {
        const alert = await prisma.alert.create({
          data: {
            message: 'Température anormale',
            type: 'temperature',
            createdAt: _time,
            vendingMachine: {
              connect: {
                id: machine.id
              }
            },
            school: {
              connect: {
                id: machine.schoolId
              }
            },
            temperature: {
              connect: {
                id: temperature.id
              }
            }
          }
        });

        console.log(`/!\\ Created alert ${alert.id} on temperature for ${machine.nodeName} because value is ${temperature.temperature}`);
      }
    }
    if (_measurement === 'Accéléromètre') {
      const accelerometer = await prisma.accelerometer.create({
        data: {
          value: _value,
          createdAt: _time,
          vendingMachine: {
            connect: {
              id: machine.id
            }
          }
        }
      })

      console.log(`Created accelerometer row ${accelerometer.id} for ${machine.nodeName} with value ${accelerometer.value} !`);

      if (_value === 1) {
        const alert = await prisma.alert.create({
          data: {
            message: 'Tentative de vol',
            type: 'accelerometer',
            createdAt: _time,
            vendingMachine: {
              connect: {
                id: machine.id
              }
            },
            school: {
              connect: {
                id: machine.schoolId
              }
            },
            accelerometer: {
              connect: {
                id: accelerometer.id
              }
            }
          }
        });

        console.log(`/!\\ Created alert ${alert.id} on accelerometer for ${machine.nodeName} because value is ${accelerometer.value}`);
      }
    }

    if (_measurement === 'Humidité') {
      const humidity = await prisma.humidity.create({
        data: {
          value: _value,
          createdAt: _time,
          vendingMachine: {
            connect: {
              id: machine.id
            }
          }
        }
      })

      console.log(`Created humidity row ${humidity.id} for ${machine.nodeName} with value ${humidity.value} !`);

      if (_value > 90) {
        const alert = await prisma.alert.create({
          data: {
            message: 'Humidité élevée',
            type: 'humidity',
            createdAt: _time,
            vendingMachine: {
              connect: {
                id: machine.id
              }
            },
            school: {
              connect: {
                id: machine.schoolId
              }
            },
            humidity: {
              connect: {
                id: humidity.id
              }
            }
          }
        });

        console.log(`/!\\ Created alert ${alert.id} on humidity for ${machine.nodeName} because value is ${humidity.value}`);
      }
    }


  }, useCancellable(cancellable: Cancellable): void {
  }, complete(): void {
    console.log('\nFinished SUCCESS');
  }, error(error: Error): void {
    console.error(error)
    console.log('\nFinished ERROR')
  }
})
