/*
  Warnings:

  - A unique constraint covering the columns `[accelerometerId]` on the table `Alert` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE `Alert` ADD COLUMN `accelerometerId` INTEGER;

-- CreateTable
CREATE TABLE `Accelerometer` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `value` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `vendingMachineId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE UNIQUE INDEX `Alert_accelerometerId_unique` ON `Alert`(`accelerometerId`);

-- AddForeignKey
ALTER TABLE `Accelerometer` ADD FOREIGN KEY (`vendingMachineId`) REFERENCES `VendingMachine`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Alert` ADD FOREIGN KEY (`accelerometerId`) REFERENCES `Accelerometer`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
