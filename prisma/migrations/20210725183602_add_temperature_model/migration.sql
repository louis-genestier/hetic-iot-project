-- CreateTable
CREATE TABLE `Temperature` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `temperature` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `vendingMachineId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Temperature` ADD FOREIGN KEY (`vendingMachineId`) REFERENCES `VendingMachine`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
