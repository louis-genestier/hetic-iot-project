/*
  Warnings:

  - You are about to alter the column `value` on the `Humidity` table. The data in that column could be lost. The data in that column will be cast from `Int` to `Double`.

*/
-- AlterTable
ALTER TABLE `Humidity` MODIFY `value` DOUBLE NOT NULL;
