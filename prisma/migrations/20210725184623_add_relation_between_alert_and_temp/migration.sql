/*
  Warnings:

  - A unique constraint covering the columns `[temperatureId]` on the table `Alert` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `temperatureId` to the `Alert` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `Alert` ADD COLUMN `temperatureId` INTEGER NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX `Alert_temperatureId_unique` ON `Alert`(`temperatureId`);

-- AddForeignKey
ALTER TABLE `Alert` ADD FOREIGN KEY (`temperatureId`) REFERENCES `Temperature`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
