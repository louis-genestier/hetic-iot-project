/*
  Warnings:

  - You are about to alter the column `temperature` on the `Temperature` table. The data in that column could be lost. The data in that column will be cast from `Int` to `Double`.

*/
-- AlterTable
ALTER TABLE `Temperature` MODIFY `temperature` DOUBLE NOT NULL;
