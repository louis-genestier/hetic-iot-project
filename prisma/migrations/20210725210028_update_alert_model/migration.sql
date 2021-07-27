/*
  Warnings:

  - Added the required column `schoolId` to the `Alert` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `Alert` ADD COLUMN `schoolId` INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE `Alert` ADD FOREIGN KEY (`schoolId`) REFERENCES `School`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
