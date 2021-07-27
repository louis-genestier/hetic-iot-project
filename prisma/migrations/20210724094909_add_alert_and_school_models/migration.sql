/*
  Warnings:

  - A unique constraint covering the columns `[nodeName]` on the table `VendingMachine` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `schoolId` to the `VendingMachine` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `VendingMachine` ADD COLUMN `schoolId` INTEGER NOT NULL;

-- CreateTable
CREATE TABLE `School` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `address` VARCHAR(191) NOT NULL,
    `city` VARCHAR(191) NOT NULL,
    `zipCode` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Alert` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `vendingMachineId` INTEGER NOT NULL,
    `message` VARCHAR(191) NOT NULL,
    `isHandled` BOOLEAN NOT NULL DEFAULT false,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE UNIQUE INDEX `VendingMachine.nodeName_unique` ON `VendingMachine`(`nodeName`);

-- AddForeignKey
ALTER TABLE `VendingMachine` ADD FOREIGN KEY (`schoolId`) REFERENCES `School`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Alert` ADD FOREIGN KEY (`vendingMachineId`) REFERENCES `VendingMachine`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
