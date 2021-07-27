/*
  Warnings:

  - A unique constraint covering the columns `[humidityId]` on the table `Alert` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE `Alert` ADD COLUMN `humidityId` INTEGER;

-- CreateTable
CREATE TABLE `Humidity` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `value` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `vendingMachineId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE UNIQUE INDEX `Alert_humidityId_unique` ON `Alert`(`humidityId`);

-- AddForeignKey
ALTER TABLE `Humidity` ADD FOREIGN KEY (`vendingMachineId`) REFERENCES `VendingMachine`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Alert` ADD FOREIGN KEY (`humidityId`) REFERENCES `Humidity`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
